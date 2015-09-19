//
//  This is just a horrid test of maybe getting somewhere close to isometric stuff
//  I'm not totally convinced I'm happy I know what's going on here until I do
//  some more exploring. Also I'm thinking that 45 degrees isn't quiet the
//  isometric angle I want. The code seems to be doing what I want, but the
//  end result isn't brain-pleasing enough, so I may have to use some "wrong"
//  values to make it *look* right.

//  import the complex 3D stuff :D
import processing.opengl.*;
PGraphics3D p3d ;
PGraphicsOpenGL pgl;
boolean opengl = !false; //  Huh, sure why not

void setup() {
  
  //  If you know the platform you're dealing with, pick one
  //  (the good one) and stick with it.
  if (opengl) {
    size(500,500,OPENGL);
    pgl = (PGraphicsOpenGL) g;
    pgl.projection.set
    (
      0.0040,  0.0000,  0.0000,  -0.0000,
      0.0000,  0.0040,  0.0000,  -0.0000,
      0.0000,  0.0000, -0.0020, -1.0000,
      0.0000,  0.0000,  0.0000,  1.0000
    );
    // same as
    //ortho(-width/2, width/2, -height/2, height/2, 0, 1000);
  }
  else {
    size(500,500,P3D);
    p3d = (PGraphics3D) g;
    p3d.projection.set(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
  }
  printProjection();
}


void draw() {
  
  //  Paint it black
  background(0);
  fill(255,0,0);
  stroke(255);

  //  hate matrix maths.
  pushMatrix();
    translate(width/2, height/2, 200);
    rotateX(radians(45));
    rotateY(radians(frameCount));
    box(200);
  popMatrix();
  //  Really we're going to need a lot more cubes until we get anything useful
  //  and some better lighting, and sod it we should just export the result as
  //  DXF and let a real render deal with it.
}