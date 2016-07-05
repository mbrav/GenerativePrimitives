class BoxedPoint {
  float boxSize;

  PVector pos;
  PVector speed;

  float speedChange;

 BoxedPoint(float bSize, float boundryRatio) {
    boxSize = bSize*boundryRatio;
    pos = new PVector(random(0, boxSize), random(0, boxSize));
    speed = new PVector(1, 2);
    speedChange = 1.0;
  }

  void update() {
    pos.x += speed.x * speedChange;
    pos.y += speed.y * speedChange;

    if (pos.x >= boxSize || pos.x <= 0) {
      pos.x += -speed.x * speedChange;
      speed.x = -speed.x * speedChange;
    }
    if (pos.y >= boxSize || pos.y <= 0) {
      pos.y += -speed.y * speedChange;
      speed.y = -speed.y * speedChange;
    }
  }

  // 1.0 is default speed
  void changeSpeed(float multiplier) {
    speedChange = multiplier;
  }
}

class Box {
  BoxedPoint[] points;
  int boxSize;
  float boundryRatio;

  Box(int bSize, int numberOfPoints, float bRatio) {
    boxSize = bSize;
    boundryRatio = bRatio;
    points = new BoxedPoint[numberOfPoints];
    for (int i = 0; i < points.length; i++) {
      points[i] = new BoxedPoint(boxSize, boundryRatio);
    }
  }

  void draw(float x, float y, float speedAdjust) {
    // cross for centering
    // line(x + boxSize/2, y, x + boxSize/2, y + boxSize);
    // line(x, y + boxSize/2, x + boxSize, y + boxSize/2);

    // center the box according to the ratio
    float center = (boxSize - boxSize * boundryRatio)/2;
    x += center;
    y += center;

    for (int w = 0; w < points.length; w++) {

      if (w != points.length-1) {
        bezier(x + points[w].pos.x, y + points[w].pos.y, x + points[w].pos.x + 10, y + points[w].pos.y + 10, x + points[w+1].pos.x - 10, y + points[w+1].pos.y - 10, x + points[w+1].pos.x, y + points[w+1].pos.y);
      }
    }
    for (int w = 0; w < points.length; w++) {
      points[w].changeSpeed(speedAdjust);
      points[w].update();
    }
  }
}
