ArrayList<Circle> circles;

void setup() {
  frameRate(30);
  size(500, 500);
  smooth();
  noStroke();
  colorMode(HSB,360,100,100, 100);
  background(255);
  
  circles = new ArrayList<Circle>();
}

void draw(){
//  background(360);
  
  if(frameCount % 2 == 0){
    circles.add(new Circle());
    if(circles.size() > 200 ){
      circles.remove(0);
    }
  }
  
  float avgh=0, avgs=0, avgb=0;
  
  for(Circle c : circles){
    avgh += c.h;
    avgs += c.s;
    avgb += c.b;
  }
  
  avgh /= circles.size();
  avgs /= 10 * circles.size() / 4;
  avgb /= circles.size();
  
  background(avgh,avgs,avgb);
  
  pushMatrix();
  
  translate(250, 250);
    
  for(Circle c : circles){
    c.update();
    c.display();
  }
  
  popMatrix();
}

class Circle{
  PVector x = new PVector(random(-250,250),random(-250,250));
  PVector v;
  int radius;
  
  float h,s,b,a,scale = 1;
  
  public Circle(){
    h = random(360);
    s = random(70,100);
    b = random(30,70);
    a = random(50,100);
    
    
    radius = (int) (60 + randomGaussian() * 60);
  }
  
  void update(){
    v = PVector.mult(x,-0.1);
    x.add(v);
    
    a-=0.5;
    scale -= 0.005;
  }
  
  void display(){
    pushMatrix();
    
    scale(scale);
    
    fill(color(h,s,b,a));
    ellipse(x.x,x.y,radius,radius);
    
    popMatrix();
  }
}
