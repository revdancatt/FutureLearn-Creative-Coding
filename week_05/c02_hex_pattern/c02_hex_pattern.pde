/*
This was an exploration into making Hex Grids. The logic
in makeHexGrid was scrapped together in an hour one night
I should go back and fix it all, but it's good-enough.
There are slight variations in the code of makeHexGrid
over the next few iterations.

This sketch was used to generate a whole bunch of different
images, and I was changing it as I went along. So you'll
find you can get a bunch of different effects by commenting
out various bits and bobs
*/

void setup() {
  // **NOTE: fullScreen() is a processing 3 command, I think.
  //  use normal size() for older versions.
  //  size(500,500);
  fullScreen();
  ellipseMode(CENTER);
  frameRate(1);
}


void draw() {

  //background(255);
  background(0);
  stroke(255);
  noFill();
  
  // Get some hexGrid arrays
  ArrayList<HexPoint> hexPoints_xlarge = makeGrid(160);
  ArrayList<HexPoint> hexPoints_large = makeGrid(80);
  ArrayList<HexPoint> hexPoints_small = makeGrid(40);
  ArrayList<HexPoint> hexPoints_tiny = makeGrid(20);
  
  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_xlarge.size(); i++) {
    HexPoint hPoint = hexPoints_xlarge.get(i);
    if (random(1,100) < 50) {
      drawHex(hPoint.x, hPoint.y, 140);
    }
  }

  //   Now draw the hexes at the various different sizes
  //  experiment with the last "radius/size" value that gets
  //  passed over, and later the strokeWidth that happens
  //  in the drawHex function
  for (int i = 0; i < hexPoints_large.size(); i++) {
    HexPoint hPoint = hexPoints_large.get(i);
    if (random(1,100) < 40) {
      drawHex(hPoint.x, hPoint.y, 70);
    }
  }

  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_small.size(); i++) {
    HexPoint hPoint = hexPoints_small.get(i);
    if (random(1,100) < 30) {
      drawHex(hPoint.x, hPoint.y, 34);
      //drawHex(hPoint.x, hPoint.y, int(random(5,35)));
    }
  }

  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_tiny.size(); i++) {
    HexPoint hPoint = hexPoints_tiny.get(i);
    if (random(1,100) < 20) {
      drawHex(hPoint.x, hPoint.y, 16);
    }
  }

  //saveFrame("frames/frame_####.png");
}


//  This draws the hex in this position
void drawHex(float x, float y, float radius) {

  //  Work out all the points we are going to need
  //  to draw a hex
  float NEx = -radius * sin(radians(-30));
  float NEy = -radius * cos(radians(-30));
  float Ex = -radius * sin(radians(-90));
  float Ey = -radius * cos(radians(-90));
  float SEx = -radius * sin(radians(-150));
  float SEy = -radius * cos(radians(-150));
  float SWx = -radius * sin(radians(-210));
  float SWy = -radius * cos(radians(-210));
  float Wx = -radius * sin(radians(-270));
  float Wy = -radius * cos(radians(-270));
  float NWx = -radius * sin(radians(-330));
  float NWy = -radius * cos(radians(-330));
  
  strokeCap(SQUARE);

  //  Over this code I make a whole bunch of
  //  changes here to get different effects
  int h = int(random(0,99));
  strokeWeight(radius/5);
  colorMode(HSB,100);
  if (random(1,100) <= 20) {
    stroke(h,100,100);
    fill(h,100,100);
  } else {
    noFill();
    stroke(h,100,100);
  }
  
  /*
  strokeWeight(8);
  colorMode(HSB,100);
  if (random(1,100) <= 20) {
    stroke(16);
    fill(16);
  } else {
    noFill();
    stroke(16);
  }
  */
  
  //  Now actually draw the hex
  pushMatrix();
    translate(width/2+x, height/2+y);
    beginShape();
      vertex(NEx, NEy);
      vertex(Ex, Ey);
      vertex(SEx, SEy);
      vertex(SWx, SWy);
      vertex(Wx, Wy);
      vertex(NWx, NWy);
      vertex(NEx, NEy);
      vertex(Ex, Ey);
    endShape();
  popMatrix();
  
  colorMode(RGB,255);
}