/*
 * Creative Coding
 * Week 2, 03 - 25 Squares
 * 
 */

//  Using Handy: www.gicentre.net/handy to give the short fat lines
//  a rough edge
import org.gicentre.handy.*;
HandyRenderer h;

int    frame     = 0;

void setup() {

  size(500, 500);
  h = new HandyRenderer(this);
  h.setIsAlternating(true);
  h.setHachureAngle(-45);
  //h.setRoughness(1);
  
  rectMode(CENTER);
  frameRate(1); // make it slow so we can see what happens
  
}


void draw() {

  colorMode(RGB, 255);
  background(226,228,239);
  int border   = 21;  // the size of the border around the image;
  int across   = 5;   // the number of tiles we are going to place across;
  int gap      = 5;   // the number of pixels between each tile;
  int wiggle   = int(gap*1.25);
  
  //  work out how wide the tile should be
  int tile_width = (width - (border*2) - (gap*(across-1))) / 5;

  colorMode(HSB, 100);
  int hu = int(random(1,100));
  //  Make sure the first frame is always red (because this is
  //  the one we want to submit for the class).
  if (frameCount == 0) {
    hu = 0;
  }
  
  //  Draw all the things!!
  for (int y=0; y<across; y++) {
    for (int x=0; x<across; x++) {
      //  work out the position
      int offsetX = border + (x*(tile_width+gap)) + (tile_width/2) + int(random(-wiggle, wiggle));
      int offsetY = border + (y*(tile_width+gap)) + (tile_width/2) + int(random(-wiggle, wiggle));

      //  1 in 5 times we want to use the slight different colour
      if (int(random(1,100)) <= 20) {
        fill(hu,100,80,80);
        tint(hu,100,80,80);
      } else {
        fill(hu,100,32,80);
        tint(hu,100,32,80);
      }
    
      //  Draw the square
      strokeWeight(1);
      h.rect(offsetX, offsetY, tile_width, tile_width);

      //  Draw the outline
      noFill();
      stroke(0,0,0);
      strokeWeight(2);
      h.rect(offsetX, offsetY, tile_width, tile_width);
      
    }
  }
  
 //saveFrame("frames/square_###.png");  
  
}