
// Waves Synth
// Old school winamp/itunes style smear effect synth

// fader0 -> stroke weight
// fader1 -> freq x
// fader2 -> freq y
// fader3 -> trail length
// fader4 -> feedback strength
// fader5 -> smear x direction / feedback intensity
// fader6 -> smear y direction / feedback twist
// fader7 -> smear growing or shrinking

int amt = 300;
int margin = 150;

ArrayList<PVector> points;

void setup() {
  
  size(800,800, OPENGL);
  initVSynth();
  
  points = new ArrayList<PVector>();
  lfo.setPhaseInvert(0, true); // cos
  
}

void draw() {
  
  updateVSynth();
  
  // set frequencies
  lfo.setFrequency(0, midi.eased(1, 0.1, 2, 2));
  //lfo.setFrequency(0, lfo.value(2, 0.01, 1) ); // this is for FM
  lfo.setFrequency(1, midi.eased(2, 0.1, 2, 2));
  
  // fadeout background
  noStroke();
  fill(0, midi.eased(4, 100, 0, 0.3) );
  blendMode(BLEND);
  rect(0,0,width, height);
  noFill();
  
  // animation
  float x = lfo.value(0, margin, width-margin);    
  float y = lfo.value(1, margin, height-margin);
  
  // manage trail
  points.add(new PVector(x,y));
  int currSize = floor(midi.eased(3,10,200,3));
  while(points.size() > currSize ) {
    points.remove(0);
  }
  
  // draw trail
  stroke(255);
  strokeWeight(midi.value(0, 1, 10));
  beginShape();
    for( int i = 0; i < points.size(); i++ ){
      vertex(points.get(i).x, points.get(i).y );
    }
  endShape();
  
  // copy image buffer for smearing 
  PImage p = get(0,0,width, height);
  imageMode(CENTER);
  float zoom = midi.eased(7, 0.8, 1.2);
  //translate( midi.eased(5, -10, 10), midi.eased( 6, -10, 10 ) );
  blendMode(ADD);
  tint(255, midi.eased(5, 0, 80));
  translate(width/2, height/2);
  rotate(midi.eased( 6, 0, PI ));
  image(p, 0, 0, width*zoom, height*zoom);
  
}
