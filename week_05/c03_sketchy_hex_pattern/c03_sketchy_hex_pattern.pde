//  This is the same hex code as before, kinda, but we
//  are going to use the "handy" sketch effect this tie

import org.gicentre.handy.*;
HandyRenderer h;

void setup() {
  
  //  **fullScreen only works in Processing 3
  //size(500,500);
  fullScreen();
  h = new HandyRenderer(this);
  ellipseMode(CENTER);
  frameRate(1);

}

void draw() {

  background(255);
  stroke(255);
  noFill();
  
  //  Play with various sizes to see what seems the best.
  
  // Get the 1st array of hexPoints  
  ArrayList<HexPoint> hexPoints_xlarge = makeGrid(85);
  
  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_xlarge.size(); i++) {
    HexPoint hPoint = hexPoints_xlarge.get(i);
    drawHex(hPoint.x, hPoint.y, 82);
  }

  //saveFrame("frames/frame_####.png");
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
  
  strokeWeight(1);
  noStroke();
  fill(32);
  
  pushMatrix();
    translate(width/2+x, height/2+y);
    //30,90,150
    int newAngle = (int(random(0,3))*60)-30;
    h.setHachureAngle(newAngle);
    h.beginShape();
      h.vertex(NEx, NEy);
      h.vertex(Ex, Ey);
      h.vertex(SEx, SEy);
      h.vertex(SWx, SWy);
      h.vertex(Wx, Wy);
      h.vertex(NWx, NWy);
      h.vertex(NEx, NEy);
    h.endShape();
  popMatrix();
    
}