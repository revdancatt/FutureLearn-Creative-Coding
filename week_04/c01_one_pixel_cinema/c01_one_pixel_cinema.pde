String  fileName = "film_thelma_louise";
int     rows;
float   rowWidth;
PImage  source;

void setup() {
  
  //  Because P3 doesn't allow you to set the size based
  //  on variables, we shall make it 1x1 and then resize
  //  once we've loaded the image in.
  size(1,1);
  source = loadImage(fileName + ".jpg");

  //  This will only work in P3, we warned of the slower
  //  startup time.
  surface.setSize(source.width, source.height);

  rows = source.width;
  
  //  set a shrunk down image to pull the colours from
  //  calculate the width of the rows
  rowWidth = float(source.width)/rows;
  size(int(rowWidth*rows), source.height);
  noStroke();
}

void draw() {
  image(source, 0, 0, rows, 2);
  rowWidth = float(source.width)/rows;
  
  //  now we are going to draw the gradient bars
  for (int row = rows-1; row >= 0; row--) {
    //  Get the top colour
    color top = get(row,0);
    color bottom = get(row,1);
    for (int y = height; y >= 0; y--) {
      stroke(lerpColor(bottom,top,map(y,0,height,1,0)));
      line(rowWidth*row,y,rowWidth*(row+1),y);
    }
  }
  
  //rows = int(rows/2);
  rows-=10;
  if (rows <= 0) {
    exit();
  }

  //saveFrame(fileName + "/frame_####.png");
  
}