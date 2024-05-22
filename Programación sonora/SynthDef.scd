// Inicializar el servidor
s.boot;

// Cargar los sonidos en buffers
~drumBuffer = Buffer.read(s, "C:/Users/young/Desktop/Programación sonora/drum_kick.wav");
~pianoBuffer = Buffer.read(s, "C:/Users/young/Desktop/Programación sonora/piano_rev.wav");
~bassBuffer = Buffer.read(s, "C:/Users/young/Desktop/Programación sonora/acid_bass.wav");

// Sincronizar el servidor
s.sync;

// Definir el sintetizador para drum
(
SynthDef(\drumSynth, {
    |amp = 0.1, rate = 1|
    var env, playbuf;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    playbuf = PlayBuf.ar(1, ~drumBuffer, rate, doneAction: 2);
    Out.ar(0, playbuf * env * amp);
}).add;
)

// Definir el sintetizador para piano
(
SynthDef(\pianoSynth, {
    |amp = 0.1, rate = 1|
    var env, playbuf;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    playbuf = PlayBuf.ar(1, ~pianoBuffer, rate, doneAction: 2);
    Out.ar(0, playbuf * env * amp);
}).add;
)

// Definir el sintetizador para bajo
(
SynthDef(\bassSynth, {
    |amp = 0.1, rate = 1|
    var env, playbuf;
    env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
    playbuf = PlayBuf.ar(1, ~bassBuffer, rate, doneAction: 2);
    Out.ar(0, playbuf * env * amp);
}).add;
)

// Definir la secuencia Pdef para el drum
(
Pdef(\drumSequence, Pbind(
    \instrument, \drumSynth,
    \dur, Pseq([0.5, 0.25, 0.75, 1], inf),
    \amp, Pseq([0.1, 0.2, 0.15, 0.1], inf),
    \rate, Pseq([1, 0.5, 1.5, 1], inf)
)).play;
)

// Definir la secuencia Pdef para el piano
(
Pdef(\pianoSequence, Pbind(
    \instrument, \pianoSynth,
    \dur, Pseq([1, 0.5, 0.75, 0.25], inf),
    \amp, Pseq([1, 0.4, 1, 1], inf),
    \rate, Pseq([1, 1.2, 0.8, 1], inf)
)).play;
)

// Definir la secuencia Pdef para el bajo
(
Pdef(\bassSequence, Pbind(
    \instrument, \bassSynth,
    \dur, Pseq([0.75, 0.5, 1, 0.25], inf),
    \amp, Pseq([0.3, 0.4, 0.35, 0.3], inf),
    \rate, Pseq([1, 0.9, 1.1, 1], inf)
)).play;
)

// Reproducir cada secuencia de manera independiente
Pdef(\drumSequence).play;
Pdef(\pianoSequence).play;
Pdef(\bassSequence).play;

// Parar todos los sonidos
s.quiet;
