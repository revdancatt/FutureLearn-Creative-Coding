//  This is slightly modified to only add hexes if they are
//  with a certain distance of the middle

//  This works out the loop needed for a hexagon
ArrayList<HexPoint> makeGrid(float radius, float maxDistance) {

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
  int number_of_hexes = ceil(leftover_width/(radius*3));
  float start_x_offset = -(number_of_hexes*(radius*3));
  
  float leftover_height = (height/2)-(hex_height/2);
  number_of_hexes = ceil(leftover_height/(hex_height));
  float start_y_offset = -((number_of_hexes*(hex_height))+(hex_height/2));
  
  int counter = 0;
  for (float y = start_y_offset; y <= abs(start_y_offset)+(hex_height*2); y+=(hex_height/2)) {    
    boolean shift_hex = false;
    if (counter % 2 == 0) {
      shift_hex = true;
    }
    for (float x = start_x_offset; x <= abs(start_x_offset)+(radius*3); x+=(radius*3)) {
      float newX = x;
      if (shift_hex) {
        newX += radius*1.5;
      }
      //  Only add the point if it's within a certain distance
      if (dist(0, 0, newX, y) <= maxDistance) {
        hexPoints.add(new HexPoint(newX, y));
      }
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