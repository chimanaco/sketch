/*
  author:chimanaco
  
  referemce:
  http://woodenbooks.com/
  
  rainbow spring 
 */

import controlP5.*;
ControlP5 cp5;

int radius = 100;
int offset = 20;
float angle = 0;
int number = 4;
int strokeColor = 1;
int weight = 0;
int hueSpeed = 1;

float centerX;
float centerY;

int myNumber = 0;

float myHue = 0;
int maxHue = 360;
int mySaturation = 100;
int maxSaturation = 100;
int myBrightness = 100;
int maxBrightness = 100;

float hueAngle = 0;

void setup() {
  size(400, 400);
  colorMode(HSB, maxHue, maxSaturation, maxBrightness);
  
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

  cp5.addSlider("hueSpeed")
    .setPosition(xPos, yScaleos + yMargin * 3)
      .setRange(0, 60)
        ;
  
  cp5.addSlider("mySaturation")
    .setPosition(xPos, yScaleos + yMargin * 4)
      .setRange(0, 100)
        ;
  
  cp5.addSlider("myBrightness")
    .setPosition(xPos, yScaleos + yMargin * 5)
      .setRange(0, 100)
        ;
  
  
  cp5.addSlider("weight")
    .setPosition(xPos, yScaleos + yMargin * 6)
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
    
  myHue = myHue + hueSpeed;
  if(myHue > maxHue) myHue = 0;
    
//    println(myHue);
        
    //hueAngle = hueAngle + hueSpeed;
    //myHue = map(sin(hueAngle), -1, 1, 0, maxHue);
    //float x2 = map(myHue, 0, width, 0, 360);
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
  //stroke(strokeColor, 100, 100);
  stroke(myHue, mySaturation, myBrightness);
  ellipse(x, y, r, r);
  ellipse(x, y, r + offset, r + offset);
  
 
}

