/*

  Author: chimanaco 

 */

int radius = 100;
int angle = 40;
int eatSpeed = 2;
int maxAngle = angle;
boolean closeMouth = true;
packmaso p;  // packmaso

void setup() {
  size(400, 400);
  colorMode(RGB, 255, 255, 255, 255);
  background(0, 0, 0, 0);  // r, g, b, alpha

  // create packmaso
  p = new packmaso();
}

void draw() {
  background(0);

  if ((angle < 0)||(angle > maxAngle)) {
    closeMouth = !closeMouth;
  }

  if (closeMouth) {
    angle -= eatSpeed;
  } else {
    angle += eatSpeed;
  }

  p.run(radius, angle);
}

// packmaso 
class packmaso {
  //constructor
  packmaso() {
    noStroke();   
    fill(250, 250, 0);
  }

  void run(int radius, int angle) {
    arc(width/2, height/2, radius, radius, radians(angle), radians(360-angle));
  }
}

