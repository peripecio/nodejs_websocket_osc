Linea linea;

JavaScript javascript;
interface JavaScript {
    void sendPoints();
}
void bindJavascript(JavaScript js) {
    javascript = js;
}



void setup() {
  size(400,400);
  smooth();
  
  linea = new Linea();
  
}

void draw() {
  background(200);
  
  linea.draw();

//  if(javascript!=null){
//      text("Conectado a js", 10,10);
//  }
//  else {
//      text("NO Conectado a js", 10,10);
//  }
  
}

void mousePressed() {
  linea.reset();
  linea.addPt(mouseX, mouseY);
}
void mouseDragged() {
  linea.addPt(mouseX, mouseY);
}
void mouseReleased() {
// Llamar a una función de javascript
  if(javascript!=null){
      javascript.sendPoints();
  }
}

// Para llamar desde js
ArrayList getPoints() { return linea.pts; }
//

class Linea {
  ArrayList<PVector> pts;
  
  Linea() {
    pts = new ArrayList();
  }
  
  void addPt(float x, float y) {
    pts.add(new PVector(x,y));
  }
  void addPt(PVector p) {
    pts.add(p);
  }
  
  void draw() {
    for(int i=0; i<pts.size(); i++) {
      stroke(0);
      fill(0);
      PVector p=pts.get(i);
      if(i>0) {
        PVector pa=pts.get(i-1);
        line(pa.x, pa.y, p.x, p.y);
      }      
      ellipse(p.x, p.y, 3,3);
    }
  }
  
  void reset() {
    pts.clear();
  }
}


