public class YearBar {
  private int Year;
  private int TotalEnrollment;
  
  private ArrayList<CollegeBar> CollegeBars;
 
  private int xPos, yPos;
  private int bar_width, bar_height;
  
  private color barColor_Unselected;
  private color barColor_Selected;
  private color barColor_HoveredOn;
  
  private final int radius = 7;
  
  public YearBar(int year, int totalEnrollment, int x, int y, int bar_width, int bar_height, ArrayList<CollegeBar> collegeBars) {
    this.Year = year;
    this.TotalEnrollment = totalEnrollment;
    
    this.xPos = x;
    this.yPos = y;
    this.bar_width = bar_width;
    this.bar_height = bar_height;
   
    this.CollegeBars = collegeBars; 
  }
  
  public void setColor(color Color) {
    this.barColor_Unselected = Color; 
  }
  
  public ArrayList<CollegeBar> getCollegeBars() {
    return CollegeBars; 
  }
  
  public void draw() {
    fill(barColor_Unselected, 100);
    //stroke(#9E843E);
    noStroke();
    rect(xPos, yPos, bar_width, bar_height, radius); 
  }
}
