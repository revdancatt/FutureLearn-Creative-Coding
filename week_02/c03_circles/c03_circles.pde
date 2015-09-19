/*
 * Creative Coding
 * Week 2, 06 - Moving Patterns 2
 *
 * Similar to the previous sketch, this sketch draws a grid of oscillating circles. Each circle has a "lifetime"
 * over which it grows and changes intensity and opacity. At the end of each lifetime the circle begins again.
 * Pressing the left and right arrow keys changes the lifetime of all the circles globally.
 * 
 */

//  Using Handy: www.gicentre.net/handy to give the short fat lines
//  a rough edge
import org.gicentre.handy.*; 
HandyRenderer h;

// variable used to store the current frame rate value
int   frame_rate_value  = 21;

void setup() {
  // make the display window the full size of the screen
  size(displayWidth, displayHeight);
  h = new HandyRenderer(this);
  h.setHachurePerturbationAngle(20);
  rectMode(CENTER);
}


void draw() {

  //  Paint it white!!
  background(255);

  //  Same as before we loop our way through the grid
  int num          = 20;
  int margin       = 0;
  float gutter     = 0; //distance between each cell
  float cellsize   = ( width - (2 * margin) - gutter * (num - 1) ) / (num - 1);

  int circleNumber = 0; // counter
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      circleNumber = (i * num) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;

      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
  
  //  Save the frames if we need to turn this into an animation
  //saveFrame("frames/sketch_###.png");
  
} //end of draw 


//  In incorrectly names "moving"Circle, where we just draw the thing
void movingCircle(float x, float y, float size, int offset) {

  //  I don't like casting (float) and (int) this way, but the example
  //  code does it and I'm copying it.
  float circlePeriod = (float)frame_rate_value;
  float circleAge = (float)((frameCount + offset) % (int)circlePeriod) / circlePeriod;
  float circleSize = size * 2.0 * sin(circleAge * HALF_PI);

  //  I totally forgot how I came to this number :) Oh right, I think
  //  I wrote some code that outputted the maxiumum size a circle could get
  //  to, rather like...
  //  maxSize = -999999
  //  if (circleSize > maxSize) {
  //    maxSize = circleSize;
  //    println(maxSize);
  //  }
  //  Run that once will give to the largest circle.
  //  Because I haven't learnt about the map() function yet
  //  I use this to work out how "visible" I want the circle so
  //  it totally fades off to nothing.
  
  float visible = 255 - (circleSize * 1.783216783);
  if (visible < 1) {
    visible = 1;
  }
  
  //  again no map() function, so I do this crazy stuff to get the
  //  effect I want
  float weight = circleSize * .020979021;
  float rough = circleSize * .06993007;

  strokeWeight(1);
  h.setRoughness(10-rough);
  stroke(0,0,0,visible);
  noFill();

  // there's a 15% chance of the circle being red  
  int chance = int(random(1,100));
  if (chance <= 15) {
    stroke(255,0,0,visible);
    fill(255,0,0,visible/2);
  }

  h.ellipse(x-size/2, y-size/2, circleSize, circleSize);

}


/*
 * keyReleased function
 *
 * called automatically by Processing when a keyboard key is released
 */
void keyReleased() {

  // right arrow -- increase frame_rate_value
  if (keyCode == RIGHT && frame_rate_value < 120) {
    frame_rate_value++;
  }

  // left arrow -- decrease frame_rate_value
  if ( keyCode == LEFT && frame_rate_value > 2) {
    frame_rate_value--;
  }

  // print the current value on the screen
  println("Current frame Rate is: " + frame_rate_value);
}