class BoxedPoint {
  float boxSize;

  PVector pos;
  PVector speed;

  BoxedPoint(float bSize, float boundryRatio) {
    boxSize = bSize*boundryRatio;
    pos = new PVector(random(0, boxSize), random(0, boxSize));
    speed = new PVector(random(0.1, 0.6), random(0.1, 0.6));
  }

  void update() {
    pos.x += speed.x;
    pos.y += speed.y;

    if (pos.x >= boxSize || pos.x <= 0) {
      pos.x += -speed.x;
      speed.x = -speed.x;
    }
    if (pos.y >= boxSize || pos.y <= 0) {
      pos.y += -speed.y;
      speed.y = -speed.y;
    }
  }
}

class Box {
  BoxedPoint[] points;

  Box(int boxSize, int numberOfPoints, float boundryRatio) {
    points = new BoxedPoint[numberOfPoints];
    for (int i = 0; i < points.length; i++) {
      points[i] = new BoxedPoint(boxSize, boundryRatio);
    }
  }

  void draw(float x, float y) {
    for (int w = 0; w < points.length; w++) {

      if (w == points.length-1) {
        ;
      } else {
        line(x + points[w].pos.x, y + points[w].pos.y, x + points[w+1].pos.x, y + points[w+1].pos.y);
      }
    }
    for (int w = 0; w < points.length; w++) {
      points[w].update();
    }
  }
}
