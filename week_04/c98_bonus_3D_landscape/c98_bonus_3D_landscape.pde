/*
A quick and very unsatisfactory play with 3D landscape to
have a look at directional lighting
*/

float     sinCounter   = 0;
float     modScale     = 40;
float     zModScale    = 60;
float     minH         = 999999;
float     maxH         = -999999;

void setup() {
  size(500, 500, P3D);
  colorMode(HSB, 100);
}

void draw() {
  
  //  Paint it black!!
  background(0);

  //  Set up the light each time, seems excessive but
  //  after a while, once we get into vectors we may
  //  want to move the light around in various interesting
  //  ways based on vector calculations.
  directionalLight(1, 0, 100, -1, 1, -1);

  //  We want to have a 60 frame loop
  //  we are going to use sinCounter for this
  float adjust = sin(radians(sinCounter));
  sinCounter+=1;


  //  now was draw the landscape
  pushMatrix();
  translate(width/2, height/2, 0);

  //  The default camera is slightly from above (I think)
  //  so 90 degrees doesn't give us the expected result
  //  of looking directly onto the landscape plane. Or
  //  something like that anyway, I haven't had the time
  //  to really look into it.
  rotateX(sin(radians(-90)));
  
  //  Looping via odd points because I don't like having
  //  and edge right down the middle.
  for (float z1 = -19.5; z1 < 19.5; z1++) {
    for (float x1 = -19.5; x1 < 19.5; x1++) {

      float x2 = x1+1;
      float z2 = z1+1;

      //  Generate the heights for the 4 corners
      float h1 = map(noise(x1+100, z1+adjust),0,1,0,2.0);
      float h2 = map(noise(x2+100, z1+adjust),0,1,0,2.0);
      float h3 = map(noise(x2+100, z2+adjust),0,1,0,2.0);
      float h4 = map(noise(x1+100, z2+adjust),0,1,0,2.0);

      //  Pick a colour based on the height
      float hue = map(h1,0.17,1.6,0,99);
            
      noStroke();
      fill(hue,100,75);

      //  Draw the two tris that'll make up each
      //  sqaure of the landscape.
      beginShape();
      vertex(x1*modScale, 100-(h1*zModScale), z1*modScale);
      vertex(x2*modScale, 100-(h2*zModScale), z1*modScale);
      vertex(x1*modScale, 100-(h4*zModScale), z2*modScale);
      vertex(x1*modScale, 100-(h1*zModScale), z1*modScale);
      endShape();

      beginShape();
      vertex(x2*modScale, 100-(h2*zModScale), z1*modScale);
      vertex(x2*modScale, 100-(h3*zModScale), z2*modScale);
      vertex(x1*modScale, 100-(h4*zModScale), z2*modScale);
      vertex(x2*modScale, 100-(h2*zModScale), z1*modScale);
      endShape();
  
    }
  }
  popMatrix();
  
  //  Using this to break out of the animation when we
  //  have enough frames for a loop (which will be 180,
  //  360, 540, 720 etc).
  if (sinCounter>=180) {
    //exit();
  }
  //  Save the frame if we must
  //saveFrame("frames/frame_####.png");
}