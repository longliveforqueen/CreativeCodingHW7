float wind = 0.1;
float gravity = 0.8;

class KochLine {
 
//A line between two points: start and end
  PVector start;
  PVector end;
  
  KochLine(PVector a, PVector b) {
    start = a.get();
    end = b.get();
  }
 
  void display() {
    stroke(255);
//Draw the line from PVector start to end.
    start.y=start.y + gravity;
    end.y = end.y + gravity;
    start.x = start.x + wind;
    end.x = end.x + wind;
   
    line(start.x, start.y, end.x, end.y);
  }
  PVector kochA() {
   return start.get();
  }
 
  PVector kochE() {
    return end.get();
  }
   PVector kochB() {
//PVector from start to end
    PVector v = PVector.sub(end, start);
//One-third the length
    v.div(3);
//Add that PVector to the beginning of the line to find the new point.
    v.add(start);
    return v;
  }
 
  PVector kochD() {
    PVector v = PVector.sub(end, start);
//Same thing here, only we need to move two-thirds along the line instead of one-third.
    v.mult(2/3.0);
    v.add(start);
    return v;
  }
   PVector kochC() {
//Start at the beginning.
    PVector a = start.get();
 
    PVector v = PVector.sub(end, start);
//Move 1/3rd of the way to point B.
    v.div(3);
    a.add(v);
 
//Rotate “above” the line 60 degrees.
    v.rotate(-radians(60));
//Move along that vector to point C.
    a.add(v);
 
    return a;
  }
}//class KochLine end

ArrayList<KochLine> lines = new ArrayList<KochLine>();// store all the kochlines


void KochSnowFlake(){
  float randomNum1 = random(20, width-20);
  float randomNum2 = 0;
  float randomNum3 = random(20,50);
  PVector vec1 = new PVector(randomNum1,randomNum2);
  PVector vec2 = new PVector(randomNum1+randomNum3, randomNum2);
  PVector vec3 = new PVector(randomNum1+randomNum3/2, randomNum2+randomNum3*sqrt(3)/2);
 
 
  lines.add(new KochLine(vec1,vec2));
  lines.add(new KochLine(vec2,vec3));
  lines.add(new KochLine(vec3,vec1));
  for(int i = 0; i<5; i++){
    generate();
  }
  
}



void setup() {
  size(600, 600);
  background(0);
  KochSnowFlake();
}

void draw() {
  background(0);
  
  for (KochLine l : lines) {
    l.display();
  }
}


void generate() {
  ArrayList next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
 
//The KochLine object has five functions, each of which return a PVector according to the Koch rules.
    PVector a = l.kochA();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
 
    next.add(new KochLine(a, b));
    next.add(new KochLine(b, c));
    next.add(new KochLine(c, d));
    next.add(new KochLine(d, e));
  }
 
  lines = next;

}
void mousePressed(){
  if(mouseButton==LEFT)
    wind = wind + 0.2;
  if(mouseButton==RIGHT)
    wind = wind - 0.2;
}
