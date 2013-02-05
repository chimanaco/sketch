/*
  author:chimanaco
 
  inspired: 
   http://www.ikiya.jp/crest/warituke/sippou.html
 
*/
import controlP5.*;
ControlP5 cp5;
ColorPicker cp;
boolean cp5Visble = true;

int col = 5;  // tate
int row = 5; // yoko
float cellWidth;  // radius width
float cellHeight; // radius height
int strokeW = 5;
float xPosOffset = -0.15;
float yPosOffset = -0.15;
int myColor = color(180, 15, 15, 60);
int bgColor = color(255, 255, 255, 255);
int R = 157;
int G = 75;
int B = 40;

/*
  setup
 */
void setup() {
  size(400, 400);
  colorMode(RGB);

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

  // cp5 color
  cp = cp5.addColorPicker("picker")
    .setPosition(xPos, yPos)
      //      .setColorValue(color(15, 31, 106, 255))
      .setColorValue(myColor)
        ;

  // cp5 slider
  String[] slides = {
    "col",  "row", "xPosOffset", "yPosOffset", "strokeW", "R", "G", "B" 
  };
  int[] minList = {
    1, 1, -1, -1, 0, 0, 0 , 0
  };
  int[] maxList = {
    40, 40, 1, 1, 10, 255, 255, 255
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
   background(bgColor);

  stroke(R, G, B);
  strokeWeight(strokeW);
  
  cellWidth = width / col;
  cellHeight = height / row;
  
  // add repeatation instead of change of position
  int xNumOffset = ceil(cellWidth - cellWidth / 2);
  int yNumOffset = ceil(cellHeight- cellHeight / 2);
  
  for (int i = 0; i < width * xNumOffset; i += cellWidth) {
    for (int j = 0; j < height * yNumOffset; j += cellHeight) {
      createPattern(i + i * xPosOffset, j + j * yPosOffset);
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
  fill(cp.getColorValue());
  ellipse(xPos, yPos, cellWidth, cellHeight);
}

