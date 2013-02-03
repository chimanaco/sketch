/*
  author:chimanaco
 
 inspired:
 http://www.ikiya.jp/crest/download.html
 http://www.jalpurmillersonline.com/shop/2-boxed-mixes-a-masalas/140-jalpur-tea-masala
 
 */

// pattern
int radius = 100;
int lineNumber = 4;
int lineWeight = 7;
int lineColor = color(15, 31, 106, 255);

/*
  setup
 */
void setup() {
  size(400, 400);
  colorMode(RGB);
  smooth();
}

/*
  loop
 */
void draw() {
  background(255);

  stroke(lineColor);
  strokeWeight(lineWeight);

  int col = ceil(height / radius * 4) + 2;  // tate
  int row = ceil(width / radius) + 1; // yoko  

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
  pattern
 */
void createPattern(float xPos, float yPos) {  
  for (int i = 0; i < lineNumber; i++) {
    float r = radius - radius / lineNumber * i;
    ellipse(xPos, yPos, r, r);
  }
}

