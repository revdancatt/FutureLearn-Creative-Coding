/*
Pixel Peeping Code for Future Learn Creative Coding
Rev Dan Catt

This takes an image (stores the original) and then moves
triangles around from one place to another. We're doing
this because triangles are a challenge, computers do 
rectangles really well, triangles not so much.
*/

int      maxRows;
int      maxCols;
int      counter;

float    diagDist;

String   sourceName = "source01";
String   triangleName = "triangle60"; // also comes in 20, 30 & 40 size.
PImage   source;
PImage   triangle;

void setup() {
  
  //  Set the stage really small, in *new* processing you
  //  can't use variables to set the size. So we make the
  //  stage 1x1 to start with, load in the source image
  //  and then use the surface.setSize function to set
  //  the new size
  size(1,1);
  source = loadImage(sourceName + ".jpg");
  source.loadPixels();
  surface.setSize(source.width, source.height);

  //  Because triangles are hard we are going to use a
  //  png of a triangle that has transparency. When we
  //  copy pixels from one place to another we will use
  //  this as a "mask" to define just how transparent
  //  the pixel we are drawing is going to be.
  //
  //  I'm using an image as the mask as it probably easier
  //  for people to understand what's going on. We could
  //  to be a bit more advance create a new "triangle canvas"
  //  and use processing to draw the shape we want to move
  //  over onto it, assuming the edges are nice and smoothed
  //  this would also work. The advantage of drawing a shape
  //  to be the "master mask" of the pixels we are going to
  //  move is that we can do some cool stuff with dynamically
  //  changing it into funky different shapes. *But* for the
  //  moment, here's an image mask...
  triangle = loadImage(triangleName + ".png"); 
  triangle.loadPixels();

  //  Otherwise it's too fast
  frameRate(1);
  
  //  We're never going to be stroking anything in this
  noStroke();

  counter = 0;
  
  //  We split the image into a grid of rows and columns that we
  //  will be stepping through, because some triangles point up
  //  and others down, we need to step thru at half the width
  //  of the triangle, so they fit snugly together.
  maxRows = floor(height / triangle.height);
  maxCols = floor(width / (triangle.width/2));
  
  //  I want to keep track of the diaginal distance from the
  //  center of the image to the corner. This is because in some
  //  later calculations I want the chances of moving triangles
  //  around to happen more in the middle then the edge (for
  //  aesthetic reasons). We'll be using this measurement in those.
  diagDist = sqrt(dist(0,0,width/2,height/2));
  
}

void draw() {

  //  Because this would be a fine thing...
  float chance;
  
  //  Right, blat the image right onto the canvas.
  image(source, 0, 0);
  
  //  Now loop thru the rows and cols...
  for (int r=0; r<maxRows; r++) {
    for (int c=0; c<maxCols; c++) {

      //  Work out the rough pixel co-ords of this col & row. so we can
      //  calculate the distance. We don't do anything else with 
      //  these x,y values, so it doesnt really matter that they
      //  aren't going to be pixel perfect.
      int x = c * (triangle.width/2);
      int y = r * (triangle.height);
      
      //  Work out the distance from the center
      float thisDist = sqrt(dist(x,y,width/2,height/2));
      
      //  Increase the chance of a swap as we get closer to the center
      //  If *this* distance is pretty much the same as the diaginal distance,
      //  then there should be a 1% chance of doing a triangle swap. If
      //  we are right in the middle then a 30% chance of a swap.
      //  For larger triangles this is less obvious (because there are less
      //  of them) You can play with these values (making them the same or
      //  extreme) to see the effect. (150,-15) is good.
      //  (-100, 100) will also work, *but* only if you comment out the
      //  2nd drawTriangle call below.
      chance = int(map(thisDist,0,diagDist,1,30));
      float doit = random(0,100);

      //  If we roll lower than the chance then we swap
      if (doit<chance) {
        
        //  Favor picking rows and cols near the middle of the image
        //  Instead of picking a random number between 0 and the maxRows
        //  we pick two numbers between half the value. This is like
        //  instead of rolling 1 twelve sided dice, we roll 2 6 sided
        //  dice. Rolling a 1d12 gives us an even chance of picking
        //  any number. But 2d6 throwing 2 six-sided dice will give us
        //  a bell curve, favoring the middle numbers (7) more than
        //  throwing doubles (2 | 12).
        //  And so, as we look at the points, that increase their chance
        //  of being swapped based on the (doit<chance) above, now we
        //  pick a triangle to be swapped with, which is also favoring
        //  images from the middle.
        int sourceRow = int(random(0,maxRows/2)) + int(random(0,maxRows/2));
        int sourceCol = int(random(0,maxCols/2)) + int(random(0,maxCols/2));
        
        //  Something is slighty off in my calculations, meaning that sometimes
        //  depending on the size of the source image things can go a bit wrong
        //  at the edges. This is a hacky fix(ish) to that.
        if (sourceRow > maxRows-2) {sourceRow = maxRows-2;}
        if (sourceCol > maxCols-2) {sourceCol = maxCols-2;}
        
        //  Move the triangle from one place to the other
        //  and back.
        //  Note: We always read pixel values from the original source
        //  but write to the onscreen image. That way we if we pick the
        //  same point twice, we don't use the new written over image to
        //  swap from, but rather the original.
        drawTriangle(r, c, sourceRow, sourceCol);
        drawTriangle(sourceRow, sourceCol, r, c); // <-- optionally remove this.

      }
    }
  }

  //  Save the frames if you must, and then pick the one that pleases
  //  you the most. Normally we'd just stick these in a "frames"
  //  directory, but here I think it's handy to name the folder 
  //  after the name of the source filename. And by handy I mean
  //  I kept forgetting to save/change the frames and then wrote
  //  over them next time I tried running the code with a different
  //  source image.
  saveFrame(sourceName + "/frame_####.png");

}

void drawTriangle(int targetRow, int targetCol, int sourceRow, int sourceCol) {
  
  //  Based on the row and col, we work out the pixel offset at which
  //  we want to start *writing* the pixels
  int targetStartPixelX = targetCol * (triangle.width/2);
  int targetStartPixelY = targetRow * (triangle.height);

  //  Work out if the target is flipped. By default the
  //  triangle points up /\ (in one row every odd triangle
  //  will be flipped, then in ever other row each even
  //  triangle will be fliiped). Much use of % to figure it
  //  out. There is absolutely a single line way of doing
  //  this, but how readable would that be huh?
  boolean targetPointingDown = false;
  if (targetRow % 2 == 0 && targetCol % 2 == 0) {
    targetPointingDown = true;
  }
  if (targetRow % 2 == 1 && targetCol % 2 == 1) {
    targetPointingDown = true;
  }
  
  //  Now get the area we are going to read pixels from  
  int sourceStartPixelX = sourceCol * (triangle.width/2);
  int sourceStartPixelY = sourceRow * (triangle.height);

  //  Work out if the source is flipped. By default the
  //  triangle points up /\ (see above).
  boolean sourcePointingDown = false;
  if (sourceRow % 2 == 0 && sourceCol % 2 == 0) {
    sourcePointingDown = true;
  }
  if (targetRow % 2 == 1 && sourceCol % 2 == 1) {
    sourcePointingDown = true;
  }

  //  if the source and target are pointing in differnet directions, then we need
  //  to flip the image when we come to copy the pixels from one place to another
  boolean flipBlit = false;
  if (targetPointingDown == true && sourcePointingDown == false) {flipBlit = true;}
  if (targetPointingDown == false && sourcePointingDown == true) {flipBlit = true;}

  
  //  Now loop thru the whole triangle image which is the size of the 
  //  area we want to write to.
  //  Note: we are reading/writing a rectangle area, but using the alpha
  //  from the triangle to decide how we are going to write.
  for (int y=0; y < triangle.height; y++) {
    for (int x=0; x < triangle.width; x++) {
      
      //  Pick pick point of the triangle we are going to read from,
      //  this will give us the alpha value that we want to write with.
      //  If the target area is flipped then we read from the bottom
      //  of the triangle up. i.e. we will draw \/ rather than /\
      int triPixelPoint = (y*triangle.width)+x;
      if (targetPointingDown == false) {
        triPixelPoint = (((triangle.height-1)-y)*triangle.width)+x;
      }

      //  Grab the pixel value from the triangle (really we just want the alpha)
      //  value from it.
      color triCol = triangle.pixels[triPixelPoint];

      //  Now we are going to work out where we are going to write the pixel too,
      //  Which is the start pixel plus the offset
      int targetPixelX = targetStartPixelX + x;
      int targetPixelY = targetStartPixelY + y;

      int sourcePixelX = sourceStartPixelX + x;
      int sourcePixelY = sourceStartPixelY + y;
      if (flipBlit == true) {
        sourcePixelY = sourceStartPixelY + ((triangle.height-1)-y);
      }
      int sourcePixelPoint = (sourcePixelY * source.width) + sourcePixelX;

      color sourceColour;
      sourceColour = source.pixels[sourcePixelPoint];
      
      //  Grab the colour from the source pixel array, but the alpha from the
      //  triangle
      fill(red(sourceColour), green(sourceColour), blue(sourceColour), alpha(triCol));

      //  Draw a rectangle (point doesn't work, as it has slight alpha)
      //  Don't believe me, swap this in for point and see what happens.
      rect(targetPixelX, targetPixelY,1,1);
      point(targetPixelX, targetPixelY);

    }
  }

}