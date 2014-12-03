
float red = 0;
float green = 0;
float blue = 0;

void setup() {
  size(400, 400);
  initVSynth();
}

void draw() {
   
  updateVSynth();
  background(
    midi.eased(0, 0, 255), 
    midi.eased(1, 0, 255), 
    midi.eased(2, 0, 255)
  );
  
}



