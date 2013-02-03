/*
  author:chimanaco
 
 inspired:
 http://popachi.exblog.jp/5133130/
 http://natureofcode.com/book/chapter-4-particle-systems/
 
 */

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;

// line
int lineWidth = 60;
int lineHeight = 30;
int lineOffset = 0;
int lineWeight = 15;
int lineSpacing = 45;

// pattern
PGraphics pg;

void setup() {
  size(400, 400);
  colorMode(RGB);

  setupCP5();

  pg = createGraphics(width, height);
  createPattern();
}

void setupCP5() {
  int xPos = 10;
  int yPos = 10;

  // cp5 
  cp5 = new ControlP5(this);

  // color
  cp = cp5.addColorPicker("picker")
    .setPosition(xPos, yPos)
      .setColorValue(color(255, 140, 0, 255))
        ;
  
  // slider
  String[] slides = {
    "lineWidth", "lineHeight", "lineOffset", "lineWeight", "lineSpacing"
  };
  int[] minList = {
    0, 0, -200, 0, 0
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

void draw() {
  fadeToWhite();

  int col = ceil(height / (lineWeight)) + 1;  // tate
  int row = ceil(width / (lineWidth + lineOffset) + 1); // yoko  
  pushMatrix();
  translate(-10, - 1 *(lineWeight + lineSpacing));
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      image(pg, (lineWidth + lineOffset) * j, lineSpacing * i);
    }
  }
  popMatrix();
}

// fade
void fadeToWhite() {
  noStroke();
  fill(255, 10);
  rectMode(CORNER);
  rect(0, 0, width, height);
}

void controlEvent(ControlEvent theEvent) {
  createPattern();
}

// pattern
void createPattern() {
  int y = lineSpacing / 2;
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.strokeJoin(MITER);
  pg.strokeWeight(lineWeight);
  pg.stroke(cp.getColorValue());
  pg.line(0, y, lineOffset, y);
  pg.line(lineOffset, y, lineOffset + lineWidth / 2, y + lineHeight);
  pg.line(lineOffset + lineWidth / 2, y + lineHeight, lineOffset + lineWidth, y);
  pg.endDraw();
}

