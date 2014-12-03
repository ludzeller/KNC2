
void setup() {
  size(1280, 720, OPENGL);
  initVSynth();
  noCursor();
}

void draw() {
   
  updateVSynth();
  
  noStroke();
  fill(0, midi.eased(4, 255, 0, 0.5));
  rect(0,0,width,height);
  
  for( int i = 0; i < midi.eased(0, 5, 200, 2 ); i++ ){
    // this is storing a random number between -Pi and Pi
    float rand = random((float) (-1 * Math.PI), (float) Math.PI );
    float size = random(midi.eased(1, 2, 50, 2));
    
    fill(random(midi.eased(2, 0, 255)));
   
    float range = midi.eased( 3, 5, width / 2 * 2, 3 );
    
    ellipse( 
      width/2 + sin(rand) * random(0, range), 
      height/2 + cos(rand) * random(0, range), 
      size, 
      size
    );
  }

  // copy image buffer for smearing 
  PImage p = get(0,0,width, height);
  imageMode(CENTER);
  float zoom = midi.eased(7, 0.8, 1.2);
  //translate( midi.eased(5, -10, 10), midi.eased( 6, -10, 10 ) );
  tint(255,midi.eased(6,0,255));
  image(p, width/2, height/2, width*zoom, height*zoom);  

}



