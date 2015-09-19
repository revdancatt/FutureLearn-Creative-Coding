/*
//  Somewhere we are in week 3, and I'm already thinking about tumblr gifs
//  Mess around with the below values to get different results
*/
int       balls        = 30;
int       max_layers   = 40;
int       weirdness    = 3;  //  This is the one you'll want to mess with first
int       radius       = 150;

float     ball_size    = 25;
float     distModMod   = 75;

boolean   do_draw      = true;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
}

void draw() {
  
  //  This is a method to draw only one frame, at the end we set do_draw to
  //  false and then we never draw again. You can use a key press to set it
  //  back to true when you want to advance a frame.
  //  There's probably a built in way to debug processing (but I was writing
  //  this is ver2.x at the time.
  if (do_draw == false) {
    return;
  }
   
  //  Paint it black
  background(0);
  
  //  The base distance we will draw the ball out, and the
  //  value that we can adjust that by
  
  //  Loop throu all the balls, moving from the "back" layer
  //  forwards
  for (int layer=0; layer<max_layers; layer++) {

    //  By this point I now know about map() yay. So let's
    //  draw a ball starting from the back layer upwards
    //  and make the fill colour based on how far down
    //  the layers we are.
    noStroke();
    fill(map(layer, 0, max_layers-1, 0, 255));
      
    //  Now loop round the balls
    for (int ball=0; ball<balls; ball++) {
  
      //  Convert the current ball to a 360 degree thing
      //  No stopping me from using map now I know about it.
      float angle = map(ball, 0, balls, 0, 360);
  
      //  Now we want to make the distMod somewhere between +/- distModMod
      float distMod = distModMod * sin(radians((angle+frameCount)*weirdness));
      distMod = distMod * map(layer, 0, max_layers-1, 0, 1);
      float newRadius = radius;
      newRadius = newRadius * map(layer, 0, max_layers-1, 0.25, 1);
      
      //  So the final radius is the original radius + the +/- distMod
      float thisRadius = newRadius + distMod;
  
      float x = thisRadius*sin(radians(angle)) + width/2;
      float y = thisRadius*cos(radians(angle)) + height/2;
      float newSize = map(layer, 0, max_layers-1, 5, ball_size);
      
      //  Finally, draw the ball
      ellipse(x, y, newSize, newSize);
    }
  }
  
  //saveFrame("frames/frame_###.png");
  //do_draw = false;
  
}