import blobDetection.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

ArrayList<PVector> brush = new ArrayList<PVector>(); 


Capture video;
OpenCV opencv;

PImage test;
int time;

//float videoScale;

void setup() {
  size(800, 650);
  reset();
  background(0);
  String[] cameras = Capture.list();
//  test = loadImage("048.jpg");
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }  
  }  

  video = new Capture(this, 640/2, 480/2, "FaceTime Camera");
  opencv = new OpenCV(this, 640/2, 480/2);
  video.start();
} 
void draw() {
  opencv.loadImage(video);
  background(255);
 // pushMatrix() ;
  scale(-2,2);
  translate(-video.width, 0);
  image(video, 0, 0);
  
  
  
  
  //println(opencv.max());
  PVector loc = opencv.max();
  
  //if(loc.x == 0.0 && loc.y == 0.0){
  //  //the location is in the top corner
  //}
 
  
  if(brush.size() > 2){
      PVector prevLoc = brush.get(brush.size()-1);
      
      float pointDist = dist(prevLoc.x,prevLoc.y, loc.x,loc.y);
      
      //println(pointDist);
      
      if(pointDist < 35){
               brush.add(loc);

      }
      
  }else{
     if(loc.x != 0 && loc.y != 0) {
        brush.add(loc);
     }
  }

  

  if ( brush.size() > 2) {

    for (int i = 0; i < brush.size(); i++ ) {
      if (i>=1) {
        PVector temp = brush.get(i);
        PVector temp1 = brush.get(i-1);
        float strokeVelocity = dist(temp.x,temp.y, temp1.x, temp1.y);
        if(strokeVelocity > 30) {
            strokeVelocity = 30;
        }
        
        strokeVelocity = map(strokeVelocity, 1, 30, 30, 1);
        strokeWeight(strokeVelocity);
        line(temp.x, temp.y, temp1.x, temp1.y);
      }


      // ellipse(temp.x, temp.y, 10, 10);
    }
  } 

   if (time>millis()){
     reset();
   }
    // popMatrix();

  //stroke(255, 0, 0);
  //strokeWeight(3);
  //fill(255, 0, 0);
  //ellipse(loc.x, loc.y, 10, 10);
}


void captureEvent(Capture c) {
  c.read();
}

   void reset(){
     time = millis() + 60;
     background(255);
   }

  
//make an arraylist of 
// ArrayList<Pvector> brush=new ArrayList<PVector>(); // creating new generic arraylist
//do a millis and save a point every x seconds so it's not so heavy
