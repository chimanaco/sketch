/*
  author:chimanaco
 
 inspired(copied):
 http://www.openprocessing.org/sketch/39064
 
 */

int maxStarSize = 14;
String graphicsMode =  P2D;
ArrayList fallingChars;

int interval = 200;
int startTime;

/*
  setup
 */
void setup()
{
  size(400, 400, P2D);
  colorMode(RGB, 255, 255, 255, 255);

  fallingChars = new ArrayList();  // Create an empty ArrayList
  for ( int i = 0; i< 1; i++)      // now add some elements for initial seeding 
    CreateChar(1);
}

/*
  loop
 */
void draw()
{
  background(248, 201, 229);
  for (int i = fallingChars.size()-1; i >= 0; i--)
  {   // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    fallingHeart fc = (fallingHeart) fallingChars.get(i);
    if (fc.notVisible() ) fallingChars.remove(i);
    else
    {
      fc.fall();
      fc.display();
    }
  }
  if ((frameCount & 2) > 0 )
  {
    // timer
    if (millis() > startTime + interval) {
      startTime = millis(); // reset start time
      int x = (int)random(4);
      for (int j = 0; j < x; j++)
      {
        CreateChar(4);  // top 1/4th
        CreateChar(8);  // top 1/8th
      }
    }
  }
}

class fallingHeart {
  int mx;
  float my;
  int mAlpha;
  float mSize;
  float mRotate;
  int mnPoints;

  color from = color(191, 0, 78);
  color to = color(225, 116, 168);
  color interA = lerpColor(from, to, random(1));

  //constructor
  fallingHeart(int x, int y)
  {
    mx = x;
    my = y;
    mAlpha = 255;
    mSize = random(maxStarSize);
    mRotate = random(TWO_PI);
    mnPoints = 5 + (int)random(5);
  }

  boolean notVisible() {
    if (my < 0) {
      return false;
    }
    else
      return (my > height + 30);
  }

  void display()
  {
    if (!notVisible()) {
      fill(color(255, 255, 255), mAlpha);
      pushMatrix();
      translate(mx - mSize /2, my - mSize /2);
      rotate(mRotate);
      heart(interA);
      popMatrix();
    }
  }

  void fall()
  {
    mAlpha = mAlpha - 1;
    my = my + 1 + mSize / 5;
    mSize = mSize * 0.99;
  }
}

void CreateChar(int n)
{
  int x = (int)random(width);
  //      int y = (int)random(height/ n);
  int y = 0;
  if (n == 1) // Start by adding some elements to whole screen
    fallingChars.add(new fallingHeart(x, y)); 
  else // top-up
  fallingChars.add(new fallingHeart(x, -y));  // Start by adding some elements
}

void heart(color interA)
{
  beginShape();
  noStroke();
  fill(interA); 
  vertex(40, 15); 
  bezierVertex(40, -5, 80, 5, 40, 40); 
  vertex(40, 15); 
  bezierVertex(40, -5, 0, 5, 40, 40);   
  endShape(CLOSE);
}

