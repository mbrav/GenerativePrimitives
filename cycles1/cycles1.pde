// Cycles #1

// Based on Vincent D. Warmerdam's formula
// http://koaning.io/fluctuating-repetition.html

// by Michael Braverman
// July 7th, 2016

// DEPENDENCIES:
// Make sure you have the following Processing 3 libraries installed:
// GifAnimation: https://github.com/01010101/GifAnimation/

import gifAnimation.*;
GifMaker gifExport;

int framesCount;
int frameSkip = 1;

// number of points per frame
int pointsNumber = 50000;
PVector pos = new PVector(0,0,0);

// Formula variables
float a,b,c,d,e,f;

int morphingVariable;
void setup() {
  frameRate(15);
  size(500, 500, P3D);
  background(42,51,54);
  smooth(2);

  a = random(0,PI);
  b = random(0,PI);
  c = random(0,PI);
  d = random(0,PI);
  e = random(0,PI);
  f = random(0,PI);

  morphingVariable = int(random(0, 6));

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(0);

}

void draw () {
  float frames = 60;
  float add = 0.08;

  if (framesCount >= frames/2) {
    add = -add;
  }

  switch (morphingVariable) {
    case 0:
      a += add;
      a = round(a * 100) * 0.01;
      break;
    case 1:
      b += add;
      b = round(b * 100) * 0.01;
      break;
    case 2:
      c += add;
      c = round(c * 100) * 0.01;
      break;
    case 3:
      d += add;
      d = round(d * 100) * 0.01;
      break;
    case 4:
      e += add;
      e = round(e * 100) * 0.01;
      break;
    case 5:
      f += add;
      f = round(f * 100) * 0.01;
      break;
  }

  background(42,51,54);
  stroke(247,248,251, 150);

  PVector newPos = new PVector(0,0,0);
  PVector max = new PVector(0,0,0);
  for (int i = 0; i < pointsNumber; i++) {

    newPos.x = sin(a * pos.y) + cos(b * pos.x) - cos(c * pos.z);
    newPos.y = sin(d * pos.y) + cos(e * pos.x) - cos(f * pos.z);
    newPos.z = pos.x + 0.1;

    pos.x = newPos.x;
    pos.y = newPos.y;
    pos.z = newPos.z;

    if (abs(max.x) < abs(pos.x)) {
      max.x = pos.x;
    }
    if (abs(max.y) < abs(pos.y)) {
      max.y = pos.y;
    }
    if (abs(max.z) < abs(pos.z)) {
      max.z = pos.z;
    }

    point(pos.x * width/(PI*2) + width/2, pos.y * height/(PI*2) + height/2);
  }

  // println(max);
  print(a);
  print("\t");
  print(b);
  print("\t");
  print(c);
  print("\t");
  print(d);
  print("\t");
  print(e);
  print("\t");
  println(f);

  framesCount++;

  if (framesCount % frameSkip == 0) {
    gifExport.setDelay(1);
    gifExport.addFrame();
  }

  if (framesCount/frameSkip == frames) {
    gifExport.finish();
    println("gif saved");
  }
}
