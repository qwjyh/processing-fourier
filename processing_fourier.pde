float[] carA = {100, 100};
float[] carB = {200,50};
float[] carC = {200, 200};

float[] car_to_polar (float[] input) {
  float r = dist(0, 0, input[0], input[1]);
  float[] out = {r, atan2(input[0], input[1])};
  return out;
}

float[] polar_to_car (float[] input) {
  float[] output = {input[0] * cos(input[1]), input[0] * sin(input[1])};
  return output;
}

float[] mfmrotate (float[] from, float rad, float r) {
  // float to_r = sqrt(sq(from[0]) + sq(r) - 2 * r * from[0] * cos(rad));
  // float to_rad = asin((r * sin(rad)) / to_r) + from[1];
  float[] carfrom = polar_to_car(from);
  float cartox = carfrom[0] + r * cos(rad);
  float cartoy = carfrom[1] + r * sin(rad);
  float[] carto = {cartox, cartoy};
  float[] to = car_to_polar(carto);
  return to;
}

void point_polar (float[] polar) {
  float[] car = polar_to_car(polar);
  point(car[0], car[1]);
  // circle(car[0], car[1], 2);
}


void setup(){
  size(480, 480);
  
  println(car_to_polar(carA)[0], car_to_polar(carA)[1]);
  println(car_to_polar(carB)[0], car_to_polar(carB)[1]);

  float[] polA = car_to_polar(carA);
  float[] polB = car_to_polar(carB);

  point(100,100);
  point_polar(polA);
  point_polar(polB);
  for (int i = 0; i < 120; ++i) {
    point_polar(mfmrotate(polA, radians(i), 10));
  }

  for (int i = 0; i < 360; ++i) {
    point_polar(mfmrotate(
      mfmrotate(
        car_to_polar(carC),
        2.0 * PI * ((float)i/360) * (-2.0), 
        14
      ),
      2.0 * PI * ((float)i/360), 
      50
    ));
  }
}
