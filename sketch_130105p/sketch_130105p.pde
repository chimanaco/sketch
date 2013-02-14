/*
http://kazefuku.net/archives/756
 http://workshop.chromeexperiments.com/examples/gui/#1--Basic-Usage
 */

import controlP5.*;
ControlP5 cp5;

boolean cp5Visble = true;

int radius = 70;
int mouthAngle = 40;
int eatSpeed = 5;
float speed = 0.02;
int interval = 750;
int scalarSpeed = 18;
int colorSpeed = 2;
float offset = 200;

int myColor = 0;
int maxColor = 360;

int startTime;
int maxAngle = mouthAngle;

ArrayList particles;

void setup() {
  size(400, 400);
  //smooth();
  noStroke();

  colorMode(HSB, maxColor, 100, 100);
  background(0);
  setupCP5();

  // createArray
  particles = new ArrayList();
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
      .setRange(0, 400)
        ;

  cp5.addSlider("mouthAngle")
    .setPosition(xPos, yScaleos + yMargin)
      .setRange(0, 90)
        ;  

  cp5.addSlider("eatSpeed")
    .setPosition(xPos, yScaleos + yMargin * 2)
      .setRange(0, 10)
        ; 

  cp5.addSlider("speed")
    .setPosition(xPos, yScaleos + yMargin * 3)
      .setRange(0, 0.1)
        ;

  cp5.addSlider("interval")
    .setPosition(xPos, yScaleos + yMargin * 4)
      .setRange(0, 10000)
        ;

  cp5.addSlider("scalarSpeed")
    .setPosition(xPos, yScaleos + yMargin * 5)
      .setRange(0, 100)
        ;

  cp5.addSlider("colorSpeed")
    .setPosition(xPos, yScaleos + yMargin * 6)
      .setRange(0, 100)
        ;
}

/*
  cp5 visible
 */
void mouseClicked() {
  if (cp5Visble) {
    cp5.hide();
  } 
  else {
    cp5.show();
  }
  cp5Visble = !cp5Visble;
}

void draw() {
  background(0);

  // timer
  if (millis() > startTime + interval) {
    startTime = millis(); // reset start time
    createPackmaso();
  }

  for (int i = particles.size()-1; i >= 0; i--) {
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    packmaso p = (packmaso) particles.get(i);
    if (p.notVisible() ) particles.remove(i);
    p.run();
  }
  
  //if(mousePressed) save("1330105.jpg");
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(cp5.getController("angle"))) {
    maxAngle = (int)(theEvent.getController().getValue());
  }
}

void createPackmaso() {
  myColor = myColor + colorSpeed;

  if (myColor > maxColor) {
    myColor = 0;
  }
    
  particles.add(new packmaso(myColor));
}

// packmaso 
class packmaso {
  float angle = 0.0;
  float x;
  float y;
  float mx;
  int packmasoColor;
  float yScale = 1;
  boolean closeMouth = true;

  float faceAngle;
  float pAngle;
  float scalar = 200;

  //constructor
  packmaso(int myColor) {
    packmasoColor = color(myColor, 100, 100);
  }

  boolean notVisible() {
    if (scalar < 0) {
      return true;
    }
    else
      return false;
  }

  void run() {
    x = offset + cos(angle) * scalar;
    y = offset + sin(angle) * scalar;

    // pack pack
    if ((mouthAngle < 0)||(mouthAngle > maxAngle)) {
      closeMouth = !closeMouth;
    }

    if (closeMouth) {
      mouthAngle -= eatSpeed;
    } 
    else {
      mouthAngle += eatSpeed;
    }

    // change size by position
    yScale = abs(scalar/100);

    // change angle
    angle += speed;
    if (scalar < 0) scalar = 0;

    scalar -= speed * scalarSpeed;

    // change pack angle by position 
    faceAngle = angle % TWO_PI / TWO_PI;
    pAngle = map(faceAngle, 0, 1, 0, 360) + 90;

    fill(packmasoColor);

    // rotation    
    pushMatrix();
      translate(x, y); 
      rotate(radians(pAngle));
      arc(0, 0, radius * yScale, radius * yScale, radians(mouthAngle), radians(360 - mouthAngle));
      //ellipse(0, 0, radius * yScale, radius * yScale);
    popMatrix();
  }
}

