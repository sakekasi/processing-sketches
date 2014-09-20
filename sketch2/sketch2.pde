void setup(){
  frameRate(30);
  size(500,500);
  smooth();
  background(255);
}

void draw(){
  float angle = radians(random(360));
  float length = 5 + 60*abs(sin(radians(random(360))));
  float x = random(500), y = random(500);
  float strength = random(15);
  
  strokeWeight(strength);
  line(x,y,x+length*cos(angle),y+length*sin(angle));
  
  if(mousePressed){
    background(255);
  }
}
