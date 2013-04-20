import controlP5.*;
ControlP5 cp5;

Toggle[] togg;

void gui(){
  cp5 = new ControlP5(this);
  togg = new Toggle[peaksize];
  
   for(int i = 0; i < peaksize; ++i) {
     togg[i] = cp5.addToggle(" "+i).setPosition(legend_width+3+binsperband*i,spectrum_height+legend_height).setSize(15,15).setValue(false);
   }
}
