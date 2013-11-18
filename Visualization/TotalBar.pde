public class TotalBar
{
  private int year;
  private int total;
  private int xPos;
  private int yPos;
  
  public TotalBar()
  {  
    super();
  }
  
  public TotalBar(int year, int xPos, int high)
  {  
    this.year = year;
    this.xPos = xPos;
    this.total = high;
    this.yPos = GRID_1_HOR_Y - total;
    
    fill(TOTAL_BAR_COLOR);
    draw(xPos, yPos, COLLEGE_BAR_THICKNESS, total);
  }
  
  public int getTotal()
  {
    return total;
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
      if( (mouseY > yPos ) && (mouseY < (yPos + total)) )
        return true;
    }
    return false;
  }
}

