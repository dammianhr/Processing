// create shape
void createHemesh() {
  hemeshCreate(creator, create0, create1, create2, create3);
}

//display shape
void drawHemesh(float z){
  if(edgeOn){   
    strokeWeight(edgeWeight);
    stroke(255);
    render.drawEdges(myShape);
  }
        
  if(faceOn){
    noStroke();
    //fill(255);
    fill(constrain(abs(FAR_Z-z)/10.0, 0, 255),transparency);
    render.drawFaces(myShape);
  }
}

//name shape
String numToName(int num) {
  String name = null;
  
  switch(num) {

    // shapes
    case 0: name = "Box"; break;
    case 1: name = "Cone"; break;
    case 2: name = "Dodecahedron"; break;
    case 3: name = "Geodesic"; break;
    case 4: name = "Sphere"; break;
    case 5: name = "Cylinder"; break;
    case 6: name = "Icosahedron"; break;
    case 7: name = "Octahedron"; break;
    case 8: name = "Tetrahedron"; break;

    // default
    default: name = "None"; break;
  }

  return name;
}

void hemeshCreate(int select, float value1, float value2, float value3, float value4) {
  switch(select) {

    case 0: myShape = new HE_Mesh(new HEC_Box().setDepth(value1).setHeight(value2).setWidth(value3)); break;
    case 1: myShape = new HE_Mesh(new HEC_Cone().setRadius(value1).setHeight(value2).setFacets(int(value3)).setSteps(int(value4))); break;
    case 2: myShape = new HE_Mesh(new HEC_Dodecahedron().setEdge(value1)); break;
    case 3: myShape = new HE_Mesh(new HEC_Geodesic().setRadius(value1).setLevel(int(value2))); break;
    case 4: myShape = new HE_Mesh(new HEC_Sphere().setRadius(value1).setUFacets(int(value2)).setVFacets(int(value3))); break;
    case 5: myShape = new HE_Mesh(new HEC_Cylinder().setRadius(value1).setHeight(value2).setFacets(int(value3)).setSteps(int(value4))); break;
    case 6: myShape = new HE_Mesh(new HEC_Icosahedron().setEdge(value1)); break;
    case 7: myShape = new HE_Mesh(new HEC_Octahedron().setEdge(value1)); break;
    case 8: myShape = new HE_Mesh(new HEC_Tetrahedron().setEdge(value1)); break;
  }
}
