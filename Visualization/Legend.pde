public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  
  private int rWidth, rHeight;
  
  private final int Legend_yPADDING = 8;
  private final int Legend_TEXTSIZE = 10;
  private final int Legend_xPADDING = 8; //5
  
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
    this.bottomLeftY = bottomLeftY;
    
    calcLegendPosValues(leftX, rightX);
    
    elements = new ArrayList<LegendElement>();
    buildLegendElements();
  }

  //int bottomLeftX, int bottomLeftY

  
  private void calcLegendPosValues(int leftX, int rightX) {
    colorBoxHeight = Legend_TEXTSIZE;
    colorBoxWidth = ceil(1.5 * colorBoxHeight);
    
    int maxStringWidth = determineMaxStringPixelSize();
    
    rWidth = (2 * Legend_xPADDING) + colorBoxWidth + Legend_xPADDING + maxStringWidth;
    rHeight = (2 * Legend_yPADDING) + (NUM_ELEMENTS * Legend_TEXTSIZE) + ((NUM_ELEMENTS-1) * Legend_yPADDING);
    
    int availSpace = rightX - leftX;
    
    if (rWidth < availSpace) {
      int availPadTotal = availSpace - rWidth;
      int dynamicPad = floor((float) availPadTotal / 2);
      rX = leftX + dynamicPad;
    }
    else {
      rX = leftX + 5;
      //rX = leftX ;
    }

    rY = bottomLeftY - rHeight; 
    //rY = bottomLeftY - rHeight - 75; 
    
  }
  
  public void buildLegendElements() {
    int relativeY = rY;
    int relativeX;
    
    int elementWidth = rWidth - Legend_xPADDING; //- (2 * Legend_xPADDING);
    int elementHeight = Legend_TEXTSIZE;
    
    for (int i=0; i < NUM_ELEMENTS; i++) {
      relativeY += Legend_yPADDING;
      relativeX = rX + (Legend_xPADDING/2);
      
      LegendElement newElement = new LegendElement(relativeX, relativeY, elementWidth, elementHeight, colorBoxColors[i], collegeTEXT[i], 
                                                   i, Legend_xPADDING, Legend_yPADDING, Legend_TEXTSIZE); 
      elements.add(newElement);
      
      relativeY += elementHeight;
    }    
  }
  
  
  public void draw() {
    fill(COLOR_LegendBackground);
    noStroke();
    rect(rX, rY, rWidth, rHeight, RADIUS);
    
    for (LegendElement line : elements) {
      line.draw();  
    }
    
  }
  
  public void checkElementsForHoveredOn() {
    for (LegendElement line : elements) {
      line.checkHoveredOn();
    }  
  }
  
  public void checkMouseClicked() {
    for (LegendElement collegeLine : elements) {
       boolean wasClicked = collegeLine.isMouseInsideBounds();
       if (wasClicked) {
         int collegeIdSelected = collegeLine.getLegendId();
         if (collegeIdSelected != colToDraw) {
           int oldCollegeIdSelected = colToDraw;
           
           collegeLine.setClickSelected(true);
           elements.get(oldCollegeIdSelected).setClickSelected(false);
           
           colToDraw = collegeIdSelected;
           Event_VizOneCollegeToDrawChange = true;
         } 
         else {
           // Do nothing becuase this YearBar was clicked but is already the Currently-Selected-Year
         } 
       }
       else {
         //Do nothing because this YearBar was not clicked
       }
    }  
  }
  
  
  private int determineMaxStringPixelSize() {
    int max = 0;
    int curr;

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
  
  public int colorBoxWidth;
  public int colorBoxHeight;
  
  public int legend_xPadding;
  public int legend_yPadding;
  public int legend_textSize;
  
  public color legendColor;
  public String legendText;
  public int legendId;
  
  public boolean hoveredOn;
  public boolean clickSelected;
  
  public final color buttonColor_unselected = color(64,55,80); //COLOR_LegendBackground;
  public final color buttonColor_hoveredOn = color(64,55,80); //COLOR_LegendBackground;
  public final color buttonColor_clickSelected = color(255,255,153);
  
  
  
  public LegendElement(int xPos, int yPos, int elementWidth, int elementHeight, color legendColor, String legendText, int legendId,
                       int legend_xPadding, int legend_yPadding, int legend_textSize) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
    this.legendColor = legendColor;
    this.legendText = legendText;
    this.legendId = legendId;
    
    this.legend_xPadding = legend_xPadding;
    this.legend_yPadding = legend_yPadding;
    this.legend_textSize = legend_textSize;
    
    colorBoxHeight = legend_textSize;
    colorBoxWidth = ceil(1.5 * colorBoxHeight);
    
    hoveredOn = false;
    if (legendId == colToDraw) {
      clickSelected = true;    
    }
    else {
      clickSelected = false;
    }
  }

  public int getLegendId() {
    return legendId;
  }  
  
  
  public void setHoveredOn(boolean val) {
    hoveredOn = val; 
  }
  
  public void setClickSelected(boolean val) {
    clickSelected = val;  
  }
  
  public boolean isMouseInsideBounds() {
    if  ( ((mouseX > xPos) && (mouseX < (xPos + elementWidth))) && ((mouseY > yPos) && (mouseY < (yPos + elementHeight))) ) {
      return true;
    }
    else {
      return false;
    }
  }
  
  public void checkHoveredOn() {
    if (isMouseInsideBounds()) {
      hoveredOn = true;
    }
    else {
      hoveredOn = false;
    }     
  }
  
  
  public void draw() {
      int relativeX = xPos + legend_xPadding/2;
      
      //println("Legend Element: \t" + 
      
      if (clickSelected) {
        fill(buttonColor_clickSelected);
        noStroke();
        rect(xPos, yPos, elementWidth, elementHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, yPos, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, yPos);          
      }
      else if (hoveredOn) {
        fill(buttonColor_hoveredOn);
        noStroke();
        rect(xPos, yPos, elementWidth, elementHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, yPos, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, yPos);        
      }
      else {
        fill(buttonColor_unselected, 100);
        noStroke();
        rect(xPos, yPos, elementWidth, elementHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, yPos, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, yPos);  
      }
      
  }
}
