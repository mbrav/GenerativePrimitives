// Lines #4 - The Settlement
// by Michael Braverman
// July 5th, 2016

import gifAnimation.*;
GifMaker gifExport;

int boxSize =25; // pixels

// GENERATIVE VARIABLES
float boxBoundryRatioMin = 0.6;
float boxBoundryRatioMax = 1.8;

int boxedPointsMin = 2;
int boxedPointsMax = 6;

Box[] boxes;
int boxesCount;

float cosineAdd;

int framesCount;
int frameSkip = 2;

void setup() {
  pixelDensity(1);
  frameRate(60);
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
  fill(42,51,54,100);
  rect(0,0,width,height);
  stroke(247,248,251);

  cosineAdd += 0.012;

  for (int i = 0; i < sqrt(boxesCount); i++) {
    for (int j = 0; j < sqrt(boxesCount); j++) {

      int index = (i+1)*(j+1)-1;
      boxes[index].draw(i*boxSize,j*boxSize, cos(cosineAdd*5));
    }
  }

  framesCount++;

  if (framesCount % frameSkip == 0) {
    gifExport.setDelay(1);
    gifExport.addFrame();
  }

  if (framesCount/frameSkip == 30) {
    gifExport.finish();
    println("gif saved");
  }
}

void keyPressed() {
  gifExport.finish();
  println("gif saved");
}
