/*
  
  author:
  chimanaco
  
  massive love & respect to:
  Fujiko Fujio

  inspired
  http://wonderfl.net/c/if9A/ 

  if you don know "連ドラ":
  Google image for "連ドラ　ドラえもん"
 
 */

color bgColor = color(255, 152, 170);
color lineColor = color(0, 255);

float headRX = 95;
float headRY = 85;
float headY = 5;
color headColor = color(25, 120, 254);

float faceRX = 75;
float faceRY = 65;
float faceY = 15;
color faceColor = color(255);

float eyeRadius = 30;
float eyeX = 15;
float eyeY = -15;
color eyeColor = color(255);

float eyeBallX = 0;
float eyeBallY = 0;
float eyeBallR = 5;
color eyeBallColor = color(0);
float eyeBallWeight = 3;
float eyeBallAngle = 0;
float eyeBallSpeed = 7;
float eyeBallRound = 5;

float noseR = 15;
float noseY = 3;
color noseColor = color(255, 0, 0);
float noseLineL = 28;

float mouthR = 30;
float mouthY = 24;
float mouthH = 20;

float beardW = 20;
float beardX = 10;
float beardY = 9;
float beardMarginY = 4;
float beardOffsetX = 0;
float beardAngle = 0;

int sum;  // number of D
int currentNum = 0;  // current number
int preNum = 0;  // previous number
float pos;  // current postion
int endPos;  // distanation postion
float speed = 1; // original motion speed from center to destination
float angle;  // rotation angle

int interval = 3000;
int startTime;

boolean firstTime = true;

final int NUMBERS[] = { 1, 2, 3, 4, 5, 6, 8, 10, 12, 18, 20 };
final int POSITIONS[] = { 0, 15, 23, 30, 35, 40, 50, 60, 72, 100, 110 };
final int NUMBERS_LENGTH = NUMBERS.length;

/*
  setup
 */
void setup() {
  size(400, 400);
  colorMode(RGB);
  smooth();
  
  // set first time
  changeNumber();
}

/*
  loop
 */
void draw() {
  background(bgColor);

  // timer
  if (millis() > startTime + interval) {
    startTime = millis(); // reset start time
    changeNumber();
  }
    
  // position
  if (pos < endPos) {
    pos = pos + speed;
  } 
  else {
    pos = endPos;
  }

  pushMatrix();
  translate(width / 2, height / 2);  
  
  for (int j = 0; j < 7; j++) {    
    for (int i = 0; i < 360; i+=angle) {
      pushMatrix();
      rotate(radians(i));
      translate(0, pos);
      stroke(lineColor);
      
      if (j == 0) {
        noStroke();
        // head
        doraHead();
      } 
      else if ( j == 1) {
        noStroke();
        // face
        doraFace();
      } 
      else if ( j == 2) {
        // eye
        doraEye();
      } 
      else if ( j == 3) {
        // eyeBall
        doraEyeBall();
      } 
      else if ( j == 4) {
        // nose
        doraNose();
      } 
      else if ( j == 5) {
        // mouth
        doraMouth();
      } 
      else if (j == 6) {
        // beard
        doraBeard();
      }
      popMatrix();
    }
  }
  popMatrix();

  // text
  displayText();

  // dora speed
  speed = speed * 1.1;  
  // eye speed
  eyeBallAngle += eyeBallSpeed;
}


/*
  changeNumber
 */
void changeNumber() { 
  pos = 0;
  speed = 1;
  
  if(firstTime) {
    sum = 1;
    firstTime = false;
  } else {
    sum = int(random(1, NUMBERS_LENGTH + 1));
  }
  
  // set destination postion
  endPos = POSITIONS[sum - 1];
  
  // set current number
  currentNum = NUMBERS[sum - 1];
  
  // set angle
  angle = 360 / currentNum;
  
  // set offset
  switch(currentNum) {
  case 6: 
    beardOffsetX = 6;
    beardAngle = 30;
    mouthR = 30;
    break;
  case 8: 
    beardOffsetX = 4;
    beardAngle = 25;
    mouthR = 28;
    break;
  case 10:
    beardOffsetX = 3;
    beardAngle = 20;
    mouthR = 25;
    break;
  case 12:
    beardOffsetX = 3;
    beardAngle = 15;
    mouthR = 24;
    break;
  case 18:
    beardOffsetX = 0;
    beardAngle = 10;
    mouthR = 20;
    break;
  case 20:
    beardOffsetX = 0;
    beardAngle = 5;
    mouthR = 20; 
    break;
  default: 
    beardOffsetX = 0;
    beardAngle = 0;
    mouthR = 30;
    break;
  }
}

//  Head
void doraHead() {
  fill(headColor);
  ellipse(0, headY, headRX, headRY);
}

//  Face
void doraFace() {
  fill(faceColor);
  ellipse(0, faceY, faceRX, faceRY);
}

//  Eye
void doraEye() {
  fill(eyeColor);
  ellipse(eyeX, eyeY, eyeRadius, eyeRadius);
  if (sum < 2) {
    ellipse(-eyeX, eyeY, eyeRadius, eyeRadius);
  }
}

//  EyeBall
void doraEyeBall() {
  //fill(eyeBallColor);
  strokeWeight(eyeBallWeight);
  noFill();
  ellipse(eyeX + eyeBallX + eyeBallRound * cos(radians(eyeBallAngle)), eyeY + eyeBallY + eyeBallRound * sin(radians(eyeBallAngle)), eyeBallR, eyeBallR);
  if (sum < 2) {
    ellipse(-eyeX -( eyeBallX + eyeBallRound * cos(radians(eyeBallAngle))), eyeY + eyeBallY + eyeBallRound * sin(radians(eyeBallAngle)), eyeBallR, eyeBallR);
  }
}

//  Nose 
void doraNose() {
  strokeWeight(1);
  fill(noseColor);
  ellipse(0, noseY, noseR, noseR);

  line(0, noseY + noseR / 2, 0, noseY + noseR / 2 + noseLineL);
}

//  Mouth
void doraMouth() {
  noFill();
  bezier(-mouthR, mouthY, -mouthR + (mouthR / 3), mouthY + mouthH, mouthR - (mouthR / 3), mouthY + mouthH, mouthR, mouthY);
}

//  Beard
void doraBeard() {
  pushMatrix();
  translate(0, beardY);

  for (int i = 0; i < 3; i++) {
    float by = beardMarginY * i;    
    
    pushMatrix();
    translate(beardX + beardOffsetX, 0);
    rotate(radians( - beardAngle));
    line(0, by, beardW, by);
    popMatrix();

    if (currentNum < 6) {
      pushMatrix();
      translate( -beardX, 0);
      line(0, by, - beardW, by);
      popMatrix();
    }
  }
  popMatrix();
}

//  text
void displayText() {
  int n;

  fill(headColor);
  textAlign(RIGHT);
  
  if (preNum == currentNum) {
    n = currentNum;
  } 
  else {
    if (preNum < currentNum) {
      preNum++;
    } 
    else {
      preNum--;
    }
    n = preNum;
  }
  
  text(n + "D", 380, 20);
}

/*
  drawPetal
 */
void drawDora() {
  pushMatrix();
  translate(0, pos);  

  // head
  doraHead();
  // face
  doraFace();
  // eye
  doraEye();
  // eyeBall
  doraEyeBall();
  // nose
  doraNose();
  // mouth
  doraMouth();
  // beard
  doraBeard();

  popMatrix();
}


