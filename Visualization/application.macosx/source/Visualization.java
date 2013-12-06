import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import processing.opengl.*; 
import processing.data.*; 
import processing.event.*; 
import controlP5.*; 
import processing.core.*; 
import japplemenubar.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Visualization extends PApplet {



// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

////////////// Init Methods //////////////////

public void setup() {
  
  selected = loadImage("selected.png");
  unselected = loadImage("unselected.png");

  if (frame != null) {
    frame.setResizable(true);
  }
  
  initGlobals();
  loadData();
  initScreen();
  
  background(255);
  
  buildVisualizationOne();
  setInitialEventTracerValuesInsideVisualObjects();
}

public void initScreen() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

public void setInitialEventTracerValuesInsideVisualObjects() {
  yearBars.get(0).setClickSelected(true);  // tells the 1999 YearBar that it is currently selected, at viz startup
 
  Event_SelectedYearChange = true;
}

///////////////// Processing Drawing /////////////////////
public void mouseClicked() {
  vizOneCheckMouseClicked();  
}


public void draw() {
  background(255);
  
  if (Event_VizOneCollegeToDrawChange) {
    buildVisualizationOne();
    Event_VizOneCollegeToDrawChange = false;  
  }
  
  if (Event_SelectedYearChange) {
    buildVisualizationTwo();
    Event_SelectedYearChange = false;
    
    if (Event_VizTwoDisplayModeChange) {
      Event_VizTwoDisplayModeChange = false;
    }
  }
  
  if (Event_VizTwoDisplayModeChange) {
    buildVisualizationTwo();
   
    Event_VizTwoDisplayModeChange = false; 
  }
  
  checkVisualizationOne();
  drawVisualizationOne();
  
  checkVisualizationTwo();
  drawVisualizationTwo();
  
  for(ArrayList<barChartBar> bars : collegeBars){
    for (int i=0; i<bars.size() && !bars.get(i).render(); i++);
  }
  
}
















public class Axis {
  int VizBelongsTo;
  String Name;
  
  int x1;
  int y1;
  int x2;
  int y2; 
  
  int Color;
  
  int weight;
  
  final int labelPad = 2;
  
  
  public Axis(int belongsTo, String Name, int x1, int y1, int x2, int y2, int Color) {
    this.VizBelongsTo = belongsTo;
    this.Name = Name; 
    
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    
    this.Color = Color;
    
    weight = 3;
  }
  
  public int getHeight() {
    return (y2 - y1);
  }
  
  public int getWidth() {
    return (x2 - x1);
  }
  
  public void draw() {
    stroke(Color);
    strokeWeight(weight);
    line(x1, y1, x2, y2);
    
    strokeWeight(1);
  }
  
  public void drawLabel(String[] label) {
    int labelTextSize = 11;
    
    fill(155);
    textSize(labelTextSize);
    textAlign(CENTER, BOTTOM);
    
    if (label.length == 1) {
       text(label[0], x1, y1 - labelPad);
    }
    else if (label.length >= 2) {
      text(label[0], x1, y1 - labelPad - labelTextSize - labelPad);
      text(label[1], x1, y1 - labelPad);
    }
  
    textSize(12);  
  }
  
  public void setWeight(int w){
    weight = w;
  }
  
  public void setColor(int Color){
    this.Color = Color;
  }
  
  
}
public class CollegeBar 
{
  private String Name;
  private int Year;
  
  private int TotalCollege;
  private int TotalUniversity;
  private int percentSize;
  private int halfBarWidth;
  private int textPlacement;
  
  private int xPos, yPos;
  private int bar_width, bar_height;
  
  private ArrayList<Major> top3Majors;
  private int White, Black, Hispanic, Asian;
  private int Male, Female;
  
  private int barColor_Unselected;
  private int barColor_HoveredOn;
  
  private boolean hoveredOn;
  
  private PopupBubble popup;
  
  private final int opacity_HoveredOn = 255;
  private final int opacity_Unselected = 170;
  private int n;
  
  public CollegeBar()
  {
    super();
  }
  
  //parameters can be changed based on needs later
  public CollegeBar(String name, int xPos, int yPos, int theWidth, int theHeight)
  {
    this.Name = name;
    this.xPos = xPos;
    this.yPos = yPos;
    this.bar_width = theWidth;
    this.bar_height = theHeight;
    
    this.hoveredOn = false;
    
    halfBarWidth = round(bar_width/2.0f);
    textPlacement = xPos + halfBarWidth;
    
    n = 0;
  }
  
  
  //this is college constructor that should be used
  public CollegeBar(String name, ArrayList<Major> top3Majors, 
                 int Male, int Female, 
                 int White, int Black, int Hispanic, int Asian, 
                 int TotalCollege) 
  {
    this.Name = name;
    this.top3Majors = top3Majors;
    this.Male = Male;
    this.Female = Female;
    this.White = White;
    this.Black = Black;
    this.Hispanic = Hispanic;
    this.Asian = Asian;
    this.TotalCollege = TotalCollege;
  }
  
  /*
  * Method that checks whether or not the chunk is hovered over
  * @param mouseX, mouseY - the cursor's value
  * @return - true if the cursor collides with the chunk, else false
  */
  public void isHoveredOver()
  {
    if ( ((mouseX > xPos) && (mouseX < (xPos + bar_width)) ) && ((mouseY > yPos) && (mouseY < (yPos + bar_height))) ) {
      hoveredOn = true;
      CurrSelectedCollege = Name;
    }
    else {
      if (hoveredOn == true && CurrSelectedCollege != null && CurrSelectedCollege.equals(Name)) {
        //CurrSelectedCollege = null; 
      }
      hoveredOn = false;
    }

  }
  
  
  /*
  * Method that draws the rectangle; hard egdes for now
  */
  public void draw()
  {
    if (hoveredOn) {
      fill(barColor_HoveredOn, opacity_HoveredOn);
      stroke(255);
      rect(xPos, yPos, bar_width, bar_height);
    }
    else {
        fill(barColor_Unselected, opacity_Unselected);
        stroke(255);
        strokeWeight(1.2f);
        rect(xPos, yPos, bar_width, bar_height);
    }
    
    if(colToDraw != 6){
      String collegeNum = Integer.toString(TotalCollege);
      textAlign(CENTER);
      text(collegeNum, textPlacement, yPos-5);
    }
  }
  
  private void buildPopupBubble() {
    String[] content = new String[12];
    content[0] = "College of";
    content[1] = Name;
    content[2] = "--";
    content[3] = "";
    content[4] = "College Enrollment";
    content[5] = new Integer(TotalCollege).toString();
    content[6] = "";
    content[7] = "-";
    content[8] = "";
    content[9] = "Percent of";
    content[10] = "University Enrollment";
    content[11] = new Integer(percentSize).toString() + " %";
    
    
    float[] contentSize = new float[12];
    contentSize[0] = textWidth(content[0]);
    contentSize[1] = textWidth(content[1]);
    
    contentSize[2] = 0; //maxSize - 2;
    
    contentSize[3] = 0;
    contentSize[4] = textWidth(content[4]);
    contentSize[5] = textWidth(content[5]);
    contentSize[6] = 0;
    
    contentSize[7] = 0; //maxSize - 2;
    
    contentSize[8] = 0;
    contentSize[9] = textWidth(content[9]);
    contentSize[10] = textWidth(content[10]);
    contentSize[11] = textWidth(content[11]);
    
    float maxSize = 1;
    for (int i=0; i < 12; i++) {
       float currSize = contentSize[i];
       if (currSize > maxSize) {
         maxSize = currSize; 
       }
    }
    
    contentSize[2] = maxSize - 2;
    contentSize[7] = maxSize - 2;
    
    ///////////////////////////////////////////
    
    int bubWidth = ceil(maxSize) + 2 * POPUP_EDGE_PADDING;
    int bubHeight = content.length * POPUP_VERTICAL_SPACING + 2 * POPUP_EDGE_PADDING;
    
    popup = new PopupBubble(0, 0, mouseX, mouseY, bubWidth, bubHeight, COLOR_PopupBubble);
    popup.setContent(content);
  }
  
  public void drawDetailsOnDemandIfNeeded() {
    if (hoveredOn) {
      buildPopupBubble();
      popup.draw(1);
    }  
  }
  
  public void setCollegeEnrollment(int enrollment) {
     this.TotalCollege = enrollment;
  }
  
  public void setUniversityEnrollment(int enrollment) {
    this.TotalUniversity = enrollment;
    this.percentSize = round(((float)TotalCollege / TotalUniversity) * 100);
  }
  
  /*
  * Setters
  */
  public void setName(String name)
  {
    this.Name = name;
  }
  
  public void setYear(int year)
  {
    this.Year = year;
  }
  
  public void setColor(int r, int g, int b)
  {
    barColor_Unselected = color(r, g, b);
  }
  
  public void setColor_Unselected(int Color) {
     barColor_Unselected = Color;
     barColor_HoveredOn = Color;
  }
  
  public void setPercentSize(int percentSize)
  {
    this.percentSize = percentSize;
  }
  
  public void setXpos(int xPos)
  {
    this.xPos = xPos;
  }
  
  public void setYpos(int yPos)
  {
    this.yPos = yPos;
  }
  
  public void setHeight(int theHeight)
  {
    this.bar_height = theHeight; 
  }
  
  public void setWidth(int theWidth)
  {
    this.bar_width = theWidth; 
  }
  
  public void setTop3Majors(ArrayList<Major> list)
  {
    if(list.size() > 3 || list.isEmpty())
      return;
    for(int x=0; x<3; x++)
    {
      list.remove(x);
      top3Majors.add(list.get(x));
    }
  }
  
  public void setWhite(int white)
  {
   this.White = white;
  } 
  
  public void setBlack(int black)
  {
   this.Black = black;
  }
  
  public void setAsian(int asian)
  {
   this.Asian = asian;
  }
  
  public void setHispanic(int hisp)
  {
   this.Hispanic = hisp;
  }
  
  public void setTotalMale(int totalMale)
  {
    this.Male = totalMale;
  }
  
  public void setTotalFemale(int totalFemale)
  {
    this.Female = totalFemale;
  }
  
  /*
  * Getters
  */
  public String getName()
  {
    return Name;
  }
  
  public int getYear()
  {
    return Year;
  }
  
  public int getPercentSize()
  {
    return percentSize;
  }
  
  public int getXpos()
  {
    return xPos;
  }
  
  public int getYpos()
  {
    return yPos;
  }
  
  public int getHeight()
  {
    return bar_height; 
  }
  
  public int getWidth()
  {
    return bar_width; 
  }
  
  public ArrayList getTop3Majors()
  {
    return top3Majors;
  }
  
  public int getWhite()
  {
    return White;
  }
  
  public int getBlack()
  {
    return Black;
  }
  
  public int getAsian()
  {
    return Asian;
  }
  
  public int getHispanic()
  {
    return Hispanic;
  }
  
  public int getMale()
  {
    return Male;
  }
  
  public int getFemale()
  {
    return Female;
  }
  
  public int getTotalCollege()
  {
    return TotalCollege;
  }
}
////////////////// Data Manipulation ///////////////////

public void loadData() {
  int iYear = 1999;
  for (int i=0; i < NUM_YEARS; i++) {
    String[] lines = loadStrings("data/" + iYear + ".csv"); //splits the ith year file into its 11 lines (as String arrays)
    
    ArrayList<College> collegesInYear = new ArrayList<College>(); //holds the top ten major-entries in the ith year
    for (int j=1; j < lines.length; j++) {
      String[] lineVals = split(lines[j], ',');  //splits apart the jth line (1-10, major data entry)
      
      ArrayList<Major> top3Majors = new ArrayList<Major>();
      
      Major FirstMajor = new Major(lineVals[1], Integer.parseInt(lineVals[2]));
      top3Majors.add(FirstMajor);
      
      Major SecondMajor;
      if (!lineVals[3].equals("null")) {
        SecondMajor = new Major(lineVals[3], Integer.parseInt(lineVals[4]));
      }
      else {
        SecondMajor = null; 
      }
      top3Majors.add(SecondMajor);
      
      
      Major ThirdMajor;
      if (!lineVals[5].equals("null")) {
        ThirdMajor = new Major(lineVals[5], Integer.parseInt(lineVals[6]));
      }
      else {
        ThirdMajor = null; 
      }
      top3Majors.add(ThirdMajor);
      
      
      
      College entry = new College(lineVals[0], top3Majors,
                                        Integer.parseInt(lineVals[7]), Integer.parseInt(lineVals[8]), 
                                        Integer.parseInt(lineVals[9]), Integer.parseInt(lineVals[10]), Integer.parseInt(lineVals[11]),Integer.parseInt(lineVals[12]), 
                                        Integer.parseInt(lineVals[13]));
      collegesInYear.add(entry);
    }
    
    Years.add(collegesInYear);
    iYear++;
  }
  
  
}
public class College {
  private String Name;
  
  private ArrayList<Major> top3Majors;
  
  private int Male;
  private int Female;
  
  private int White;
  private int Black;
  private int Hispanic;
  private int Asian;
  
  private int TotalCollege;
  
  public College(String name, ArrayList<Major> top3Majors, 
                    int Male, int Female, 
                    int White, int Black, int Hispanic, int Asian, 
                    int TotalCollege) {
    this.Name = name;
    
    this.top3Majors = top3Majors;
    
    this.Male = Male;
    this.Female = Female;
    
    this.White = White;
    this.Black = Black;
    this.Hispanic = Hispanic;
    this.Asian = Asian;
    
    this.TotalCollege = TotalCollege;
  }
  
  public String getName()
  {
    return Name;
  }
  
  public ArrayList getTop3Majors()
  {
    return top3Majors;
  }
  
  public int getWhite()
  {
    return White;
  }
  
  public int getBlack()
  {
    return Black;
  }
  
  public int getAsian()
  {
    return Asian;
  }
  
  public int getHispanic()
  {
    return Hispanic;
  }
  
  public int getMale()
  {
    return Male;
  }
  
  public int getFemale()
  {
    return Female;
  }
  
  public int getTotalCollege()
  {
    return TotalCollege;
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////

public class Major 
{
 private String NameMajor;
 private int Enrollment;

 public Major(String name, int enrollment) 
 {
   this.NameMajor = name;
   this.Enrollment = enrollment;
 } 
 
 public String getName() {
   return NameMajor;
 }
 
 public int getEnrollment() {
    return Enrollment; 
 }
}
//*************** Global Variables *******************//
/* 2D ArrayList. Top outerlist holds 15 arraylist each representing a single year.
   innerlist holds 6 College objects */
/* 1999 --> {College_Architecture_1999, College_Computing_1999, College_Engineering_1999, College_IvanAllen_1999, ... College_Science_1999}
   2000 --> {College_Architecture_2000, College_Computing_2000, College_Engineering_2000, College_IvanAllen_2000, ... }
   ...
   ...
   2013 --> {College_Architecture_2013, College_Computing_2013, College_Engineering_2013, College_IvanAllen_2013, ... College_Science_2013} */
//*************** Global Variables *******************//

PopupBubble dir1, dir2, dir3;


boolean firstDraw = true;
//public int rX, rY;


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

int vizTwo_Menu_X;
int vizTwo_Menu_Y;
int vizTwo_Menu_WIDTH;
int vizTwo_Menu_HEIGHT;


//*** Color Values ***//          
final int COLOR_ARCHITECTURE = color(219,125,51), // 
            COLOR_COMPUTING = color(53,125,174), //
            COLOR_ENGINEERING = color(122,40,32),
            COLOR_IVANALLEN = color(93,71,118), //
            COLOR_MANAGEMENT =  color(113,137,63),
            COLOR_SCIENCES = color(57,94,139),
            COLOR_ALL_COLLEGES = color(255);
    
final int COLOR_MALE = color(92,119,180), // sky blue
            COLOR_FEMALE = color(214,101,145); // pink
    
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

final int Color_AXIS = color(209);

final int COLOR_YearBar_Unselected = color(250); //#F3E5BE
final int COLOR_YearBar_HoveredOn = color(231, 221, 142);  //E7DD8E
final int COLOR_YearBar_ClickSelected = color(153, 121, 35);  //997923
final int COLOR_YearBarLabel = color(158, 115, 62);

final int COLOR_PopupBubble = color(0); //209  //255,196,64
final int COLOR_DoDText = color(230);

final int COLOR_LegendBackground = color(210); //color(209);
final int COLOR_LegendText = color(10);



//-------------------- GLOBAL VARIABLE METHODS ------------------------------//

public void initGlobals() {
  initGlobalDataAndVizElements();
  initGlobalPositions();
  initControlP5();
  initEventInteractionTracers_defautValues();
  initFonts();
}

public void initGlobalDataAndVizElements() {
  // Data Structures
  Years = new ArrayList<ArrayList<College>>();
  
  // Viz-Element Structures
  yearBars = new ArrayList<YearBar>();
  
//  dir1 = new PopupBubble(3, 0, int x, int y, int rWidth, int rHeight, color Color);
//  
//  dir2 = new PopupBubble(3, 0, int x, int y, int rWidth, int rHeight, color Color);
//  
//  dirYear = new PopupBubble(1, 0, int x, int y, int rWidth, int rHeight, color Color);
  
}

public void initFonts() {
  calibri = loadFont("Calibri-12.vlw");
  Aharoni_Bold = loadFont("Aharoni-Bold-12.vlw"); 
  avenir = loadFont("Avenir-Light-32.vlw");
  hel = loadFont("Helvetica-Light-40.vlw");
}

public void initControlP5() {
  cp5 = new ControlP5(this);
}

public void initEventInteractionTracers_defautValues() {
  CurrSelectedYear = BASE_YEAR;
  Event_SelectedYearChange = false;
 
  CurrVizTwoDisplayMode = 0;
  Event_VizTwoDisplayModeChange = false;
  
  CurrSelectedCollege = null;
  Event_VizTwoDisplayModeChange = false;

  colToDraw = 6;
  Event_VizOneCollegeToDrawChange = false;
}


public void initGlobalPositions() {
  //-- Overall Visualization --//
  totViz_X = 0;
  totViz_Y = 0;
  totViz_width = SCREEN_WIDTH - 2;
  totViz_height = SCREEN_HEIGHT - 2;
  
  
  //-- 1st Viz --//
  vizOne_X = totViz_X;
  vizOne_Y = totViz_Y;
  vizOne_width = totViz_width;
  vizOne_height = PApplet.parseInt(totViz_height / 2.3f);
  
  
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
public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  private boolean hov;
  
  private int rX, rY;
  private int rWidth, rHeight;
  
  private final int Legend_yPADDING_small = 4; //8;
  private final int Legend_yPADDING_big = 10; //8;
  private final int Legend_TEXTSIZE = 10;
  private final int Legend_xPADDING = 8; //5
  
  private int elementHeight;
  
  private int colorBoxWidth;
  private int colorBoxHeight;
  
  private ArrayList<LegendElement> elements;
  
  
  private final int RADIUS = 7;
  
  private final int NUM_ELEMENTS = 7;
  
  private final String[] collegeTEXT = {"College of Architecture", "College of Computing", "College of Engineering",
                                        "College of Ivan Allen", "College of Management", "College of Sciences", "All Colleges"};
  
  private final int[] colorBoxColors = {COLOR_ARCHITECTURE, COLOR_COMPUTING, COLOR_ENGINEERING, 
                                         COLOR_IVANALLEN, COLOR_MANAGEMENT, COLOR_SCIENCES, COLOR_ALL_COLLEGES };
    
    
  
  public Legend(int leftX, int rightX, int bottomLeftY) {
    this.bottomLeftY = bottomLeftY;
    
    calcLegendPosValues(leftX, rightX);
    
    elements = new ArrayList<LegendElement>();
    buildLegendElements();
  }
  
  public int getPosX() {
    return rX;  
  }
  
  public int getWidth() {
    return rWidth;  
  }

  
  private void calcLegendPosValues(int leftX, int rightX) {
    colorBoxHeight = Legend_TEXTSIZE;
    colorBoxWidth = ceil(1.5f * colorBoxHeight);
    
    int maxStringWidth = determineMaxStringPixelSize();
    
    elementHeight = Legend_TEXTSIZE + Legend_yPADDING_big - Legend_yPADDING_small;
    
    rWidth = (2 * Legend_xPADDING) + colorBoxWidth + Legend_xPADDING + maxStringWidth;
    //rHeight = (2 * Legend_yPADDING_big) + (NUM_ELEMENTS * Legend_TEXTSIZE) + ((NUM_ELEMENTS-1) * Legend_yPADDING_small);
    rHeight = (2 * Legend_yPADDING_big) + (NUM_ELEMENTS * elementHeight) + ((NUM_ELEMENTS-1) * Legend_yPADDING_small);
    
    int availSpace = rightX - leftX;
    
    if (rWidth < availSpace) {
      int availPadTotal = availSpace - rWidth;
      int dynamicPad = floor((float) availPadTotal / 2);
      rX = leftX + dynamicPad;
    }
    else {
      rX = leftX + 5;
    }

    rY = bottomLeftY - rHeight; 
    
  }
  
  public void buildLegendElements() {
    int relativeY = rY;
    int relativeX;
    
    int elementWidth = rWidth - Legend_xPADDING; //- (2 * Legend_xPADDING);
    //int elementHeight = Legend_TEXTSIZE;
    
    for (int i=0; i < NUM_ELEMENTS; i++) {
      if (i == 0) {
        relativeY += Legend_yPADDING_big;  
      }
      else {
        relativeY += Legend_yPADDING_small;
      }
      relativeX = rX + (Legend_xPADDING/2);
      
      LegendElement newElement = new LegendElement(relativeX, relativeY, elementWidth, elementHeight, colorBoxColors[i], collegeTEXT[i], 
                                                   i, Legend_xPADDING, Legend_yPADDING_big, Legend_yPADDING_small, Legend_TEXTSIZE); 
      elements.add(newElement);
      
      relativeY += elementHeight;
    }    
  }
  
  
  public void draw() {
    fill(COLOR_LegendBackground);
    noStroke();
    rect(rX, rY, rWidth, rHeight, RADIUS);
    
    isHov();
    
    if(hov){
      fill(150);
      rect(rX+rWidth-100, 5, 100, 25, RADIUS);
      
      fill(0, 140);
      
      //year bar
      triangle(vizOne_xAxis_x1-25+70+5, vizOne_xAxis_y1+25, vizOne_xAxis_x1-25+65+5, vizOne_xAxis_y1+30,vizOne_xAxis_x1-25+75+5, vizOne_xAxis_y1+30);
      rect(vizOne_xAxis_x1-25, vizOne_xAxis_y1+30, 150, 65, RADIUS);
      
      //viz1
      triangle(rX+(rWidth/2), rY-60+50+5, rX+(rWidth/2)-5, rY-60+50, rX+(rWidth/2)+5, rY-60+50);
      rect(rX, rY-60, rWidth, 50, RADIUS);
      
      //viz2
      triangle(rX-12+(rWidth/2), rY+170+50+5, rX-12+(rWidth/2)-5, rY+170+50, rX-12+(rWidth/2)+5, rY+170+50);
      rect(rX-12, rY+170, rWidth, 50, RADIUS);
      
      
      
      fill(255, 245);
      textSize(12);
      textAlign(CENTER);
      text("Click on any year bar to change the view in the viz below", vizOne_xAxis_x1-25+5, vizOne_xAxis_y1+35, 140, 65);
      
      text("Click on any college name to change the view", rX+4, rY-60+7, rWidth-5, 50);
      
      text("Select buttons below to change view to the left", rX-12+4, rY+170+7, rWidth-5, 50);
      
      
      
    }
    else{
      fill(220);
      rect(rX+rWidth-100, 5, 100, 25, RADIUS);
    }
    
    
    //rect(rX+rWidth-100, 10, 100, 25, RADIUS);
    fill(0);
    textSize(12);
    textAlign(CENTER);
    text("Directions", rX+rWidth-51, 22);
    
//    String directions = "Directions: To change the view you may select on any college name below.";
//    fill(0);
//    textSize(9);
//    textAlign(LEFT);
//    text(directions, rX, rY-50, 160, 100);
    
    for (LegendElement line : elements) {
      line.draw();  
    }
    
  }
  
    public void isHov()
  {
    if ( ((mouseX > rX+rWidth-100) && (mouseX < ((rX+rWidth-100) + 100)) ) && ((mouseY > 10) && (mouseY < (10 + 25))) ) {
      hov = true;
    }
    else {
      hov = false;
    }

  }
  
  public void checkElementsForHoveredOn() {
    for (LegendElement line : elements) {
      line.checkHoveredOn();
    }  
  }
  
  public void checkMouseClicked() {
    for (LegendElement collegeLine : elements) {
       boolean wasClicked = collegeLine.isMouseInsideBounds();
       if (wasClicked) {
         int collegeIdSelected = collegeLine.getLegendId();
         if (collegeIdSelected != colToDraw) {
           int oldCollegeIdSelected = colToDraw;
           
           collegeLine.setClickSelected(true);
           elements.get(oldCollegeIdSelected).setClickSelected(false);
           
           colToDraw = collegeIdSelected;
           Event_VizOneCollegeToDrawChange = true;
         } 
         else {
           // Do nothing becuase this LegendElement was clicked but is already the Currently-Selected-CollegeToDraw
         } 
       }
       else {
         //Do nothing because this LegendElement was not clicked
       }
    }  
  }
  
  
  private int determineMaxStringPixelSize() {
    int max = 0;
    int curr;

    for (int i=0; i < 6; i++) {
      textSize(Legend_TEXTSIZE);
      curr = ceil(textWidth(collegeTEXT[i]));
      if (curr > max) {
        max = curr; 
      }
    }
    
    return max;
  }
}



public class LegendElement {
  public int xPos, yPos;
  public int elementWidth, elementHeight;
  
  public int biggerY;
  public int biggerHeight;
  
  public int colorBoxWidth;
  public int colorBoxHeight;
  
  public int legend_xPadding;
  public int legend_yPadding_big;
  public int legend_yPadding_small;
  public int legend_textSize;
  
  public int legendColor;
  public String legendText;
  public int legendId;
  
  public boolean hoveredOn;
  public boolean clickSelected;
  
  public final int buttonColor_unselected = color(200); //color(100); //color(64,55,80); //COLOR_LegendBackground;
  public final int buttonColor_hoveredOn = color(150); //color(125); //color(64,55,80); //COLOR_LegendBackground;
  public final int buttonColor_clickSelected = color(219,181,85); //color(255,255,153);
  
  
  
  public LegendElement(int xPos, int yPos, int elementWidth, int elementHeight, int legendColor, String legendText, int legendId,
                       int legend_xPadding, int legend_yPadding_big, int legend_yPadding_small, int legend_textSize) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
    this.legendColor = legendColor;
    this.legendText = legendText;
    this.legendId = legendId;
    
    this.legend_xPadding = legend_xPadding;
    this.legend_yPadding_big = legend_yPadding_big;
    this.legend_yPadding_small = legend_yPadding_small;
    this.legend_textSize = legend_textSize;
    
    biggerY = yPos;
    biggerHeight = elementHeight;
    //biggerY = yPos - (legend_yPadding / 2) + 1;
    //biggerHeight = elementHeight + legend_yPadding - 2;
    
    colorBoxHeight = legend_textSize;
    colorBoxWidth = ceil(1.5f * colorBoxHeight);
    
    hoveredOn = false;
    if (legendId == colToDraw) {
      clickSelected = true;    
    }
    else {
      clickSelected = false;
    }
  }

  public int getLegendId() {
    return legendId;
  }  
  
  
  public void setHoveredOn(boolean val) {
    hoveredOn = val; 
  }
  
  public void setClickSelected(boolean val) {
    clickSelected = val;  
  }
  
  public boolean isMouseInsideBounds() {
    if  ( ((mouseX > xPos) && (mouseX < (xPos + elementWidth))) && ((mouseY > biggerY) && (mouseY < (yPos + biggerHeight))) ) {
      return true;
    }
    else {
      return false;
    }
  }
  
  public void checkHoveredOn() {
    if (isMouseInsideBounds()) {
      hoveredOn = true;
    }
    else {
      hoveredOn = false;
    }     
  }
  
  
  public void draw() {
      int relativeX = xPos + legend_xPadding/2;
      
      int centeredY = yPos + (legend_yPadding_big / 2) - (legend_yPadding_small / 2);
      
      if (clickSelected) {
        fill(buttonColor_clickSelected);
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        //rect(xPos, yPos, elementWidth, elementHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);          
      }
      else if (hoveredOn) {
        fill(buttonColor_hoveredOn);
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);        
      }
      else {
        fill(buttonColor_unselected, 125); //100
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);  
      }
      
  }
}
public class PopupBubble {
  private int side;
  private int align;
  private int xPos;
  private int yPos;
  private int rWidth;
  private int rHeight;
  
  private int tX1, tY1, tX2, tY2, tX3, tY3;
  private int rX, rY;
  
  private int backgroundColor;
  
  private String[] content;
  
  private final int radius = 7;
  private final int padding = POPUP_EDGE_PADDING;
  private final int textHeight = POPUP_VERTICAL_SPACING;
  
  
  public PopupBubble(int side, int align, int x, int y, int rWidth, int rHeight, int Color) {
    this.side = side;
    this.align = align;
    this.xPos = x;
    this.yPos = y;
    this.rWidth = rWidth;
    this.rHeight = rHeight;
    
    this.backgroundColor = Color;
    
    content = new String[1];
    content[0] = null;
    
    calculateOtherValues();
  } 
  
  
  private void calculateOtherValues() {
    tX1 = xPos;
    tY1 = yPos;
    
    //Triangle on side=LEFT
    if (true) {  //side == 0
      //Triangle align=CENTER 
      if (true) {  //align == 0
        int triangleDividingLine_length = ceil((float) .2f * rWidth);
        int triangleTotalBase_length = ceil((float) .25f * rHeight);
        int triangleIndividualBase_length = ceil((float) .5f * triangleTotalBase_length);
        
        int triangleCenterAlignment_distance = ceil((float) .5f * rHeight);
        
        tX2 = tX1 + triangleDividingLine_length;
        tY2 = tY1 - triangleIndividualBase_length;
        
        tX3 = tX1 + triangleDividingLine_length;
        tY3 = tY1 + triangleIndividualBase_length;
        
        rX = tX1 + triangleDividingLine_length;
        rY = tY1 - triangleCenterAlignment_distance;
      }
      else {
        //Intentionally left blank
      }
    }
    else {
      //Intentionally left blank
    }  
  }
  
  
  public void setBackgroundColor(int Color) {
    this.backgroundColor = Color; 
  }
  
  public void setContent(String[] newContent) {
    this.content = new String[newContent.length];
    
    for (int i=0; i < newContent.length; i++) {
      content[i] = newContent[i];
    } 
    
  }
  
  
  public void draw(int vizId) {
    if (vizId == 1) {
      fill(backgroundColor, 230);
      noStroke();
      triangle(tX1, tY1, tX2, tY2, tX3, tY3);
      rect(rX, rY, rWidth, rHeight, radius);
      
      if ((content.length >= 1) && (content[0] != null)) {
        drawContents();
      }

    }
    else if (vizId == 2) {
      fill(backgroundColor);
      noStroke();
      triangle(tX1, tY1, tX2, tY2, tX3, tY3);
      rect(rX, rY, rWidth, rHeight, radius);         
    }
    else {
      //do nothing
    }
  }
  
  private void drawContents() {
      int baseY = rY + padding;
      int baseX = rX;
      
      int currY = baseY;
      int currX = baseX;
      
      for (int i=0; i < content.length; i++) {
        if (content[i].equals("")) {
          fill(COLOR_DoDText);
          textAlign(TOP);
          textSize(textHeight);
          text(" ", baseX, currY);
          currY += textHeight;
        }
        else if (content[i].equals("--")) {
          stroke(COLOR_DoDText);
          line(baseX + padding, currY + (textHeight / 2), baseX + (rWidth - padding), currY + (textHeight / 2));
          currY += textHeight;           
        }
        else if (content[i].equals("-")) {
          stroke(COLOR_DoDText);
          line(baseX +  2 * padding, currY + (textHeight / 2), baseX + (rWidth - 2 * padding), currY + (textHeight / 2));
          currY += textHeight;
        }
        else {
          fill(COLOR_DoDText);
          textAlign(CENTER, TOP);
          textSize(textHeight);
          
          int centeringX = baseX + ceil((float)rWidth / 2);
          
          text(content[i], centeringX, currY);
          currY += textHeight;
        }
      }
  }
  
}
//------------------------ BUILD METHODS -------------------------//
public void buildVisualizationOne() {
   vizOne_yAxis = new Axis(1, "yAxis", vizOne_yAxis_x1, vizOne_yAxis_y1, vizOne_yAxis_x2, vizOne_yAxis_y2, Color_AXIS);
   vizOne_xAxis = new Axis(1, "xAxis", vizOne_xAxis_x1, vizOne_xAxis_y1, vizOne_xAxis_x2, vizOne_xAxis_y2, Color_AXIS);
   
   legend = new Legend(vizOne_xAxis.x2, width, vizOne_xAxis.y1);

   yearBars.clear();
   YearBar currYearBar;
   for (int i=0; i < NUM_YEARS; i++) {
     currYearBar = buildYearBar(i);
     yearBars.add(currYearBar);
   }
      
   setVarInCurrSelectedYearBar(CurrSelectedYear - BASE_YEAR);
}


public YearBar buildYearBar(int yearIndex) {
  YearBar yearBar;
  
  int totalEnrollment = 0;
  College currCollege;
  CollegeBar currCollegeBar;
  
  for (int i=0; i < 6; i++) {
    totalEnrollment += Years.get(yearIndex).get(i).getTotalCollege();
  }
  
  int xPos = vizOne_yAxis.x1 + ((1 + yearIndex) * YearBar_SPACING) + (yearIndex * YearBar_WIDTH);
  int yPos = vizOne_yAxis.y1 + (vizOne_yAxis.getHeight() - (totalEnrollment / STUDENTS_PER_PIXEL)) - InnerBarSpacing;
  int barHeight = vizOne_xAxis.y1 - yPos;
  
  int relative_xPos = xPos + InnerBarSpacing;
  int relative_yPos = yPos + InnerBarSpacing;
  
  ArrayList<CollegeBar> collegeBars = new ArrayList<CollegeBar>();
  
  if(colToDraw == 6){
    for (int i=0; i < 6; i++) {
      currCollege = Years.get(yearIndex).get(i);
      currCollegeBar = buildCollegeBar(currCollege, totalEnrollment, relative_xPos, relative_yPos, barHeight);
      relative_yPos += currCollegeBar.getHeight();
      collegeBars.add(currCollegeBar); 
    }
  }
  else{
      currCollege = Years.get(yearIndex).get(colToDraw);
      currCollegeBar = buildCollegeBar(currCollege, totalEnrollment, relative_xPos, relative_yPos, barHeight);
      collegeBars.add(currCollegeBar);  
      CurrSelectedCollege = currCollege.getName();
      Event_SelectedCollegeChange = true;
  }
  
  
  yearBar = new YearBar(BASE_YEAR + yearIndex, totalEnrollment, xPos, yPos, YearBar_WIDTH, barHeight, collegeBars, YearBarLabelBar_HEIGHT, relative_xPos + label_xPading, vizOne_xAxis.y1 + label_yPading, YearBarLabel_WIDTH, YearBarLabel_WIDTH);
  yearBar.setBarColor_Unselected(COLOR_YearBar_Unselected);
  yearBar.setBarColor_HoveredOn(COLOR_YearBar_HoveredOn);
  yearBar.setBarColor_ClickSelected(COLOR_YearBar_HoveredOn);
  
  return yearBar; 
}


public CollegeBar buildCollegeBar(College college, int totalEnrollmentForYear, int xPos, int yPos, int yearBarHeight) {
  CollegeBar collegeBar;
  
  float barHeight = round(((float)college.getTotalCollege() / totalEnrollmentForYear) * (yearBarHeight - InnerBarSpacing));
  if(colToDraw == 6){
    collegeBar = new CollegeBar(college.getName(), xPos, yPos, CollegeBar_WIDTH, (int) barHeight);
  }
  else{
    int posY = PApplet.parseInt(vizOne_xAxis_y1 - barHeight);
    collegeBar = new CollegeBar(college.getName(), xPos, posY, CollegeBar_WIDTH, (int) barHeight);
  }
  collegeBar.setCollegeEnrollment(college.getTotalCollege());
  collegeBar.setUniversityEnrollment(totalEnrollmentForYear);
  
  int barColor = determineCollegeBarColorFromName(college.getName());
  collegeBar.setColor_Unselected(barColor);
  
  return collegeBar; 
}


public int determineCollegeBarColorFromName(String name) {
 if (name.equals("Architecture")) {
   return COLOR_ARCHITECTURE;
 }
 else if (name.equals("Computing")) {
   return COLOR_COMPUTING;
 }
 else if (name.equals("Engineering")) {
   return COLOR_ENGINEERING;
 }
 else if (name.equals("Ivan Allen")) {
   return COLOR_IVANALLEN;
 }
 else if (name.equals("Management")) {
   return COLOR_MANAGEMENT;
 }
 else if (name.equals("Sciences")) {
   return COLOR_SCIENCES;
 }
 else {
   return color(0,0,0); 
 }
}


private void setVarInCurrSelectedYearBar(int curr) {
  yearBars.get(curr).setClickSelected(true); 
}


//------------------------ CHECK METHODS -------------------------//
public void vizOneCheckMouseClicked() {
  for (YearBar yearBar : yearBars) {
     boolean wasClicked = yearBar.isMouseInsideBounds();
     if (wasClicked) {
       int yearClicked = yearBar.getYear();
       if (yearClicked != CurrSelectedYear) {
         int oldYearIndex = CurrSelectedYear - BASE_YEAR;
         
         yearBar.setClickSelected(true);
         yearBars.get(oldYearIndex).setClickSelected(false);
         
         CurrSelectedYear = yearClicked;
         Event_SelectedYearChange = true;
       } 
       else {
         // Do nothing becuase this YearBar was clicked but is already the Currently-Selected-Year
       } 
     }
     else {
       //Do nothing because this YearBar was not clicked
     }
  }
  
  legend.checkMouseClicked();   
     
}   

public void checkVisualizationOne() {
   for (YearBar yearBar : yearBars) {
     yearBar.isHoveredOver();
     for (CollegeBar collegeBar : yearBar.getCollegeBars()) {
       collegeBar.isHoveredOver();
     } 
   }
   legend.checkElementsForHoveredOn();
}



//------------------------ DRAW METHODS -------------------------//
public void drawVisualizationOne() {
   vizOne_yAxis.draw();
   String[] labelVals = new String[2];
   labelVals[0] = "University";
   labelVals[1] = "Enrollment";
   vizOne_yAxis.drawLabel(labelVals);
   vizOne_xAxis.draw();
   
   
   legend.draw();
   
   int titleX = vizOne_X + round((float)vizOne_width / 2);
   int titleY = vizOne_Y + vizOne_InnerPaddingY / 2; 
   
   textAlign(CENTER, TOP);
   fill(0);
   stroke(0);
   textSize(20);
   text("GT University Enrollment by Year", titleX, titleY);
   textSize(12);
   
   for (YearBar yearBar : yearBars) {
     yearBar.draw();
     
       for (CollegeBar collegeBar : yearBar.getCollegeBars()) {
         collegeBar.draw();
       }
   }

   for (YearBar yearBar : yearBars) {
     
     for (CollegeBar collegeBar : yearBar.getCollegeBars()) {
       collegeBar.drawDetailsOnDemandIfNeeded();
     } 
   }
   
}



//------------------------ BUILD METHODS -------------------------//

Chart c1;
ChartDataSet ds1;
College engi, comp, manag, sci, ivan, arch;
int year;
RadioButton r, rOther;
static int mode = 0;
static int dataMode = 0;
boolean change = true;

private final int IMG_WIDTH = 15, IMG_HEIGHT = 15;

//Works on my hardrive.
//PImage selected = loadImage("C:\\Users\\lucas\\Documents\\GitHub\\InfoVizProject\\Visualization\\data\\selected.png");
//PImage unselected = loadImage("C:\\Users\\lucas\\Documents\\GitHub\\InfoVizProject\\Visualization\\data\\unselected.png");

//String selURL = "";
PImage selected; // = loadImage("selected.png");
PImage unselected; //= loadImage("unselected.png");


/*
String selURL = "http://i.imgur.com/6lYa8K3.gif";
PImage selected = loadImage(selURL, "png");

String UnselURL = "http://i.imgur.com/Bok7rHI.png";
PImage unselected = loadImage(UnselURL, "png");
*/

barChart bc1,bc2,bc3,bc4,bc5,bc6;
ArrayList<ArrayList<barChartBar>> collegeBars;



public void buildVisualizationTwo() {
  
  dataMode = this.dataMode;
  year = 1999;
  getData();
  drawCP5();
  mode = this.mode;
  
  selected.resize(IMG_WIDTH, IMG_HEIGHT); // huy remove comment to test.
  unselected.resize(IMG_WIDTH, IMG_HEIGHT); // huy remove comment to test.

  
  collegeBars = new ArrayList<ArrayList<barChartBar>>();
  initCharts();
  //vizTwoAnimate();
  
}


//------------------------ CHECK METHODS -------------------------//
public void checkVisualizationTwo() {
  
}


/////// Percent, num radio buttons

public void drawCP5(){
  r = cp5.addRadioButton("viewButton")
          .setPosition(1180,350)
          .setSize(2,2)
          .setColorLabel(0)
          .setItemHeight(10)
          .setItemWidth(15)
          .setItemsPerRow(2)
          .setSpacingColumn(50)
          .addItem("A",0)
          //.addItem("Percent",0)
          //.addItem("Number", 1)
          .addItem("B", 1)
          .setNoneSelectedAllowed(false)
          .setImages(unselected, unselected, selected) //default, theOverImage, activeImage // huy images
          .activate(dataMode);
          
  rOther = cp5.addRadioButton("otherButton")
              .setPosition(1180,400)
              .setSize(2,2)
              .setColorLabel(0)
              .setItemHeight(10)
              .setItemWidth(15)
              .setItemsPerRow(1)
              .setSpacingColumn(50)
              .setSpacingRow(10)
              .setSpacingRow(IMG_HEIGHT/2) // huy images
              //.addItem("Major",0)
              .addItem("X", 0) 
              //.addItem("Ethnicity", 1)
              .addItem("Y", 1) 
              //.addItem("Gender", 2)
              .addItem("Z", 2) 
              .setNoneSelectedAllowed(false)
              .setImages(unselected, unselected, selected) //default, theOverImage, activeImage // huy images
              .activate(mode);

}

public void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r)) {
    collegeBars = new ArrayList<ArrayList<barChartBar>>();
    dataMode = PApplet.parseInt(r.getValue());
    //getData();
    //initCharts();
    drawVisualizationTwo();
    change = true;
  }
  
  if(theEvent.isFrom(rOther)) {
    collegeBars = new ArrayList<ArrayList<barChartBar>>();
    mode = PApplet.parseInt(rOther.getValue());
    //getData();
    //initCharts();
    drawVisualizationTwo();
    change = true;
  }
  
  if(theEvent.isFrom(selCollege)) {
    colToDraw = PApplet.parseInt(selCollege.getValue());
    int saveYear = CurrSelectedYear;
    buildVisualizationOne();
    CurrSelectedYear = saveYear;
    initCharts();
  }
  
  
  
}


//------------------------ DRAW METHODS -------------------------//


public void initCharts(){
  
  //bars = new ArrayList<barChartBar>();
  //collegeBars = new ArrayList<ArrayList<barChartBar>>();
  //print(collegeBars);
  
  getData();
  
  bc1 = new barChart(185, 493, "Engineering", 1, engi);
  //print(collegeBars);
  bc2 = new barChart(185, 655, "Computing", 1, comp);
  
  bc3 = new barChart(540, 493, "Architecture", 1, arch);
  bc4 = new barChart(540, 655, "Ivan Allen", 1, ivan);  
  
  bc5 = new barChart(895, 493, "Sciences", 1, sci);
  bc6 = new barChart(895, 655, "Management", 1, manag);
  
  //vizTwoAnimate();
  vizTwo_Menu_X = legend.getPosX();
  vizTwo_Menu_Y = 325;
  vizTwo_Menu_WIDTH = legend.getWidth();
  vizTwo_Menu_HEIGHT = 150;
}

public void drawVisualizationTwo() {

  initCharts();
  
  //fill(175);
  //Background for viz 2 legend
  fill(COLOR_LegendBackground);

  noStroke();
  //rect(1165, 325, 170, 150, 3);
  rect(1165, 325, 170, 150, ROUNDED_CORNER_VALUE);
  //rect(legend.getPosX(), 325, legend.getWidth(), 150, ROUNDED_CORNER_VALUE);
  //rect(vizTwo_Menu_X, vizTwo_Menu_Y, vizTwo_Menu_WIDTH, vizTwo_Menu_HEIGHT, ROUNDED_CORNER_VALUE);
  
  bc1.draw();
  bc2.draw();
  bc3.draw();
  bc4.draw();
  bc5.draw();
  bc6.draw();
  
  
  cp5.draw();
  
  String y = Integer.toString(CurrSelectedYear);
  y = y.concat(" Breakdown ");
  String by = "";
  if(mode == 0){
    by = "by Major";
  }
  else if (mode == 1){
    by = "by Ethnicity";
  }
  else if (mode == 2){
    by = "by Gender";
  }
  y = y.concat(by);
  textSize(20);
  textAlign(CENTER);
  text(y,round((float)vizOne_width /2),315);
  
  labelSecLegend();
}

public void labelSecLegend()
{
  //top title
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  //int wordPosY = vizTwo_Menu_Y + 20;
  //int wordPosX = vizTwo_Menu_X + floor((float) vizTwo_Menu_WIDTH / 2); 
  //text("DISPLAY",wordPosX,wordPosY);
  int wordPos = 345; 
  text("DISPLAY",1250,wordPos);
  
  //percentage
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  int percentPos = 363; 
  text("PERCENT",1220, percentPos);
  
  //number
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  int numPos = 363; 
  text("NUMBER",1280, numPos);
  
  //make division line in 2nd legend
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  int linePos = 374; 
  text("____________________________",1250,linePos);
  
  //bottom title
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  int title2Pos = 393; 
  text("DEMOGRAPHICS",1250,title2Pos);
  
  //paint Major/Ethnicity/Gender
  fill(0);
  textSize(9);
  textAlign(CENTER,BOTTOM);
  int textYPos = 412; 
  text("MAJOR",1213,textYPos);
  text("ETHNICITY",1222, textYPos + IMG_HEIGHT + 2);
  text("GENDER",1215, textYPos + 2*IMG_HEIGHT + 5);
}

public int getPercent(int enrollment, int colTotal){
  float percent = PApplet.parseFloat(enrollment)/colTotal;
  percent = percent * 100;
  
  return PApplet.parseInt(percent);
}

public void getData(){
  year = CurrSelectedYear;
  ArrayList<College> colObjs;
  if(year == 1999){
    colObjs = Years.get(0);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
  else if(year == 2000){
    colObjs = Years.get(1);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2001){
    colObjs = Years.get(2);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2002){
    colObjs = Years.get(3);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2003){
    colObjs = Years.get(4);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2004){
    colObjs = Years.get(5);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2005){
    colObjs = Years.get(6);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2006){
    colObjs = Years.get(7);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2007){
    colObjs = Years.get(8);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2008){
    colObjs = Years.get(9);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2009){
    colObjs = Years.get(10);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2010){
    colObjs = Years.get(11);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2011){
    colObjs = Years.get(12);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2012){
    colObjs = Years.get(13);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2013){
    colObjs = Years.get(14);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }

  
}


public class barChart{
  
  int sizeX, sizeY;
  int posX, posY;
  String name, dMode;
  College college;
  int chartNum;
  
  Axis X, Y; 
  
  ArrayList<barChartBar> bars;
  
  public barChart(int posX, int posY, String name, int chartNum, College college){
    this.posX = posX;
    this.posY = posY;
    this.name = name;
    this.chartNum = chartNum;
    this.college = college;
    
    bars = new ArrayList<barChartBar>();
    
    //mode = "Major";

    
    sizeX = 200;
    sizeY = 140;
    
    
    X = new Axis(2, name.concat("Xaxis"), posX, posY-140, (posX+sizeX), posY-140, color(120,120,120));
    X.setWeight(1);
    Y = new Axis(2, name.concat("Yaxis"), posX, posY, posX, (posY-sizeY), color(120,120,120));
    Y.setWeight(1);
  } //end constructor
  
  // Used to cause brushing only on correct year chosen.
  public void getBrushing()
  {
    int xpos = 0;
    int ypos = 0;
    int thisHeight = 0;
    int thisWidth = 0;

    for(YearBar yearBar : yearBars)
    {
      if(yearBar.getYear() == CurrSelectedYear)
      {
        xpos = yearBar.getXPos();
        ypos = yearBar.getYPos();
        thisHeight = yearBar.getHeight();
        thisWidth = yearBar.getWidth();
        break;
      }
    } 
    
    if (CurrSelectedCollege == null || !CurrSelectedCollege.equals(college.Name)) {
      fill(150,20);
    }
    else //CurrSelectedCollege.equals(college.Name)
    {
      if(colToDraw == 6){
        if( (mouseX > xpos && mouseX < xpos+thisWidth) && (mouseY > ypos && mouseY < ypos+thisHeight))
          fill(150,100);
        else
          fill(150,20);
      }

    }
    shouldBold();
  }
  
  public void shouldBold(){
    if(CurrSelectedCollege != null){
      if(CurrSelectedCollege.equals(college.Name) && colToDraw != 6){
        fill(150,100);
      }
    }
  }

  
  public void draw(){
    
    getData();
    
    getBrushing();
    
   // X.draw();
   // Y.draw();
   /*
    //if (CurrSelectedCollege == null || !CurrSelectedCollege.equals(college.Name)) {
      //fill(150,20);
    //}
    //else { //(CurrSelectedCollege.equals(college.Name)) {
      //fill(150,100);  
    //}
    */

    noStroke();
    rect(posX-90, posY-140-30, 345, 150, 6);
  
    //fill(80,80,80);
    fill(50);
    
    float x = 30;
    float y = 150;
    textAlign(CENTER,BOTTOM); 
 
    //paint college name
    
    textSize(18);
    text(name,posX+80,posY-143);
    float tw = textWidth(name);
    
    //paint "by percentage/by number"
    textSize(9);
     if(dataMode == 0)
      dMode = "by Percentage of Students";
    else if (dataMode ==1)
      dMode = "by Number of Students";
    text(dMode, posX+80,posY-133);
    
    
    //drawBars();
    
    
    if(firstDraw || change){
      drawBars();
    }
    bDraw();
    
  }
  
  
  public void drawBars(){
    
    int barX = posX;
    int barY = posY;
    int opacity = 255;
    
    if(mode==0){ /// 0 == MAJOR
      for(Major m : college.top3Majors){
        if(m != null){
          barChartBar b = new barChartBar(getPercent(m.Enrollment, college.TotalCollege),m.Enrollment, barX, barY, m.NameMajor, college, opacity);
          barY+= 35;
          opacity-=55;
          bars.add(b);
        }
      }
      opacity = 200;
    }
    else if(mode==1){   /// 1 == ETHNICITY
      
      
      
      barChartBar bA = new barChartBar(getPercent(college.getAsian(), college.TotalCollege),college.getAsian(), barX, barY-5, "Asian", college, opacity);
      barChartBar bB = new barChartBar(getPercent(college.getBlack(), college.TotalCollege),college.getBlack(), barX, barY+20, "Black", college, opacity);
      barChartBar bH = new barChartBar(getPercent(college.getHispanic(), college.TotalCollege),college.getHispanic(), barX, barY+45, "Hispanic", college, opacity);
      barChartBar bW = new barChartBar(getPercent(college.getWhite(), college.TotalCollege),college.getWhite(), barX, barY+70, "White", college, opacity);
      
      bars.add(bA);
      bars.add(bB);
      bars.add(bH);
      bars.add(bW);
      
    }
    else if(mode==2){   ///2 == GENDER
    
      barChartBar bF = new barChartBar(getPercent(college.getFemale(), college.TotalCollege),college.getFemale(), barX, barY, "Female", college, opacity);
      barChartBar bM = new barChartBar(getPercent(college.getMale(), college.TotalCollege),college.getMale(), barX, barY+35, "Male", college, opacity);
      
      bars.add(bF);
      bars.add(bM);
      
    }
    
    collegeBars.add(bars);
    
  }
  
  public void bDraw(){
    for(barChartBar b : bars){
     b.draw(); 
    }
  }  
  
  
  
} ///// End Class bar chart



public class barChartBar{
  int dataPercent, dataNum;
  int x, y,n, nBack; 
  String name;
  int col;
  int w, h;
  float conversion;
  int opacity;
  int Color;
  College college;
  String abrevName;
  //AniSequence s;
  int drawX, drawY;
  
  barChartBar(int dataPercent, int dataNum, int x, int y, String name, College college, int opacity){
    
    
    this.dataPercent = dataPercent;
    this.dataNum = dataNum;
    this.x = x;
    this.y = y;
    this.name = name;
    this.opacity = opacity;
    
    n=0;
    nBack = h;
    
    
    if(name.equals("Archtecture")){
      this.name = "Architecture";
    }
    this.college=college;

    w = 22;
    initData();
    setColor();
    
    
    
  }
  
  public void initData(){
    
    if(dataMode == 0){
      h = PApplet.parseInt(dataPercent*2.3f);
    }
    else if (dataMode == 1){
     h = floor(PApplet.parseFloat(dataNum)/25);
     
     if(h == 0)
       h = 1;
    }
      
    
  }
  
  
  public void draw(){
    
    
    fill(Color, opacity);
    noStroke();
    
    if(name.equals("Female") || name.equals("Male")){
       //rect(x-45,y-125,h,w);
       drawX = x-45;
       drawY = y-125;
    }
    else{
      //rect(x-20,y-125,h,w);
      drawX = x-20;
      drawY = y-125;
    }
      
    
    fill(10);
    textSize(8);
    textAlign(LEFT, BOTTOM);
    
    

    if(name.equals("Science. Technology and Society") || name.equals("Science Technology and Culture")){
      name = "Science, Technology and Culture";
      abrevName = "Science, Tech, & Culture";
      text(abrevName, x-80, y-205, 60, 100);
    }
    else if(name.equals("Pre-Architecture")){
      name = "Pre- Architecture";
      text(name, x-80, y-205, 60, 100);
    }
    else if(name.equals("History Technology and Society") || name.equals("History. Technology and Society")){
     name = "History, Technology and Society";
     abrevName = "History, Tech, & Society";
     text(abrevName, x-80, y-205, 60, 100);
    }
    else if(name.equals("International Affairs and Modern Languages")||name.equals("International Affair and Modern Languages")){
      name="International Affairs and Modern Languages";
     abrevName = "Modern Languages";
     text(abrevName, x-80, y-205, 60, 100);
    }
    else if(!college.Name.equals("Ivan Allen") && !college.Name.equals("Sciences") && !name.equals("Management")&& !name.equals("Architecture")&& !name.equals("International Affairs")){
      text(name, x-80, y-205, 60, 100);
    }
    else if(college.Name.equals("Ivan Allen")){
      text(name, x-80, y-205, 60, 100);
    }
    else{
      text(name, x-80, y-110);
    }
    
    textSize(10);
    if(dataMode == 0){
      String dp = String.valueOf(dataPercent);
      dp=dp.concat("%");
      if(name.equals("Female") || name.equals("Male"))
        text(dp, x+h-40, y-110);
      else
        text(dp, x+h-15, y-110);
    }
    else if(dataMode==1){
      String dn = String.valueOf(dataNum);
      if(name.equals("Female") || name.equals("Male"))
        text(dn, x+h-40, y-110);
      else
        text(dn, x+h-15, y-110);
    }
    
  }
  
  ////////////////

public boolean render() {
    if ( n<h ) {
      n+=3;
    }
    noStroke();
    fill(Color, opacity);
    rect(drawX, drawY, n, w);
    return( n<h );
  }

///////////////////

  ////////////////

public boolean renderBack() {
    if ( nBack>=0 ) {
      nBack-=3;
    }
    noStroke();
    fill(255);
    rect(drawX, drawY, nBack, w);
    
    
    noStroke();
    fill(Color, opacity);
    rect(drawX, drawY, nBack, w);
    return( nBack>=0 );
  }

///////////////////
  
  
  public void setColor(){
    if(college.Name.equals("Ivan Allen"))
      Color = COLOR_IVANALLEN;
    else if(college.Name.equals("Architecture"))
      Color = COLOR_ARCHITECTURE;
    else if(college.Name.equals("Management"))
      Color = COLOR_MANAGEMENT;
    else if(college.Name.equals("Sciences"))
      Color = COLOR_SCIENCES;
    else if(college.Name.equals("Engineering"))
        Color = COLOR_ENGINEERING;
    else if(college.Name.equals("Computing"))
      Color = COLOR_COMPUTING;
      
    if(name.equals("Male"))
      Color = COLOR_MALE;
    else if(name.equals("Female"))
      Color = COLOR_FEMALE;
  }
  
  
}///End class bar chart bars
public class YearBar {
  private int Year;
  private int TotalEnrollment;
  
  private ArrayList<CollegeBar> CollegeBars;
 
  private int xPos, yPos;
  private int bar_width, bar_height;
  
  private int labelBar_height;
  private int label_xPos;
  private int label_yPos;
  private int label_width;
  private int label_height;
  
  private boolean collegeMode;
  
  private int barColor_Unselected;
  private int barColor_ClickSelected;
  private int barColor_HoveredOn;
  
  private int labelColor_Unselected;
  
  private boolean hoveredOn;
  private boolean clickSelected;
  
  
  private final int radius = 7;
  private final int opacity_Unselected = 125;
  private final int opacity_HoveredOn = 150;
  private final int opacity_ClickSelected = 175;
  
  public YearBar(int year, int totalEnrollment, int x, int y, int bar_width, int bar_height, ArrayList<CollegeBar> collegeBars, int labelBar_height, int label_xPos, int label_yPos, int label_width, int label_height) {
    this.Year = year;
    this.TotalEnrollment = totalEnrollment;
    
    this.xPos = x;
    this.yPos = y;
    this.bar_width = bar_width;
    this.bar_height = bar_height;
    
    this.labelBar_height = labelBar_height;
    this.label_xPos = label_xPos;
    this.label_yPos = label_yPos;
    this.label_width = label_width;
    this.label_height = label_height;
   
    this.CollegeBars = collegeBars;
   
    this.hoveredOn = false;
    this.clickSelected = false; 
  }
  
  public void setBarColor_Unselected(int Color) {
    this.barColor_Unselected = Color; 
  }
  
  public void setBarColor_HoveredOn(int Color) {
    this.barColor_HoveredOn = Color; 
  }
  
  public void setBarColor_ClickSelected(int Color) {
    this.barColor_ClickSelected = Color; 
  }  
  
  public void setLabelColor(int Color) {
    this.labelColor_Unselected = Color; 
  }
  
  public void setCollegeMode(boolean mode) {
   collegeMode = mode; 
  }
  
  public ArrayList<CollegeBar> getCollegeBars() {
    return CollegeBars; 
  }
  
  public int getYear() {
    return Year; 
  }
  
  public boolean isMouseInsideBounds() {
    if ( (((mouseX > xPos) && (mouseX < (xPos + bar_width))) && ((mouseY > yPos) && (mouseY < (yPos + bar_height))) ) ||
       (((mouseX > xPos) && (mouseX < (xPos + bar_width))) && ((mouseY > (yPos + bar_height)) && (mouseY < (yPos + bar_height + labelBar_height)))) ) {
      return true;
    }
    else {
      return false;
    }
  }
  
  // brushing only on correct year hovering.
  public int getXPos()
  {
    return xPos;
  }
  
  public int getYPos()
  {
    return yPos;
  }
  
  public int getWidth()
  {
    return bar_width;
  }
  
  public int getHeight()
  {
    return bar_height;
  }
  
  public boolean getCollegeMode() {
    return collegeMode; 
  }
  
  
  public void isHoveredOver() {
    if (isMouseInsideBounds()) {
      hoveredOn = true;
    }
    else {
      hoveredOn = false;
    } 
  }
  
  public void setClickSelected(boolean val) {
    this.clickSelected = val; 
  }
  
  
  public void draw() {
    int xlabel = label_xPos + round((float)(bar_width - 2 * InnerBarSpacing) / 2);
    //SELECTED Version
    if (clickSelected) {
      //Regular Bar Part
      fill(barColor_HoveredOn, opacity_HoveredOn);
      noStroke();
      rect(xPos, yPos, bar_width, bar_height, radius, radius, 0, 0);
     
      //Label Bar Part
      fill(barColor_ClickSelected, opacity_ClickSelected);
      noStroke();
      rect(xPos, yPos + bar_height, bar_width, labelBar_height, 0, 0, radius, radius);
      
      //Label Text
      fill(0);
      stroke(0);
      String yearText = new Integer(Year).toString();
      textSize(12);
      textAlign(CENTER, TOP);
      text(yearText, xlabel, label_yPos); 
   
      //yAxis smart grid line
      strokeWeight(1);
      stroke(150, 50);
      line(vizOne_yAxis.x1, yPos + InnerBarSpacing - 1, vizOne_xAxis.x2, yPos + InnerBarSpacing - 1);
      
      fill(0);
      stroke(0);
      textAlign(RIGHT, CENTER);
      textSize(12);
      String enrollment = new Integer(TotalEnrollment).toString();
      float labelXPos = vizOne_yAxis.x1 - textWidth(enrollment) - 5 ;
      float labelYPos = yPos + InnerBarSpacing - 1;
      text(enrollment, vizOne_yAxis.x1 - 5, yPos + InnerBarSpacing - 1);
      noStroke();  
    }
    //HOVERED ON Version
    else if (hoveredOn) {
      //Regular Bar Part
      fill(250);
      noStroke();
      rect(xPos, yPos, bar_width, bar_height, radius, radius, 0, 0);
     
      //Label Bar Part
      fill(barColor_HoveredOn, opacity_HoveredOn);
      noStroke();
      rect(xPos, yPos + bar_height, bar_width, labelBar_height, 0, 0, radius, radius);
      
      //Label Text
      fill(0);
      stroke(0);
      String yearText = new Integer(Year).toString();
      textAlign(CENTER, TOP);
      text(yearText, xlabel, label_yPos);
    }
    //NORMAL Version
    else {
      //Regular Bar Part
      fill(barColor_Unselected, opacity_Unselected);
      noStroke();
      rect(xPos, yPos, bar_width, bar_height, radius, radius, 0, 0);
     
      //Label Bar Part
      fill(barColor_Unselected, opacity_Unselected);
      noStroke();
      rect(xPos, yPos + bar_height, bar_width, labelBar_height, 0, 0, radius, radius);
      
      //Label Text
      fill(0);
      stroke(0);
      String yearText = new Integer(Year).toString();
      textAlign(CENTER, TOP);
      text(yearText, xlabel, label_yPos);
    }
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Visualization" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
