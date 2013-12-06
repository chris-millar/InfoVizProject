//------------------------ BUILD METHODS -------------------------//
void buildVisualizationOne() {
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
    int posY = int(vizOne_xAxis_y1 - barHeight);
    collegeBar = new CollegeBar(college.getName(), xPos, posY, CollegeBar_WIDTH, (int) barHeight);
  }
  collegeBar.setCollegeEnrollment(college.getTotalCollege());
  collegeBar.setUniversityEnrollment(totalEnrollmentForYear);
  
  color barColor = determineCollegeBarColorFromName(college.getName());
  collegeBar.setColor_Unselected(barColor);
  
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


private void setVarInCurrSelectedYearBar(int curr) {
  yearBars.get(curr).setClickSelected(true); 
}


//------------------------ CHECK METHODS -------------------------//
void vizOneCheckMouseClicked() {
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

void checkVisualizationOne() {
   for (YearBar yearBar : yearBars) {
     yearBar.isHoveredOver();
     for (CollegeBar collegeBar : yearBar.getCollegeBars()) {
       collegeBar.isHoveredOver();
     } 
   }
   legend.checkElementsForHoveredOn();
}



//------------------------ DRAW METHODS -------------------------//
void drawVisualizationOne() {
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



