//
//  Future Learn Creative Coding week 3 (probably)
//

//  Using handy again, see previous sketches for the URL to install it
import org.gicentre.handy.*;
HandyRenderer h;


float   x, y;   // current drawing position
float   dx, dy;
float   dx2, dy2;
float   frame;

PImage img;

void setup() {
  
  //  Doing this big, and also so we can see the source image.
  //  In the "real world" we wouldn't display the image
  size(2000,1000);
  h = new HandyRenderer(this);
  img = loadImage("zachary.png");
  image(img, 0, 0, 1000, 1000);

  // initial position in the centre of side we want to draw in
  x = width*0.75;
  y = height*0.5;

  //  set a random velocity
  dx = random(-3, 3);
  dy = random(-3, 3);
  frame = 0;
  
  //  Fill in the side we are going to draw on.
  noStroke();
  fill(255);
  rect(width/2,0,width/2,height);
  stroke(0);
  noFill();
}

void draw() {
 
  //  This is slow but just to keep things sane for the moment reblit
  //  the image each time
  image(img, 0, 0, 1000, 1000);
  float rad = radians(frame);

  //  Move the x and y by the dx,dy values
  x += dx;
  y += dy;

  //  If we hit an edge, then we want to start heading in a new
  //  direction with a different velocity
  float max = 3;
  float min = 2;

  if (x > width-100) {
    dx = -random(min, max);
  }

  if (y > height-100) {
    dy = -random(min, max);
  }
  
  if (x < (width/2)+100) {
    dx = random(min, max);
  }

  if (y < 100) {
    dy = random(min, max);
  }

  //  This is all the normal stuff to move a controlling point around the screen
  //  from which we draw the lines
  float bx = x + 100 * sin(rad);
  float by = y + 100 * cos(rad);

  //  Extract the colour we want to use from the image on the left
  //  that matches the control point we are draw based on, on the
  //  right
  color c = get(int(bx)-width/2,int(by));
  float shade = ((red(c)+green(c)+blue(c))/3);
  float maxShade = 255;

  //  Draw longer lines where the shade is lighter, shorter where
  //  they are dark.
  float radius = map(shade,0,maxShade,5,100);
  float x2 = bx + radius * sin(radians(frame));
  float y2 = by + radius * cos(radians(frame));
  float x3 = bx - radius * sin(radians(frame));
  float y3 = by - radius * cos(radians(frame));
 
  //  Again, we are modifying the line based on the
  //  shade of the line underneath. In this case
  //  we are making the short dark lines thinker.
  strokeWeight(map(shade,0,maxShade,3,0.6));
  h.setRoughness(map(shade,0,maxShade,3,0.6));
  stroke(c,64-(shade/4));
  if (int(frameCount) % 1 == 0) {
    h.line(x2,y2,x3,y3);
  }
      
  //  I was doing something crazy here that involves doing something
  //  after a certain amount of "drawing" had been done. But
  //  I totally forget what. Something while doing rapid iterations
  //  I suspect.
  frame += map(shade,0,maxShade,1,1);
  
  //  Save every 200th frame so we can build up an animation without filling the
  //  hard drive with every new line.
  if (int(frameCount) % 200 == 0) {
    saveFrame("frames/frame_######.png");
  }
  
}