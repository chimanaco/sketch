/*
  author:chimanaco
 
 inspired:
 http://popachi.exblog.jp/5133130/
 http://natureofcode.com/book/chapter-4-particle-systems/
 
 */

// line
int lineWidth = 60;
int lineHeight = 30;
int lineOffset = 0;
int lineWeight = 15;
int lineSpacing = 45;

// pattern
PShape s;  // The PShape object

void setup() {
  size(400, 400, P2D);
  colorMode(RGB);

  s = createShape();
  createPattern();
}

void draw() {
  background(255);
  //fadeToWhite();

  int col = ceil(height / (lineWeight)) + 1;  // tate
  int row = ceil(width / (lineWidth + lineOffset) + 1); // yoko  
  pushMatrix();
  translate(-10, - 1 *(lineWeight + lineSpacing));
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      //image(pg, (lineWidth + lineOffset) * j, lineSpacing * i);
      shape(s, (lineWidth + lineOffset) * j, lineSpacing * i);
      //blend(s, 0, 0, 33, 100, 67, 0, 33, 100, LIGHTEST);
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

// pattern
void createPattern() {
  int y = lineSpacing / 2;
  
  s = createShape();
  s.noFill();
  s.stroke(100);
  s.strokeWeight(lineWeight);
  s.vertex(0, 0);
  s.vertex(lineOffset, 0);
  s.vertex(lineOffset + lineWidth /2 , lineHeight);
  s.vertex(lineWidth + lineOffset, 0);
  s.end();
}

