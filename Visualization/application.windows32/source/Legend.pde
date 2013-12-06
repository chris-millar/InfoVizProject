public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  private boolean hov;
  
  private int rX, rY;
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
  
  public int getPosX() {
    return rX;  
  }
  
  public int getWidth() {
    return rWidth;  
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
    
    isHov();
    
    if(hov){
      fill(150);
      rect(rX+rWidth-100, 5, 100, 25, RADIUS);
      
      fill(0, 140);
      
      //year bar
      triangle(vizOne_xAxis_x1-25+70+5, vizOne_xAxis_y1+25, vizOne_xAxis_x1-25+65+5, vizOne_xAxis_y1+30,vizOne_xAxis_x1-25+75+5, vizOne_xAxis_y1+30);
      rect(vizOne_xAxis_x1-25, vizOne_xAxis_y1+30, 150, 65, RADIUS);
      
      //viz1
      triangle(rX+(rWidth/2), rY-60+50+5, rX+(rWidth/2)-5, rY-60+50, rX+(rWidth/2)+5, rY-60+50);
      rect(rX, rY-60, rWidth, 50, RADIUS);
      
      //viz2
      triangle(rX-12+(rWidth/2), rY+170+50+5, rX-12+(rWidth/2)-5, rY+170+50, rX-12+(rWidth/2)+5, rY+170+50);
      rect(rX-12, rY+170, rWidth, 50, RADIUS);
      
      
      
      fill(255, 245);
      textSize(12);
      textAlign(CENTER);
      text("Click on any year bar to change the view in the viz below", vizOne_xAxis_x1-25+5, vizOne_xAxis_y1+35, 140, 65);
      
      text("Click on any college name to change the view", rX+4, rY-60+7, rWidth-5, 50);
      
      text("Select buttons below to change view to the left", rX-12+4, rY+170+7, rWidth-5, 50);
      
      
      
    }
    else{
      fill(220);
      rect(rX+rWidth-100, 5, 100, 25, RADIUS);
    }
    
    
    //rect(rX+rWidth-100, 10, 100, 25, RADIUS);
    fill(0);
    textSize(12);
    textAlign(CENTER);
    text("Directions", rX+rWidth-51, 22);
    
//    String directions = "Directions: To change the view you may select on any college name below.";
//    fill(0);
//    textSize(9);
//    textAlign(LEFT);
//    text(directions, rX, rY-50, 160, 100);
    
    for (LegendElement line : elements) {
      line.draw();  
    }
    
  }
  
    public void isHov()
  {
    if ( ((mouseX > rX+rWidth-100) && (mouseX < ((rX+rWidth-100) + 100)) ) && ((mouseY > 10) && (mouseY < (10 + 25))) ) {
      hov = true;
    }
    else {
      hov = false;
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
