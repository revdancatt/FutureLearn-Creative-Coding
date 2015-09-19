// A quick test to see what happens if we use different
// shapes on a hexgrid. Not much to see here, will do
// something with it at some point.
void setup() {
  size(500,500);
  //fullScreen();
  ellipseMode(RADIUS);
}

void draw() {

  background(42,4,74);
  stroke(0);
  noFill();
  
  // Get the 1st array of hexPoints
  ArrayList<HexPoint> hexPoints_large = makeGrid(40);
  
  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_large.size(); i++) {
    HexPoint hPoint = hexPoints_large.get(i);
    drawShape(hPoint.x, hPoint.y, 0);
    //drawShape(hPoint.x, hPoint.y, 40);
    //drawShape(hPoint.x, hPoint.y, 40*2);
    //drawShape(hPoint.x, hPoint.y, 40*3);
    //drawShape(hPoint.x, hPoint.y, 40*4);
  }

  /*
  saveFrame("anim1/frame_####.png");
  if (frameCount >= 360) {
    exit();
  }
  */
}


//  This draws the circle in this position
void drawShape(float x, float y, float radius) {
  noFill();
  stroke(255);
  pushMatrix();
    translate(width/2+x, height/2+y);
    ellipse(x, y, radius+frameCount, radius+frameCount);
  popMatrix();
  
}