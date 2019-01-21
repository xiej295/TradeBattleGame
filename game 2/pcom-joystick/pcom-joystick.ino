int x1;
int y1;
int x2;
int y2;

void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);

  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
}

void loop() {
  int xVal1 = analogRead(A1);
  int yVal1 = analogRead(A0);
  int xVal2 = analogRead(A3);
  int yVal2 = analogRead(A2);

  
  if(xVal1 < 300){
    x1 = 1;
  }else if(xVal1 > 800){
    x1 = -1;
  }

  if(yVal1 < 300){
    y1 = -1;
  }else if(yVal1 > 800){
    y1 = 1;
  }

  if(xVal2 < 300){
    x2 = 1;
  }else if(xVal2 > 800){
    x2 = -1;
  }

  if(yVal2 < 300){
    y2 = -1;
  }else if(yVal2 > 800){
    y2 = 1;
  }

  Serial.print(x1);
  Serial.print(",");
  Serial.print(y1);
  Serial.print(",");
  Serial.print(x2);
  Serial.print(",");
  Serial.println(y2);
  delay(100);

  x1 = 0;
  y1 = 0;
  x2 = 0;
  y2 = 0;
}
