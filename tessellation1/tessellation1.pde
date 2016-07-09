// Tessellation #1
// by Michael Braverman
// July 6th, 2016

// DEPENDENCIES:
// Make sure you have the following Processing 3 libraries installed:
// GifAnimation: https://github.com/01010101/GifAnimation/

import gifAnimation.*;
GifMaker gifExport;

int framesCount;
int frameSkip = 2;

float add;

void setup() {
  pixelDensity(1);
  frameRate(15);
  size(500, 500, P2D);
  background(42,51,54);
  smooth(8);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(0);
}

void draw () {
  fill(42,51,54);
  rect(0,0,width,height);
  stroke(247,248,251);

  cos(add);

  int circleSize = 25;
  float piIncrement = PI/(width/circleSize);
  for (int i = 0; i < width/circleSize/2; i++) {
    for (int j = 0; j < height/circleSize/2; j++) {

      if ( i % 2 == 0 && j % 2 == 0) {
        PVector pos = new PVector(circleSize*i+circleSize/2, circleSize*j+circleSize/2);
        ellipse(width/2 + pos.x * cos(i + add), width/2 + pos.y * cos(j + add), circleSize * cos(piIncrement*i + add), circleSize * cos(piIncrement*i + add));
        ellipse(width/2 - pos.x * cos(i + add), width/2 - pos.y * cos(j + add), circleSize * cos(piIncrement*i + add), circleSize * cos(piIncrement*i + add));
        ellipse(width/2 + pos.x * cos(i + add), width/2 - pos.y * cos(j + add), circleSize * cos(piIncrement*i + add), circleSize * cos(piIncrement*i + add));
        ellipse(width/2 - pos.x * cos(i + add), width/2 + pos.y * cos(j + add), circleSize * cos(piIncrement*i + add), circleSize * cos(piIncrement*i + add));
      }
    }
  }

  add += 0.02;
  framesCount++;

  if (framesCount % frameSkip == 0) {
    gifExport.setDelay(1);
    gifExport.addFrame();
  }

  int frames = int(PI/0.02/2);
  if (framesCount/frameSkip == frames) {
    gifExport.finish();
    println("gif saved");
    println("frames:");
    println(frames);
  }
}
