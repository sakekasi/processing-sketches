import processing.pdf.*;

boolean record = false;

int weight= 10;
Mover m;

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
  //scale(0.5);
  m.display();

  popMatrix();
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      weight++;
    } else if (keyCode == DOWN) {
      weight--;
    }
  } else {
    if (key == ' ') {
      background(255);
    } else if ( key == '\n') {

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


    if (frameCount % 2 == 0 ) {
      a = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
    }

    if (x.x >= 250 || x.x <= -250 || x.y >= 250 || x.y <= -250) {
      v = PVector.mult(x, -0.001);
    }

    v.add(a);
    x.add(v);
  }

  void display() {
    ellipse(x.x, x.y, weight, weight);
  }
}

