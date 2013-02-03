/*
  author:chimanaco
 
 sample of crop circle :
 http://woodenbooks.com/
 */

int radius = 160;
int weight = 1;
int myNumber = 0;
int myColor = 0;
int myOffset = 0;
int maxNumber = 111;
int maxColor = 360;
int maxOffset = radius / 2;
boolean numberAdd = true;
boolean colorAdd = true;
boolean offsetAdd = true;
float angle = 0;
float centerX;
float centerY;

void setup() {
  size(400, 400);
  colorMode(HSB, maxColor, 100, 100);

  centerX = width / 2;
  centerY = height / 2;
}

void draw() {
  background(0);

  // center
  createCircle(centerX, centerX, radius);

  // reset
  angle = 0;

  // orbital
  for (int i = 0; i < myNumber; i++) {
    float xp = centerX + cos(angle) * radius /2 ;
    float yp = centerY + sin(angle) * radius /2;

    angle += TWO_PI / myNumber;    
    createCircle(xp, yp, radius);
  }
  
  // number of circle
  if ((myNumber > maxNumber) && numberAdd) {
    numberAdd = false;
  }

  if ((myNumber < 0) && !numberAdd) {
    numberAdd = true;
  } 

  if (numberAdd) myNumber++;
  else myNumber--;

  // number of offset
  if ((myOffset > maxOffset) && offsetAdd) {
    offsetAdd = false;
  }

  if ((myOffset < -maxOffset) && !offsetAdd) {
    offsetAdd = true;
  } 

  if (offsetAdd) myOffset++;
  else myOffset--;

  // color
   myColor++;
  
  if (myColor > maxColor) {
    myColor = 0;
  }
}

void createCircle(float x, float y, float r) {
  noFill();
  strokeWeight(weight);
  stroke(myColor, 100, 100);
  ellipse(x, y, r, r);
  ellipse(x, y, r + myOffset, r + myOffset);
}

