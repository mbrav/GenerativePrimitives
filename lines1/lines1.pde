import gifAnimation.*;
GifMaker gifExport;

int boxSize = 50; // pixels
int boxedPoints = 10;

BoxedPoint[] points = new BoxedPoint[boxedPoints];

int framesCount;

void setup() {
  pixelDensity(1);
  frameRate(10);
  size(500, 500, P2D);
  smooth(8);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(5);

  for (int i = 0; i < points.length; i++) {
    points[i] = new BoxedPoint(boxSize, 1.1);
  }
}

void draw () {

  background(42,51,54);
  stroke(247,248,251);
  noFill();

  for (int i = 0; i <= height/boxSize; i++) {
    for (int j = 0; j <= width/boxSize; j++) {
      // start from outside boundries
      float relativeX = i * boxSize - boxSize;
      float relativeY = j * boxSize - boxSize;

      for (int w = 0; w < points.length; w++) {

        if (w == 0) {
          // connect the first point to the edge of the box
          points[w].x = 0;
          points[w].speedX = 0;
        }

        if (w == points.length-1) {
          points[w].speedX = 0;
          // connect it to the first point of the next box
          line(relativeX + points[w].x, relativeY + points[w].y, relativeX + points[0].x + boxSize, relativeY + points[0].y);
        } else {
          line(relativeX + points[w].x, relativeY + points[w].y, relativeX + points[w+1].x, relativeY + points[w+1].y);
        }
      }
      for (int w = 0; w < points.length; w++) {
        points[w].update();
      }
    }
  }

  framesCount++;

  // textSize(10);
  // text("Frame rate: " + int(frameRate), 10, height - 15);

  gifExport.setDelay(1);
  gifExport.addFrame();

  if (framesCount == 30) {
    gifExport.finish();
    println("gif saved");
  }
}

void keyPressed() {
  gifExport.finish();
  println("gif saved");
}
