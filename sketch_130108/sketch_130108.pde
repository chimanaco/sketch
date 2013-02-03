/*
  author:chimanaco
  
  inspired:
  http://woodenbooks.com/
  
 */

int radius = 200;
int offset = -5;
float angle = 0;
int number = 75;
int weight = 0;
int hueSpeed = 10;

float centerX;
float centerY;

int myNumber = 0;

float myHue = 0;
int maxHue = 360;
int mySaturation = 70;
int maxSaturation = 100;
int myBrightness = 100;

float hueAngle = 0;

void setup() {
  size(400, 400);
  colorMode(HSB, maxHue, maxSaturation, myBrightness);
  
  centerX = width/2;
  centerY = height/2;
}

void draw() {
  background(0);
  // center
  createCircle(centerX, centerX, radius);
  
  // reset
  angle = 0;
  
  // orbital
  for (int i = 0; i < number; i++) {
    float xp = centerX + cos(angle) * radius /2 ;
    float yp = centerY + sin(angle) * radius /2;

    angle += TWO_PI / number;    
    createCircle(xp, yp, radius);
    
  myHue = myHue + hueSpeed;
  if(myHue > maxHue) myHue = 0;
  }
}

void createCircle(float x, float y, float r) {
  noFill();
  strokeWeight(weight);
  stroke(myHue, mySaturation, myBrightness);
  ellipse(x, y, r, r);
  ellipse(x, y, r + offset, r + offset);
}

