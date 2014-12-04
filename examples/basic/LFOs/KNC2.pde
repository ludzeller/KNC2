
// KNC2
// ludwig.zeller@fhnw.ch
// December 2014
// IVK / IXDM / HGK / FHNW

// usage:
// place this file as a tab in your project. See the examples for more reference. 
// You have to call initKNC2(); in your setup() method after setting size();
// and to call updateKNC2(); ideally at the beginning of your draw(); method


// todo:
// memory management and interpolation, save presets to data folder, also as initialisation point
// (soft recall: load from memory and put as easing target of interpolator engine)
// allow for non-linear mappings also for negative ranges, etc


// General ---------------

String version = "0.16";

void initKNC2(){
 println("Using KNC2 Version " + version);
 initMidi("SLIDER/KNOB"); // default for NanoControl
 initLfos();  
}

void initKNC2(String port){
 initMidi(port);
 initLfos(); 
}

void updateKNC2(){
  updateMidi();
  updateLfos();
}



// MIDI ---------------
import themidibus.*; 

MidiBus bus; 
MidiBuffer midi;

void initMidi(String inputPort) {
  midi = new MidiBuffer();
  MidiBus.list();
  
  bus = new MidiBus(this, inputPort, -1);   
}

void updateMidi(){
  midi.update(); 
}


class MidiBuffer{
  
  int ccAmount = 129;
  float defaultValue = 1;
  boolean useKnobsForEasing = true;  
 
  float[] direct; // last read value
  float[] eased; // current animated value
  float[] easeRate; // easing speed
  
  
  MidiBuffer() {
    // initialize buffers
    direct = new float[ccAmount];
    for( int i = 0; i < ccAmount; i++ ){
      direct[i] = defaultValue; 
    }
    
    eased = new float[ccAmount];
    for( int i = 0; i < ccAmount; i++ ){
      eased[i] = defaultValue; 
    }
    
    easeRate = new float[ccAmount];
    for( int i = 0; i < ccAmount; i++ ){
      easeRate[i] = defaultValue; // default with a very fast ease rate
    }
  }
  
  void update() {
    
    for( int i = 0; i < ccAmount; i++ ){
      float delta = direct[i] - eased[i];
      eased[i] += delta * easeRate[i];
    }
    
    if(useKnobsForEasing) {
      for(int i = 0; i < 8; i++) {
        easeRate[i] = value( i+16, 0.001, 1, 3 ); // 0-7
        easeRate[i+32] = value( i+16, 0.001, 1, 3 ); // 32-39
        easeRate[i+48] = value( i+16, 0.001, 1, 3 ); // 48-55
        easeRate[i+71] = value( i+16, 0.001, 1, 3 ); // 64-71
      } 
    }
  }
  
  float value(int index) {
    return value(index, 0, 1, 1);
  } 
  
  float value(int index, float a, float b) {
    return value(index, a, b, 1);
  }
  
  float value(int index, float a, float b, float linearity) {
    return map(pow(direct[index], linearity), 0, 1, a, b);
  }
  
  float eased(int index) {
    return eased(index, 0, 1, 1);
  } 
  
  float eased(int index, float a, float b) {
    return map(eased[index], 0, 1, a, b); 
  }
  
  float eased(int index, float a, float b, float linearity) {
    return map(pow(eased[index], linearity), 0, 1, a, b);
  }
  

}

public void controllerChange(int channel, int number, int value) {
  if(channel != 0) {
    println("Wrong Midi Channel, should be 1");
  } else {
    println("Number: " + number + ", Value: " + value);
    midi.direct[number] = map(value, 0, 127, 0, 1); // store and normalize incoming value
  }
}

public void noteOn(int channel, int pitch, int velocity) {
  if(channel != 0) {
    println("Wrong Midi Channel, should be 1");
  } else {
    println("Note: " + pitch + ", Velocity: " + velocity);
    midi.direct[128] = map(pitch, 0, 127, 0, 1); // store and normalize incoming value
  }
}



// LFOBuffer ---------------

LFOBuffer lfo;

void initLfos(){
  lfo = new LFOBuffer();
}

void updateLfos(){
  lfo.update();
}



class LFOBuffer {
 
  ArrayList<LFO> lfos;
  int amountLFOs = 8;

  LFOBuffer() {
    lfos = new ArrayList<LFO>(); // create 8 LFOs with frequency 1Hz
    for(int i = 0; i < amountLFOs; i++) {
      lfos.add(new LFO(1));
    }
  }
  
  void update(){
    for(int i = 0; i < lfos.size(); i++){
      lfos.get(i).update();
    }
  }

  void setFrequency(int num, float freq){
    lfos.get(num).setFrequency(freq);
  }  
  
  void setPhaseInvert(int num, boolean phase) {
    lfos.get(num).setPhaseInvert(phase);
  }
  
  void setWaveForm(int num, String type) {
    lfos.get(num).setWaveForm(type);
  }
  
  float value(int num){
    return lfos.get(num).value(0, 1);
  }
  
  float value(int num, float a, float b){
    return lfos.get(num).value(a, b, 0);
  }
  
  float value(int num, float a, float b, float phase ){
    return lfos.get(num).value(a,b,phase);
  }
  
  
}



// LFO ---------------
class LFO {
  
  boolean phaseInvert = false;
  float timer = 0;
  int lastTime = 0;
  float freq = 1; // Hertz
  int waveForm = 1; // 1 = Sin, 2 = Cos, 3 = Saw, 4 = Pulse
  
  LFO(float f) {
    this.setFrequency(f);
  }
  
  void update(){
    float diffTime = millis() - lastTime; // time passed
    timer += diffTime * freq; // actual animation
    timer %= 1000; // wrap around
    lastTime = millis(); 
  }
  
  void setFrequency(float f){
    this.freq = f;
  } 
  
  void setPhaseInvert(boolean invert) {
    phaseInvert = invert;
  }
  
  void setWaveForm(String type){
    
    if(type == "sin") waveForm = 1;
    if(type == "cos") waveForm = 2;
    if(type == "saw") waveForm = 3;
    if(type == "pul") waveForm = 4;
    
  }
  
  void setWaveCos(){
    waveForm = 2; 
  }
  
  void setWaveSaw(){
    waveForm = 3;
  }
  
  void setWavePul(){
    waveForm = 4;
  }
  
  float value(){
    return value(0, 1);
  }
  
  float value(float a, float b){
    return value(a, b, 0);
  }
  
  float value(float a, float b, float phase ){
    
    switch(waveForm) {
    
      case 1:
      
        if(phaseInvert) {
          return map(sin( map(timer+phase, 0, 1000, 0, TWO_PI ) ), -1, 1, a, b);
        } else {
          return map(cos( map(timer+phase, 0, 1000, 0, TWO_PI ) ), -1, 1, b, a);
        }

        
      case 2:
      
        if(phaseInvert) {
          return map(cos( map(timer+phase, 0, 1000, 0, TWO_PI ) ), -1, 1, a, b);
        } else {
          return map(sin( map(timer+phase, 0, 1000, 0, TWO_PI ) ), -1, 1, b, a);
        }
              
      
      case 3:
      
        if(phaseInvert) {
          return map( (timer+phase)%1000, 0, 999, a, b);
        } else {
          return map( (timer+phase)%1000, 0, 999, b, a);
        }
        
      case 4:
        if(phaseInvert) {
          return map( round(((timer+phase)%1000)/1000.0), 0, 1, b, a); // pulse
        } else {
          return map( round(((timer+phase)%1000)/1000.0), 0, 1, a, b);
        }
        
      
    }
    
    return -1;
    
  }
  
  void reset() {
    timer = 0;
  }
  
}




