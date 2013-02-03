/*
  author:chimanaco
 
 inspired:
 my socks
 
 Generic methods for dashed lines- OpenProcessing
 http://www.openprocessing.org/sketch/7013
 
 */

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;

// pattern
float radius = 50;
int lineNumber = 4;
int lineWeight = 7;

boolean cp5Visble = true;

int startTime;
int myR;
int myG;
int myB;
int myColor;
int interval = 1000;

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
      //      .setColorValue(color(15, 31, 106, 255))
      .setColorValue(color(180, 15, 15, 255))
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
  background(168, 100, 60);
  
  // timer
//  if (millis() > startTime + interval) {
//    startTime = millis(); // reset start time
//    changeValue();
//  }
  
  int col = ceil(height / radius * 4) + 2;  // tate
  int row = ceil(width / radius + 1); // yoko  


  
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      
      float xPos = radius * j; 
      if ((i % 2 == 0)&&(j % 2 == 0)) fill(0);
      else if ((i % 2 == 1)&&(j % 2 == 1)) fill(0);
      else fill(cp.getColorValue());      
      createPattern(xPos, radius * 2 * i);
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

void changeValue() {
  radius = random(200);
  myColor = ceil(random(255));
}

/*
  change pattern
 */
void createPattern(float xPos, float yPos) {
  noStroke();
  // quad
  quad(xPos, yPos + radius, xPos + radius/2, yPos, xPos + radius, yPos + radius, xPos + radius /2, yPos + radius * 2);

  // line
  stroke(255, 255, 255);
  dashline(xPos, yPos, xPos + radius, yPos + radius * 2, 5, 5);
  dashline(xPos, yPos + radius * 2, xPos + radius, yPos, 5, 5);
}

/*
 * Draw a dashed line with given set of dashes and gap lengths.
 * x0 starting x-coordinate of line.
 * y0 starting y-coordinate of line.
 * x1 ending x-coordinate of line.
 * y1 ending y-coordinate of line.
 * spacing array giving lengths of dashes and gaps in pixels;
 *  an array with values {5, 3, 9, 4} will draw a line with a
 *  5-pixel dash, 3-pixel gap, 9-pixel dash, and 4-pixel gap.
 *  if the array has an odd number of entries, the values are
 *  recycled, so an array of {5, 3, 2} will draw a line with a
 *  5-pixel dash, 3-pixel gap, 2-pixel dash, 5-pixel gap,
 *  3-pixel dash, and 2-pixel gap, then repeat.
 */
void dashline(float x0, float y0, float x1, float y1, float[ ] spacing)
{
  float distance = dist(x0, y0, x1, y1);
  float [ ] xSpacing = new float[spacing.length];
  float [ ] ySpacing = new float[spacing.length];
  float drawn = 0.0;  // amount of distance drawn

  if (distance > 0)
  {
    int i;
    boolean drawLine = true; // alternate between dashes and gaps

    /*
      Figure out x and y distances for each of the spacing values
     I decided to trade memory for time; I'd rather allocate
     a few dozen bytes than have to do a calculation every time
     I draw.
     */
    for (i = 0; i < spacing.length; i++)
    {
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance);
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance);
    }

    i = 0;
    while (drawn < distance)
    {
      if (drawLine)
      {
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]);
      }
      x0 += xSpacing[i];
      y0 += ySpacing[i];
      /* Add distance "drawn" by this line or gap */
      drawn = drawn + mag(xSpacing[i], ySpacing[i]);
      i = (i + 1) % spacing.length;  // cycle through array
      drawLine = !drawLine;  // switch between dash and gap
    }
  }
}

/*
 * Draw a dashed line with given dash and gap length.
 * x0 starting x-coordinate of line.
 * y0 starting y-coordinate of line.
 * x1 ending x-coordinate of line.
 * y1 ending y-coordinate of line.
 * dash - length of dashed line in pixels
 * gap - space between dashes in pixels
 */
void dashline(float x0, float y0, float x1, float y1, float dash, float gap)
{
  float [ ] spacing = { 
    dash, gap
  };
  dashline(x0, y0, x1, y1, spacing);
}

