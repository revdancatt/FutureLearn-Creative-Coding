//
//  A bonus bit of code as I work out how to make the lines work
//  in 3D space.
//
//  In 2D we can build up the lines just by not painting over the background. We
//  can't do this in 3D space, as we need to draw the 3D lines each and every
//  time. To do this we run all the normal code from the 2D lines stuff, that
//  "draws" the line if the two end points are within a certain distance.
//  But instead of drawing the line, it just makes a new 3D line object.
//  We then loop through all those saved lines and draw them in 3D space
int       numArray;
int       boxSize;
int       reset;
int       rotMod;

float[]   x;  //  x positions for the end points
float[]   y;  //  y positions for the end points
float[]   z;  //  y positions for the end points
float[]   xInc;
float[]   yInc;
float[]   zInc;
float     proximity;
float     bounds;

color[]   c;  //  The colour of the points

ArrayList<FloatingLine> floatingLines = new ArrayList<FloatingLine>();

void setup() {

  //  Make it HD sized for YouTube and Vimeo
  //  If your laptop can't handle this size use the commented out
  //  values below as a guide
  size(1920, 1080, P3D);
  
  //  These values should probably be a function of the size
  boxSize = 800;
  bounds = (boxSize/2);
  numArray = 24;  //  The number of points 12-24 is good.
  
  //  rotMod is a value we're going to use in a couple of places, it
  //  tells us when to stop adding more lines and when to start
  //  rotating in along an extra axis. I can't remember now but
  //  For example it can be set so we only add lines for the 1st
  //  180 degrees or rotation (by setting the value to 1), then
  //  start the additional rotation after 360 degrees and exit after
  //  540 degrees. 1.2.3
  rotMod = 4;

  //  reduce this if we make the draw area smaller.
  proximity = 240;
  
  //  For smaller screens use these instead
  /*
  size(960, 540, P3D);
  boxSize = 400;
  bounds = (boxSize/2);
  numArray = 12;  //  The number of points 12-24 is good.
  rotMod = 4;
  proximity = 120;
  */
  
  //  Set up all the arrays for the points we are going to
  //  bounce around the place
  x      = new float[numArray];
  y      = new float[numArray];
  z      = new float[numArray];
  c      = new color[numArray];
  xInc   = new float[numArray];
  yInc   = new float[numArray];
  zInc   = new float[numArray];
  reset  = 0;
  
  //  Create all the points withing the bounding box
  for (int i=0; i<numArray; i++) {
    x[i] = random(boxSize) - bounds;
    y[i] = random(boxSize) - bounds;
    z[i] = random(boxSize) - bounds;
    xInc[i] = random(-1, 1);
    yInc[i] = random(-1, 1);
    zInc[i] = random(-1, 1);
    
    //  Set up the colours for each point, this cycles round
    //  Yellow, Cyan & Magenta, with every 3rd point being
    //  one of the colours.
    //  CYM
    if (i % 3 == 0) {c[i] = color(255,255,0);}
    if (i % 3 == 1) {c[i] = color(0,255,255);}
    if (i % 3 == 2) {c[i] = color(255,0,255);}

  }

  //  Paint it black
  background(0);

}

void draw() {
  
  //  You can get some interesting effects by not setting the background here
  background(0);
  noFill();
  
  //  Not sure why I called this zoom, but this is how far the line is offset each time
  //  setting it to 1 makes the lines really code, values of 8 or 12 is crazy fast
  //  If you set it to 12 youll probably want to make some other adjustments to not fill
  //  up the whole screen with lines that end up look like a mess.
  float zoom = 2;
  
  //  update the positions
  for (int i=0; i<numArray; i++) {

    x[i] += xInc[i]*zoom;
    y[i] += yInc[i]*zoom;
    z[i] += zInc[i]*zoom;

    //  bounce off the sides of the window. Yes I'm still using curly brackets,
    //  but readable & modifiable code wins each time when people are trying
    //  to learn from someone elses code.
    if (x[i] > bounds) {xInc[i] = -random(1);}
    if (x[i] < -bounds) {xInc[i] = random(1);}

    if (y[i] > bounds) {yInc[i] = -random(1);}
    if (y[i] < -bounds) {yInc[i] = random(1);}

    if (z[i] > bounds) {zInc[i] = -random(1);}
    if (z[i] < -bounds) {zInc[i] = random(1);}
  }

  //  Note we only add new lines for the 1st n frames.
  if (frameCount < 180 * rotMod) {
    
    strokeWeight(2);
    for (int i=0; i<numArray; i++) {
      for (int j=0; j<i; j++) {
        
        //  If two points are close enough (in 3 dimensions) create a new line
        float distance = dist(x[i],y[i],z[i], x[j],y[j],z[j]);
        if (distance < proximity) {
  
          //  Pick a colour that's a function of the colour of the two
          //  end points
          float pickColour = map(distance,0,proximity,0.0,1.0);
          color newColor = lerpColor(c[i],c[j],pickColour);
          float alpha = map(distance,0,proximity,192,16);
          
          //  Not sure how to add/modify an alpha value on a colour, so
          //  going to create a whole new colour ('cause I'm an idiot).
          color newNewColor = color(red(newColor),green(newColor),blue(newColor), alpha);
          
          //  Got the end points, got the color, DISCO, time to add a whole new
          //  line to our every growing collection of lines.
          floatingLines.add(new FloatingLine(x[i],y[i],z[i], x[j],y[j],z[j], newNewColor));
        }
      }
    }
  }
  
  //  Do some cunning rotation based on something I can no longer remember
  //  which is why you should comment your code as you go along kids.
  //  Play with the value of rotMod should help you figure out what's going on.
  translate(width/2,height/2,0);
  rotateY(radians(float(frameCount)/rotMod));
  //  After a time rotate in an extra way (because we're fancy like that).
  if (frameCount >= 360 * rotMod) {
    rotateX(radians(float(frameCount)/rotMod));
  }
  stroke(255,16);
  strokeWeight(1);
  //box(boxSize); // wanna see the box that everything fits in?

  //  Now that we have added some more lines (maybe) we draw them
  strokeWeight(1);
  for (int i = floatingLines.size() - 1; i >= 0; i--) {
    FloatingLine tline = floatingLines.get(i);
    stroke(tline.col);
    line(tline.x1,tline.y1,tline.z1, tline.x2,tline.y2,tline.z2);  
  }
  //  NOTE: At some point it'd be nice to export the lines as a text file
  //  that could be read in by a 3D render like Blender to get some nice
  //  global illumination renders of the end result. I may come back and do
  //  that at some point, when I find a render that handles lines well
  //  (maybe RenderMan and RIB files??).
  
  
  //  Save the frames and exit after a while (or else your hard drive will
  //  fill up).
  //  For those interested I then use Adobe Premiere which allows you to
  //  import a sequence of frames and render out as a video. I then use
  //  gifBrewer to turn the video into an animated gif
  //saveFrame("frames/frame_####.png");
  if (frameCount >= 360 * rotMod * 1.5) {
    exit();
  }

}

//  A very simple class that stores everything I need for the lines. I supposed I could
//  have added the draw method for the line in here, so each one drew itself, but meh
//  maybe if I was going to do something extra with it.
class FloatingLine {
  float x1;
  float y1;
  float z1;
  float x2;
  float y2;
  float z2;
  color col;
  
  FloatingLine(float tx1, float ty1, float tz1, float tx2, float ty2, float tz2, color tc) {
    x1 = tx1;
    y1 = ty1;
    z1 = tz1;
    x2 = tx2;
    y2 = ty2;
    z2 = tz2;
    col = tc;
  }
}