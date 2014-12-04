
// Sliders 1, 2 and 3 control the background color

float red = 0;
float green = 0;
float blue = 0;

void setup() {
  size(400, 400);
  initKNC2();
}

void draw() {
   
  updateKNC2();
  background(
    midi.eased(0, 0, 255), 
    midi.eased(1, 0, 255), 
    midi.eased(2, 0, 255)
  );
  
}



