import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;
DropdownList shapeList;
ControlFrame cf;

void gui(){
  cp5 = new ControlP5(this);
  //cp5.setAutoDraw(true);
  
   cf = addControlFrame("Control GUI", 440,150);
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addToggle("face On").plugTo(parent,"faceOn").setPosition(10,10).setSize(20,20).setValue(true);
    cp5.addToggle("edge On").plugTo(parent,"edgeOn").setPosition(50,10).setSize(20,20).setValue(false);
    cp5.addSlider("Edge Weight").plugTo(parent,"edgeWeight").setPosition(10,50).setWidth(70).setRange(1,10).setValue(1).setNumberOfTickMarks(10).setSliderMode(Slider.FLEXIBLE);
    cp5.addSlider("zoom").plugTo(parent,"zoom").setPosition(10,70).setWidth(70).setRange(1,50).setValue(20);
    cp5.addSlider("transparency").plugTo(parent,"transparency").setPosition(10,90).setWidth(70).setRange(0,255).setValue(255);
    
    cp5.addSlider("create0").plugTo(parent,"create0").setPosition(150,10).setWidth(120).setRange(1,40).setValue(4).setNumberOfTickMarks(40).setSliderMode(Slider.FLEXIBLE);
    cp5.addSlider("create1").plugTo(parent,"create1").setPosition(150,40).setWidth(120).setRange(1,40).setValue(4).setNumberOfTickMarks(40).setSliderMode(Slider.FLEXIBLE);
    cp5.addSlider("create2").plugTo(parent,"create2").setPosition(150,70).setWidth(120).setRange(1,40).setValue(4).setNumberOfTickMarks(40).setSliderMode(Slider.FLEXIBLE);
    cp5.addSlider("create3").plugTo(parent,"create3").setPosition(150,100).setWidth(120).setRange(1,40).setValue(4).setNumberOfTickMarks(40).setSliderMode(Slider.FLEXIBLE);
    
     // ShapeList
    shapeList = cp5.addDropdownList("myShapeList");
    shapeList.setPosition(320, 30);
    shapeList.setBarHeight(20);
    shapeList.setItemHeight(15);
    shapeList.captionLabel().set("Select Shape");
    shapeList.captionLabel().style().marginTop = 6;
    shapeList.captionLabel().style().marginLeft = 3;
      for(int i=0; i<10; i++) {
    if (numToName(i) != "None") { shapeList.addItem(numToName(i),i); }}
  }
  
  void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    creator = int(theEvent.getGroup().getValue());
    createHemesh();
  } 
}

  
  private ControlFrame() {
  }
  
  public void draw() {
    background(0);
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;

  Object parent;
}


