/*
  author:chimanaco
 
 inspired:
 http://popachi.exblog.jp/5133130/
 
 */

float centerX;
float centerY;

int myHue = 25;
int maxHue = 360;
int mySaturation = 100;
int maxSaturation = 100;
int myBrightness = 80;
int maxBrightness = 100;

int radius = 284;
int radiusMid = radius + 8;
int radiusOut = radius + 16;

int startX = 0;
int startY = 0;
int endX = 0;
int endY = 117;
int x2 = 5;
int y2 = 0;
int x3 = 45;
int y3 = 120;
int x4;
int y4;
int x5;
int y5;

void setup() {
  size(400, 400);
  colorMode(HSB, maxHue, maxSaturation, maxBrightness);
  smooth();
  noStroke();
  
  centerX = width/2;
  centerY = height/2;

}

void draw() {
  background(0);

  fill(myHue, mySaturation, myBrightness);
  ellipse(centerX, centerY, radiusOut, radiusOut);
  fill(myHue, mySaturation - 50, maxBrightness);
  ellipse(centerX, centerY, radiusMid, radiusMid);
  fill(0, 0, maxBrightness);
  ellipse(centerX, centerY, radius, radius);

  int number = 12;

  pushMatrix();
  translate(centerX, centerY);
  for (int i = 0; i < number; i++) {
    rotate(TWO_PI/number);
    createFruit();
  }
  popMatrix();
}

void createFruit() {
  endX = startX;
  x5 = startX - (x2 - startX);
  x4 = startX - (x3 - startX);
  y4 = y3;
  y5 = y2;

  pushMatrix();
  translate(0, 20); 
  fill(myHue, mySaturation, maxBrightness);
  beginShape();
  vertex(startX, startY);
  bezierVertex(x2, y2, x3, y3, endX, endY);
  bezierVertex(x4, y4, x5, y5, startX, startY);
  endShape();
  popMatrix();
}

