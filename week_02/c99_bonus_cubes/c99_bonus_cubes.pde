//
//  For the tumblrs!!!
//  Bonus cube code, this is the start of figuring out that I want to do
//  something on a hex grid.
//

//  One again, using sketchy looking stuff: www.gicentre.net/handy
import org.gicentre.handy.*;

HandyRenderer h;
int   maxSize  = 100;
int   xOffset;
int   yOffset;

boolean do_draw = true;

void setup() {

  //  Set the size
  size(500, 500);
  //  handy has a bunch of handy (hahah) presets, one of which
  //  is pencil, so I'm going to use that.
  h = HandyPresets.createPencil(this);
  
  //  Here we want to work out the offset needed to draw cubes based on
  //  what happens when we take the size and rotate it around to one of the
  //  side points the "North East" one in this case.
  //  There is totally going to be a better way of doing this I'm sure.
  float NEx = maxSize * sin(radians(120));
  float NEy = maxSize * cos(radians(120));

  //  Now we have rotated a point round to one of the outer cube corners, get the co-ords
  //  and use that for the offsets we'll be using in our loop
  xOffset = int(NEx * 2);
  yOffset = int(maxSize - NEy);
  
}

void draw() {
  
  //  Again a toggle incase we want to break out of the loop
  if (do_draw == false)
    return;
  
  background(240,240,240);

  //  Build the loop that allows us to draw a whole bunch of cubes
  int row = 0;
  int maxY = height+yOffset;
  int maxX = width+xOffset;
  
  //  We are going to bounce the size of the cubes back and forth for our animation
  int size = frameCount;
  if (size > 100) {
    size = 200 - size;
  }
    
  //  FOR THE LOOP GODS
  for (int y=0; y<maxX; y+=yOffset) {
    for (int x=0; x<maxY; x+=xOffset) {
      //  We need to shuffle the cubes to the right every other row
      if (row % 2 == 0) {
        drawCube(x, y, size);
      } else {
        drawCube(x+(xOffset/2), y, size);
      }
    }
    row++;
  }
  
  //  Save the frame to make the animation
  saveFrame("frames/frame_###.png");
  
  //  Once we've done 200 frames then stop, that's enough to create a loop
  if (frameCount > 200) {
    do_draw = false;
  }
  
}


//  This draws the cube
void drawCube(float x, float y, float size) {
  
  //  If I were going to modify this further I'd probably
  //  rotate the cubes around so they spiralled into place
  //  by the final full sized frame.
  //  I'd throw an extra rotate value into the calculations
  //  based on frameCount. Exercise is left to the reader.  
  
  //  First things first we need to work out the 6 points of the cube.
  float Nx = x + size * sin(radians(180));
  float Ny = y + size * cos(radians(180));
  float NEx = x + size * sin(radians(120));
  float NEy = y + size * cos(radians(120));
  float SEx = x + size * sin(radians(60));
  float SEy = y + size * cos(radians(60));
  float Sx = x + size * sin(radians(0));
  float Sy = y + size * cos(radians(0));
  float SWx = x + size * sin(radians(-60));
  float SWy = y + size * cos(radians(-60));
  float NWx = x + size * sin(radians(-120));
  float NWy = y + size * cos(radians(-120));

  h.setRoughness(4);

  //  Top face
  h.setUseSecondaryColour(true);
  h.setFillGap(2);
  h.setFillWeight(0);
  h.setBackgroundColour(color(255,0));
  h.setStrokeColour(color(255,0));
  h.setFillColour(color(192,192,192));
  h.setHachureAngle(-65);
  h.quad(x,y,NWx,NWy,Nx,Ny,NEx,NEy);

  //  shading
  h.setUseSecondaryColour(false);
  h.setFillGap(4);
  h.setFillWeight(0);
  h.setFillColour(color(160,160,160));
  h.setHachureAngle(60);
  h.triangle(NWx, NWy, Nx, Ny, lerp(Nx, NEx, 0.5), lerp(Ny, NEy, 0.5));

  
  // Right face
  h.setUseSecondaryColour(true);
  h.setFillGap(2);
  h.setFillWeight(0);
  h.setBackgroundColour(color(255,0));
  h.setStrokeColour(color(255,0));
  h.setFillColour(color(160,160,160));
  h.setHachureAngle(0);
  h.quad(x,y,NEx,NEy,SEx,SEy,Sx,Sy);

  //  shading
  h.setUseSecondaryColour(false);
  h.setFillGap(4);
  h.setFillWeight(0);
  h.setFillColour(color(96,96,96));
  h.setHachureAngle(-60);
  h.triangle(SEx,SEy,lerp(SEx,Sx,0.5),lerp(SEy,Sy,0.5),NEx,NEy);


  
  //  Left face
  h.setUseSecondaryColour(true);
  h.setFillGap(2);
  h.setFillWeight(0);
  h.setBackgroundColour(color(255,0));
  h.setStrokeColour(color(255,0));
  h.setFillColour(color(96,96,96));
  h.setHachureAngle(55);
  h.quad(x,y,Sx,Sy,SWx,SWy,NWx,NWy);

  // shading
  h.setUseSecondaryColour(false);
  h.setFillGap(4);
  h.setFillWeight(0);
  h.setFillColour(color(64,64,64));
  h.setRoughness(4);
  h.setHachureAngle(-10);
  h.triangle(Sx, Sy, SWx, SWy, lerp(SWx, NWx, 0.5), lerp(SWy, NWy, 0.5));
  
  
  //  Lines
  h.setRoughness(2);
  h.setStrokeWeight(size*0.05);
  h.setStrokeColour(color(32,255));
  h.line(x,y,NEx,NEy);
  h.line(x,y,NWx,NWy);
  h.line(x,y,Sx,Sy);

  h.line(Nx,Ny,NEx,NEy);
  h.line(Nx,Ny,NWx,NWy);

  h.line(SEx,SEy,NEx,NEy);  
  h.line(SEx,SEy,Sx,Sy);

  h.line(SWx,SWy, NWx, NWy);  
  h.line(SWx,SWy, Sx, Sy);  

  
}

//  Left over code that I've used before which allows us to put a break
//  in the drawing and then carry one.
void keyReleased() {

  // if the spacebar is pressed draw a new frame
  if (keyCode == 32) {
    do_draw = true;
  }

}