public class TotalBar
{
  private int year;
  private int totalHeight;
  private int xPos;
  
  public TotalBar()
  {  
    super();
  }
  
  public TotalBar(int year, int xPos, int high)
  {  
    this.year = year;
    this.xPos = xPos;
    this.totalHeight = high;
    
    fill(TOTAL_BAR_COLOR);
    draw(xPos, GRID_1_HOR_Y - totalHeight, COLLEGE_BAR_THICKNESS, totalHeight);
  }
  
  public void draw(int x, int y, int wide, int high)
  {
    rect(x, y, wide, high);
  }
}

