import processing.pdf.*;

Mover m;

int weight=10;
float dx = 0.05;

String filename = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) +
    Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());

void setup() {
  frameRate(30);
  size(500, 500);
  
  beginRecord(PDF, "print/"+filename+".pdf");
  smooth();
  noStroke();
  background(255);
  fill(0);
  m = new Mover();
}

void draw() {
  m.update();

  pushMatrix();

  translate(250, 250);
  m.display();

  popMatrix();
  
  if(frameCount % 3 == 0){
    int choice = (int) random(3);
    
    if(choice == 0){
      weight++;
    } else if(choice == 1){
      weight--;
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      m.update_ay(-1*dx);
    } else if (keyCode == DOWN) {
      m.update_ay(1*dx);
    } else if (keyCode == LEFT) {
      m.update_ax(-1*dx);
    } else if (keyCode == RIGHT) {
      m.update_ax(1*dx);
    }
  } else {
    if(key == ' '){
      background(255);
    } else if( key == '\n'){
      save("screen/"+filename+".jpg");
      endRecord();
      exit();
    }
  }
}



class Mover {
  PVector x = new PVector(0, 0);
  PVector v = new PVector(0, 0);
  PVector a = new PVector(0, 0);
  PVector j = new PVector(0, 0);

  void update() {
    if (x.x >= 250 || x.x <= -250){
      v.x = v.x * -1;
    } else if(x.y >= 250 || x.y <= -250) {
      v.y = v.y * -1;
    }

    v.add(a);
    x.add(v);
  }

  void display() {
    ellipse(x.x, x.y, weight, weight);
  }
  
  void update_ax(float dx){
    PVector d = new PVector(dx, 0);
    v.add(d);
    
    if(Math.abs(weight) > 30){
      weight /= 2;
    }
  }
  
  void update_ay(float dy){
    PVector d = new PVector(0, dy);
    v.add(d);
    
    if(Math.abs(weight) > 30){
      weight /= 2;
    }
  }
}

