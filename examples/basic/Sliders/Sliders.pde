
// use the sliders, knobs adjust easing by default

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
    
    ellipse( 
      map( i, start, end-1, margin, width-margin ),
      midi.eased(i, height-margin, margin),
      20, 
      20 
    );
  }
  
}
