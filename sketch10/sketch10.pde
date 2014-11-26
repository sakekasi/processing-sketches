import processing.pdf.*;

float weights[];

String filename = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) +
    Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());

void setup(){
  frameRate(30);
  size(500, 500);
  
  beginRecord(PDF, "print/"+filename+".pdf");
  smooth();
  noStroke();

  weights = new float[50*50]; 
  update();
}

void draw(){
  if(frameCount % 100 == 0){
    update();
  }
  
  background(255);
  fill(0);
  
  for(int x = 0; x < 50; x++){
    for(int y = 0; y < 50; y++){
      fill(255 - 255/(1+0.05*weights[50*x+y]));
      ellipse((float) 10*x + 5,(float) 10*y + 5,(float) weights[50*x+y],(float) weights[50*x+y]);
    }
  } 
}

void update(){
  for(int i=0; i<weights.length; i++){
    //weights[i] = random(15);
    weights[i] = 10 * randomGaussian();
  }
}

void keyPressed() {
  if( key == '\n'){
    save("screen/"+filename+".jpg");
    endRecord();
    exit();
  } else if( key == ' ' ){
    update();
  }
}
