import processing.pdf.*;

String filename = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) +
    Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());

void setup(){
  frameRate(30);
  size(500,500);
  
  beginRecord(PDF, "print/"+filename+".pdf");
  smooth();
  background(255);
}

void draw(){
  float size = 33 + 30*randomGaussian();//random(3,100);
  float x = random(500), y = random(500);
  float strength = random(15);
  
  strokeWeight(strength);
  ellipse(x,y,size,size);
  
  if(mousePressed){
    background(255);
  }
}

void keyPressed() {
  if( key == '\n'){
    save("screen/"+filename+".jpg");
    endRecord();
    exit();
  }
}
