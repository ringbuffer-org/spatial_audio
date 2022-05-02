/*

Create a 2D speaker setup for VBAP panning.

- azimuth and spread can be controlled
  using OSC commands

- irregular setups can be adjusted by
  setting gains and/or delays for each speaker

*/

// some server options for multichannel
(
o = Server.local.options;
o.numInputBusChannels = 32;
o.numOutputBusChannels = 9;
)



// SynthDef ////////////////////////////////////////////////////////////////////////////////////////////////////////


SynthDef( \vbap_panner,
	{
		|out_bus = 0, in_buff = -1, out_buf = 0, azi = 0, ele = 0, spr = 0|
		Out.ar(out_bus, VBAP.ar(8, SoundIn.ar(in_buff), out_buf, azi, ele, spr));
}).add;





SynthDef( \speaker,
	{
		|in_bus = 0, out_bus = 0, gain = 1, delay=0|

		Out.ar(out_bus, gain  * DelayL.ar(In.ar(in_bus), 1, delay));

}).add;




s.waitForBoot({




	// VBAP Setup ////////////////////////////////////////////////////////////////////////////////////////////////////////

	~nSpeakers = 8;

	~vbap_BUS = Bus.audio(s,~nSpeakers);

	~nSpat = 32;

	~speakers = VBAPSpeakerArray.new(2, [0, 45, 90, 135, 180, -135, -90, -45]); // 8 channel ring

	~speakers.speakers[1].dump;

	~vbap_BUFF = ~speakers.loadToBuffer;

	2.wait;


	// Create Synths ///////////////////////////////////////////////////////////////////////////////////////////////////

	~spatial_GROUP = Group.new();

	for (0, ~nSpat -1, {arg i;

		post('Adding spatialization module: ');
		i.postln;

		~panner = ~panner.add(
			Synth(\vbap_panner,
				[\out_bus, ~vbap_BUS.index, \in_buff,i, \out_buf, ~vbap_BUFF.bufnum],
				target: ~spatial_GROUP
		);)
	});



	~speaker_GROUP = Group.after(~spatial_GROUP);

	for (0, ~nSpeakers-1, {arg i;

		post('Adding speaker module: ');
		i.postln;

		~output_speakers = ~output_speakers.add(
			Synth(\speaker,
				[\in_bus, ~vbap_BUS.index + i, \out_bus, 0+i],
				target: ~speaker_GROUP
		);)
	});



	// CONTROL ////////////////////////////////////////////////////////////////////////////////////////////////////////


	~spat_azim_BUS   = Bus.control(s,~nSpat);
	~spat_spre_BUS   = Bus.control(s,~nSpat);

	~spat_azim_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;

			~spat_azim_BUS.setAt(msg[1],msg[2]);

	}, '/spat/azim');


	~spat_spre_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;

			~spat_spre_BUS.setAt(msg[1],msg[2]);

	}, '/spat/spre');


	// map it

	for (0, ~nSpat -1, {arg i;


		post('Mapping spatialization module: ');
		i.postln;

		~panner[i].map(\azi,~spat_azim_BUS.index +i);
		~panner[i].map(\spr,~spat_spre_BUS.index +i);


	});


	ServerMeter(s);

});
