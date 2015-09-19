import processing.svg.*;


void setup() {
  size(2970,2100);
  //size(2100,1000);
  //fullScreen();
  ellipseMode(CENTER);
  frameRate(1);
  beginRecord(SVG, "everything.svg");
}


void draw() {

  background(255);
  stroke(255);
  noFill();
  
  // Get the 1st array of hexPoints
  //ArrayList<HexPoint> hexPoints_xlarge = makeGrid(160);
  //ArrayList<HexPoint> hexPoints_large = makeGrid(80);
  ArrayList<HexPoint> hexPoints_small = makeGrid(100);
  //ArrayList<HexPoint> hexPoints_tiny = makeGrid(20);
  
  //  Go thru them drawing hexes
  /*
  for (int i = 0; i < hexPoints_xlarge.size(); i++) {
    HexPoint hPoint = hexPoints_xlarge.get(i);
    if (random(1,100) < 60) {
      drawHex(hPoint.x, hPoint.y, 160);
    }
  }

  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_large.size(); i++) {
    HexPoint hPoint = hexPoints_large.get(i);
    if (random(1,100) < 60) {
      drawHex(hPoint.x, hPoint.y, 80);
    }
  }
  */
  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_small.size(); i++) {
    HexPoint hPoint = hexPoints_small.get(i);
    //if (random(1,100) < 40) {
      drawHex(hPoint.x, hPoint.y, int(random(20,85)));
    //}
  }

  //  Go thru them drawing hexes
  /*
  for (int i = 0; i < hexPoints_tiny.size(); i++) {
    HexPoint hPoint = hexPoints_tiny.get(i);
    if (random(1,100) < 20) {
      drawHex(hPoint.x, hPoint.y, 20);
    }
  }
  */
  //saveFrame("hexes4/frame_####.png");
  endRecord();
  exit();
}


//  This draws the hex in this position
void drawHex(float x, float y, float radius) {

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
  
  int h = int(random(0,99));
  
  strokeWeight(8);
  noStroke();
  //colorMode(HSB,100);
  //if (random(1,100) <= 20) {
  //  stroke(32);
  fill(32);
  //} else {
  //  noFill();
  //  stroke(32);
  //}
  
  pushMatrix();
    translate(width/2+x, height/2+y);
    //rotate(radians(60));
    beginShape();
      vertex(NEx, NEy);
      vertex(Ex, Ey);
      vertex(SEx, SEy);
      vertex(SWx, SWy);
      vertex(Wx, Wy);
      vertex(NWx, NWy);
      vertex(NEx, NEy);
    endShape();
  popMatrix();
  
  //colorMode(RGB,255);
}