
int margin = 100;

void setup() {
  size(800, 400, OPENGL);
  initVSynth(); 
}


void draw() {
  updateVSynth();
  
  background(0);
  fill(255);
  noStroke(); 
  
  int start = 32;
  int end = 40;
  
  for(int i = start; i < end; i++){
    
    ellipse( 
      map( i, start, end-1, margin, width-margin ),
      midi.eased(i, height-margin, margin),
      20, 
      20 
    );
  }
  
}
