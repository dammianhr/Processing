import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

import codeanticode.syphon.*;

SyphonServer server;
PImage toSyphon;

HE_Mesh myShape;
WB_Render render;

//saving variables
boolean faceOn;
boolean edgeOn;
int edgeWeight;

//view
float zoom;                     
float actualZoom = 20;  
int transparency = 255;

// basic shape variables
int creator = 0;                       // default shape: BOX
float create0 = 4;                     
float create1 = 4;                     
float create2 = 4;                    
float create3 = 4;                     

boolean FULLSCREEN = false;

int MAX_X =800 ;
int MAX_Y =600;

float FAR_Z = -5000.0;
float NEAR_Z = 1000;

int SIZE = 50;
int BLOCK_NUM = 70;

Block[] blocks = new Block[BLOCK_NUM];

void setup() {
  size(800,600, P3D);
  smooth();
  
  server = new SyphonServer(this, "Poligon Space");
  toSyphon = createImage(800,600,ARGB);
  
  //create shape
  createHemesh();

  render=new WB_Render(this);
  
  camera(0, 0, -90, 0, 0, -100, 0, 1, 0);
  float cameraZ = ((width/2.0) / tan(PI*60.0/360.0));
  // adjusted from perspective() reference to narrow fov
  perspective(PI/4.0, float(width)/height, cameraZ/10.0, cameraZ*10.0);
  
  noStroke();
  
  shininess(.0010);

  // create paticles with class
  for(int i=0; i<BLOCK_NUM; i++) blocks[i] = new Block(); 
  
  gui();
}

void draw() {
  background(0,0);
  
 // lightSpecular(100, 100, 100);
  directionalLight(220, 220, 180, 1, 1, -1);
 // specular(155, 155, 155);
  directionalLight(50, 80, 120, -1, -1, -1);
  //ambientLight(153, 102, 0);
  //ambient(51, 26, 0);
  
  // draw class shape
  for(int i=0; i<BLOCK_NUM; i++)
    blocks[i].draw();
    
  loadPixels();
  toSyphon.loadPixels();
  
  for (int j = 0; j < pixels.length; j++) {
    toSyphon.pixels[j] = pixels[j]; 
  }
  
  toSyphon.updatePixels();
  server.sendImage(toSyphon);
    
    
}

public void stop() {
  server.stop();
} 

void mousePressed() {
  saveFrame("spaceParticle-###.png");
}


