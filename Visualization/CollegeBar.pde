public class CollegeBar 
{
  private String Name;
  private int year;
  private color collegeColor; //I'm not sure what we're taking in for color (rgb or hex);
  private int percentSize;
  private int xPos, yPos;
  private int theHeight, theWidth;
  private ArrayList top3Majors;
  private int White, Black, Hispanic, Asian;
  private int Male, Female;
  private int TotalCollege;
  
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
    this.theWidth = theWidth;
    this.theHeight = theHeight;
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
  public boolean isHoveredOver()
  {
    if( (mouseX > xPos) && (mouseX < (xPos+theWidth)) )
    {
      if( (mouseY < yPos) && (mouseY > (yPos+theHeight)) )
        return true;
    }
    return false;
  }
  
  /*
  * Method that draws the rectangle; hard egdes for now
  */
  public void draw()
  {
    fill(collegeColor);
    rect(xPos, yPos, theWidth, theHeight);
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
    this.year = year;
  }
  
  public void setColor(int r, int g, int b)
  {
    collegeColor = color(r, g, b);
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
    this.theHeight = theHeight; 
  }
  
  public void setWidth(int theWidth)
  {
    this.theWidth = theWidth; 
  }
  
  public void setTop3Majors(ArrayList list)
  {
    if(list.size() > 3 || list.isEmpty())
      return;
    for(int x=0; x<3; x++)
    {
      list.remove(x);
      top3Majors.add(x);
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
    return year;
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
    return theHeight; 
  }
  
  public int getWidth()
  {
    return theWidth; 
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
