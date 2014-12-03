
int counter = 0;

void setup() {

  initVSynth();
  
  size(1000, 500);
  background(0);
  noStroke();

}

void draw() {
 
  updateVSynth();
  
  counter++;
  if(counter > width) {
    counter = 0;
    background(0); 
  }
  
  ellipse(counter, midi.eased(0, height, 0), 3, 3);
  
}


