
// sliders set speed of 8 LFOs

int margin = 100;

void setup() {
  size(800, 400);
  initKNC2(); 
}


void draw() {
  updateKNC2();
  
  background(0);
  fill(255);
  noStroke(); 
  
  int start = 0;
  int end = 8;
  
  for(int i = start; i < end; i++){
    
    lfo.setFrequency(i, midi.value(i, 0.01, 5, 3));
    
    ellipse( 
      map( i, start, end-1, margin, width-margin ),
      lfo.value(i, margin, height-margin),
      20, 
      20 
    );
  }
  
}
