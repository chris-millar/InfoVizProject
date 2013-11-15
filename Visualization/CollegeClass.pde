public class College 
{
  private String name;
  private int year;
  private color collegeColor; //I'm not sure what we're taking in for color (rgb or hex);
  private int percentSize;
  private int xPos, yPos;
  private int height, width;
  private ArrayList top3Majors;
  private int whiteMale, whiteFemale, asianMale, asianFemale, 
              blackMale, blackFemale, hispanicMale, hispanicFemale;
  private int totalMale, totalFemale;
  
  public College()
  {
    super();
  }
  
  //parameters can be changed based on needs later
  public College(String name, int xPos, int yPos, int width, int height)
  {
    this.name = name;
    this.xPos = xPos;
    this.yPos = yPos;
    this.width = width;
    this.height = height;
  }
  
  /*
  * Method that checks whether or not the chunk is hovered over
  * @param mouseX, mouseY - the cursor's value
  * @return - true if the cursor collides with the chunk, else false
  */
  public boolean isHoveredOver(int mouseX, int mouseY)
  {
    if( (mouseX > xPos) && (mouseX < (xPos+width)) )
    {
      if( (mouseY < yPos) && (mouseY > (yPos+height)) )
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
    rect(xPos, yPos, width, height);
  }
  
  /*
  * Setters
  */
  public void setName(String name)
  {
    this.name = name;
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
  
  public void setHeight(int height)
  {
    this.height = height; 
  }
  
  public void setWidth(int width)
  {
    this.width = width; 
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
  
  public void setWhiteMale(int whiteMale)
  {
    this.whiteMale = whiteMale;
  }
  
  public void setWhiteFemale(int whiteFemale)
  {
    this.whiteFemale = whiteFemale;
  }
  
  public void setAsianMale(int asianMale)
  {
    this.asianMale = asianMale;
  }
  
  public void setAsianFemale(int asianFemale)
  {
    this.asianFemale = asianFemale;
  }
  
  public void setBlackMale(int blackMale)
  {
    this.blackMale = blackMale;
  }
  
  public void setBlackFemale(int blackFemale)
  {
    this.blackFemale = blackFemale;
  }

  public void setHispanicMale(int hispanicMale)
  {
    this.hispanicMale = hispanicMale;
  }
  
  public void setHispanicFemale(int hispanicFemale)
  {
    this.hispanicFemale = hispanicFemale;
  }
  
  public void setTotalMale(int totalMale)
  {
    this.totalMale = totalMale;
  }
  
  public void setTotalFemale(int totalFemale)
  {
    this.totalFemale = totalFemale;
  }
  
  /*
  * Getters
  */
   public String getName()
  {
    return name;
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
    return height; 
  }
  
  public int getWidth()
  {
    return width; 
  }
  
  public ArrayList setTop3Majors()
  {
    return top3Majors;
  }
  
  public int getWhiteMale()
  {
    return whiteMale;
  }
  
  public int getWhiteFemale()
  {
    return whiteFemale;
  }
  
  public int getAsianMale()
  {
    return asianMale;
  }
  
  public int getAsianFemale()
  {
    return asianFemale;
  }
  
  public int getBlackMale()
  {
    return blackMale;
  }
  
  public int getBlackFemale()
  {
    return blackFemale;
  }

  public int getHispanicMale()
  {
    return hispanicMale;
  }
  
  public int getHispanicFemale()
  {
    return hispanicFemale;
  }
  
  public int getTotalMale()
  {
    return totalMale;
  }
  
  public int setTotalFemale()
  {
    return totalFemale;
  }
}
