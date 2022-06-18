float[] carA = {100, 100};
float[] carB = {200,50};

float[] car_to_polar (float[] input) {
  float r = dist(0, 0, input[0], input[1]);
  float[] out = {r, atan2(input[0], input[1])};
  return out;
}

void setup(){
  size(480, 480);
  
  println(car_to_polar(carA)[0], car_to_polar(carA)[1]);
  println(car_to_polar(carB)[0], car_to_polar(carB)[1]);
}
