public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  
  private int rWidth, rHeight;
  
  private final int Legend_PADDING = 8;
  private final int Legend_TEXTSIZE = 10;
  
  private int colorBoxWidth;
  private int colorBoxHeight;
  
  private ArrayList<LegendElement> elements;
  
  
  private final int RADIUS = 7;
  
  /*
  private final String text_ARCHITECTURE = "College of Architecture";
  private final String text_COMPUTING = "College of Computing";
  private final String text_ENGINEERING = "College of Engineering";
  private final String text_IVANALLEN = "College of Ivan Allen";
  private final String text_MANAGMENT = "College of Managment";
  private final String text_SCIENCES = "College of Sciences";
  */
  
  private final int NUM_ELEMENTS = 7;
  
  private final String[] collegeTEXT = {"College of Architecture", "College of Computing", "College of Engineering",
                                        "College of Ivan Allen", "College of Managment", "College of Sciences", "All Colleges"};
  
  private final color[] colorBoxColors = {COLOR_ARCHITECTURE, COLOR_COMPUTING, COLOR_ENGINEERING, 
                                         COLOR_IVANALLEN, COLOR_MANAGEMENT, COLOR_SCIENCES, COLOR_ALL_COLLEGES };
    
    
  
  public Legend(int leftX, int rightX, int bottomLeftY) {
    //this.bottomLeftX = bottomLeftX;
    this.bottomLeftY = bottomLeftY;
    
    calcLegendPosValues(leftX, rightX);
    
    elements = new ArrayList<LegendElements>();
    buildLegendElements();
  }

  //int bottomLeftX, int bottomLeftY

  
  private void calcLegendPosValues(int leftX, int rightX) {
    colorBoxHeight = Legend_TEXTSIZE;
    colorBoxWidth = ceil(1.5 * colorBoxHeight);
    
    int maxStringWidth = determineMaxStringPixelSize();
    
    rWidth = (2 * Legend_PADDING) + colorBoxWidth + Legend_PADDING + maxStringWidth;
    rHeight = (2 * Legend_PADDING) + (6 * Legend_TEXTSIZE) + (5 * Legend_PADDING);
    
    int availSpace = rightX - leftX;
    
    if (rWidth < availSpace) {
      int availPadTotal = availSpace - rWidth;
      int dynamicPad = floor((float) availPadTotal / 2);
      rX = leftX + dynamicPad;
    }
    else {
      rX = leftX ;
    }
    //rX = bottomLeftX;
    rY = bottomLeftY - rHeight - 75; 
    
    
    
      //rY = bottomLeftY;
   
   
   //start here
    
  }
  
  public void buildLegendElements() {
    int relativeY = rY;
    int relativeX;
    for (int i=0; i < NUM_ELEMENTS; i++) {
      relativeY += Legend_PADDING;
      relativeX = rX + Legend_PADDING + 15;
      
      LegendElement newElement = new LegendElement(relativeX, relativeY, 
      elements.Add(newElement);
    }    
  }
  
  
  public void draw() {
    fill(COLOR_LegendBackground);
    noStroke();
    rect(rX-2, rY, rWidth+10, rHeight+50, RADIUS);
    
    int relativeY = rY;
    int relativeX;
    for (int i=0; i < NUM_ELEMENTS; i++) {
      relativeY += Legend_PADDING;
      relativeX = rX + Legend_PADDING + 15;
      
      //draw color rect
      fill(colorBoxColors[i]);
      noStroke();
      rect(relativeX+105, relativeY, colorBoxWidth+8, colorBoxHeight);
      relativeX += colorBoxWidth;
      
      //draw college name
      relativeX += Legend_PADDING;
      textAlign(LEFT, TOP);
      fill(COLOR_LegendText);
      stroke(COLOR_LegendText);
      textSize(Legend_TEXTSIZE);
      text(collegeTEXT[i], relativeX, relativeY);
      
      
      
      relativeY += Legend_TEXTSIZE + 5;
    }
  }
  
  
  private int determineMaxStringPixelSize() {
    int max = 0;
    //int[] curr = new int[6];
    int curr;
    
    /*
    curr[0] = ceil(textWidth(text_ARCHITECTURE));
    curr[1] = ceil(textWidth(text_COMPUTING));
    curr[2] = ceil(textWidth(text_ENGINEERING));
    curr[3] = ceil(textWidth(text_IVANALLEN));
    curr[4] = ceil(textWidth(text_MANAGMENT));
    curr[5] = ceil(textWidth(text_SCIENCES));
    */
    
    for (int i=0; i < 6; i++) {
      textSize(Legend_TEXTSIZE);
      curr = ceil(textWidth(collegeTEXT[i]));
      if (curr > max) {
        max = curr; 
      }
    }
    
    return max;
  }
}

public class LegendElement {
  public int xPos, yPos;
  public int elementWidth, elementHeight;
  
  public color legendColor;
  public String legendText;
  public int legendID;
  
  public boolean hoveredOn;
  public boolean clickSelected;
  
  public final color buttonColor_unselected;
  public final color buttonColor_hoveredOn;
  public final color buttonColor_clickSelected;
  
  
  
  public LegendElement(int xPos, int yPos, int elementWidth, int elementHeight, color legendColor, String legendText, int legendID) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
    this.legendColor = legendColor;
    this.legendText = legendText;
    this.legendID = legendID;
    
    hoveredOn = false;
    clickSelected = false;
  }  
  
  
  public void setHoveredOn(boolean val) {
    hoveredOn = val; 
  }
  
  public void setClickSelected(boolean val) {
    clickSelected = val;  
  }
  
  
  public void draw() {
    
  }
}
