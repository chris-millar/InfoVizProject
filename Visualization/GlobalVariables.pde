//*************** Global Variables *******************//
/* 2D ArrayList. Top outerlist holds 15 arraylist each representing a single year.
   innerlist holds 6 College objects */
/* 1999 --> {College_Architecture_1999, College_Computing_1999, College_Engineering_1999, College_IvanAllen_1999, ... College_Science_1999}
   2000 --> {College_Architecture_2000, College_Computing_2000, College_Engineering_2000, College_IvanAllen_2000, ... }
   ...
   ...
   2013 --> {College_Architecture_2013, College_Computing_2013, College_Engineering_2013, College_IvanAllen_2013, ... College_Science_2013} */
//*************** Global Variables *******************//

boolean firstDraw = true;
public int rX, rY;


//*** Data Variables ***//
public ArrayList<ArrayList<College>> Years;
public final int NUM_YEARS = 15;
public final int BASE_YEAR = 1999;


//*** Control P5 Stuff ***//
ControlP5 cp5;
RadioButton selCollege, college;


//*** Fonts ***//
PFont calibri;
PFont Aharoni_Bold;
PFont avenir;
PFont hel;


//*** Event & Interaction Tracers ***//
public int CurrSelectedYear;
public boolean Event_SelectedYearChange;

public String CurrSelectedCollege;
public boolean Event_SelectedCollegeChange;

public int CurrVizTwoDisplayMode;   // Determines VizTwo Display Mode {0 = Top3Majors, 1 = Gender, 2 = Ethnicity}
public boolean Event_VizTwoDisplayModeChange;

public int colToDraw;
public boolean Event_VizOneCollegeToDrawChange;


//*** Visualization 1 Visual Elements ***//
Axis vizOne_yAxis;
Axis vizOne_xAxis;

Legend legend;

ArrayList<YearBar> yearBars;


//*** Screen Position Variables ***//
final int SCREEN_WIDTH = 1350;
final int SCREEN_HEIGHT = 650;

final int STUDENTS_PER_PIXEL = 60; //265 px, each worth 60 students  --> for Viz 1 Y-Axis ONLY

final int POPUP_EDGE_PADDING = 7;
final int POPUP_VERTICAL_SPACING = 10;

final int ROUNDED_CORNER_VALUE = 10;

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
int vizOne_LegendPadding;

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
int YearBarLabelBar_HEIGHT;
int YearBarLabel_WIDTH;
int YearBarLabel_HEIGHT;
int InnerBarSpacing;
int CollegeBar_WIDTH;

int label_xPading;
int label_yPading;


//*** Color Values ***//          
final color COLOR_ARCHITECTURE = color(219,125,51), // 
            COLOR_COMPUTING = color(53,125,174), //
            COLOR_ENGINEERING = color(122,40,32),
            COLOR_IVANALLEN = color(93,71,118), //
            COLOR_MANAGEMENT =  color(113,137,63),
            COLOR_SCIENCES = color(57,94,139),
            COLOR_ALL_COLLEGES = color(255);
    
final color COLOR_MALE = color(92,119,180), // sky blue
            COLOR_FEMALE = color(214,101,145); // pink
    
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

final color Color_AXIS = color(209);

final color COLOR_YearBar_Unselected = color(250); //#F3E5BE
final color COLOR_YearBar_HoveredOn = color(231, 221, 142);  //E7DD8E
final color COLOR_YearBar_ClickSelected = color(153, 121, 35);  //997923
final color COLOR_YearBarLabel = color(158, 115, 62);

final color COLOR_PopupBubble = color(0); //209  //255,196,64
final color COLOR_DoDText = color(230);

final color COLOR_LegendBackground = color(210); //color(209);
final color COLOR_LegendText = color(10);



//-------------------- GLOBAL VARIABLE METHODS ------------------------------//

public void initGlobals() {
  initGlobalDataAndVizElements();
  initGlobalPositions();
  initControlP5();
  initEventInteractionTracers_defautValues();
  initFonts();
}

void initGlobalDataAndVizElements() {
  // Data Structures
  Years = new ArrayList<ArrayList<College>>();
  
  // Viz-Element Structures
  yearBars = new ArrayList<YearBar>();
  
}

void initFonts() {
  calibri = loadFont("Calibri-12.vlw");
  Aharoni_Bold = loadFont("Aharoni-Bold-12.vlw"); 
  avenir = loadFont("Avenir-Light-32.vlw");
  hel = loadFont("Helvetica-Light-40.vlw");
}

void initControlP5() {
  cp5 = new ControlP5(this);
}

void initEventInteractionTracers_defautValues() {
  CurrSelectedYear = BASE_YEAR;
  Event_SelectedYearChange = false;
 
  CurrVizTwoDisplayMode = 0;
  Event_VizTwoDisplayModeChange = false;
  
  CurrSelectedCollege = null;
  Event_VizTwoDisplayModeChange = false;

  colToDraw = 6;
  Event_VizOneCollegeToDrawChange = false;
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
  vizOne_height = int(totViz_height / 2.3);
  
  
  //-- 2nd Viz --//
  vizTwo_X = totViz_X;
  vizTwo_Y = totViz_Y + vizOne_height;
  vizTwo_width = totViz_width;
  vizTwo_height = totViz_height / 2;
  
  vizOne_InnerPaddingX = 45; //px
  vizOne_InnerPaddingY = 30; //px
  vizOne_LegendPadding = vizOne_InnerPaddingX - 15;
  
  vizOne_yAxis_x1 = vizOne_X + vizOne_InnerPaddingX;
  vizOne_yAxis_y1 = vizOne_Y + vizOne_InnerPaddingY;
  vizOne_yAxis_x2 = vizOne_yAxis_x1;
  vizOne_yAxis_y2 = vizOne_height - vizOne_InnerPaddingY;
  
  YearBar_SPACING = 20;
  InnerBarSpacing = 7; // 9 + 2
  CollegeBar_WIDTH = 40; // 36 + 4 = 40
  YearBar_WIDTH = (2 * InnerBarSpacing) + CollegeBar_WIDTH;
  YearBarLabelBar_HEIGHT = 3 * InnerBarSpacing;
  YearBarLabel_WIDTH = CollegeBar_WIDTH;
  YearBarLabel_HEIGHT = YearBarLabelBar_HEIGHT;
  
  label_xPading = 3;
  label_yPading = 3;
  
  vizOne_xAxis_x1 = vizOne_yAxis_x2;
  vizOne_xAxis_y1 = vizOne_yAxis_y2;
  vizOne_xAxis_x2 = vizOne_xAxis_x1 + ((1 + NUM_YEARS) * YearBar_SPACING) + (NUM_YEARS * YearBar_WIDTH); //vizOne_width - vizOne_InnerPaddingX;
  vizOne_xAxis_y2 = vizOne_xAxis_y1;
}
