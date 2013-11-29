public class CollegeBar 
{
  private String Name;
  private int Year;
  
  private int TotalCollege;
  private int TotalUniversity;
  private int percentSize;
  
  private int xPos, yPos;
  private int bar_width, bar_height;
  
  private ArrayList<Major> top3Majors;
  private int White, Black, Hispanic, Asian;
  private int Male, Female;
  
  private color barColor_Unselected;
  //private color barColor_Selected;
  private color barColor_HoveredOn;
  
  private boolean hoveredOn;
  
  private PopupBubble popup;
  
  private final int opacity_HoveredOn = 255;
  private final int opacity_Unselected = 170;
  
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
    this.bar_width = theWidth;
    this.bar_height = theHeight;
    
    this.hoveredOn = false;
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
  public void isHoveredOver()
  {
    if ( ((mouseX > xPos) && (mouseX < (xPos + bar_width)) ) && ((mouseY > yPos) && (mouseY < (yPos + bar_height))) ) {
      hoveredOn = true;
      CurrSelectedCollege = Name;
    }
    else {
      if (hoveredOn == true && CurrSelectedCollege != null && CurrSelectedCollege.equals(Name)) {
        CurrSelectedCollege = null; 
      }
      hoveredOn = false;
    }

  }
  
  /*
  * Method that draws the rectangle; hard egdes for now
  */
  public void draw()
  {
    if (hoveredOn) {
      fill(barColor_HoveredOn, opacity_HoveredOn);
      //noStroke();
      stroke(255);
      //stroke(barColor_HoveredOn, opacity_Unselected);
      rect(xPos, yPos, bar_width, bar_height);
      
      //buildPopupBubble();
      //popup.draw();
    }
    else {
      fill(barColor_Unselected, opacity_Unselected);
      //noStroke();
      stroke(255);
      strokeWeight(1.2);
      rect(xPos, yPos, bar_width, bar_height);
    }
  }
  
  private void buildPopupBubble() {
    String[] content = new String[12];
    content[0] = "College of";
    content[1] = Name;
    content[2] = "--";
    content[3] = "";
    content[4] = "College Enrollment";
    content[5] = new Integer(TotalCollege).toString();
    content[6] = "";
    content[7] = "-";
    content[8] = "";
    content[9] = "Percent of";
    content[10] = "University Enrollment";
    content[11] = new Integer(percentSize).toString() + " %";
    
    
    float[] contentSize = new float[12];
    contentSize[0] = textWidth(content[0]);
    contentSize[1] = textWidth(content[1]);
    
    contentSize[2] = 0; //maxSize - 2;
    
    contentSize[3] = 0;
    contentSize[4] = textWidth(content[4]);
    contentSize[5] = textWidth(content[5]);
    contentSize[6] = 0;
    
    contentSize[7] = 0; //maxSize - 2;
    
    contentSize[8] = 0;
    contentSize[9] = textWidth(content[9]);
    contentSize[10] = textWidth(content[10]);
    contentSize[11] = textWidth(content[11]);
    
    float maxSize = 1;
    for (int i=0; i < 12; i++) {
       float currSize = contentSize[i];
       if (currSize > maxSize) {
         maxSize = currSize; 
       }
    }
    
    contentSize[2] = maxSize - 2;
    contentSize[7] = maxSize - 2;
    
    
    ///////////////////////////////////////////
    
    int bubWidth = ceil(maxSize) + 2 * POPUP_EDGE_PADDING;
    int bubHeight = content.length * POPUP_VERTICAL_SPACING + 2 * POPUP_EDGE_PADDING;
    
    popup = new PopupBubble(0, 0, mouseX, mouseY, bubWidth, bubHeight, COLOR_PopupBubble);
    popup.setContent(content);
    
  }
  
  public void drawDetailsOnDemandIfNeeded() {
    if (hoveredOn) {
      buildPopupBubble();
      popup.draw(1);
    }  
  }
  
  public void setCollegeEnrollment(int enrollment) {
     this.TotalCollege = enrollment;
  }
  
  public void setUniversityEnrollment(int enrollment) {
    this.TotalUniversity = enrollment;
    this.percentSize = round(((float)TotalCollege / TotalUniversity) * 100);
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
    this.Year = year;
  }
  
  public void setColor(int r, int g, int b)
  {
    barColor_Unselected = color(r, g, b);
  }
  
  public void setColor_Unselected(color Color) {
     barColor_Unselected = Color;
     barColor_HoveredOn = Color;
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
    this.bar_height = theHeight; 
  }
  
  public void setWidth(int theWidth)
  {
    this.bar_width = theWidth; 
  }
  
  public void setTop3Majors(ArrayList<Major> list)
  {
    if(list.size() > 3 || list.isEmpty())
      return;
    for(int x=0; x<3; x++)
    {
      list.remove(x);
      top3Majors.add(list.get(x));
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
    return Year;
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
    return bar_height; 
  }
  
  public int getWidth()
  {
    return bar_width; 
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
