import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*; // So we have access to the mixer inputs

Minim         minim;
AudioInput    in;
FFT           fft;
Mixer.Info[] mixerInfo;

//  Some FFT code used from @praystation's new graphics/audio course...
//  https://gumroad.com/joshuadavis
int           inRange     = 16;
int           inMax       = 100;
float         inAmp       = 80.0;
float         inIndex     = 0.2;
float         inIndexAmp  = inIndex;
float         inIndexStep = 0.35;
float[]       inData      = new float[inRange];


PImage        aurora;
int           starRandomSource;
float         starSpeed;
int           recenterCounter = 0;
int           grabNow;
int           maxFrameTime;
float         flySpeed;
float         auroraCount;
float         auroraSpeed;

ArrayList<FireFly> fireFlies = new ArrayList<FireFly>();
ArrayList<HexPoint> hexPoints_large;
ArrayList<HexPoint> hexPoints_medium;
ArrayList<HexPoint> hexPoints_small;

void setup() {

  //  HD!!!
  size(1280,720);

  //  Pick a random seed and use it
  starRandomSource = int(random(0,10000));
  randomSeed(starRandomSource);

  //  Make the stars move over the course of about 18,000 frames (5 mins at 60fps)
  starSpeed = 60*60*60/width;
  maxFrameTime = 1800;
  //  Initial speeds of things which will be based on music
  flySpeed = 0.2;
  auroraSpeed = 0.1;
  auroraCount = 0;
  aurora = loadImage("aurora.png");

  //  utility code for taking screenshots
  grabNow = int(random(500,1000));
  
  //  Set up the audio input device
  minim   = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  for(int i = 0; i < mixerInfo.length; i++)
  {
    println(i + ": " + mixerInfo[i].getName());
  }

  //  I'm using Soundflower (2ch) to pipe audio in from KOMPLETE KONTROL
  //  Look at the debug window to see what audio mixers are available on
  //  your system...
  //  ***** THIS WILL THROW AN ERROR FOR YOU, UNTIL YOU SET UP A VALID INPUT ***
  Mixer mixer = AudioSystem.getMixer(mixerInfo[6]);
  minim.setInputMixer(mixer); //  Apparently this is bad
  
  //  Now get the line in, and turn monitoring on so we can
  //  hear what's going on
  in = minim.getLineIn(Minim.MONO);
  in.enableMonitoring();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.linAverages(inRange);
  
  //  Create a bunch of fireflies
  for (int f = 0; f <= 24; f++) {
    fireFlies.add(new FireFly(f, random(0,width), random(0,height), random(0,359), random(0.1,1.1), false));
  }
  
  //  Set up the hexes that will react to sound
  hexPoints_large = makeGrid(200);
  hexPoints_medium = makeGrid(90);
  hexPoints_small = makeGrid(40);

}

void draw() {
  
  background(0);
  doAudioStuff();
  drawStars();
  drawSky();
  drawAurora();
  drawLand();
  updateFireFlies();
  drawFireFlies();
  drawHexes();
  drawFFT();
  
  //  This resets the scene with new colours and saves random frames
  //  vary these to change when you save frames and when you
  //  change everything
  /*
  if (frameCount == grabNow) {
    grabNow += int(random(500,1000));
    starRandomSource = int(random(0,10000));
  }
  if (frameCount == 1 || frameCount % 200 == 0) {
    saveFrame("seed_" + starRandomSource +"/frame_#####.png"); 
  }
  */
}


void doAudioStuff() {
  //  Grab the FFT data from the audio
  fft.forward(in.mix);
  for (int i = 0; i < inRange; ++i) {
    float tempIndexAvg = (fft.getAvg(i) * inAmp) * inIndexAmp;
    float tempIndexCon = constrain(tempIndexAvg, 0, inMax);
    inData[i]     = tempIndexCon;
    inIndexAmp+=inIndexStep;
  }
  inIndexAmp = inIndex;

  //  We are really only interested in the 1st 4 values, which is where all the
  //  actions is happening, the first value is the speed of the aurora
  auroraSpeed = inData[0]/100*16;
  
  //  The fly speed is the 3rd bar
  flySpeed = inData[2]/100*16;
}

void drawFFT() {
  noStroke();
  fill(0,200);
  for (int i = 0; i < inRange; ++i) {
    fill(255,255,255,64);
    rect(10 + (i*5), (height-inData[i])-11, 4, inData[i]);    
  }
}

void drawStars() {
  colorMode(RGB,255);
  randomSeed(starRandomSource);

  float horizon = height/3*2;
  stroke(255);
  for (int star = 0; star < 500; star++) {
    point(random(-width,width)+(float(frameCount)/starSpeed),random(0,horizon));
  }
     
}
  
void drawSky() {
  colorMode(HSB,100);
  int skyHue = int(random(0,100));
  float horizon = height/3*2;
  
  //  Now put the other colour in
  for (int y = 0; y < horizon; y++) {
    stroke(skyHue, 100, 50, int(map(y,0,horizon,0,100-(100*(float(frameCount)/maxFrameTime)))));
    line(0,y,width,y);
  }
}




void drawAurora() {
  colorMode(RGB,255);
  randomSeed(starRandomSource);
  float horizon = height/3*2;
  int auroraTop = int(horizon*0.33);
  int auroraBottom = int(horizon*0.66);
  int auroraStart = int(width*random(0.1,0.4));
  int auroraEnd = auroraStart + int(random(width*0.1, width*0.3));
  int auroraHeight = 100;
  
  for (int y = auroraTop; y <= auroraBottom; y++) {
    float x = auroraStart + (sin(radians((auroraCount/3)+(y*3)))+1)*((auroraEnd-auroraStart)*map(y,auroraTop,auroraBottom,0.2,0.5)) + map(y,auroraTop,auroraBottom,200,0);
    image(aurora, x, y-100, 2, 100);
  }
  
  //  Now increase the auroraCount, this is what makes it move
  auroraCount+=auroraSpeed;
  
}




void drawLand() {
  randomSeed(starRandomSource);

  colorMode(HSB,100);
  int landHue = int(random(0,100));
  color land1 = color(landHue,73,32*(1-float(frameCount)/(maxFrameTime*1.5)));
  color land2 = color(landHue,65,40*(1-float(frameCount)/(maxFrameTime*1.5)));
  color land3 = color(landHue,69,56*(1-float(frameCount)/(maxFrameTime*1.5)));
  
  float horizon = height/3*2;
  float hOffset1 = (height - horizon) * 0.15;
  float hOffset2 = (height - horizon) * 0.3;
  
  noStroke();

  //  First hill
  fill(land1);
  beginShape();
    curveVertex(-100,horizon);
    curveVertex(-100,horizon);
    curveVertex(width*map(random(1),0,1,0.2,0.4), horizon-(map(random(1),0,1,0,80)));
    curveVertex(width*map(random(1),0,1,0.5,0.8), horizon-(map(random(1),0,1,0,80)));
    curveVertex(width+100,horizon);
    curveVertex(width+100,horizon);
  endShape();
  rect(0,horizon,width,height);

  
  //  Second hill
  fill(land2);
  beginShape();
    curveVertex(-100,horizon+hOffset1);
    curveVertex(-100,horizon+hOffset1);
    curveVertex(width*map(random(1),0,1, 0.10, 0.25), horizon-(map(random(1),0,1,0,60))+hOffset1);
    curveVertex(width*map(random(1),0,1, 0.35, 0.65), horizon-(map(random(1),0,1,0,60))+hOffset1);
    curveVertex(width*map(random(1),0,1, 0.75, 0.90), horizon-(map(random(1),0,1,0,60))+hOffset1);
    curveVertex(width+100,horizon+hOffset1);
    curveVertex(width+100,horizon+hOffset1);
  endShape();
  rect(0,horizon+hOffset1,width,height);
  
  //  Third hill
  fill(land3);
  beginShape();
    curveVertex(-100,horizon+hOffset2);
    curveVertex(-100,horizon+hOffset2);
    curveVertex(width*map(random(1),0,1, 0.05, 0.15), horizon-(map(random(1),0,1,0,40))+hOffset2);
    curveVertex(width*map(random(1),0,1, 0.25, 0.35), horizon-(map(random(1),0,1,0,40))+hOffset2);
    curveVertex(width*map(random(1),0,1, 0.45, 0.60), horizon-(map(random(1),0,1,0,40))+hOffset2);
    curveVertex(width*map(random(1),0,1, 0.75, 0.90), horizon-(map(random(1),0,1,0,40))+hOffset2);
    curveVertex(width+100,horizon+hOffset2);
    curveVertex(width+100,horizon+hOffset2);
  endShape();
  rect(0,horizon+hOffset2,width,height);
  
  for (int s = 0; s <= 12; s++) {
    //  Now we are going to draw some random squares
    int squareSize = int(random(30,150));
    float squareX = random(-30,width+30);
    float squareY = random(horizon, height);
    int squareRot = int(random(45,45));
    
    noStroke();
  
    fill(land1);
    pushMatrix();
      translate(squareX, squareY);
      rotate(radians(squareRot));
      rect(0,0,squareSize,squareSize);
    popMatrix();
    
    fill(land3);
    pushMatrix();
      translate(squareX+(squareSize*0.06), squareY+(squareSize*0.1));
      rotate(radians(squareRot));
      rect(0,0,squareSize,squareSize);
    popMatrix();
  }
  
}




//  update the position of the flies
void updateFireFlies() {

  //  Here we are going to do a weird boid thing to move our flies around
  //  where we base the center point we are going to fly around to be
  //  somewhere near the middle of all the flies
  int fly1id = 1;
  int fly2id = 2;
  int fly3id = 3;
  int fly4id = 4;
  
  
  //  First I want to work out the two flies that are furthest apart
  float maxDist = -999999;
  for (int f2 = 0; f2 < fireFlies.size(); f2++) {
    FireFly fly2 = fireFlies.get(f2);
    for (int f1 = 0; f1 < fireFlies.size(); f1++) {
      FireFly fly1 = fireFlies.get(f1);
      if (f1 == f2) {continue;}
      float thisDist = PVector.dist(fly1.location, fly2.location);
      if (thisDist > maxDist) {
        maxDist = thisDist;
        fly1id = fly1.id;
        fly2id = fly2.id;
      }
    }
  }

  //  Now we do it again, excluding the two flies we already have, to
  //  find the next two
  maxDist = -999999;
  for (int f2 = 0; f2 < fireFlies.size(); f2++) {
    FireFly fly2 = fireFlies.get(f2);
    if (fly2.id == fly1id) {continue;}
    if (fly2.id == fly2id) {continue;}

    for (int f1 = 0; f1 < fireFlies.size(); f1++) {
      FireFly fly1 = fireFlies.get(f1);
      if (fly1.id == fly1id) {continue;}
      if (fly1.id == fly2id) {continue;}

    if (f1 == f2) {continue;}
      float thisDist = PVector.dist(fly1.location, fly2.location);
      if (thisDist > maxDist) {
        maxDist = thisDist;
        fly3id = fly1.id;
        fly4id = fly2.id;
      }
    }
  }

  //  Now we have gotten the two flies that are the furthest apart
  //  and the next two, we work out the mid points between flies 1&2
  //  and 3&4.
  FireFly fly1 = fireFlies.get(fly1id);
  FireFly fly2 = fireFlies.get(fly2id);
  FireFly fly3 = fireFlies.get(fly3id);
  FireFly fly4 = fireFlies.get(fly4id);
  
  float mid1x = lerp(fly1.location.x, fly2.location.x, 0.5);
  float mid1y = lerp(fly1.location.y, fly2.location.y, 0.5);
  float mid2x = lerp(fly3.location.x, fly4.location.x, 0.5);
  float mid2y = lerp(fly3.location.y, fly4.location.y, 0.5);
 
 
   //  And from *those* midpoints we work out the mid point of those.
  //  We could have found the average x and average y position of all
  //  the flies, but these seems more fun and I wanted to try this
  //  out for a while
  float midx = lerp(mid1x, mid2x, 0.5);
  float midy = lerp(mid1y, mid2y, 0.5);
  
  //  Quick hack to stop the flys buzzing off the screen, when we
  //  start this, keep doing it for 600 iterations before going back to
  //  normal checks. On avergae that should be enough to recenter them
  if (midx < 0 || midx > width || midy < 0 || midy > height || recenterCounter > 0) {
    recenterCounter++;
    midx = random(0, width);
    midy = random(0, height);
    if (recenterCounter > 600) {
      recenterCounter = 0;
    }
  }
  
  PVector midV = new PVector(midx, midy);
  PVector dir;
  
  //  Now we want to make the flies turn towards the mid point.
  

  for (int i = 0; i < fireFlies.size(); i++) {
    FireFly fly = fireFlies.get(i);
    
    float flyDist = PVector.dist(fly.location, midV);
    if (flyDist < fly.dist) {      
      dir = PVector.sub(fly.location, midV);
      fly.velocity.rotate(radians(5));
    } else {
      dir = PVector.sub(midV, fly.location);
      fly.velocity.rotate(radians(-1.5));
    }
    dir.normalize();
    dir.mult(0.5);

    fly.velocity.add(dir);
    fly.velocity.limit(fly.topspeed*flySpeed);
    fly.location.add(fly.velocity);
    
    if (random(0,100) < fly.flipChance) {
      if (fly.litup) {
        fly.flipChance = 10;
        fly.litup = false;
      } else {
        fly.flipChance = 0.5;
        fly.litup = true;
      }
    } else {
      fly.flipChance += 0.5;
    }
    
  }

}




void drawFireFlies() {
  randomSeed(int(random(0,10000)));
  colorMode(RGB,255);
  
  noFill();
  float heightOffset = height*0.33;
  
  for (int i = 0; i < fireFlies.size(); i++) {
    FireFly fly = fireFlies.get(i);
    stroke(0, 0, 0);
    rect(fly.location.x-2, (fly.location.y/2)+heightOffset,4,1);
    //  Are we lit up or not?
    if (fly.litup) {
      stroke(255,255,0);
    } else {
      stroke(128,128,0);
    }
    if (fly.velocity.x > 0) {
      point(fly.location.x-2, (fly.location.y/2)+heightOffset);
      point(fly.location.x-2, (fly.location.y/2)+heightOffset+1);
    } else {
      point(fly.location.x+2, (fly.location.y/2)+heightOffset);
      point(fly.location.x+2, (fly.location.y/2)+heightOffset+1);
    }      
    
  }
  
}




void drawHexes() {

  randomSeed(int(random(0,10000)));
  for (int i = 0; i < hexPoints_small.size(); i++) {
    HexPoint hPoint = hexPoints_small.get(i);
    if (random(0,100) < 15) {
      drawHex(hPoint.x, hPoint.y, 40, 0);
    }
  }

  for (int i = 0; i < hexPoints_medium.size(); i++) {
    HexPoint hPoint = hexPoints_medium.get(i);
    if (random(0,100) < 15) {
      drawHex(hPoint.x, hPoint.y, 90, 0);
    }
  }

  for (int i = 0; i < hexPoints_large.size(); i++) {
    HexPoint hPoint = hexPoints_large.get(i);
    if (random(0,100) < 15) {
      drawHex(hPoint.x, hPoint.y, 200, 0);
    }
  }

}

//  This draws the hex in this position
void drawHex(float x, float y, float radius, int type) {

  //  Type is either
  // [0] = small
  // [1] = medium
  // [2] = large
  if (type == 0) {radius = radius * inData[2]/100;}
  if (type == 1) {radius = radius * inData[1]/100;}
  if (type == 2) {radius = radius * inData[3]/100;}
  
  float NEx = -radius * sin(radians(-30));
  float NEy = -radius * cos(radians(-30));
  float Ex = -radius * sin(radians(-90));
  float Ey = -radius * cos(radians(-90));
  float SEx = -radius * sin(radians(-150));
  float SEy = -radius * cos(radians(-150));
  float SWx = -radius * sin(radians(-210));
  float SWy = -radius * cos(radians(-210));
  float Wx = -radius * sin(radians(-270));
  float Wy = -radius * cos(radians(-270));
  float NWx = -radius * sin(radians(-330));
  float NWy = -radius * cos(radians(-330));
  
  noStroke();
  fill(128, 128, 128, 128);
  
  pushMatrix();
    translate(width/2+x, height/2+y);
    beginShape();
      vertex(NEx, NEy);
      vertex(Ex, Ey);
      vertex(SEx, SEy);
      vertex(SWx, SWy);
      vertex(Wx, Wy);
      vertex(NWx, NWy);
      vertex(NEx, NEy);
    endShape();
  popMatrix();
  
}

class FireFly {
  
  int id;
  float dist;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float bottomspeed;
  boolean litup;
  float flipChance;
  
  FireFly(int tid, float x, float y, float heading, float speed, boolean tlitup) {
    id = tid;
    dist = random(10,height*0.33);
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    topspeed = random(0.5,4);
    bottomspeed = 1;
    flipChance = 0.5;
    litup = tlitup;
  }
}

//  This works out the loop needed for a hexagon
ArrayList<HexPoint> makeGrid(float radius) {

  ArrayList<HexPoint> hexPoints = new ArrayList<HexPoint>();
  
  //  first we can work out the total width of a hexagon
  //  this will be twice the radius
  float hex_width = radius * 2;
  
  //  Now we need to work out the height, to do that we
  //  need to move the second point straight up and then
  //  rotate it
  float NEx = -radius * sin(radians(-30));
  float NEy = -radius * cos(radians(-30));

  float hex_height = abs(NEy*2);
    
  float leftover_width = (width/2)-radius;
  int number_of_hexes = floor(leftover_width/(radius*3));
  float start_x_offset = -(number_of_hexes*(radius*3));
  
  float leftover_height = (height/2)-(hex_height/2);
  number_of_hexes = floor(leftover_height/(hex_height));
  float start_y_offset = -((number_of_hexes*(hex_height))+(hex_height/2));
  
  int counter = 0;
  for (float y = start_y_offset-(hex_height); y <= abs(start_y_offset)+(hex_height*2); y+=(hex_height/2)) {    
    boolean shift_hex = false;
    if (counter % 2 == 0) {
      shift_hex = true;
    }
    for (float x = start_x_offset-(radius*1); x <= abs(start_x_offset)+(radius*2); x+=(radius*3)) {
      float newX = x;
      if (shift_hex) {
        newX += radius*1.5;
      }
      hexPoints.add(new HexPoint(newX, y));
    }
    counter++;
  }
  
  return hexPoints;
  
}

//  This is just a point that's the center of a hex
class HexPoint {
  float x;
  float y;
  
  HexPoint(float tx, float ty) {
    x = tx;
    y = ty;
  }
}