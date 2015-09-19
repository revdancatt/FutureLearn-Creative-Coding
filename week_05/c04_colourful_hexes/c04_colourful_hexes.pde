/*
Now we move into the world of making pretty patterns with
hexes. I did initially try and output a SVN of the hex and
then use that as a Shape in Processing. But in this instance
it just wasn't working out for me.
*/

void setup() {
  
  // NOTE: fullScreen() wont work on Processing vrs <= 2
  //size(1000,1000);
  fullScreen();
  colorMode(HSB, 100);
  ellipseMode(CENTER);
  frameRate(1);
}

void draw() {

  //  Paint it black
  background(0);
  
  // Get the 1st array of hexPoints
  ArrayList<HexPoint> hexPoints_xlarge = makeGrid(80);
  
  //  Go thru them drawing hexes
  for (int i = 0; i < hexPoints_xlarge.size(); i++) {
    HexPoint hPoint = hexPoints_xlarge.get(i);
    drawHex(hPoint.x, hPoint.y, 81); // 1px larger to hide edges
  }

  /*
  saveFrame("frames/frame_####.png");
  //  I did a bit of rotation animation here to see what
  //  would happen and only needed 360 frames
  if (frameCount >= 360) {
    exit();
  }
  */

}


//  This draws the hex in this position
void drawHex(float x, float y, float radius) {

  //  Work out the outside 6 points.
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
  
  //  Now we need to work out the mid points
  //  between the NE and E points, and so on
  //  so we can slit the whole thing into 4
  //  bits
  float NEEx = lerp(NEx, Ex, 0.5);
  float NEEy = lerp(NEy, Ey, 0.5);
  float SEEx = lerp(SEx, Ex, 0.5);
  float SEEy = lerp(SEy, Ey, 0.5);
  
  float NWWx = lerp(NWx, Wx, 0.5);
  float NWWy = lerp(NWy, Wy, 0.5);
  float SWWx = lerp(SWx, Wx, 0.5);
  float SWWy = lerp(SWy, Wy, 0.5);
  
  //  This bit does the colours. This is the most
  //  fancy version, but other times I was hand
  //  coding the colours for different effects.
  strokeWeight(1);
  color c1 = color(int(random(0,100)), 80, 100);
  color c4 = color(int(random(0,100)),20,100);
  color c2 = lerpColor(c1, c4, 0.33);
  color c3 = lerpColor(c1, c4, 0.66);
  
  
  pushMatrix();
    translate(width/2+x, height/2+y);
    
    //  This turns the hex into one of the 6 different
    //  orientations.
    int newAngle = int(random(0,6))*60;
    rotate(radians(newAngle));
    //rotate(radians(frameCount)); // <-- start playing with fixed colours, framerate and sizes.
    stroke(c1);
    
    //  Now draw the 4 different slices of the hex
    fill(c1);
    beginShape();
      vertex(NEx, NEy);
      vertex(NEEx, NEEy);
      vertex(NWWx, NWWy);
      vertex(NWx, NWy);
      vertex(NEx, NEy);
    endShape();

    stroke(c2);
    fill(c2);
    beginShape();
      vertex(NEEx, NEEy);
      vertex(Ex, Ey);
      vertex(Wx, Wy);
      vertex(NWWx, NWWy);
      vertex(NEEx, NEEy);
    endShape();
  
    stroke(c3);
    fill(c3);
    beginShape();
      vertex(Ex, Ey);
      vertex(SEEx, SEEy);
      vertex(SWWx, SWWy);
      vertex(Wx, Wy);
      vertex(Ex, Ey);
    endShape();
  
    stroke(c4);
    fill(c4);
    beginShape();
      vertex(SEEx, SEEy);
      vertex(SEx, SEy);
      vertex(SWx, SWy);
      vertex(SWWx, SWWy);
      vertex(SEEx, SEEy);
    endShape();
  
  popMatrix();
    
}