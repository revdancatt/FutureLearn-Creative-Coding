//  This is me taking the hexes into the 3rd dimension
//  We still use the same hex grid, but with lots of
//  tipping and what have you in 3D

void setup() {
  size(500,500, P3D);
  ellipseMode(CENTER);
}

void draw() {

  //  Paint it black!!
  background(0);
  stroke(0);
  noFill();
  
  //  Adjusting this gives us more or less hexes
  float maxDistance = 210;
  
  // Get the 1st array of hexPoints
  ArrayList<HexPoint> hexPoints_xlarge = makeGrid(20, maxDistance);
  
  //  We have to do some odd stuff to move the grid into
  //  the center of the screen... why oh why can't Processing
  //  have a setOrigin() function??
  rotateX(radians(90));
  translate(0,-300,-375);
  
  //  Now we've moved the stuff to where we want it (via
  //  a method of trial and error, we can start to rotate
  //  it around.
  pushMatrix();
  
    //  Lights please
    //directionalLight(255, 0, 0, -1, -0.5, -1);
    //directionalLight(0, 128, 0, 0.8, -0.8, -1);
    directionalLight(255, 255, 255, -1, -0.5, -1);
    directionalLight(128, 128, 128, 0.8, -0.8, -1);
    
    //  I like to move it move it.
    //  But in a really awkward way.
    //  Shift it to the middle, rotate,
    //  and then move back
    translate(width/2, height/2, 0);
    rotateZ(radians(float(frameCount)/6));
    translate(-width/2, -height/2, 0);

    //  Go thru them drawing hexes
    for (int i = 0; i < hexPoints_xlarge.size(); i++) {
      HexPoint hPoint = hexPoints_xlarge.get(i);
      drawHex(hPoint.x, hPoint.y, 14, maxDistance);
    }

  popMatrix();
  

  /*
  saveFrame("hex_tower2/frame_####.png");
  if (frameCount > 360) {
    exit();
  }
  */

}


//  This draws the hex in this position
void drawHex(float x, float y, float radius, float maxDistance) {

  //  As usual, firgure out the points
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
    
  //  Base the shade on the distance from the middle
  float maxDistSqrt = sqrt(maxDistance);
  float hexDist = sqrt(dist(0, 0, x+1, y));
  int hexShade = int(map(hexDist, 0, maxDistSqrt+1, 255, 0));

  strokeWeight(0);
  color c1 = color(hexShade);
  stroke(0);
  fill(c1);
  
  pushMatrix();
    translate(width/2+x, height/2+y);
    //30,90,150e
    //int newAngle = int(random(0,6))*60;
    //rotate(radians(newAngle));

    //  work out the height for the hex, which is a function of the distance
    hexDist = sqrt(dist(0, 0, x+1, y));
    float heightMod = map(hexDist, 0, maxDistSqrt+1, 1, 0);
    float modDist = 400 * ((sin(radians(frameCount))+1)/2);
    float hexHeight = heightMod * modDist;
    
    //  Top
    beginShape();
      vertex(NEx, NEy, 0);
      vertex(Ex, Ey, 0);
      vertex(SEx, SEy, 0);
      vertex(SWx, SWy, 0);
      vertex(Wx, Wy, 0);
      vertex(NWx, NWy, 0);
      vertex(NEx, NEy, 0);
    endShape();
  
    //  Bottom
    beginShape();
      vertex(NEx, NEy, hexHeight);
      vertex(Ex, Ey, hexHeight);
      vertex(SEx, SEy, hexHeight);
      vertex(SWx, SWy, hexHeight);
      vertex(Wx, Wy, hexHeight);
      vertex(NWx, NWy, hexHeight);
      vertex(NEx, NEy, hexHeight);
    endShape();
  
    //  Do all the six sides
    beginShape();
      vertex(NWx, NWy, 0);
      vertex(NEx, NEy, 0);
      vertex(NEx, NEy, hexHeight);
      vertex(NWx, NWy, hexHeight);
      vertex(NWx, NWy, 0);
    endShape();

    beginShape();
      vertex(NEx, NEy, 0);
      vertex(Ex, Ey, 0);
      vertex(Ex, Ey, hexHeight);
      vertex(NEx, NEy, hexHeight);
      vertex(NEx, NEy, 0);
    endShape();

    beginShape();
      vertex(Ex, Ey, 0);
      vertex(SEx, SEy, 0);
      vertex(SEx, SEy, hexHeight);
      vertex(Ex, Ey, hexHeight);
      vertex(Ex, Ey, 0);
    endShape();

    beginShape();
      vertex(SEx, SEy, 0);
      vertex(SWx, SWy, 0);
      vertex(SWx, SWy, hexHeight);
      vertex(SEx, SEy, hexHeight);
      vertex(SEx, SEy, 0);
    endShape();

    beginShape();
      vertex(SWx, SWy, 0);
      vertex(Wx, Wy, 0);
      vertex(Wx, Wy, hexHeight);
      vertex(SWx, SWy, hexHeight);
      vertex(SWx, SWy, 0);
    endShape();

    beginShape();
      vertex(Wx, Wy, 0);
      vertex(NWx, NWy, 0);
      vertex(NWx, NWy, hexHeight);
      vertex(Wx, Wy, hexHeight);
      vertex(Wx, Wy, 0);
    endShape();

  popMatrix();
  
}