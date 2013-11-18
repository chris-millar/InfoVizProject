public class TotalBar
{
  private int year;
  private int totalStudents;
  private int xPos;
  private int yPos;
  private int totalHeight;
  
  public TotalBar()
  {  
    super();
  }
  
  public TotalBar(int year, int xPos, int totalHeight, int totalCollege)
  {  
    this.year = year;
    this.xPos = xPos;
    this.totalHeight = totalHeight;
    this.yPos = GRID_1_HOR_Y - totalHeight;
    this.totalStudents = totalCollege;
        
    fill(TOTAL_BAR_COLOR);
    draw(xPos, yPos, COLLEGE_BAR_THICKNESS, totalHeight);
  }
  
  public int getYear()
  {
    return year;
  }
  
  public int getTotalStudents()
  {
    return totalStudents;
  }
  
  public void draw(int x, int y, int wide, int high)
  {
    noStroke();
    rect(x, y, wide, high);
  }
  
  public Boolean isHoveredOver()
  {
    if( (mouseX > xPos) && (mouseX < (xPos + COLLEGE_BAR_THICKNESS)) )
    {
      if( (mouseY > yPos ) && (mouseY < (yPos + totalHeight)) )
        return true;
    }
    return false;
  }
}

