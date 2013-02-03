/*
  author:chimanaco
 
 original:
 Interference and moiré pattern
 Ira Greenberg, October 18, 2005
 
 Processing: Creative Coding and Computational Art 
 http://www.amazon.co.jp/gp/product/159059617X?ie=UTF8&camp=1207&creative=8411&creativeASIN=159059617X&linkCode=shr&tag=chimanaco-22
 
 */

float interval;
float spacer;
// Experiment with these values
float angle = 0;
float amplitude = .05;
float waveGap = 10;
float frequency = .1;

int HSBHue = 360;

/*
  setup cp5
 */
void setup() {
  size(400, 400);
  colorMode(HSB, 360, 100, 100);
  interval = width * .03;
//  interval = width * .1;
  spacer = interval;
  noFill();
  frameRate(30);
}

/*
  loop
 */
void draw() {
  background(0);
    
  stroke(HSBHue * mouseX / width, 100, 100);
  
  float py = 0;
  /* This nested for loop fills the frame
   with a wave pattern. Some of its properties
   are controlled, in part, by the mouse position*/
  for (int i = 0; i < height; i += waveGap) {
    for (int j = 0; j < width; j++) {
      py = i + sin(radians(angle))* mouseY * amplitude;
      point(j, py);
      angle += mouseX * frequency;
    }
  }
  
  stroke(HSBHue * mouseX/width, 50, 50);
  
  // draw concentric ring pattern
  for (int i = 0; i < width * spacer / interval; i += spacer) {
    ellipse(width / 2, height / 2, 10 + i, 10 + i);
  }
}
