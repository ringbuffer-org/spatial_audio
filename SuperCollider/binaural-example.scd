
s.boot;

// create the ambisonics mix bus

(
~order     = 1;
~nHOA      = (pow(~order+1,2)).asInteger;
~ambi_BUS  = Bus.audio(s,~nHOA);
)


~ambi_BUS.scope;


(ambi_BUS
~encoder_A = {

	arg azim=0, elev=0;

	Out.ar(~ambi_BUS,HOASphericalHarmonics.coefN3D(~order,azim,elev) * 0.1* SoundIn.ar(0) );

}.play;
)


~ambi_BUS.scope;

// set parameters
~encoder_A.set(\azim,0)
~encoder_A.set(\elev,0)



// load binaural IRs for the decoder
HOABinaural.loadbinauralIRs(s);

~decoder = { HOABinaural.ar(~order, In.ar(~ambi_BUS,~nHOA)) }.play;

~decoder.moveAfter(~encoder_A);





// Add another encoded signal to the ambi bus

~encoder_B = {arg azim=0, elev=0;
	Out.ar(~ambi_BUS,HOASphericalHarmonics.coefN3D(~order,azim,elev)*0.1*Saw.ar(277));
	}.play;

~encoder_B.set(\azim,pi/2)
~encoder_B.set(\elev,1)


~front_BUS = Bus.audio(s);

(
~f = {

	Out.ar(~front_BUS,In.ar(~ambi_BUS.index)+In.ar(~ambi_BUS.index+3))

}.play;
)

~f.free