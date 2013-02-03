/*
  author:chimanaco
  
  referemce:
  http://woodenbooks.com/
 */

import controlP5.*;
ControlP5 cp5;

int radius = 100;
int offset = 20;
float angle = 0;
int number = 4;
int strokeColor = 1;
int weight = 1;

int angleSample = 1;

float centerX;
float centerY;

int myNumber = 0;
int maxColor = 360;

void setup() {
  size(400, 400);
  colorMode(HSB, maxColor, 100, 100);
  
  centerX = width/2;
  centerY = height/2;
  
  setupCP5();
}

void setupCP5() {
  float xPos = 10;
  float yScaleos = 10;
  float yMargin = 15;

  // cp5 
  cp5 = new ControlP5(this);

  // add a horizontal sliders, the value of this slider will be linked
  cp5.addSlider("radius")
    .setPosition(xPos, yScaleos)
      .setRange(0, 200)
        ;

  cp5.addSlider("offset")
    .setPosition(xPos, yScaleos + yMargin)
      .setRange(-50, 50)
        ;  

  cp5.addSlider("number")
    .setPosition(xPos, yScaleos + yMargin * 2)
      .setRange(0, 100)
        ; 

  cp5.addSlider("strokeColor")
    .setPosition(xPos, yScaleos + yMargin * 3)
      .setRange(0, 360)
        ;

  cp5.addSlider("weight")
    .setPosition(xPos, yScaleos + yMargin * 4)
      .setRange(0, 100)
        ;
}

void draw() {
  background(0);
  
  // center
  createCircle(centerX, centerX, radius);
  
  // reset
  angle = 0;
  
  // orbital
  for (int i = 0; i < number; i++) {
    float xp = centerX + cos(angle) * radius /2 ;
    float yp = centerY + sin(angle) * radius /2;

    angle += TWO_PI / number;    
    createCircle(xp, yp, radius);
  }
}

//void controlEvent(ControlEvent theEvent) {
//  if (theEvent.isFrom(cp5.getController("angle"))) {
//    maxAngle = (int)(theEvent.getController().getValue());
//  }
//}

void createCircle(float x, float y, float r) {
  noFill();
  strokeWeight(weight);
  stroke(strokeColor, 100, 100);
  ellipse(x, y, r, r);
  ellipse(x, y, r + offset, r + offset);
}

