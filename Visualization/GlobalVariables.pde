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
public final int NumYears = 15;


//*** Screen Position Variables ***//
final int SCREEN_WIDTH = 1350;
final int SCREEN_HEIGHT = 650;

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


//-------------------- GLOBAL VARIABLE METHODS ------------------------------//

public void initGlobals() {
  initGlobalData();
  initGlobalPositions();
}

void initGlobalData() {
  Years = new ArrayList<ArrayList<College>>();
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
