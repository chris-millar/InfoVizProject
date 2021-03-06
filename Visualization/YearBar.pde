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
  
  private color barColor_Unselected;
  private color barColor_ClickSelected;
  private color barColor_HoveredOn;
  
  private color labelColor_Unselected;
  
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
  
  public void setBarColor_Unselected(color Color) {
    this.barColor_Unselected = Color; 
  }
  
  public void setBarColor_HoveredOn(color Color) {
    this.barColor_HoveredOn = Color; 
  }
  
  public void setBarColor_ClickSelected(color Color) {
    this.barColor_ClickSelected = Color; 
  }  
  
  public void setLabelColor(color Color) {
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
