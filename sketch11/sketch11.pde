import processing.pdf.*;

int connections[];

String filename = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) +
    Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());

void setup(){
  frameRate(30);
  size(500, 500);
  
  beginRecord(PDF, "print/"+filename+".pdf");
  smooth();
  stroke(0);

  connections = new int[50*50]; 
  update();
}

void draw(){
  if(frameCount % 100 == 0){
    update();
  }
  
  background(255);
  strokeWeight(1);
  
  
  for(int x = 0; x < 50; x++){
    for(int y = 0; y < 50; y++){
      int nx = connections[50*x+y] / 50, ny = connections[50*x+y] % 50; 
      int dist = (int) (Math.abs(x-nx) + Math.abs(y-ny));
      
      strokeWeight((float) Math.exp(0.02*dist)); //exponentially reward distance
      stroke(0,0,0,(float) (200.0/Math.exp(0.055*dist))); //exponentially penalize distance
      
      line((float) 10*x + 5,(float) 10*y + 5, 10*nx + 5, 10*ny + 5);
    }
  } 
}

void update(){
  for(int i=0; i<connections.length; i++){
    //weights[i] = random(15);
    connections[i] = (int) random(50*50);
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
