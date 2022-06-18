float[] carA = {50, 50};
float[] carB = {100, 25};
float[] carC = {0, 0};

float[] car_to_polar (float[] input) {
  float r = dist(0, 0, input[0], input[1]);
  float[] out = {r, atan2(input[1], input[0])};
  return out;
}

float[] polar_to_car (float[] input) {
  float[] output = {input[0] * cos(input[1]), input[0] * sin(input[1])};
  return output;
}

void point_polar (float[] polar) {
  float[] car = polar_to_car(polar);
  point(car[0], car[1]);
  // circle(car[0], car[1], 2);
}

float[] mfmrotate (float[] from, float rad, float r) {
  // float to_r = sqrt(sq(from[0]) + sq(r) - 2 * r * from[0] * cos(rad));
  // float to_rad = asin((r * sin(rad)) / to_r) + from[1];
  float[] carfrom = polar_to_car(from);
  float cartox = carfrom[0] + r * cos(rad + from[1]);
  float cartoy = carfrom[1] + r * sin(rad + from[1]);
  float[] carto = {cartox, cartoy};
  float[] to = car_to_polar(carto);
  return to;
}

float[] mfmrotate (float[] from, float rad, float r, boolean debug) {
  // float to_r = sqrt(sq(from[0]) + sq(r) - 2 * r * from[0] * cos(rad));
  // float to_rad = asin((r * sin(rad)) / to_r) + from[1];
  float[] carfrom = polar_to_car(from);
  float cartox = carfrom[0] + r * cos(rad + from[1]);
  float cartoy = carfrom[1] + r * sin(rad + from[1]);
  if (debug) {
    circle(carfrom[0], carfrom[1], 3);
    line(carfrom[0], carfrom[1], cartox, cartoy);
    print("from: ", carfrom[0], ", ", carfrom[1]);
    println(" to: ", cartox, ", ", cartoy);
  }
  float[] carto = {cartox, cartoy};
  float[] to = car_to_polar(carto);
  return to;
}



void setup(){
  size(480, 480);
  translate(width/2, height/2);
  
  println(car_to_polar(carA)[0], degrees(car_to_polar(carA)[1]));
  println(car_to_polar(carB)[0], degrees(car_to_polar(carB)[1]));

  float[] polA = car_to_polar(carA);
  float[] polB = car_to_polar(carB);

  point(100,100);
  point_polar(polA);
  point_polar(polB);
  for (int i = 0; i < 120; ++i) {
    point_polar(mfmrotate(polA, radians(i), 10));
  }

  // point_polar(mfmrotate(
  //   car_to_polar(carC),
  //   radians(0),
  //   200,
  //   true
  // ));
  // point_polar(mfmrotate(
  //   car_to_polar(carC),
  //   radians(60),
  //   200,
  //   true
  // ));
  // point_polar(mfmrotate(
  //   mfmrotate(
  //     car_to_polar(carC),
  //     radians(60),
  //     200,
  //     true
  //   ),
  //   radians(60),
  //   100,
  //   true
  // ));

  for (int i = 0; i < 360; ++i) {
    point_polar(mfmrotate(
      mfmrotate(
        car_to_polar(carC),
        2.0 * PI * ((float)i/360.0), 
        50
      ),
      2.0 * PI * ((float)i/360.0) * (-3.0), 
      50.0
    ));
  }
}

int i = 0;
boolean first = true;

void draw(){
  if (first) {
    first = false;  //<>//
  }
  translate(width/2, height/2);
  background(#CCCCCC);
  ++i;
  point_polar(mfmrotate(
    mfmrotate(
      car_to_polar(carC),
      2.0 * PI * ((float)i/360.0), 
      50, true
    ),
    2.0 * PI * ((float)i/360.0) * (-3.0), 
    14.0, true
  ));
}
