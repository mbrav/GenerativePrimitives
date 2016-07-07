// Cycles #1

// Based on Vincent D. Warmerdam's formula
// http://koaning.io/fluctuating-repetition.html

// by Michael Braverman
// July 7th, 2016

import gifAnimation.*;
import controlP5.*;
GifMaker gifExport;
ControlP5 cp5;

int framesCount;
int frameSkip = 1;

// number of points per frame
int pointsNumber = 50000;
PVector pos = new PVector(0,0,0);

// Formula variables
float a,b,c,d,e,f;

float add;

void setup() {
  frameRate(15);
  size(500, 500, P3D);
  background(42,51,54);
  smooth(2);

  a = 155;
  b = 0.5;
  c = 0.3;
  // c = 0;
  d = 1.20;
  e = 0.25;
  f = 2.34;

  cp5 = new ControlP5(this);
  cp5.addSlider("a")
     .setPosition(10,10)
     .setRange(0,PI);
  cp5.addSlider("b")
     .setPosition(10,25)
     .setRange(0,PI);
  cp5.addSlider("c")
     .setPosition(10,40)
     .setRange(0,PI);
  cp5.addSlider("d")
     .setPosition(10,55)
     .setRange(0,PI);
  cp5.addSlider("e")
     .setPosition(10,70)
     .setRange(0,PI);
  cp5.addSlider("f")
     .setPosition(10,85)
     .setRange(0,PI);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(0);
}

void draw () {
  e += PI/60;
  b += PI/60;

  background(42,51,54);
  stroke(247,248,251, 150);

  framesCount++;

  PVector newPos = new PVector(0,0,0);
  for (int i = 0; i < pointsNumber; i++) {
    newPos.x = sin(a * pos.y) + cos(b * pos.x) - cos(c * pos.z);
    newPos.y = sin(d * pos.y) + cos(e * pos.x) - cos(f * pos.z);
    newPos.z = pos.x + 0.1;

    pos.x = newPos.x;
    pos.y = newPos.y;
    pos.z = newPos.z;

    point(pos.x * width/6 + width/2, pos.y * height/6 + height/2);
  }

  if (framesCount % frameSkip == 0) {
    gifExport.setDelay(1);
    gifExport.addFrame();
  }

  if (framesCount/frameSkip == 60) {
    gifExport.finish();
    println("gif saved");
  }
}
