/*
http://kazefuku.net/archives/756
 http://workshop.chromeexperiments.com/examples/gui/#1--Basic-Usage
 */

import controlP5.*;
ControlP5 cp5;

int radius = 150;
int angle = 40;
int eatSpeed = 5;
float xSpeed = 12;

int xPos = 0;
int yPos = 300;

int maxAngle = angle;

//float radius = 70;
//float angle = 95;
//float eatSpeed = 1;
boolean closeMouth = true;
packmaso p;  // packmaso
enemy e;  // enemy

void setup() {
  size(400, 400);
  colorMode(RGB, 255, 255, 255, 255);
  background(0, 0, 0, 0);  // r, g, b, alpha
  smooth();
  setupCP5();
  
  // create packmaso
  p = new packmaso(xPos, yPos);
  // create enemy
  e = new enemy();
}

void setupCP5() {
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

  cp5.addSlider("xSpeed")
    .setPosition(10, 55)
      .setRange(0, 15)
        ;
}

void draw() {
  background(0);
  p.run(radius, xSpeed);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(cp5.getController("angle"))) {
    maxAngle = (int)(theEvent.getController().getValue());
  }
}

// packmaso 
class packmaso {
  int x;
  int y;
  int ySpeed = -50;
  int packmasoColor = color(250, 250, 0);
  int startD;
  int endD;
  int wallHeight = 150;
  float yp;
  boolean goRight = true;
  boolean goTop = true;

  //constructor
  packmaso(int xPos, int yPos) {
    noStroke();
    x = xPos;
    y = yPos;
  }

  void run(int radius, float xSpeed) {
    // pack pack
    if ((angle < 0)||(angle > maxAngle)) {
      closeMouth = !closeMouth;
    }
        
    if (closeMouth) {
      angle -= eatSpeed;
    } 
    else {
      angle += eatSpeed;
    }

    // over top
    if ((y < wallHeight / 2) && (goTop)) {
      goTop = false; 
      ySpeed = -1 * ySpeed;
    }

    // under bottom
    if ((y > height -wallHeight) && (!goTop)) {
      goTop = true;
      ySpeed = -1 * ySpeed;
    }

    // x    
    if ( (x < - radius / 2) || (x > width + radius / 2) ) {
      goRight = !goRight;
      y = y + ySpeed;
    }
    
    // resize by ypos / height
    yp =  y / 400f;
    // change speed by ypos / height
    xSpeed = xSpeed * yp;
    
    //xPosition
    if (goRight) {
      x += xSpeed;
      startD = angle;
      endD = 360 - angle;
    } 
    else {
      x -= xSpeed;
      startD = angle -180;
      endD = 180 - angle;
    }
    
    fill(packmasoColor);
    arc(x, y, radius * yp, radius * yp, radians(startD), radians(endD));
    
    e.run(x, y, radius, yp, goRight);
  }
}

// enemy 
class enemy {
  int radius = 10;
  int randomY = 4;
  float offset;

  //constructor
  enemy() {
    noStroke();
  }

  void run(float x, float y, float r, float yp, boolean goRight) {
    if (goRight) {
      offset = 0.777;
    } 
    else {
      offset = -0.777;
    }

    fill(0, 255, 255);
    ellipse(x + r * yp * offset, y + random(randomY) - randomY / 2, radius * yp, radius * yp);
  }
}
