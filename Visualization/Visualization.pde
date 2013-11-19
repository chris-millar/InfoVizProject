// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

boolean debug = true;
////////////// Init Methods //////////////////

public void setup() {
  initGlobals();
  loadData();
  if (debug) { test_Data(); }
  initScreen();
  
  background(255);
  
  buildVisualizationOne();
}

public void initScreen() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  //frameRate(30);
}

///////////////// Processing Drawing /////////////////////
void draw() {
  if (false) { test_Positions(); }
  
   //fill(255);
   //rect(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
  background(255);
  
  checkVisualizationOne();
  buildVisualizationOne();
  drawVisualizationOne();
}


void buildVisualizationOne() {
   vizOne_yAxis = new Axis(1, "yAxis", vizOne_yAxis_x1, vizOne_yAxis_y1, vizOne_yAxis_x2, vizOne_yAxis_y2, color(0));
   vizOne_xAxis = new Axis(1, "xAxis", vizOne_xAxis_x1, vizOne_xAxis_y1, vizOne_xAxis_x2, vizOne_xAxis_y2, color(0));
   
   yearBars.clear();
   YearBar currYearBar;
   for (int i=0; i < NUM_YEARS; i++) {
     currYearBar = buildYearBar(i);
     yearBars.add(currYearBar);
   }
}

void checkVisualizationOne() {
  
}

void drawVisualizationOne() {
   vizOne_yAxis.draw();
   vizOne_xAxis.draw();
   
   for (YearBar bar : yearBars) {
     bar.draw();
     for (CollegeBar collegeBar : bar.getCollegeBars()) {
       collegeBar.draw();
     } 
   }
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
  int yPos = vizOne_yAxis.y1 + (vizOne_yAxis.getHeight() - (totalEnrollment / STUDENTS_PER_PIXEL));
  int barHeight = vizOne_xAxis.y1 - yPos;
  
  int relative_xPos = xPos + InnerBarSpacing;
  int relative_yPos = yPos + InnerBarSpacing;
  
  ArrayList<CollegeBar> collegeBars = new ArrayList<CollegeBar>();
  
  for (int i=0; i < 6; i++) {
    currCollege = Years.get(yearIndex).get(i);
    currCollegeBar = buildCollegeBar(currCollege, totalEnrollment, relative_xPos, relative_yPos, barHeight);
    relative_yPos += currCollegeBar.getHeight();
    collegeBars.add(currCollegeBar); 
  }
  
  
  yearBar = new YearBar(BASE_YEAR + yearIndex, totalEnrollment, xPos, yPos, YearBar_WIDTH, barHeight, collegeBars);
  yearBar.setColor(YearBar_COLOR);
  
  return yearBar; 
}

public CollegeBar buildCollegeBar(College college, int totalEnrollmentForYear, int xPos, int yPos, int yearBarHeight) {
  CollegeBar collegeBar;
  
  //int barHeight = (yearBarHeight - (2 * InnerBarSpacing)) - (college.getTotalCollege() / STUDENTS_PER_PIXEL);
  
  float barHeight = ((float)college.getTotalCollege() / totalEnrollmentForYear) * (yearBarHeight - (2 * InnerBarSpacing));
  collegeBar = new CollegeBar(college.getName(), xPos, yPos, CollegeBar_WIDTH, (int) barHeight);
  
  color barColor = determineCollegeBarColorFromName(college.getName());
  collegeBar.setColor(barColor);
  
  return collegeBar; 
}

public color determineCollegeBarColorFromName(String name) {
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


class Axis {
  int VizBelongsTo;
  String Name;
  
  int x1;
  int y1;
  int x2;
  int y2; 
  
  color Color;
  
  
  public Axis(int belongsTo, String Name, int x1, int y1, int x2, int y2, color Color) {
    this.VizBelongsTo = belongsTo;
    this.Name = Name; 
    
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    
    this.Color = Color;
  }
  
  public int getHeight() {
    return (y2 - y1);
  }
  
  public int getWidth() {
    return (x2 - x1);
  }
  
  public void draw() {
    stroke(Color);
    line(x1, y1, x2, y2); 
  }
}










