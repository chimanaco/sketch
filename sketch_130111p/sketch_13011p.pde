/*
  author:chimanaco
 
 inspired:
 http://www.jalpurmillersonline.com/shop/2-boxed-mixes-a-masalas/140-jalpur-tea-masala
 
 */

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;
boolean cp5Visble = true;

// line
float lineWidth = 40;
int lineHeight = 40;
int lineOffset = 0;
int lineWeight = 5;
float lineSpacing = 35;
float dotRadius = 8;
int dotColor = color(120, 56, 34);

// pattern
PShape s;  // The PShape object
PShape dotShape;  // The PShape object

/*
  setup cp5
*/
void setup() {
  size(400, 400, P2D);
  colorMode(RGB);
  smooth();
  
  // setup cp5
  setupCP5();
  
  createPattern();
}

/*
  setup cp5
*/
void setupCP5() {
  int xPos = 10;
  int yPos = 10;

  // cp5 
  cp5 = new ControlP5(this);

  // color
  cp = cp5.addColorPicker("picker")
    .setPosition(xPos, yPos)
      .setColorValue(color(0, 135, 0, 255))
        ;

  // slider
  String[] slides = {
    "lineWidth", "lineHeight", "lineOffset", "lineWeight", "lineSpacing"
  };
  int[] minList = {
    1, 0, 0, 1, 0
  };
  int[] maxList = {
    200, 200, 200, 100, 200, 200
  };

  int yMargin = 15;
  int len = slides.length; 
  yPos = 80;

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
  //background(255);
  
  // fade background
  fadeToWhite();
  
  int col = ceil(height / (lineWeight)) + 1;  // tate
  int row = ceil(width / (lineWidth + lineOffset) + 1); // yoko  
    
  pushMatrix();
  translate(-10, - 1 *(lineWeight + lineSpacing));
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      shape(s, (lineWidth + lineOffset) * j, lineSpacing * i);
      shape(dotShape, (lineWidth + lineOffset) * j, lineSpacing * i);
    }
  }
  popMatrix();
}

/*
  fade background
*/
void fadeToWhite() {
  noStroke();
  fill(255, 10);
  rectMode(CORNER);
  rect(0, 0, width, height);
}

/*
  cp5 toggle event
*/
void controlEvent(ControlEvent theEvent) {
  createPattern();
}

/*
  cp5 visible
*/
void mouseClicked() {
  if (cp5Visble) {
    cp5.hide();
  } else {
    cp5.show();
  }
  cp5Visble = !cp5Visble;
}

/*
  change pattern
*/
void createPattern() {
  s = createShape();
  s.noFill();
  s.stroke(cp.getColorValue());
  s.strokeWeight(lineWeight);
  //s.strokeCap(PROJECT);
  s.vertex(0, 0);
  s.vertex(lineOffset, 0);
  s.vertex(lineOffset + lineWidth /2, lineHeight);
  s.vertex(lineWidth + lineOffset, 0);
  s.end();
  
  dotShape = createShape(ELLIPSE, - dotRadius /2, lineSpacing / 2, dotRadius, dotRadius);
  dotShape.noStroke();
  dotShape.fill(dotColor);
}

