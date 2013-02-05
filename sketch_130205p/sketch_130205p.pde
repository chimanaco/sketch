/*
  author:chimanaco
 
 inspired: 
 Olympus digital billboard you can see from Shinjuku station
 
 */

import controlP5.*;
ControlP5 cp5;
boolean cp5Visble = true;

int lineNumber = 123;
float margin = 15.8;
float speed = 1;
int bgColor = color(0);
int maxHue = 360;
float lineSpeed = 1.88;

int num = 0;
ArrayList particles;

/*
  setup
 */
void setup() {
  size(400, 400);  
  colorMode(HSB, maxHue, 100, 100);
  background(bgColor);

  // setup cp5
  setupCP5();

  // createArray
  particles = new ArrayList();
  particles.add(new particle(num));
}

/*
  setup cp5
 */
void setupCP5() {
  float xPos = 10;
  float yPos = 10;
  float yMargin = 15;

  // cp5 
  cp5 = new ControlP5(this);

  // cp5 slider
  String[] slides = {
    "lineNumber", "margin", "lineSpeed"
  };
  int[] minList = {
    1, 0, 1
  };
  int[] maxList = {
    1000, 50, 5
  };
  int len = slides.length; 

  for (int i = 0; i < len; i++) {
    cp5.addSlider(slides[i])
      .setPosition(xPos, yPos + yMargin * i )
        .setRange(minList[i], maxList[i]);
    ;
  }
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

/*
  loop
 */
void draw() {
  background(bgColor);

  if (num < lineNumber) {

    particle p = (particle) particles.get(particles.size()-1);

    if (p.goNext() ) {
      num ++;

      particles.add(new particle(num));
    }
  }

  for (int i = particles.size()-1; i >= 0; i--) {
    particle p = (particle) particles.get(i);
    p.run();
  }
}

/*
  particle
 */
class particle {
  float sx = 0;
  float ex = 0;
  float offset = 0;
  float myHue;

  boolean positive = true;

  //constructor
  particle(int myNum) {
    myHue = (float) myNum / (float) lineNumber * maxHue;
  }

  boolean goNext() {
    if (ex > margin) {
      return true;
    }
    else
      return false;
  }

  // run
  void run() {
    if (positive && sx > width) {
      positive = false;
      offset = 0;
    }

    if (!positive && sx < 0) {
      positive = true;
      offset = 0;
    }

    if (positive) {
      offset++;
      sx = sx + speed; 
      ex = sx + offset * lineSpeed;
    } 
    else {
      offset--;
      sx = sx - speed; 
      ex = sx + offset * lineSpeed;
    }

    stroke(myHue, 100, 100);
    line(sx, 0, ex, height);
  }
}

