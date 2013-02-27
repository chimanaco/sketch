/*
  author:chimanaco
 
 inspired:
 "EYE WORX" on Denman St.
 
 atan2:
 http://processing.org/learning/basics/arctangent.html
 
 BGM:
 https://www.youtube.com/watch?v=3F4qZpXdkZM
 
 */

// radius
int eyeR1 = 100;
int eyeR2 = 90;
int eyeR3 = 80;
int eyeR4 = 60;
int eyeR5 = 40;
int eyeR6 = 15;

// spiral
int outerRectW = 90;
int outerRectH = 150;
int outerRectNum = 10;
int outerRectColor = color(255, 0, 0);

int innerRectW = 60;
int innerRectH = 30;
int innerRectNum = 10;
int innerRectColor = color(255, 60);

// color
color c1 = color(255);
color c2 = color(0);
color c3 = color(255);
color c4 = color(39, 132, 211);
color c5 = color(0);
color c6 = color(255);
color[] eyesColors = { 
  c1, c2, c3, c4, c5
};

// eyes
ArrayList eyes;

// eye ball
EyeBall eBall;

// eye ball offset
int eyeBallOffset = 3;

// move ellipse
int eyeRMax = 50;
float angle = 0;
float speed = 7;

/*
  setup cp5
 */
void setup() {
  size(400, 400, P2D);
  colorMode(RGB, 255);

  smooth();
  
  // eyes
  eyes = new ArrayList();  
  for (int i = 0; i < eyesColors.length; i++) {
    eyes.add(new Eye(width / 2, height /2, eyesColors[i]));
  }

  // eye ball
  eBall = new EyeBall( width / 2, height /2, eyeR5, c6);
}

/*
  loop
 */
void draw() {  
  background(0);

  float a = sin(radians(angle));
  float m = map(a, -1, 1, 0, 1);

  // eye radius
  float[] eyesRs = {
    eyeR1 + eyeRMax *  m, eyeR2, eyeR3, eyeR4, eyeR5
  };

  noStroke();

  for (int i = 0; i < eyes.size(); i++) {
    Eye e = (Eye) eyes.get(i);

    // inner spiral
    if (i == 4) {
      drawSpiral(innerRectW, innerRectH, innerRectNum, innerRectColor);
    }

    e.display(eyesRs[i]);
  }    

  // eye ball update
  eBall.update(mouseX, mouseY);
  eBall.display();
  
  // outer spiral
  drawSpiral(outerRectW, outerRectH, outerRectNum, outerRectColor);
  
  // speed
  angle += speed;
}


// drawSpriral
void drawSpiral(int w, int h, int n, color c) {
  noFill();
  stroke(c);

  rectMode(CENTER);

  for (int i = 0; i < 360; i += n) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(radians(i));
    rect(0, 0, w, h);
    popMatrix();
  }
}


/*
  eye
 */
class Eye {
  int x, y;
  color myColor;

  Eye(int tx, int ty, color c) {
    x = tx;
    y = ty;
    myColor = c;
  }

  void display(float r) {
    pushMatrix();
    translate(x, y);
    fill(myColor);
    ellipse(0, 0, r, r);
    popMatrix();
  }
}

/*
  eye ball
 */
class EyeBall {
  int x, y;
  int radius;
  color myColor;
  float angle = 0.0;

  EyeBall(int tx, int ty, int r, color c) {
    x = tx;
    y = ty;
    radius = r / 2;
    myColor = c;
  }

  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    fill(myColor);
    ellipse(radius - eyeBallOffset, 0, eyeR6, eyeR6);
    popMatrix();
  }
}

