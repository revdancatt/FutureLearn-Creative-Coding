/*
 * Creative Coding
 * Week 2, 05 - Moving Patterns 1
 * 
 */

//  Using Handy: www.gicentre.net/handy to give the short fat lines
//  a rough edge
import org.gicentre.handy.*;
HandyRenderer h;

// variable used to store the current frame rate value
int    frame_rate_value   = 60;
int    tween              = 30;
int    rough              = 2;
int    angle              = 0;
int    thickness          = 30;

void setup() {
  
  size(500, 500);
  h = new HandyRenderer(this);
  h.setRoughness(rough);

  frameRate(frame_rate_value);
  rectMode(CENTER);
  background(255);
  strokeWeight(thickness);

}


void draw() {

  //  Semi transparent over the background to get "trails" of
  //  the previous frame
  colorMode(RGB, 360);
  noStroke();
  fill(360, 360, 360, 30);
  rect(width/2, height/2, width, height);

  
  colorMode(HSB, 360);
  int num = 5;
  int margin = 0;
  float gutter = 0; //distance between each cell
  float cellsize = (width - (2 * margin) - gutter * (num - 1)) / num;
  
  //  this is so we can pass over an inddex for the circle if we want to do different
  //  things with each one.
  int circleNum = 0;
  
  //  Loop thru the "cells" calling the (now badly named) movingCircle function.
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      float tx = margin + (cellsize * i) + (gutter * i) + (cellsize / 2);
      float ty = margin + (cellsize * j) + (gutter * j) + (cellsize / 2);
      //  Send in a modified cellsize so the thing we are drawing
      //  is slightly more interesting then exactually matching
      //  the amount the things are spaced out.
      movingCircle(tx, ty, cellsize*2, circleNum);
    }
  }
  
  //  Increase the angles, 360 degrees in a circle, stepping in 6 frames
  //  at a time, will give us a loop time of 60 frames.
  angle+=6;
  if (angle>359)
    angle=0;
    
  //  Going to save the 60 frames needed to loop,
  //  but only once we have the 1st rotation and a useful set of
  //  trails.
  //println(frameCount);
  if (frameCount >=60 && frameCount < 120) {
    //saveFrame("frames/round_###.png");
  }
  
}


//  This is where we draw the "circle" (but not any more)
void movingCircle(float x, float y, float size, int circleNum) {

  //  This doesn't actually do anything because we are currently
  //  always passing in '0' as the circleNum value. Mess around
  //  with passing in different values to see what happens
  float finalAngle;
  finalAngle = angle + circleNum;
  if (finalAngle>359)
    finalAngle-=360;

  //  The rotating angle for each tempX and tempY postion is affected by frameRate and angle;
  //  These are the start and end points of the line we are going to draw.
  float tempX1 = x + (size/3) * sin(radians(finalAngle));
  float tempY1 = y + (size/3) * cos(radians(finalAngle));
  float tempX2 = x + (size/2) * sin(radians(finalAngle));
  float tempY2 = y + (size/2) * cos(radians(finalAngle));

  noFill();
  stroke(angle, 0, 0);
  //  Using h. to draw the line, if we leave h. off then we just
  //  draw a normal line
  h.line(tempX1, tempY1, tempX2, tempY2);
  
}


/*
 * keyReleased function
 *
 * called automatically by Processing when a keyboard key is released
 */
void keyReleased() {

  // right arrow -- increase roughness
  if (keyCode == RIGHT && rough < 100) {
    rough++;
    h.setRoughness(rough);
  }

  // left arrow -- decrease roughness
  if ( keyCode == LEFT && rough > 0) {
    rough--;
    h.setRoughness(rough);
  }

  // set the frameRate and print current value on the screen
  println("Current rough: " + rough);
}