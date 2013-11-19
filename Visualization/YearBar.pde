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
  
  private color barColor_Unselected;
  private color barColor_ClickSelected;
  private color barColor_HoveredOn;
  
  private color labelColor_Unselected;
  
  private boolean hoveredOn;
  private boolean clickSelected;
  
  
  private final int radius = 7;
  private final int opacity_Unselected = 125;
  //private final int opacity_hoveredOn = (int) (opacity_normal + ((float) .25 * opacity_normal));
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
    //SELECTED Version
    if (clickSelected) {
      //Regular Bar Part
      fill(barColor_ClickSelected, opacity_ClickSelected);
      //stroke(#9E843E);
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
      //textSize(12);
      text(yearText, label_xPos, label_yPos, label_width, label_height);      
    }
    //HOVERED ON Version
    else if (hoveredOn) {
      /*
      color tempColor;
      if ((Year % 2) == 0) {
        tempColor = barColor_HoveredOn;
      }
      else {
        tempColor = barColor_ClickSelected;
      }
      */
      
      //Regular Bar Part
      fill(barColor_HoveredOn, opacity_HoveredOn);
      //stroke(#9E843E);
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
      //textSize(12);
      text(yearText, label_xPos, label_yPos, label_width, label_height);
    }
    //NORMAL Version
    else {
      //Regular Bar Part
      fill(barColor_Unselected, opacity_Unselected);
      //stroke(#9E843E);
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
      //textSize(12);
      text(yearText, label_xPos, label_yPos, label_width, label_height);
    }
  }
  
}
