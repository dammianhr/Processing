/*
a compilation and updating of sketches found on the web

source:
https://www.duration.cc
https://github.com/YCAMInterlab/Duration

https://forum.processing.org/topic/duration-timeline-osc

https://github.com/dammianhr/Duration_ProcessingListener

thanks for sharing!
-------------------*/



import oscP5.*;
import netP5.*;

OscP5 oscP5;

//what we want to control with duration
float oneCurve, location, curveMin, curveMax;
float sixLfo;
int twoSwitch;
int threeColR, threeColG, threeColB;
boolean fourBang, bangOn;
int bangCounter;
String fiveFlag;


float[] audio = new float[0];

int [] locations = new int [7];

void setup() {
  oscP5 = new OscP5(this, 12345);
  size (400, 700);
  smooth();

  for (int i = 0; i < 7; i++) {
    locations[i] = i*height/7;
  }
}

void draw() {
  background (0);
  textSize (13);
  textAlign (CORNER);
  stroke (255);

  for (int i = 0; i < locations.length; i++) {
    line (0, locations[i], width, locations[i]);
  }

  int middle = height/locations.length/2;

  //curve controls the location of the ball
  text ("Speed from Curve is: " + oneCurve, 10, 30+locations[0]);
  text ("Values are from: " + curveMin + " to: " + curveMax, 10, 30+locations[0] + 20 );
  ellipse (int(location + oneCurve * width), locations[0] + middle, 40, 40);
  location = constrain (location, 0, width);

  //switch toggles circle or square
  text ("Enable/Disable from switch is: " + twoSwitch, 10, 30+locations[1]);
  rectMode (CENTER);
  if (twoSwitch == 1) ellipse (width/2, locations[1] + middle, 50, 50);
  if (twoSwitch == 0) rect (width/2, locations[1] + middle, 40, 40);

  //colors change the fill
  text ("RGB from Color is: " + threeColR + ", " + threeColG + ", " + threeColB, 10, 30+locations[2]);
  fill (threeColR, threeColG, threeColB);
  noStroke();
  ellipse (width/2, locations[2] + middle, 40, 40);
  fill (255);

  //bang writes the word, "bang!", holds for a second
  text ("Bang from bang is: " + fourBang, 10, 30+locations[3]);
  textSize (25);
  textAlign (CENTER);
  if (fourBang) bangOn = true;
  if (bangOn) {
    text ("BANG!", width/2, locations[3] + middle + 10);
    bangCounter ++;
    if (bangCounter >50) {
      bangOn = false;
      bangCounter = 0;
    }
  }
  textSize (13);
  textAlign (CORNER);

  //flag writes whatever word is on the flag
  text ("Word from flag is: " + fiveFlag, 10, 30+locations[4]);
  textSize (25);
  textAlign (CENTER);
  if (fiveFlag !=null) text (fiveFlag, width/2, locations[4] + middle + 10);
  
  //LFO curve
  textSize (13);
  textAlign (CORNER);
  stroke (255);
  text ("ferncuency of LFO is: " + sixLfo, 10, 30+locations[5]);
  text ("Values are from: " + curveMin + " to: " + curveMax, 10, 30+locations[5] + 20 );
  ellipse (int(location + sixLfo * width), locations[5] + middle, 40, 40);
  location = constrain (location, 5, width);
  
  //AUDIO
  stroke(255); 
  text ("Audio FFT analisis: ", 10, 30+locations[6]);
  translate(30, 100+locations[6]);
 
  for (float f:audio) {
    translate(2, 0);
    line(0, 0, 0, -f * 100);
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals ("/duration/info")) {
    println (" -Duration has started! ----------");
    theOscMessage.print();
  }

  if (theOscMessage.addrPattern().equals ("/duration/info") && theOscMessage.get(1).stringValue().equals("/curves")) {
    curveMin = theOscMessage.get(2).floatValue();
    curveMin = theOscMessage.get(3).floatValue();
  }
  
    if (theOscMessage.addrPattern().equals ("/curves")) {
    oneCurve = theOscMessage.get(0).floatValue();
    
    println(oneCurve);
  }

  if (theOscMessage.addrPattern().equals ("/switches")) {
    twoSwitch = theOscMessage.get(0).intValue();
  }

  if (theOscMessage.addrPattern().equals ("/colors")) {
    threeColR = theOscMessage.get(0).intValue();
    threeColG = theOscMessage.get(1).intValue();
    threeColB = theOscMessage.get(2).intValue();
  }

  if (theOscMessage.addrPattern().equals ("/bangs")) { //you can change the track name from Duration and edit it here
    fourBang = true;
  }
  else {
    fourBang = false;
  }

  if (theOscMessage.addrPattern().equals ("/flags")) {
    fiveFlag = theOscMessage.get(0).stringValue();
  }
  
    if (theOscMessage.addrPattern().equals ("/lfo")) {
    sixLfo = theOscMessage.get(0).floatValue();
  }
   //AUDIO react
   if ( theOscMessage.addrPattern( ).equals( "/audio" ) ) {
    audio = new float[ theOscMessage.typetag().length() ];
    for (int i = 0 ; i < theOscMessage.typetag( ).length( ); i++) {
      audio[ i ] = theOscMessage.get( i ).floatValue( );
    }
    normalize( audio ); // map the highest value of array audio to 1, match others accordingly
  }
}


void normalize(float[] src) {
  float high = 0;
  for ( float f:src ) { 
    if ( f > high ) {
      high = f;
    }
  }
  for (int i = 0 ; i< src.length; i++) {
    src[i] = map(src[i], 0, high, 0, 1);
  }

  //uncomment if you want to print out all the messages
  //println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  //theOscMessage.print();
}


