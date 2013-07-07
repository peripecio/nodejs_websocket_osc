/*

Guillermo Casado 2013
www.peripecio.com

Escucha OSCs enviados desde un bridge websocket-osc
ws <--> osc

*/
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;    // Para escuchar
NetAddress myRemoteLocation;  // Para enviar

String lastMsg_rcv;
int t_lastMsg_rcv = -1;
boolean swMsg_rcv = false;

Linea linea;



void setup() {
  size(400,400);
  smooth();
  frameRate(25);
  // Listen
  oscP5 = new OscP5(this,6666);
  
  // Envio de OSC
  myRemoteLocation = new NetAddress("127.0.0.1",6667);
  
  linea = new Linea();
  
}


void draw() {
  background(255);  
  
  if(swMsg_rcv) {
    
    fill(255,0,0);
    rect(width*0.4, height*0.4, width*0.2, height*0.2);
        
    if(millis()>t_lastMsg_rcv+300) {
      swMsg_rcv=false;
    }
  }
  
  linea.draw();
  
}


/* Eventos OSC entrantes */
void oscEvent(OscMessage theOscMessage) {
  swMsg_rcv = true;
  t_lastMsg_rcv = millis();
  
  int valor = theOscMessage.get(0).intValue();
  int valx = theOscMessage.get(1).intValue();
  int valy = theOscMessage.get(2).intValue();
  if(valor==0) {
    linea.reset();
  }
  linea.addPt(valx, valy);
   
 
  println("RECV: "+valor+" - "+valx+","+valy);
}


// ****************************


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


