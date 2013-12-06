public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  
  private int rWidth, rHeight;
  
  private final int Legend_yPADDING_small = 4; //8;
  private final int Legend_yPADDING_big = 10; //8;
  private final int Legend_TEXTSIZE = 10;
  private final int Legend_xPADDING = 8; //5
  
  private int elementHeight;
  
  private int colorBoxWidth;
  private int colorBoxHeight;
  
  private ArrayList<LegendElement> elements;
  
  
  private final int RADIUS = 7;
  
  private final int NUM_ELEMENTS = 7;
  
  private final String[] collegeTEXT = {"College of Architecture", "College of Computing", "College of Engineering",
                                        "College of Ivan Allen", "College of Management", "College of Sciences", "All Colleges"};
  
  private final color[] colorBoxColors = {COLOR_ARCHITECTURE, COLOR_COMPUTING, COLOR_ENGINEERING, 
                                         COLOR_IVANALLEN, COLOR_MANAGEMENT, COLOR_SCIENCES, COLOR_ALL_COLLEGES };
    
    
  
  public Legend(int leftX, int rightX, int bottomLeftY) {
    this.bottomLeftY = bottomLeftY;
    
    calcLegendPosValues(leftX, rightX);
    
    elements = new ArrayList<LegendElement>();
    buildLegendElements();
  }

  
  private void calcLegendPosValues(int leftX, int rightX) {
    colorBoxHeight = Legend_TEXTSIZE;
    colorBoxWidth = ceil(1.5 * colorBoxHeight);
    
    int maxStringWidth = determineMaxStringPixelSize();
    
    elementHeight = Legend_TEXTSIZE + Legend_yPADDING_big - Legend_yPADDING_small;
    
    rWidth = (2 * Legend_xPADDING) + colorBoxWidth + Legend_xPADDING + maxStringWidth;
    //rHeight = (2 * Legend_yPADDING_big) + (NUM_ELEMENTS * Legend_TEXTSIZE) + ((NUM_ELEMENTS-1) * Legend_yPADDING_small);
    rHeight = (2 * Legend_yPADDING_big) + (NUM_ELEMENTS * elementHeight) + ((NUM_ELEMENTS-1) * Legend_yPADDING_small);
    
    int availSpace = rightX - leftX;
    
    if (rWidth < availSpace) {
      int availPadTotal = availSpace - rWidth;
      int dynamicPad = floor((float) availPadTotal / 2);
      rX = leftX + dynamicPad;
    }
    else {
      rX = leftX + 5;
    }

    rY = bottomLeftY - rHeight; 
    
  }
  
  public void buildLegendElements() {
    int relativeY = rY;
    int relativeX;
    
    int elementWidth = rWidth - Legend_xPADDING; //- (2 * Legend_xPADDING);
    //int elementHeight = Legend_TEXTSIZE;
    
    for (int i=0; i < NUM_ELEMENTS; i++) {
      if (i == 0) {
        relativeY += Legend_yPADDING_big;  
      }
      else {
        relativeY += Legend_yPADDING_small;
      }
      relativeX = rX + (Legend_xPADDING/2);
      
      LegendElement newElement = new LegendElement(relativeX, relativeY, elementWidth, elementHeight, colorBoxColors[i], collegeTEXT[i], 
                                                   i, Legend_xPADDING, Legend_yPADDING_big, Legend_yPADDING_small, Legend_TEXTSIZE); 
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
           // Do nothing becuase this LegendElement was clicked but is already the Currently-Selected-CollegeToDraw
         } 
       }
       else {
         //Do nothing because this LegendElement was not clicked
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
  
  public int biggerY;
  public int biggerHeight;
  
  public int colorBoxWidth;
  public int colorBoxHeight;
  
  public int legend_xPadding;
  public int legend_yPadding_big;
  public int legend_yPadding_small;
  public int legend_textSize;
  
  public color legendColor;
  public String legendText;
  public int legendId;
  
  public boolean hoveredOn;
  public boolean clickSelected;
  
  public final color buttonColor_unselected = color(200); //color(100); //color(64,55,80); //COLOR_LegendBackground;
  public final color buttonColor_hoveredOn = color(150); //color(125); //color(64,55,80); //COLOR_LegendBackground;
  public final color buttonColor_clickSelected = color(219,181,85); //color(255,255,153);
  
  
  
  public LegendElement(int xPos, int yPos, int elementWidth, int elementHeight, color legendColor, String legendText, int legendId,
                       int legend_xPadding, int legend_yPadding_big, int legend_yPadding_small, int legend_textSize) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
    this.legendColor = legendColor;
    this.legendText = legendText;
    this.legendId = legendId;
    
    this.legend_xPadding = legend_xPadding;
    this.legend_yPadding_big = legend_yPadding_big;
    this.legend_yPadding_small = legend_yPadding_small;
    this.legend_textSize = legend_textSize;
    
    biggerY = yPos;
    biggerHeight = elementHeight;
    //biggerY = yPos - (legend_yPadding / 2) + 1;
    //biggerHeight = elementHeight + legend_yPadding - 2;
    
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
    if  ( ((mouseX > xPos) && (mouseX < (xPos + elementWidth))) && ((mouseY > biggerY) && (mouseY < (yPos + biggerHeight))) ) {
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
      
      int centeredY = yPos + (legend_yPadding_big / 2) - (legend_yPadding_small / 2);
      
      if (clickSelected) {
        fill(buttonColor_clickSelected);
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        //rect(xPos, yPos, elementWidth, elementHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);          
      }
      else if (hoveredOn) {
        fill(buttonColor_hoveredOn);
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);        
      }
      else {
        fill(buttonColor_unselected, 125); //100
        noStroke();
        rect(xPos, biggerY, elementWidth, biggerHeight);
        
        //draw color rect
        fill(legendColor);
        noStroke();
        rect(relativeX, centeredY, colorBoxWidth, colorBoxHeight);
        relativeX += colorBoxWidth;
        
        //draw college name
        relativeX += legend_xPadding;
        textAlign(LEFT, TOP);
        fill(COLOR_LegendText);
        stroke(COLOR_LegendText);
        textSize(legend_textSize);
        text(legendText, relativeX, centeredY);  
      }
      
  }
}
