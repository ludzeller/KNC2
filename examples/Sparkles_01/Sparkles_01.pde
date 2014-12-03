
void setup() {
  size(720, 720);
  initVSynth();
}

void draw() {
  
  updateVSynth();
  
  rectMode(CENTER);
  
  float s; 
  float xAmt, yAmt;
  float xStep, yStep;
  
  xAmt = round(midi.eased(2,1,100,3));
  //yAmt = midi.eased(3,1,100,3); 
  
  xStep = width / xAmt / 1.0;
  yStep = height / xAmt / 1.0;
  
  s = xStep;
  
  fill(0, midi.eased(1,0,255,2));
  rect(width/2,height/2,width,height);
  
  translate(xStep/2,yStep/2);

  fill(midi.value(3,0,255));
  noStroke();
  
  for (int x = 0; x < xAmt; x++) {
    for (int y = 0; y < xAmt; y++) {
      if(random(100)>midi.eased(0,0,100,4)) continue;
      pushMatrix();
      translate(x * xStep, y * yStep);
      ellipse( 0, 0, s, s);
      popMatrix();
    }
  }
}






