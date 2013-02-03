/*
http://kazefuku.net/archives/756
http://workshop.chromeexperiments.com/examples/gui/#1--Basic-Usage
 */

import controlP5.*;

ControlP5 cp5;
int myColor = color(0, 0, 0);

int radius = 70;
int angle = 45;
int eatSpeed = 1;
int maxAngle = angle;

//float radius = 70;
//float angle = 95;
//float eatSpeed = 1;
boolean closeMouth = true;
packmaso p;  // packmaso

void setup() {
  size(400, 400);
  colorMode(RGB, 255, 255, 255, 255);
  background(0, 0, 0, 0);  // r, g, b, alpha

  // cp5  
  cp5 = new ControlP5(this);

  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("radius")
    .setPosition(10, 10)
      .setRange(0, 400)
        ;

  cp5.addSlider("angle")
    .setPosition(10, 25)
      .setRange(0, 90)
        ;  

  cp5.addSlider("eatSpeed")
    .setPosition(10, 40)
      .setRange(0, 10)
        ;  
  // create packmaso
  p = new packmaso();
}

void draw() {
  background(0);
  
  if ((angle<0)||(angle>maxAngle)) {
    closeMouth = !closeMouth;
  }

  if (closeMouth) {
    angle-=eatSpeed;
  } 
  else {
    angle+=eatSpeed;
  }

  p.run(radius, angle, 360-angle);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(cp5.getController("angle"))) {
    maxAngle = (int)(theEvent.getController().getValue());
  }
}

// packmaso 
class packmaso {
  //constructor
  packmaso() {
    noStroke();   
    fill(250, 250, 0);
  }

  void run(int radius, int startD, int endD) {
    arc(width/2, height/2, radius, radius, radians(startD), radians(endD));
  }
}

