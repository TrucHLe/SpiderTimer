/* @pjs preload="Spider.png"; */

//buffer reference: http://wiki.processing.org/w/Draw_to_off-screen_buffer

PImage spider;
PGraphics buffer;
PImage img;

int pos;
int spiderCount;
int lastSpiderDrawnTime;

float[] xPos = new float[60];
float[] yPos = new float[60];
float[] xSpeed = new float[60];
float[] ySpeed = new float[60];


void setup()
{
  imageMode(CENTER);
  size(400, 400);
  buffer = createGraphics(400, 400, JAVA2D);
  background(255);
  spider=loadImage("Spider.png");

  for (int pos=0; pos<60; pos++)
  {
    xPos[pos]=random(3, width-30);
    yPos[pos]=random(3, height-30);
    xSpeed[pos]=int(random(-2, 2));
    ySpeed[pos]=int(random(-2, 2));
  }

  lastSpiderDrawnTime=millis();
  pos=0;
  spiderCount=parseInt(random(10, 30));
}

void draw()
{
  background(255); //background continuously being drawn
  updateBuffer();
  image(img, width/2, height/2);
}

void updateBuffer()
{
  renderSpiders(buffer);
  img=buffer.get(0, 0, buffer.width, buffer.height);
}

void renderSpiders(PGraphics buffer)
{
  buffer.beginDraw();
  buffer.background(255);
  buffer.smooth();
  buffer.noFill();

  if (spiderCount==60)
  {
    spiderCount=0;
    lastSpiderDrawnTime=millis();
  }

  pos=0;
  if (spiderCount<60)
  {

    if (millis()-lastSpiderDrawnTime>60000)
    {
      spiderCount++;
      lastSpiderDrawnTime=millis();
    }

    while (pos<spiderCount) //if spiderCount>0 --> draw spider
    {
      moveSpider(pos);
      buffer.image(spider, xPos[pos], yPos[pos], 30, 30);
      pos++;
    }
  }

  buffer.endDraw();
} 

void moveSpider(int pos) {
  xPos[pos]+=xSpeed[pos];
  yPos[pos]+=ySpeed[pos];

  if (xPos[pos]+30>width||xPos[pos]-3<0)
  {
    xSpeed[pos]*=-1;
  }
  if (yPos[pos]+30>height||yPos[pos]-3<0)
  {
    ySpeed[pos]*=-1;
  }
}
