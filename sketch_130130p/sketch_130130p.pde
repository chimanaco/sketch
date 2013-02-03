/*
  author:chimanaco
 
 inspired:
 Interference and moiré pattern
 Ira Greenberg, October 18, 2005
 
 Processing: Creative Coding and Computational Art 
 http://www.amazon.co.jp/gp/product/159059617X?ie=UTF8&camp=1207&creative=8411&creativeASIN=159059617X&linkCode=shr&tag=chimanaco-22
 
 */

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;

boolean cp5Visble = true;

float interval;
float spacer;
// Experiment with these values
float angle = 0;
float amplitude = .05;
float waveGap = 10;
float frequency = .1;

float ringGrowthRate = .5;
boolean isInactive = true;
int HSBHue = 360;

/*
  setup cp5
 */
void setup() {
  size(400, 400);
  colorMode(HSB, 360, 100, 100);
  interval = width * .03;
//  interval = width * .1;
  spacer = interval;
  noFill();
  frameRate(30);

  // setup cp5
  setupCP5();
}

/*
  setup cp5
 */
void setupCP5() {
  int xPos = 10;
  int yPos = 10;

  // cp5 
  cp5 = new ControlP5(this);

  // slider
  String[] slides = {
    "amplitude", "waveGap", "frequency", "ringGrowthRate"
  };
  int[] minList = {
    0, 0, 0, 0
  };
  int[] maxList = {
    1, 20, 1, 10
  };

  int yMargin = 15;
  int len = slides.length; 
  yPos = 10;

  for (int i = 0; i < len; i++) {
    cp5.addSlider(slides[i])
      .setPosition(xPos, yPos + yMargin * i )
        .setRange(minList[i], maxList[i]);
    ;
  }
}

/*
  loop
 */
void draw() {
  background(0);
  
//  HSBHue += 2;
//  
//  if(HSBHue > 360) {
//    HSBHue = 0;
//  }
  
  
  stroke(HSBHue * mouseX/width, 100, 100);
  //stroke(255);
  
  
  float py = 0;
  /* This nested for loop fills the frame
   with a wave pattern. Some of its properties
   are controlled, in part, by the mouse position*/
  for (int i = 0; i < height; i += waveGap) {
    for (int j = 0; j < width; j++) {
      py = i + sin(radians(angle))* mouseY * amplitude;
      point(j, py);
      angle += mouseX * frequency;
    }
  }
  
  stroke(HSBHue * mouseX/width, 50, 50);
  
  // draw concentric ring pattern
  //for (int i=0; i<width/2*spacer/interval; i+=spacer) {
  for (int i=0; i<width*spacer/interval; i+=spacer) {
//    ellipse(mouseX, mouseY, 10+i, 10+i);
    ellipse(width/2, height/2, 10+i, 10+i);
  }
//  
//  if(spacer > width && isInactive) {
//    isInactive = false;
//  } else if (spacer < 10 && !isInactive) {
//    isInactive = true;
//  }
//  
//  if(isInactive) {
//    spacer += ringGrowthRate;
//  } else {
//    spacer -= ringGrowthRate;
//  }
  //println(spacer);
  // describe mouse press behavior
//  if (mousePressed) {
//    angle = 0;
//    isInactive = false;
//    // grow rings
//    if (spacer < interval*2) {
//      spacer += ringGrowthRate;
//    }
//  }
//  // shrink rings
//  if (isInactive) {
//    if (spacer> interval) {
//      spacer -= ringGrowthRate;
//    }
//  }
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

