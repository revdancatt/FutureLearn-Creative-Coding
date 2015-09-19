/*
 * Creative Coding
 * Week 3, Lession 3.13
 * by Rev Dan Catt
 *
 * Draws the pretty lines
 */
 
//  Note, we are only just learning about arrays now, normally this would be
//  tucked into an array of point objects, and yet here we are.
int       numArray    = 12; //  The number of points 12-24 is good.
int       reset       = 0;  //  How often we clear the draw area and start again

float[]   x           = new float[numArray];  //  x positions for the end points
float[]   y           = new float[numArray];  //  y positions for the end points
color[]   c           = new color[numArray];; //  The colour of the points
float[]   xInc        = new float[numArray];;
float[]   yInc        = new float[numArray];;
float     proximity;

void setup() {

  //  Goint to make this one nice and big, scale to fit obvs
  size(1920, 1080);
  //size(500, 500);
    
  //  We should probably make this a function of the size, but I was too busy
  //  tweeking it by hand to do that.
  proximity = 480;
 
   //  Now we loop over the number of points we want giving them positions and colours
  for (int i=0; i<numArray; i++) {
    x[i] = random(width);
    y[i] = random(height);
    xInc[i] = random(-1, 1);
    yInc[i] = random(-1, 1);
    
    //  Set up the colours for each point, this cycles round
    //  Yellow, Cyan & Magenta, with every 3rd point being
    //  one of the colours.
    //  CYM
    if (i % 3 == 0) {c[i] = color(255,255,0);}
    if (i % 3 == 1) {c[i] = color(0,255,255);}
    if (i % 3 == 2) {c[i] = color(255,0,255);}

    //  Or you can use these colour schemes (and why not make your own)
    // RGB
    //if (i % 3 == 0) {c[i] = color(255,0,0);}
    //if (i % 3 == 1) {c[i] = color(0,255,0);}
    //if (i % 3 == 2) {c[i] = color(0,0,255);}

    // B&W
    //if (i % 3 == 0) {c[i] = color(255,255,255);}
    //if (i % 3 == 1) {c[i] = color(128,128,128);}
    //if (i % 3 == 2) {c[i] = color(0,0,0);}

  }
  
  //  Fill the background black, using 255 (white)
  //  works well for the B&W colours.
  background(0);
  
}

void draw() {

  //  Adjust the speed the lines move, increase for faster
  //  reduce for slower
  float zoom = 1;
  
  
  //  Update the position of the points and flip the direction
  //  the point is moving if it hits an edge.
  for (int i=0; i<numArray; i++) {

    x[i] += xInc[i]*zoom;
    y[i] += yInc[i]*zoom;

    //  bounce off the sides of the window
    //  *NOTE* This isn't how I'd write the code, I unroll this to make it more
    //  readable in later code version. Also, the code as written here has a
    //  small flaw in logic which can cause points to become trapped near edges
    //  see if you can spot it.
    if (x[i] > width || x[i] < 0) {
      xInc[i] = xInc[i] > 0 ? -random(1) : random(1);
    }

    if (y[i] > height || y[i] < 0 ) {
      yInc[i] = yInc[i] > 0 ? -random(1) : random(1);
    }

  }

  
  //  Now check the distance between each point
  for (int i=0; i<numArray; i++) {
    for (int j=0; j<i; j++) {
      //  Get the distance between the points
      float distance = dist(x[i], y[i], x[j], y[j]  );
      //  If it's less than the proximity that we want to draw the line at
      //  then we can go ahead and draw the line
      if (distance < proximity) {

        //  Now we want to know what colour to draw, to do this we are going to
        //  look at the colour of the two points, and pick the final colour
        //  based on those.
        //
        //  So if both end points were Yellow, then the final colour will be yellow.
        //  If one end is Yellow and the other is Cyan, then the colour we pick will
        //  be somewhere between the two.
        //
        //  To decide how much of each colour to use, we use the distance. The distance
        //  is always going to be somewhere between 0 and proximity. The lerpColor
        //  lets us specify which point between the two end colours to use. If the
        //  distance is 240px, and the proximity is 480px, then pickColour will end
        //  up halfway between 0.0 and 1.0 ... which is 0.5. lerpColor will pick a
        //  colour exactly half way between the two points.
        //
        //  This way the colour changes as the points move closer or further away. If
        //  yellow and cyan points start really closely, the we'll be using more yellow
        //  than cyan in the final colour. As they move apart reaching the final proximity
        //  the colour will change from yellow to cyan.
        
        //  Pick how far we are going to select between the two colours
        float pickColour = map(distance, 0, proximity, 0.0, 1.0);
        //  Now pick the new colour from between the 1st and 2nd points.
        color newColor = lerpColor(c[i], c[j], pickColour);

        //  Finally as the points move apart I want the opacity to drop off. When
        //  they are at the furthest distance possible then the line should be
        //  0 alpha transparency.
        
        //  Pick a transparency between 32 and 0. i.e. close together = (slightly) visible,
        //  far apart = more transparent.
        float alpha = map(distance,0,proximity,32,0);
        
        //  Finally set the line colour. I'm not sure how to add an alpha value
        //  to an already defined colour. So instead we'll create a new colour
        //  from the rgb values in the newColor and add the alpha here
        stroke(red(newColor),green(newColor),blue(newColor), alpha);

        //  And draw the line.
        line(x[i], y[i], x[j], y[j]);
      }
    }
  }

  //  I don't want to save every frame, but I do want to save some as the image
  //  gets drawn, this saves a png every 250 frames.
  if (frameCount % 250 == 0) {
    //saveFrame("frames/frame_######.png");

    //  Increase the reset value
    reset++;
    
    //  If we've increased it 10 times, which is 10 lots of 250 frames, then
    //  fill the background in black, and reset the reset counter. This
    //  essentially starts a new drawing. This way we can just leave the whole
    //  thing going and pick the best frames.  
    if (reset>=10) {
      background(0);
      reset=0;
    }
  }

}