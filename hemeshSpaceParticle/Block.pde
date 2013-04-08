class Block {
  float x, y, z;
  float rotX, rotY, rotZ;
  float speed, size;
  int t; // time, used for movement & rotation
  
  Block() {
    rebirth();
    z = random(FAR_Z, NEAR_Z);
  }
  
  void draw() {
      z+=speed;
      if(z>NEAR_Z) {
        rebirth();
      } else {
        pushMatrix();
        translate(x, y, z);
        rotateX(t*rotX);
        rotateY(t*rotY);
        rotateZ(t*rotZ);
        
        if (abs(actualZoom - zoom) > 1)   { actualZoom = 0.99 * actualZoom + 0.01 * zoom; }
        scale(actualZoom);
        //draw shape
        drawHemesh(z);
        popMatrix();
        
        t++;
      }
  }
  
  void rebirth() {
    float dist = random(SIZE+SIZE/2, abs(FAR_Z)/3);
    float deg = random(PI*2);
    x = sin(deg)*dist;
    y = cos(deg)*dist;
    z = FAR_Z;
    t = 0;
    rotX=random(.035);
    rotY=random(.035);
    rotZ=random(.035);
    speed=random(8.0, 60.0);
    size=random(SIZE/4, SIZE);
  }
}
