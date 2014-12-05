
## KNC2

ludwig.zeller@fhnw.ch

IVK / IXDM / HGK / FHNW

v0.16

###About:

A wrapper for The MidiBus in order to use the Korg NanoControl 2 (or any other USB MIDI) controller within Processing in a very convenient way. That's it! Well, plus variable waveform LFOs and optional parameter glide for that certain instrument feeling.

Please note, it's not a library but just a snippet to include in your sketch. This code was developed by Ludwig Zeller for a series of workshops at HGK Basel. See https://vimeo.com/113396020.

###Usage:

You need to install the Processing library The MidiBus from http://www.smallbutdigital.com/themidibus.php or via the Processing library installer dialog.

Place the KNC2.pde as a tab in your Processing sketch. See the examples for more reference. You have to call initKNC2(); in your setup() method after setting size();
and to call updateKNC2(); ideally at the beginning of your draw(); method.

Attach your Korg NanoControl 2 controller before running your sketch. You need the default  CC mappings. If you have modified these you can load up the right mappings from the file extra/mapping.nktrl2_data with the KORG KONTROL Editor. 

*You can also use KNC2 with other controllers.* KNC2 processes all CC updates on MIDI channel 1 and of course this behaviour can be changed since it's a snippet and not a library. In order to connect to another USB Midi controller just call initKNC2(String port) in setup instead of initKNC2() where port is the name of the alternative device. You can only connect to one device at a time, but this could change in the future.


###Reference

```Java
// has to be called in setup(); optional: you can open another 
// controller by providing its name via initKNC2(String port);
initKNC2(); 

// has to be called at first in draw()
updateKNC2(); 

// midi.value() gives you the direct value of the controller without easing
// you can optionally provide a mapping range, 
// otherwise it will return the slider range from 0-1
// you can optionally set the linearity of the range, values between 0-1 
// produce logarithmic scales while values from 1-infinity produce 
// exponential scales
midi.value( int ccNum ); 
midi.value( int ccNum, float mapA, float mapB ); 
midi.value( int ccNum, float mapA, float mapB, float linearity ); 

// midi.eased() is similar to midi.value() but each CC signal 
// is passed through an easing filter
midi.eased( int ccNum);
midi.eased( int ccNum, float mapA, float mapB );
midi.eased( int ccNum, float mapA, float mapB, float linearity );

// you can set the easing rate for each CC individually from 0 - 1, 
// where 0 will be very slow and 1 will be like midi.value()
midi.setEaseRate( int ccNum, float rate ); 

// there are 8 LFOs (lfoNum: 0-7), if you hack the KNC2 code 
// you can of course have as many as you want
// use lfo.value() to read their values, no easing available here
// you can also set the phase of the LFOs where TWO_PI is a full cycle
lfo.value( int lfoNum);
lfo.value( int lfoNum, float mapA, float mapB );
lfo.value( int lfoNum, float mapA, float mapB, float phase );

// you can set the frequency of each LFO from 0 to infinity, but please note 
// that you cannot display changes that are faster than the framerate. 
lfo.setFrequency( int lfoNum, float freq ); 

// change waveforms between “sin”, “cos”, “saw”, “pul”
lfo.setWaveForm( int lfoNum, String waveForm ); 
```




