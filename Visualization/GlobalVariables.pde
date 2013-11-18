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
//*************** Global Variables *******************//

//*** Data Variables ***//
public ArrayList<ArrayList<College>> Years;
public ArrayList<TotalBar> totalBarList;

public final int NumYears = 15;


//*** Control P5 Stuff ***//
ControlP5 cP5;

final int WHITE = 255 , BLACK = 0, GREY = 153;

//*** Screen Position Variables ***//
final int SCREEN_WIDTH = 1350;
final int SCREEN_HEIGHT = 650;

final int GRID_1_THICKNESS = 5; //line thicknessS
final int GRID_1_VERT_HEIGHT = 325;
final int GRID_1_HOR_WIDTH = 750;
final int GRID_1_VERT_X = 100;
final int GRID_1_VERT_Y = 50;
final int GRID_1_HOR_X = GRID_1_VERT_X + GRID_1_THICKNESS;
final int GRID_1_HOR_Y = GRID_1_VERT_Y + GRID_1_VERT_HEIGHT - GRID_1_THICKNESS;
final int GRID_COLOR = GREY;

final int TOTAL_BAR_COLOR = color(147, 197, 114);
final int BAR_OFFSET = 25;
final int COLLEGE_BAR_THICKNESS = 25;

final float ALPHA_VAL = 0.999;
final int NORMALIZE_TO = 300;

int totViz_X;
int totViz_Y;
int totViz_width;
int totViz_height;


int vizOne_X;
int vizOne_Y;
int vizOne_width;
int vizOne_height;


int vizTwo_X;
int vizTwo_Y;
int vizTwo_width;
int vizTwo_height;


//*** Color Values ***//
final int COLOR_ARCHITECTURE = color(200, 0, 0), // red
          COLOR_IVANALLEN = color(0, 0, 235), // blue
          COLOR_COMPUTING = color(0, 255, 0), // green
          COLOR_SCIENCES = color(255, 0, 200), // purple
          COLOR_MANAGEMENT = color(0, 255, 255), // cyan
          COLOR_ENGINEERING = color(255, 135, 0); // orange
  
    
final int COLOR_MALE = color(102, 178, 255), // sky blue
          COLOR_FEMALE = color(255, 102, 178); // pink
    
final int COLOR_ARCHITECTURE1 = COLOR_ARCHITECTURE, 
          COLOR_ARCHITECTURE2 = color(122, 0, 0), 
          COLOR_ARCHITECTURE3 = color(199, 99, 0), 
          COLOR_ARCHITECTURE4 = color(122, 61, 0);
    
final int COLOR_IVANALLEN1 = COLOR_IVANALLEN, 
          COLOR_IVANALLEN2 = color(0, 0, 158), 
          COLOR_IVANALLEN3 = color(94, 94, 235), 
          COLOR_IVANALLEN4 = color(63, 63, 158); 
    
final int COLOR_COMPUTING1 = COLOR_COMPUTING, 
          COLOR_COMPUTING2 = color(0, 179, 0), 
          COLOR_COMPUTING3 = color(170, 255, 0), 
          COLOR_COMPUTING4 = color(119, 179, 0); 
    
final int COLOR_SCIENCES1 = COLOR_SCIENCES, 
          COLOR_SCIENCES2 = color(128, 0, 125), 
          COLOR_SCIENCES3 = color(204, 82, 161), 
          COLOR_SCIENCES4 = color(128, 51, 101); 
    
final int COLOR_MANAGEMENT1 = COLOR_MANAGEMENT,  
          COLOR_MANAGEMENT2 = color(0, 179, 179), 
          COLOR_MANAGEMENT3 = color(102, 153, 255), 
          COLOR_MANAGEMENT4 = color(0, 60, 179);
    
final int COLOR_ENGINEERING1 = COLOR_ENGINEERING,  
          COLOR_ENGINEERING2 = color(179, 95, 0), 
          COLOR_ENGINEERING3 = color(255, 200, 0), 
          COLOR_ENGINEERING4 = color(179, 140, 0);


//-------------------- GLOBAL VARIABLE METHODS ------------------------------//

public void initGlobals() {
  initGlobalData();
  initGlobalPositions();
  initControlP5();
}

void initGlobalData() {
  Years = new ArrayList<ArrayList<College>>();
  totalBarList = new ArrayList<TotalBar>();
}

void initControlP5() {
  cP5 = new ControlP5(this);
}

void initGlobalPositions() {
  //-- Overall Visualization --//
  totViz_X = 0;
  totViz_Y = 0;
  totViz_width = SCREEN_WIDTH;
  totViz_height = SCREEN_HEIGHT;
  
  
  //-- 1st Viz --//
  vizOne_X = totViz_X;
  vizOne_Y = totViz_Y;
  vizOne_width = totViz_width;
  vizOne_height = totViz_height / 2;
  
  
  //-- 2nd Viz --//
  vizTwo_X = totViz_X;
  vizTwo_Y = totViz_Y + vizOne_height;
  vizTwo_width = totViz_width;
  vizTwo_height = totViz_height / 2;
  
}
