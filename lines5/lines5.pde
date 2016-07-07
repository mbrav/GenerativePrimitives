// Lines #5
// by Michael Braverman
// July 6th, 2016

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
  pixelDensity(2);
  frameRate(60);
  size(400, 400, P2D);
  background(42,51,54);
  smooth(8);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(0);

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

  cosineAdd += 0.01;

  int boxesRoot = int(sqrt(boxesCount));

  for (int i = 0; i < boxesRoot; i++) {
    for (int j = 0; j < boxesRoot; j++) {
      int index = (i+1)*(j+1)-1;
      // derivative from center of grid to the square with i and j cords
      // - boxSize/2
      float derivative = (width/2 - (j * boxSize + boxSize/2))/(height/2 - (i * boxSize + boxSize/2));
      boxes[index].draw(i*boxSize,j*boxSize, cos(derivative + cosineAdd));

      // DEBUG INFO
      // line(width/2, height/2, i * boxSize, j * boxSize);
      // textSize(6);
      // text(j * boxSize, i * boxSize, j * boxSize + 5);
      // text(i * boxSize, i * boxSize, j * boxSize + 10);
      // text(derivative, i * boxSize, j * boxSize + 15);
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
