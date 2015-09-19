//
//  This is totally unnecessary code, as Processing has the cube
//  primative, so why build one yourself? Well it was a good exercise
//  in getting a mental handle on how the 3D stuff is working.
//  Also, I *could* move forwards from here doing odd and unusual
//  things with the cube faces (natch, just updated to the code to
//  do that). Anyway, short and sweet and a good place to build on... 
//  1st step would be to turn the cube into a class I guess.

//  The 8 points of a cube
float[] p1 = new float[3];
float[] p2 = new float[3];
float[] p3 = new float[3];
float[] p4 = new float[3];
float[] p5 = new float[3];
float[] p6 = new float[3];
float[] p7 = new float[3];
float[] p8 = new float[3];

int x = 0;
int y = 1;
int z = 2;

void setup() {
  size(500, 500, P3D);

  //  Create the 2x2x2 unit cube. If you want to 
  //  be super proper, I guess you should change
  //  these values to 0.5
  p1[x] = -1; p1[y] = -1; p1[z] = 1;
  p2[x] = -1; p2[y] = -1; p2[z] = -1;
  p3[x] = 1; p3[y] = -1; p3[z] = -1;
  p4[x] = 1; p4[y] = -1; p4[z] = 1;

  p5[x] = -1; p5[y] = 1; p5[z] = 1;
  p6[x] = -1; p6[y] = 1; p6[z] = -1;
  p7[x] = 1; p7[y] = 1; p7[z] = -1;
  p8[x] = 1; p8[y] = 1; p8[z] = 1;
  
}

void draw() {
  
  //  Paint it red (so I can better see what's going on)
  //  but black looks cool too
  background(255, 0, 0);

  //  Again, make it easier... although we probably want to
  //  pass the colours into the drawCube function, or even
  //  just let it decide what's what.
  stroke(255);
  fill(0,0,0);
  
  //  Pick your cube size
  int size = 50;
  
  drawCube( 50, 50,-250, size);
  drawCube(250, 50,-250, size);
  drawCube(450, 50,-250, size);
  
  drawCube( 50,250,-250, size);
  drawCube(250,250,-250, size);
  drawCube(450,250,-250, size);
  
  drawCube( 50,450,-250, size);
  drawCube(250,450,-250, size);
  drawCube(450,450,-250, size);
  
  saveFrame("frames/cubes_####.png");
}

void drawCube(float cx, float cy, float cz, float size) {

  //  toggle these for different effects, once explodes
  //  outwards only, the other in and out.
  //  sin() gives us values from -1 to 1, so by adding
  //  1 we get only positive values (0-2) thus exploding
  //  outwards. Leaving it as is, while cause the faces
  //  to move and and out.
  float faceAdjust = (sin(radians(frameCount))+1)*50;
   //float faceAdjust = (sin(radians(frameCount)))*50;

  //  push/pop Matrix and the order of translation/rotations
  //  make my brain hurt, and yet here we are translating
  //  and rotating like a boss.
  pushMatrix();
    translate(cx,cy,cz);
    //  comment out to mix and match various rotations and
    //  see what's going on.
    rotateY(radians(frameCount));
    rotateX(radians(frameCount)/3.14); //  'cause I want jaunty angles
    rotateZ(radians(frameCount)/13.14);//  prime float values in as the modifiers
    //rotateX(radians(frameCount)/3); //  'cause I want jaunty angles
    //rotateZ(radians(frameCount)/4);//  prime float values in as the modifiers
    
    //  DRAW ALL THE FACES
    //  Top face
    beginShape();
    vertex(p1[x]*size, p1[y]*size-faceAdjust, p1[z]*size);
    vertex(p2[x]*size, p2[y]*size-faceAdjust, p2[z]*size);
    vertex(p3[x]*size, p3[y]*size-faceAdjust, p3[z]*size);
    vertex(p4[x]*size, p4[y]*size-faceAdjust, p4[z]*size);
    vertex(p1[x]*size, p1[y]*size-faceAdjust, p1[z]*size);
    endShape();
  
    //  Bottom face
    beginShape();
    vertex(p5[x]*size, p5[y]*size+faceAdjust, p5[z]*size);
    vertex(p6[x]*size, p6[y]*size+faceAdjust, p6[z]*size);
    vertex(p7[x]*size, p7[y]*size+faceAdjust, p7[z]*size);
    vertex(p8[x]*size, p8[y]*size+faceAdjust, p8[z]*size);
    vertex(p5[x]*size, p5[y]*size+faceAdjust, p5[z]*size);
    endShape();
      
    //  Right face
    beginShape();
    vertex(p4[x]*size+faceAdjust, p4[y]*size, p4[z]*size);
    vertex(p3[x]*size+faceAdjust, p3[y]*size, p3[z]*size);
    vertex(p7[x]*size+faceAdjust, p7[y]*size, p7[z]*size);
    vertex(p8[x]*size+faceAdjust, p8[y]*size, p8[z]*size);
    vertex(p4[x]*size+faceAdjust, p4[y]*size, p4[z]*size);
    endShape();
    
    //  Left face
    beginShape();
    vertex(p1[x]*size-faceAdjust, p1[y]*size, p1[z]*size);
    vertex(p2[x]*size-faceAdjust, p2[y]*size, p2[z]*size);
    vertex(p6[x]*size-faceAdjust, p6[y]*size, p6[z]*size);
    vertex(p5[x]*size-faceAdjust, p5[y]*size, p5[z]*size);
    vertex(p1[x]*size-faceAdjust, p1[y]*size, p1[z]*size);
    endShape();
    
      //  Back face
    beginShape();
    vertex(p2[x]*size, p2[y]*size, p2[z]*size-faceAdjust);
    vertex(p3[x]*size, p3[y]*size, p3[z]*size-faceAdjust);
    vertex(p7[x]*size, p7[y]*size, p7[z]*size-faceAdjust);
    vertex(p6[x]*size, p6[y]*size, p6[z]*size-faceAdjust);
    vertex(p2[x]*size, p2[y]*size, p2[z]*size-faceAdjust);
    endShape();

  //  Front face
    beginShape();
    vertex(p1[x]*size, p1[y]*size, p1[z]*size+faceAdjust);
    vertex(p4[x]*size, p4[y]*size, p4[z]*size+faceAdjust);
    vertex(p8[x]*size, p8[y]*size, p8[z]*size+faceAdjust);
    vertex(p5[x]*size, p5[y]*size, p5[z]*size+faceAdjust);
    vertex(p1[x]*size, p1[y]*size, p1[z]*size+faceAdjust);
    endShape();
  
  popMatrix();
  
}