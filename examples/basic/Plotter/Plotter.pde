
// render value of slider 1, knob 1 controls easing

int counter = 0;

void setup() {

  initKNC2();
  
  size(1000, 500);
  background(0);
  noStroke();

}

void draw() {
 
  updateKNC2();
  
  counter++;
  if(counter > width) {
    counter = 0;
    background(0); 
  }
  
  ellipse(counter, midi.eased(0, height, 0), 3, 3);
  
}


