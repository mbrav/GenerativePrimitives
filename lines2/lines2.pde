// Lines #2
// by Michael Braverman
// July 3th, 2016

import gifAnimation.*;
GifMaker gifExport;

int boxSize = 50; // pixels

// GENERATIVE VARIABLES
float boxBoundryRatioMin = 0.3;
float boxBoundryRatioMax = 1.2;

int boxedPointsMin = 4;
int boxedPointsMax = 20;

Box[] boxes;
int boxesCount;

int framesCount;

void setup() {
  pixelDensity(1);
  frameRate(10);
  size(400, 400, P2D);
  background(42,51,54);
  smooth(8);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(2);

  boxesCount = int(sq(width/boxSize));
  boxes = new Box[boxesCount];

  for (int i = 0; i < boxes.length; i++) {
    int pointsNum = int(random(boxedPointsMin, boxedPointsMax));
    float boxRatio = random(boxBoundryRatioMin, boxBoundryRatioMax);
    boxes[i] = new Box(boxSize, pointsNum, boxRatio);
  }
}

void draw () {
  fill(42,51,54,70);
  rect(0,0,width,height);
  stroke(247,248,251);

  for (int i = 0; i < sqrt(boxesCount); i++) {
    for (int j = 0; j < sqrt(boxesCount); j++) {
      int index = (i+1)*(j+1)-1;
      boxes[index].draw(i*boxSize,j*boxSize);
    }
  }

  framesCount++;

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
