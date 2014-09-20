float triangle_dim = 130;

void setup(){
  frameRate(30);
  size(500,500);
  smooth();
  background(255);
}

void draw(){
  float angle = radians(0.4*frameCount);
  
  background(75*sin(2*angle)+75);
  
  fill(255*sin(angle));
  
  pushMatrix();
  
  translate(250,250);
  rotate(7*angle);
  scale(1+0.3*random(0.5,1)*sin(3*angle));
  
  float unit = sqrt(3)*triangle_dim/6; //used for the circumcenter
  triangle(0,-2*unit,
    -triangle_dim/2,unit,
    triangle_dim/2,unit);
  
  popMatrix();
}
