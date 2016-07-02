class BoxedPoint {
  float boxSize;

  float x;
  float y;

  float speedX;
  float speedY;

  BoxedPoint(float bsize, float scaleRatio) {
    boxSize = bsize/scaleRatio;
    speedX = random(0.01, 0.04);
    speedY = random(0.01, 0.04);
    x = random(0, boxSize);
    y = random(0, boxSize);
  }

  void update() {
    x += speedX;
    y += speedY;

    if (x >= boxSize || x <= 0) {
      x += -speedX;
      speedX = -speedX;
    }
    if (y >= boxSize || y <= 0) {
      y += -speedY;
      speedY = -speedY;
    }
  }
}
