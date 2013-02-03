/*
  author:chimanaco
 
 inspired:
 http://www.ikiya.jp/crest/download.html
 http://www.jalpurmillersonline.com/shop/2-boxed-mixes-a-masalas/140-jalpur-tea-masala
 
 */

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;

// pattern
int radius = 100;
int lineNumber = 4;
int lineWeight = 7;

boolean cp5Visble = true;

/*
  setup cp5
 */
void setup() {
  size(400, 400);
  colorMode(RGB);
  smooth();

  // setup cp5
  setupCP5();
}

/*
  setup cp5
 */
void setupCP5() {
  int xPos = 10;
  int yPos = 10;

  // cp5 
  cp5 = new ControlP5(this);

  // color
  cp = cp5.addColorPicker("picker")
    .setPosition(xPos, yPos)
      .setColorValue(color(15, 31, 106, 255))
        ;

  // slider
  String[] slides = {
    "radius", "lineWeight"
  };
  int[] minList = {
    10, 1
  };
  int[] maxList = {
    200, 10
  };

  int yMargin = 15;
  int len = slides.length; 
  yPos = 80;

  for (int i = 0; i < len; i++) {
    cp5.addSlider(slides[i])
      .setPosition(xPos, yPos + yMargin * i )
        .setRange(minList[i], maxList[i]);
    ;
  }
}

/*
  loop
 */
void draw() {
  background(255);

  int col = ceil(height / radius * 4) + 2;  // tate
  int row = ceil(width / radius + 1); // yoko  

  stroke(cp.getColorValue());
  strokeWeight(lineWeight);

  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      float xPos; 
      if (i%2 == 1) xPos = radius * j;
      else xPos = radius * j + radius /2 ;
      createPattern(xPos, radius / 4 * i);
    }
  }
}

/*
  cp5 visible
 */
void mouseClicked() {
  if (cp5Visble) {
    cp5.hide();
  } 
  else {
    cp5.show();
  }
  cp5Visble = !cp5Visble;
}

/*
  change pattern
 */
void createPattern(float xPos, float yPos) {  
  for (int i = 0; i < lineNumber; i++) {
    float r = radius - radius / lineNumber * i;
    ellipse(xPos, yPos, r, r);
  }
}

