/*
  author:chimanaco
 
 inspired:
 http://www.assemblyoftext.com/
 
 */

// line
int lineWidth = 60;
int lineHeight = 30;
int lineOffset = 0;
int lineWeight = 15;
int lineSpacing = 45;
int lineColor = color(255, 140, 0, 255);

// pattern
PGraphics pg;

void setup() {
  size(400, 400);
  colorMode(RGB);

  pg = createGraphics(width, height);
  createPattern();
}

void draw() {
  background(255);
 // fadeToWhite();

  int col = ceil(height / (lineWeight)) + 1;  // tate
  int row = ceil(width / (lineWidth + lineOffset) + 1); // yoko  
  pushMatrix();
  translate(-10, - 1 *(lineHeight + lineSpacing));
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

// pattern
void createPattern() {
  int y = lineSpacing / 2;
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.strokeWeight(lineWeight);
  pg.stroke(lineColor);
  pg.line(0, y, lineOffset, y);
  pg.line(lineOffset, y, lineOffset + lineWidth / 2, y + lineHeight);
  pg.line(lineOffset + lineWidth / 2, y + lineHeight, lineOffset + lineWidth, y);
  pg.endDraw();
}

