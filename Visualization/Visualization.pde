<<<<<<< HEAD
// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

import controlP5.*;

//*************** Global Variables *******************//
/* 2D ArrayList. Top outerlist holds 15 arraylist each representing a single year.
   innerlist holds 10 MajorEntry objects, each holding the data from 1 line (out of 10)
   from a year file (each line represents one of the top-ten majors for that year and its
   associated data). */
/* 1999 --> {1stMajorEntry_1999, 2ndMajorEntry_1999, 3rdMajorEntry_1999, 4thMajorEntry_1999, ... 10thMajorEntry_1999}
   2000 --> {1stMajorEntry_2000, 2ndMajorEntry_2000, 3rdMajorEntry_2000, 4thMajorEntry_2000, ... }
   ...
   ...
   2013 --> {1stMajorEntry_2013, 2ndMajorEntry_2013, 3rdMajorEntry_2013, 4thMajorEntry_2013, ... 10thMajorEntry_2013} */
ArrayList<ArrayList<College>> Years;
final int NumYears = 15;
ControlP5 cP5;
//*************** Global Variables *******************//

final int COLOR_ARCHITECTURE = color(200, 0, 0), // red
    COLOR_IVANALLEN = color(0, 0, 235), // blue
    COLOR_COMPUTING = color(0, 255, 0), // green
    COLOR_SCIENCES = color(255, 0, 200), // purple
    COLOR_MANAGEMENT = color(0, 255, 255), // cyan
    COLOR_ENGINEERING = color(255, 135, 0), // orange
    
    COLOR_MALE = color(102, 178, 255), // sky blue
    COLOR_FEMALE = color(255, 102, 178), // pink
    
    COLOR_ARCHITECTURE1 = COLOR_ARCHITECTURE, 
    COLOR_ARCHITECTURE2 = color(122, 0, 0), 
    COLOR_ARCHITECTURE3 = color(199, 99, 0), 
    COLOR_ARCHITECTURE4 = color(122, 61, 0), 
    
    COLOR_IVANALLEN1 = COLOR_IVANALLEN, 
    COLOR_IVANALLEN2 = color(0, 0, 158), 
    COLOR_IVANALLEN3 = color(94, 94, 235), 
    COLOR_IVANALLEN4 = color(63, 63, 158), 
    
    COLOR_COMPUTING1 = COLOR_COMPUTING, 
    COLOR_COMPUTING2 = color(0, 179, 0), 
    COLOR_COMPUTING3 = color(170, 255, 0), 
    COLOR_COMPUTING4 = color(119, 179, 0), 
    
    COLOR_SCIENCES1 = COLOR_SCIENCES, 
    COLOR_SCIENCES2 = color(128, 0, 125), 
    COLOR_SCIENCES3 = color(204, 82, 161), 
    COLOR_SCIENCES4 = color(128, 51, 101), 
    
    COLOR_MANAGEMENT1 = COLOR_MANAGEMENT,  
    COLOR_MANAGEMENT2 = color(0, 179, 179), 
    COLOR_MANAGEMENT3 = color(102, 153, 255), 
    COLOR_MANAGEMENT4 = color(0, 60, 179), 
    
    COLOR_ENGINEERING1 = COLOR_ENGINEERING,  
    COLOR_ENGINEERING2 = color(179, 95, 0), 
    COLOR_ENGINEERING3 = color(255, 200, 0), 
    COLOR_ENGINEERING4 = color(179, 140, 0);

=======
>>>>>>> Reorganization Update
////////////// Init Methods //////////////////

public void setup() {
  initGlobals();
  loadData();
  test_Data();
<<<<<<< HEAD
  
  size(1180, 580);
  frameRate(30);
  
  cP5 = new ControlP5(this);
}

void initGlobals() {
  Years = new ArrayList<ArrayList<College>>();
}



///////////////// Processing Drawing /////////////////////
void draw() {
  
=======
  initScreen();
>>>>>>> Reorganization Update
}


public void initScreen() {
  size(1350, 650);
}



///////////////// Processing Drawing /////////////////////
public void draw() {
  
}









