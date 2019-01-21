import processing.serial.*;

Serial myPort;
String inString;
String[] data;
int x1;
int y1;
int vx1 = 0;
int vy1 = 0;
int ax1 = 0;
int ay1 = 0;
int x2;
int y2;
int vx2 = 0;
int vy2 = 0;
int ax2 = 0;
int ay2 = 0;
int readx1 = 0;
int ready1 = 0;
int readx2 = 0;
int ready2 = 0;
int v1 = 0;
int v2 = 0;
int flag1x;
int flag1y;
int flag2x;
int flag2y;
int score1;
int score2;
int w;
int h;
int islandw;
int islandh;
int flagw;
int flagh;
PFont font;
boolean reset1;
boolean reset2;
boolean collide;
boolean player1holdFlag;
boolean player2holdFlag;
boolean sourcechange1;
boolean sourcechange2;
PImage background;
PImage redboat;
PImage blueboat;
PImage redsource;
PImage bluesource;
PImage island;
String[] redurl= {"img/cha1.png","img/cha2.png","img/cha3.png"};
String[] blueurl= {"img/usa1.png","img/usa2.png","img/usa3.png"};



void setup(){
  size(1400,800);
  background(255);
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.bufferUntil('\n');
  w = 100;
  h = 80;
  x1 = 100;
  y1 = height/2-h/2;
  x2 = 1200;
  y2 = height/2-h/2;
  flag1x = 50;
  flag1y = height/2;
  flag2x = 1350;
  flag2y = height/2;
  score1 = 0;
  score2 = 0;
  font = createFont("SansSerif-48.vlw",24);
  textFont(font);
  reset1 = false;
  reset2 = false;
  collide = false;
  player1holdFlag = false;
  player2holdFlag = false;
  frameRate(30);
  size(width,height);
  background = loadImage("img/background.png");
  //size(50,50);
  redboat = loadImage("img/boat-chn.png");
  blueboat = loadImage("img/boat-usa.png");
  
  islandw = 100;
  islandh = 400;
  island = loadImage("img/island.png");
  flagw = 50;
  flagh = 50;
  sourcechange1 = true;
  sourcechange2 = true;
}

void draw(){
  image(background,0,0);
  //display scores
  fill(0);
  
  text("score:"+score1,30,30);
  text("score:"+score2,width-110,30);
  image(island,width/2-islandw/2,height/2-islandh/2,islandw,islandh);
  
  //player1
  readx1 = int(data[0]);
  ready1 = int(data[1]);
  ax1 = readx1 * 4;
  ay1 = ready1 * 4;
  println("adding");
  //delay(500);
  image(redboat,x1,y1,w,h);
  
  v1 = vx1 * vx1 + vy1 * vy1;
  
  
  
  //set x moving mode
  if(v1 != 0 && readx1 == 0 && vx1 !=0){
    ax1 = -2 * (vx1/abs(vx1));
    if(vx1 == 2 || vx1 == 0 || vx1 == -2){
      ax1 = 0;
      vx1 = 0;
    }
  }
  
  //set y moving mode
  if(v1 != 0 && ready1 == 0 && vy1 !=0){
    ay1 = -2 * (vy1/abs(vy1));
    if(vy1 == 2 || vy1 == 0 || vy1 == -2){
      ay1 = 0;
      vy1 = 0;
    }
  }


  if(x1>(width-w) || x1<0){
    vx1 = -vx1;
    ax1 = readx1 * 4;
  }
  if(y1>(height-h) || y1<0){
    vy1 = -vy1;
    ay1 = ready1 * 4;
  }
  if(y1>height/2-islandh/2-h && y1<height/2+islandh/2){
    if(x1<width/2+h && x1>width/2-islandw/2-w){
      vx1 = -vx1;
      ax1 = readx1 * 4;
    }
  }
  if(x1<width/2+w && x1>width/2-islandw/2-w){
    if(y1>height/2-islandh/2-h && y1<height/2+islandh/2){
      vy1 = -vy1;
      ay1 = ready1 * 4;
    }
  }
  
  //max speed
  if(vx1>16 && readx1 != 0){
    vx1 = 16;
    ax1 = 0;
  }
  if(vx1<-16 && readx1 != 0){
    vx1 = -16;
    ax1 = 0;
  }
  if(vy1>16 && ready1 != 0){
    vy1 = 16;
    ay1 = 0;
  }
  if(vy1<-16 && ready1 != 0){
    vy1 = -16;
    ay1 = 0;
  }
  
  vx1 = vx1 + ax1;
  x1 = x1 + vx1;
  vy1 = vy1 +ay1;
  y1 = y1 + vy1;
  println("vx1:" + vx1 + "   vy1:" + vy1 + "  ax1:" + ax1 + "   ay1:" + ay1 + "  inputx:" + readx1 +"  inputy:" + ready1);
  
  
  
  
  
  
  //player2
  readx2 = int(data[2]);
  ready2 = int(data[3]);
  ax2 = readx2 * 4;
  ay2 = ready2 * 4;
  image(blueboat,x2,y2,w,h);
  
  v2 = vx2 * vx2 + vy2 * vy2;
  
  
  
  //set x moving mode
  if(v2 != 0 && readx2 == 0 && vx2 !=0){
    ax2 = -2 * (vx2/abs(vx2));
    if(vx2 == 2 || vx2 == 0 || vx2 == -2){
      ax2 = 0;
      vx2 = 0;
    }
  }
  
  //set y moving mode
  if(v2 != 0 && ready2 == 0 && vy2 !=0){
    ay2 = -2 * (vy2/abs(vy2));
    if(vy2 == 2 || vy2 == 0 || vy2 == -2){
      ay2 = 0;
      vy2 = 0;
    }
  }

  if(x2>(width-w) || x2<0){
    vx2 = -vx2;
    ax2 = readx2 * 4;
  }
  if(y2>(height-h) || y2<0){
    vy2 = -vy2;
    ay2 = ready2 * 4;
  }
  if(y2>height/2-islandh/2-h && y2<height/2+islandh/2){
    if(x2<width/2+w && x2>width/2-islandw/2-w){
      vx2 = -vx2;
      ax2 = readx2 * 4;
    }
  }
  if(x2<width/2+w && x2>width/2-islandw/2-w){
    if(y2>height/2-islandh/2-h && y2<height/2+islandh/2){
      vy2 = -vy2;
      ay2 = ready2 * 4;
    }
  }
  
  //max speed
  if(vx2>16 && readx2 != 0){
    vx2 = 16;
    ax2 = 0;
  }
  if(vx2<-16 && readx2 != 0){
    vx2 = -16;
    ax2 = 0;
  }
  if(vy2>16 && ready2 != 0){
    vy2 = 16;
    ay2 = 0;
  }
  if(vy2<-16 && ready2 != 0){
    vy2 = -16;
    ay2 = 0;
  }
  
  vx2 = vx2 + ax2;
  x2 = x2 + vx2;
  vy2 = vy2 +ay2;
  y2 = y2 + vy2;
  
  println("vx2:" + vx2 + "   vy2:" + vy2 + "  ax2:" + ax2 + "   ay2:" + ay2 + "  inputx:" + readx2 +"  inputy:" + ready2);
  
  if(sourcechange1){
  redsource = loadImage(redurl[int(random(0,3))]);
  sourcechange1 = false;
  }
  if(sourcechange2){
  bluesource = loadImage(blueurl[int(random(0,3))]);
  sourcechange2 = false;
  }
  
  image(redsource,flag1x,flag1y,flagw,flagh);
  image(bluesource,flag2x,flag2y,flagw,flagh);
  
  //have the flag
  if(x1>flag2x-w && x1<flag2x+flagw && !collide){
    if(y1>flag2y-h && y1<flag2y+flagh){
      player1holdFlag = true;
      
    }
  }
  if(x2>flag1x-w && x2<flag1x+flagw && !collide){
    if(y2>flag1y-h && y2<flag1y+flagh){
      player2holdFlag = true;
    }
  }
  

  if(player1holdFlag){
      flag2x = x1;
      flag2y = y1;
  } else {
      flag2x = 1320;
      flag2y = height/2-flagh/2;
  }
  if(player2holdFlag){
      flag1x = x2;
      flag1y = y2;
  } else {
      flag1x = 30;
      flag1y = height/2-flagh/2;
  }

  
  
  if(reset1){
    x1 = 100;
    y1 = height/2;
    reset1 = false;
    collide = false;
    player1holdFlag = false;
    player2holdFlag = false;
  }
  if(reset2){
    x2 = 1250;
    y2 = height/2;
    reset2 = false;
    collide = false;
    player1holdFlag = false;
    player2holdFlag = false;
  }
  //win a point
  if(flag1x > width-w){
    score2 = score2 + 1;
    reset1 = true;
    reset2 = true;
    sourcechange1 = true;
  }
  if(flag2x < 0){
    score1 = score1 + 1;
    reset1 = true;
    reset2 = true;
    sourcechange2 = true;
  }
  
  
  //collide
  int distancex = abs(x1 - x2);
  int distancey = abs(y1 - y2);
  if(distancex<w && distancey<h){
    println(v1 + "    "  + v2);
    
    if(v1>v2){
      reset1 = true;
      collide = true;
    } else if(v1<v2){
      reset2 = true;
      collide = true;
    } else if(v1 == v2){
      println("here");
      
      vx1 = -vx1;
      vy1 = -vy1;
      vx2 = -vx2;
      vy2 = -vy2;
      ax1 = readx1 * 4;
      ay1 = ready1 * 4;
      ax2 = readx2 * 4;
      ay2 = ready2 * 4;
      println(ax2);
      
    }
  }
  
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  
  if(inString != null)
  inString = trim(inString);
  data = split(inString,",");
  
}
