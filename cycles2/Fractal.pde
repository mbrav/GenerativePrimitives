// Based on Vincent D. Warmerdam's formula
// http://koaning.io/fluctuating-repetition.html

class Fractal {
  // number of points per frame
  int pointsNumber = 10000;
  PVector pos = new PVector(0,0,0);

  // Formula variables
  float[] vars = new float[6];
  int morphingVar;

  float add;
  int frames;

  boolean reverse = false;

  PVector max = new PVector(0,0,0);
  PVector min = new PVector(0,0,0);

  Fractal(float _add, int _frames) {
    add = _add;
    frames = _frames;

    randomizeFractal();
  }

  // draw the Fractal
  void draw() {
    render(true);
  }

  // a funtion that simulates the randomized variables
  // checks if the animation is "good" enough
  void simulate() {
    int simulationCount = 0;
    int now = millis();

    boolean goodFractal = false;

    // while not a good Fractal, continue simulating
    while (!goodFractal) {

      for (int i = 0; i < vars.length; i++) {
        render(false);
      }

      PVector delta = new PVector(abs(max.x) - abs(min.x),abs(max.y) - abs(min.y),abs(max.z) - abs(min.z));

      if (!(delta.x < 0.1 && delta.y < 0.1 && delta.x < 0.1)) {
        // if not false
        goodFractal = true;
      } else {
        // bad fractal, randomize again
        goodFractal = false;
        randomizeFractal();
        simulationCount ++;
      }
      println(delta);
    }

    print("Took ");
    print(millis() - now);
    println(" milliseconds to simulate.");
    print("Saved you from ");
    print(simulationCount);
    println(" boring Fractal animations.");
  }

  // function that simulates or renders the Fractal
  void render(boolean paint) {
    vars[morphingVar] += add;
    PVector newPos = new PVector(0,0,0);

    for (int i = 0; i < pointsNumber; i++) {

      newPos.x = sin(vars[0] * pos.y) + cos(vars[1] * pos.x) - cos(vars[2] * pos.z);
      newPos.y = sin(vars[3] * pos.y) + cos(vars[4] * pos.x) - cos(vars[5] * pos.z);
      newPos.z = pos.x + PI/120;

      pos.x = newPos.x;
      pos.y = newPos.y;
      pos.z = newPos.z;

      if (paint) {
        point(pos.x * width/(PI*2) + width/2, pos.y * height/(PI*2) + height/2);
      } else {
        if (abs(max.x) < abs(pos.x)) {
          max.x = pos.x;
        }
        if (abs(max.y) < abs(pos.y)) {
          max.y = pos.y;
        }
        if (abs(max.z) < abs(pos.z)) {
          max.z = pos.z;
        }

        if (abs(min.x) > abs(pos.x)) {
          min.x = pos.x;
        }
        if (abs(min.y) > abs(pos.y)) {
          min.y = pos.y;
        }
        if (abs(min.z) > abs(pos.z)) {
          min.z = pos.z;
        }
      }
    }
  }

  // reset the values
  void randomizeFractal() {
    for (int i = 0; i < vars.length; i++) {
      // round to numbers that are division of PI
      // increases the clarity of geomtric lines
      vars[i] = int(random(0,frames)) * PI/frames;
    }

    // chose a random number that will morph
    morphingVar = int(random(0, 6));
    // set it to 0
    vars[morphingVar] = 0;
  }

  // "rewind" the fractal backwards
  void reverse() {
    reverse = !reverse;
    add = -add;
  }
}
