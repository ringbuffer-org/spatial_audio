
s.boot;

// load HOA stuff for binaural:
(
HOABinaural.loadbinauralIRs(s);
HOABinaural.loadHeadphoneCorrections(s);
HOABinaural.binauralIRs;
HOABinaural.headPhoneIRs;
)


// load an Ambisonics audio file to a buffer:
(
var str = "/media/anwaldt/ANWALDT_2TB/WORK/TEACHING/Online/Spatial_Audio/audio/210321_011_Raven.wav";

~buf    = Buffer.read(s, str,0,-1);

)

~buf.numFrames;

  // plot the audio data (may take some time):
~buf.plot();














// create a 4-channel audio bus for the Ambisonics signal
~ambi_BUS =Bus.audio(s,4);

~ambi_BUS.scope

// create a playback node (looped)
(
~playback = {

	var signal  = 	PlayBuf.ar(4, ~buf, 1, loop:1);

	Out.ar(~ambi_BUS,signal*5);

}.play;
)

// monitor all 4 Ambisonics channel:
~ambi_BUS.scope();


// create a decoder with angles as arguments:
(

~decoder = {

	|
	pitch=0,
	roll =0,
	yaw  =0
	|

	var input    = In.ar(~ambi_BUS.index, 4);

	// var rotated  = HOATransRotateXYZ.ar(1, input, pitch, roll, yaw);

	var binaural = HOABinaural.ar(1,input);

	Out.ar(0, binaural);

}.play;

)

// move after playback node
~decoder.moveAfter(~playback);




