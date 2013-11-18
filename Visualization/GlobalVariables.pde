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
public final int NUM_YEARS = 15;
public final int BASE_YEAR = 1999;

//*** Control P5 Stuff ***//
ControlP5 cP5;


//*** Visualization 1 Visual Elements ***//
Axis vizOne_yAxis;
Axis vizOne_xAxis;

ArrayList<YearBar> yearBars;

//*** Screen Position Variables ***//
final int SCREEN_WIDTH = 1350;
final int SCREEN_HEIGHT = 650;

final int STUDENTS_PER_PIXEL = 60; //265 px, each worth 60 students  --> for Viz 1 Y-Axis ONLY


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


int vizOne_InnerPaddingX;
int vizOne_InnerPaddingY;

int vizOne_yAxis_x1;
int vizOne_yAxis_y1;
int vizOne_yAxis_x2;
int vizOne_yAxis_y2;

int vizOne_xAxis_x1;
int vizOne_xAxis_y1;
int vizOne_xAxis_x2;
int vizOne_xAxis_y2;

int YearBar_WIDTH;
int YearBar_SPACING;
int InnerBarSpacing;
int CollegeBar_WIDTH;

//*** Color Values ***//
/*
final color COLOR_ARCHITECTURE = color(200, 0, 0), // red
            COLOR_IVANALLEN = color(0, 0, 235), // blue
            COLOR_COMPUTING = color(0, 255, 0), // green
            COLOR_SCIENCES = color(255, 0, 200), // purple
            COLOR_MANAGEMENT =  color(0, 255, 255), // cyan
            COLOR_ENGINEERING = color(255, 135, 0); // orange
*/            
final color COLOR_ARCHITECTURE = color(153, 173, 145),
            COLOR_COMPUTING =    color(63, 112, 102),
            COLOR_ENGINEERING =  color(38, 38, 41), 
            COLOR_IVANALLEN =    color(107, 70, 50),
            COLOR_MANAGEMENT =   color(194, 94, 6),
            COLOR_SCIENCES =     color(133, 126, 132);

/*
final color COLOR_ARCHITECTURE = color(77, 165, 212),                                //color(200, 0, 0), // red
            COLOR_IVANALLEN =    color(13, 136, 204),                                //color(0, 0, 235), // blue
            COLOR_COMPUTING =    color(10, 102, 153),                               //color(0, 255, 0), // green
            COLOR_SCIENCES =     color(28, 59, 76),                                //color(255, 0, 200), // purple
            COLOR_MANAGEMENT =   color(5, 51, 76),                              //color(0, 255, 255), // cyan
            COLOR_ENGINEERING =  color(3, 36, 55);                               //color(255, 135, 0); // orange  
*/
    
final color COLOR_MALE = color(102, 178, 255), // sky blue
            COLOR_FEMALE = color(255, 102, 178); // pink
    
final color COLOR_ARCHITECTURE1 = COLOR_ARCHITECTURE, 
            COLOR_ARCHITECTURE2 = color(122, 0, 0), 
            COLOR_ARCHITECTURE3 = color(199, 99, 0), 
            COLOR_ARCHITECTURE4 = color(122, 61, 0);
    
final color COLOR_IVANALLEN1 = COLOR_IVANALLEN, 
            COLOR_IVANALLEN2 = color(0, 0, 158), 
            COLOR_IVANALLEN3 = color(94, 94, 235), 
            COLOR_IVANALLEN4 = color(63, 63, 158); 
    
final color COLOR_COMPUTING1 = COLOR_COMPUTING, 
            COLOR_COMPUTING2 = color(0, 179, 0), 
            COLOR_COMPUTING3 = color(170, 255, 0), 
            COLOR_COMPUTING4 = color(119, 179, 0); 
    
final color COLOR_SCIENCES1 = COLOR_SCIENCES, 
            COLOR_SCIENCES2 = color(128, 0, 125), 
            COLOR_SCIENCES3 = color(204, 82, 161), 
            COLOR_SCIENCES4 = color(128, 51, 101); 
    
final color COLOR_MANAGEMENT1 = COLOR_MANAGEMENT,  
            COLOR_MANAGEMENT2 = color(0, 179, 179), 
            COLOR_MANAGEMENT3 = color(102, 153, 255), 
            COLOR_MANAGEMENT4 = color(0, 60, 179);
    
final color COLOR_ENGINEERING1 = COLOR_ENGINEERING,  
            COLOR_ENGINEERING2 = color(179, 95, 0), 
            COLOR_ENGINEERING3 = color(255, 200, 0), 
            COLOR_ENGINEERING4 = color(179, 140, 0);


final color YearBar_COLOR = color(243,229,190 );

//-------------------- GLOBAL VARIABLE METHODS ------------------------------//

public void initGlobals() {
  initGlobalDataAndVizElements();
  initGlobalPositions();
  initControlP5();
}

void initGlobalDataAndVizElements() {
  // Data Structures
  Years = new ArrayList<ArrayList<College>>();
  
  // Viz-Element Structures
  yearBars = new ArrayList<YearBar>();
  
}

void initControlP5() {
  cP5 = new ControlP5(this);
}


void initGlobalPositions() {
  //-- Overall Visualization --//
  totViz_X = 0;
  totViz_Y = 0;
  totViz_width = SCREEN_WIDTH - 2;
  totViz_height = SCREEN_HEIGHT - 2;
  
  
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
  
  
  vizOne_InnerPaddingX = 30; //px
  vizOne_InnerPaddingY = 30; //px
  
  vizOne_yAxis_x1 = vizOne_X + vizOne_InnerPaddingX;
  vizOne_yAxis_y1 = vizOne_Y + vizOne_InnerPaddingY;
  vizOne_yAxis_x2 = vizOne_yAxis_x1;
  vizOne_yAxis_y2 = vizOne_height - vizOne_InnerPaddingY;
  
  vizOne_xAxis_x1 = vizOne_yAxis_x2;
  vizOne_xAxis_y1 = vizOne_yAxis_y2;
  vizOne_xAxis_x2 = vizOne_width - vizOne_InnerPaddingX;
  vizOne_xAxis_y2 = vizOne_xAxis_y1;
  
  YearBar_WIDTH = 62;
  YearBar_SPACING = 20;
  InnerBarSpacing = 11; // 9 + 2
  CollegeBar_WIDTH = 40; // 36 + 4
  
}
