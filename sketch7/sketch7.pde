// "REJECTION"

import java.util.ArrayList;

float k = 0.005; //the constant detailing the force between people
ArrayList<Person> people;
Self self;

float attractionFactor(Person a, Person b){
  float r = a.x.dist(b.x);
  return -k*a.charge*b.charge / (float)Math.pow(r, 2.1); 
}

class Person{
  public PVector x;
  public PVector preInteractionVelocity;
  public float charge;
  public float size;
  
  public float grayShade;
  
  public Person(){
    x = new PVector(random(-200,0), random(-200,200));
    preInteractionVelocity = new PVector(random(5,10), 0);
    charge = random(40,100);
    size = random(20,50);
    grayShade = random(0,90);
  }
  
  void update(){
    PVector v = preInteractionVelocity.get();
    
    for(Person p: people){
      if(p != this){
        PVector force = this.x.get();
        force.sub(p.x);
      
        force.mult(attractionFactor(this, p));
      
        v.add(force);
      }
    }
    
    x.add(v);
  }
  
  void display(){
    fill(color(0,0,grayShade,60));
    ellipse(x.x, x.y, size, size);
  }
}

class Self extends Person{
  
  public Self(){
    x = new PVector(0,0);
    preInteractionVelocity = new PVector(0,0);
    charge = -150;
    size = 20;
    grayShade = 0;
  }
  
  void update(){
    PVector v = preInteractionVelocity.get();
    
    PVector restoringForce = x.get();
    restoringForce.mult(-0.02);
    v.add(restoringForce);
    
    for(Person p: people){
      if(p != this){
        PVector force = this.x.get();
        force.sub(p.x);
      
        force.mult(-1*attractionFactor(this, p));
      
        v.add(force);
      }
    }
    
    x.add(v);
  }
  
  void display(){
    fill(color(0,0,grayShade,100));
    rect(x.x,x.y,size,size);
  }
}

void setup(){
  frameRate(30);
  size(500,500);
  smooth();
  noStroke();
  colorMode(HSB,360,100,100, 100);
  background(0,0,100);
  
  people = new ArrayList<Person>();
  self = new Self();
}

void draw(){
  if(frameCount % 3 == 0){
    people.add(new Person());
  }
    
  background(0,0,100);
  
  pushMatrix();
  translate(250,250);
  
  for(Person p : people){
    p.update();
    p.display();
  }
  
  self.update();
  self.display();
  
  for(int i = people.size()-1; i>=0; i--){
    if(people.get(i).x.x > 250){
      people.remove(i);
    }
  }
  
  popMatrix();
}
