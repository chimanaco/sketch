/*
  author:chimanaco
 
 inspired:
 http://forum.processing.org/topic/shape-heart
 
 */

ArrayList particles;
color from = color(80, 105, 255);
color to = color(240, 0, 210);
float angle;

int interval = 100;
int startTime;

/*
  setup
 */
void setup() {
  size(400, 400);
  colorMode(RGB, 255, 255, 255, 255);
  background(248, 201, 229);
  // createArray
  particles = new ArrayList();
}

/*
  loop
 */
void draw() {
  if (millis() > startTime + interval) {
    startTime = millis(); // reset start time
    displayHeart();
  }
  for (int i = 0; i <= particles.size()-1; i++) {  
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    heart p = (heart) particles.get(i);
    if (p.notVisible() ) particles.remove(i);
    p.run();
  }
}

void displayHeart() {
  float amt = abs(sin(angle));
  color c = lerpColor(from, to, amt);
  float startX = 0;
  float startY = 0;

  particles.add(new heart(c, startX, startY));

  angle += 0.2;
}

// packmaso 
class heart {
  float x;
  float y;
  color heartColor;
  float speed = 0;
  float maxSpeed = 28;
  float yOffset = 10;

  //constructor
  heart(color c, float posX, float posY) {
    heartColor = c;
    x = posX;
    y = posY;
  }

  boolean notVisible() {
    if (speed > maxSpeed) {
      return true;
    }
    else
      return false;
  }

  void run() {
    pushMatrix();
    //  translate(width/2 + cos(angle) * scalar,height/2 + sin(angle) * scalar);
    translate(width/2 + x, height/2 + y + yOffset * speed);
    scale(speed, speed);
    drawHeart(heartColor);

    popMatrix();
    speed += 0.1;
  }
}

void drawHeart(color c)
{
  beginShape();
  noStroke();
  fill(c);   
  vertex(0, -20); 
  bezierVertex(0, -40, 40, -30, 0, 5); 
  bezierVertex(-40, -30, 0, -40, 0, -20);  
  endShape(CLOSE);
}
