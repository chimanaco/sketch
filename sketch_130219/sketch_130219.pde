/*
  author:chimanaco
 
 inspired:
 la desserte rouge matisse
 
 */

//PatternMaker pm;
FlowerPatternMaker pm;

int col = 4;  // tate
int xOffset = 15;
int yOffset = 15;
color bgColor = color(167, 44, 28);
String caption = "PETAL";
float powpow = 6;

/*
  setup
 */
void setup() {
  size(400, 400);
  colorMode(RGB);
  
  // pattern system
  pm = new FlowerPatternMaker(xOffset, yOffset, caption, bgColor);
}

/*
  loop
 */
void draw() {  
  pm.run(col);
}

/*
  FlowerPatternMaker
 
 */
class FlowerPatternMaker extends PatternMaker { 
  float angle;
  int xOffset;
  int yOffset;
  float speed;
  
  // la desserte rouge matisse
  color c1 = color(197, 193, 184);
  color c2 = color(116, 152, 176);
  color c3 = color(230, 137, 33);
  color c4 = color(53, 107, 21);
  color c5 = color(8, 8, 8);
  color c6 = color(87, 31, 14);
  color c7 = color(49, 70, 97);
  
  
  color [] colors = {c1, c2, c3, c4, c5, c6, c7};
  
  //constructor
  FlowerPatternMaker(int xo, int yo, String cap, color c) {
    super(cap, c);
    xOffset = xo;
    yOffset = yo;

    strokeWeight(1);
  }

  /*
    display pattern
   */
  void createPattern() { 
    // create your pattern here.
    
    angle = 360 / number;
    
    float myHeight = sin(radians(speed));
    float m = map(myHeight, -1, 1, 0, 2);
    
    // color
    int colorNum = number % colors.length;    
    color myColor = colors[colorNum];
    noStroke();
    fill(myColor, 130);  
    
    for (int i = 0; i < 360; i+=angle) {
      pushMatrix();
      translate(radius /2, radius /2);
      rotate(radians(i + speed));
      for (int j = 1; j < 5; j++) { 
        // draw Petal
        drawPetal(0, pow(m, 5) , 0, (radius - xOffset) / 8 / j, (radius - xOffset) / 4 / j, (radius - yOffset) * m / 4 / j, 0, (radius - yOffset) / 2 / j);
      }
      popMatrix();
     }
     
     speed += 0.1;
  }
  
  /*
  drawPetal
 */
void drawPetal(float ax, float ay, float bx, float by , float cx, float cy , float dx, float dy) { 
    beginShape();
    vertex(ax, ay);
    bezierVertex(bx, by, cx, cy, dx, dy);
    bezierVertex(-cx, cy, -bx, by, ax, ay);
    endShape();
  }
  
}

/*
  PatternMaker
 
 */

class PatternMaker {
  float radius;  // radius width
  int number;
  int txtSize = 10;
  int capXoffset = 5;
  int capYoffset = 5;
  color fadeColor = color(255, 60);
  color txtColor = color(0);
  color bgColor;
  String caption;
  
  //constructor
  PatternMaker(String cap, color c) {
    caption = cap;
    bgColor = c;
  }

  /*
    loop
   */
  void run(int myCol) {
    // update background
    background(bgColor);
    
    // radius
    radius = width / myCol;
    
    // sum
    number = 0;

    // draw circle pattern
    for (int i = 0; i < height; i += radius) {
      for (int j = 0; j < width; j += radius) {
        number++;
        pushMatrix();
        translate(j, i);
        createPattern();
        createCaption();
        popMatrix();
      }
    }
  }
  
  /*
    fade Background
   */
  void fader() { 
    fill(fadeColor);
    rectMode(CORNER);
    rect(0,0,width,height);
  }
  
  /*
    display caption
   */
  void createCaption() { 
    textSize(txtSize);
    fill(txtColor);
    text(caption + ": " + number, capXoffset, radius - capYoffset);
  }

  /*
    display pattern
   */
  void createPattern() { 
    // create your pattern here.
  }  
}





