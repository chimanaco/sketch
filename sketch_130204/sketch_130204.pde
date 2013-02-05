/*
  author:chimanaco
 
 inspired: 
 http://www.ikiya.jp/crest/warituke/sippou.html
 
*/

int col = 5;  // tate
int row = 5; // yoko
float cellWidth;  // unit width
float cellHeight; // unit height
int strokeW = 5;
float xPosOffset = -0.25;
float yPosOffset = -0.25;
int myColor = color(180, 15, 15, 60);
int bgColor = color(255, 255, 255, 255);
int strokeColor = color(157, 15, 40, 255);

/*
  setup cp5
 */
void setup() {
  size(400, 400);
  colorMode(RGB);
  
  // stroke
  stroke(strokeColor);
  strokeWeight(strokeW);
}

/*
  loop
 */
void draw() {
  background(bgColor);
  
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
  change pattern
 */
void createPattern(float xPos, float yPos) {
  fill(myColor);   
  ellipse(xPos, yPos, cellWidth, cellHeight);
}

