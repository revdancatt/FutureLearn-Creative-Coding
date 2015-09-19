//  For this project we had to make a clock, I wanted to test rotations
//  and some way to frame the numbers so they weren't just floating in
//  space. The framing has to reflect tick/tock time, but not distract
//  too much from the time itself
//
//  I did not get arrested for making this clock and showing it to class
//  

int       secondsSize     = 32;
int       minutesSize     = -128;
int       hoursSize       = 256;
int       startMS         = millis();
int       secondsOffset   = second(); // get the seconds at startup time
int       randomCount     = 0;

PFont     font;
boolean   updatedRandom   = false;


void setup() {

  //  This is kinda 16:9 ratio
  size(1000,562);
  
  //  Feel a bit weird including the .vlw for the font, probably
  //  best to pick and choose your own
  font = loadFont("PTMono-Bold-255.vlw");
  //  Get the milliseconds at start (which all things considered is 0, but
  //  I didn't know that at the time, I thought it was milliseconds from
  //  1st Jan 1970.
  startMS = millis();
  
}

void draw() {
  
  //  Paint it black
  background(0);
  
  //  This gets a whole bunch values and turns them
  //  into nice to read formatted strings.
  int seconds_int = second();
  int minutes_int = minute();
  String minutes_str = nf(minutes_int,2);
  int hour_int = hour();
  String hour_str = nf(hour_int,2);
  
  //  Pick the font for the clock
  textFont(font, secondsSize);

  //  At each draw cycle we get the number of elapsed milliseconds
  //  So I can work out when I want to "flip" the squares.
  //  If we got the current seconds to a few decimal places that
  //  would be good, because there are sync issues between when
  //  seconds actually tick over, and when 1000 milliseconds have
  //  passed. We could have some code run right at the start to
  //  sync all this up before we display anything, but that's
  //  overkill for this.
  int nowMS = millis();
  int diffMS = nowMS-startMS;
  float frameTick = (float(diffMS)/1000);
  float xOffset = -textWidth("00")/2;

  //  Draw the numbers, we are using the
  //  secondsOffset value to make sure the seconds are
  //  rotated around by that value initially, otherwise
  //  whenever we stat the seconds would be displayed
  //  as zero.
  //  There are still syncing issues with when the
  //  seconds tick over from 59 to 00 and the minute
  //  value changing, but you know, life.
  noStroke();
  fill(255);
  pushMatrix();
  translate(width*0.3,0);
  for (int s = 1; s <= 60; s++) {
    String s_str = nf(60-s,2);
    pushMatrix();
    translate(0,height*0.66);
    rotate(-radians((float(s+secondsOffset)+frameTick)*6));
    text(s_str, (width*0.4)-xOffset, -(secondsSize/2));
    popMatrix();
  }
  popMatrix();
  
  //  This is easy, hours and minutes
  textFont(font, 192);
  text(hour_str + ":" + minutes_str, width*0.1, height*0.635);

  // Draw the line to help focus the layout on the seconds
  noStroke();
  fill(255);
  blendMode(DIFFERENCE);
  float tl_x = width*0.7+(xOffset*0);
  float tl_y = height*0.66+(xOffset*0.25);
  rect(tl_x, tl_y,  width*0.7-(xOffset*4) - tl_x,  height*0.66+(xOffset*2.5) - tl_y);
  stroke(255);
  line(0, tl_y, width, tl_y);
  blendMode(BLEND);
  
  

  //  We use this to sync up the random squares on the screen
  //  with the moment a new second 'ticks' into place. A
  //  new second is when we are positioning the angle of the
  //  first number exact on a multipul of 6 degree
  int randomCount = int(frameTick);
  
  //  We are cunningly using randomSeeds to make the random
  //  decoration squares not quiet so random. We want to
  //  update the seed every 1/4 of a second. Comment
  //  this line out to see what I mean.
  randomSeed(randomCount);
  
  //  The chance of us dropping a square is a function
  //  of how far from the edge of the canvas we are. As
  //  we get closer to the middle of the screen (or the
  //  bound) the chances of drawing a square drop off
  float lower_bound = 0.35;  
  for (int y = 0; y < height*lower_bound; y+=8) {
    for (int x = 0; x < width; x+=8) {
      noStroke();
      //  work out what colour square we are going to draw
      float chance = map(y,0,height*lower_bound,0,1);
      if (chance < random(0,0.99)) {
        if (random(0,1.0) > 0.3) {
          fill(255,255,255,255);
        } else {
          fill(255,255,255,170);
        }
      } else {
        if (random(0,1.0) > 0.7) {
          fill(255,255,255,85);
        } else {
          fill(255,255,255,0);
        }
      }
      rect(x,y,6,6);
    }
  }

  float upper_bound = 0.7;
  for (int y = height; y > height*upper_bound; y-=8) {
    for (int x = 0; x < width; x+=8) {
      noStroke();
      //  work out what colour square we are going to draw
      float chance = map(y,height,height*upper_bound,0,1);
      if (chance < random(0,0.99)) {
        if (random(0,1.0) > 0.3) {
          fill(255,255,255,255);
        } else {
          fill(255,255,255,170);
        }
      } else {
        if (random(0,1.0) > 0.7) {
          fill(255,255,255,85);
        } else {
          fill(255,255,255,0);
        }
      }
      rect(x,y,6,6);
    }
  }

  //  Don't do this if you want to capture the frames needed
  //  for a smooth animation of the clocking running in real time
  //  use video screen capture instead. As the time taken to
  //  write the frame, means you don't get a smooth animation.
  //saveFrame("frame/tick_####.png");
  
}