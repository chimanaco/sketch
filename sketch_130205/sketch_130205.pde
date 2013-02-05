/*
  author:chimanaco
 
 inspired: 
 Olympus digital billboard you can see from Shinjuku station
 
 */

int lineNumber = 123;
float margin = 15.8;
float speed = 1;
float lineSpeed = 1.88;
int maxHue = 360;
int bgColor = color(0);
int num = 0;
ArrayList particles;

/*
  setup
 */
void setup() {
  size(400, 400);  
  colorMode(HSB, maxHue, 100, 100);
  background(bgColor);

  // createArray
  particles = new ArrayList();
  particles.add(new particle(num));
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

