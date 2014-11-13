void setup(){
  frameRate(30);
  size(500,500);
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
