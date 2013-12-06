public class PopupBubble {
  private int side;
  private int align;
  private int xPos;
  private int yPos;
  private int rWidth;
  private int rHeight;
  
  private int tX1, tY1, tX2, tY2, tX3, tY3;
  private int rX, rY;
  
  private color backgroundColor;
  
  private String[] content;
  
  private final int radius = 7;
  private final int padding = POPUP_EDGE_PADDING;
  private final int textHeight = POPUP_VERTICAL_SPACING;
  
  
  public PopupBubble(int side, int align, int x, int y, int rWidth, int rHeight, color Color) {
    this.side = side;
    this.align = align;
    this.xPos = x;
    this.yPos = y;
    this.rWidth = rWidth;
    this.rHeight = rHeight;
    
    this.backgroundColor = Color;
    
    content = new String[1];
    content[0] = null;
    
    calculateOtherValues();
  } 
  
  
  private void calculateOtherValues() {
    tX1 = xPos;
    tY1 = yPos;
    
    //Triangle on side=LEFT
    if (true) {  //side == 0
      //Triangle align=CENTER 
      if (true) {  //align == 0
        int triangleDividingLine_length = ceil((float) .2 * rWidth);
        int triangleTotalBase_length = ceil((float) .25 * rHeight);
        int triangleIndividualBase_length = ceil((float) .5 * triangleTotalBase_length);
        
        int triangleCenterAlignment_distance = ceil((float) .5 * rHeight);
        
        tX2 = tX1 + triangleDividingLine_length;
        tY2 = tY1 - triangleIndividualBase_length;
        
        tX3 = tX1 + triangleDividingLine_length;
        tY3 = tY1 + triangleIndividualBase_length;
        
        rX = tX1 + triangleDividingLine_length;
        rY = tY1 - triangleCenterAlignment_distance;
      }
      else {
        //Intentionally left blank
      }
    }
    else {
      //Intentionally left blank
    }  
  }
  
  
  public void setBackgroundColor(color Color) {
    this.backgroundColor = Color; 
  }
  
  public void setContent(String[] newContent) {
    this.content = new String[newContent.length];
    
    for (int i=0; i < newContent.length; i++) {
      content[i] = newContent[i];
    } 
    
  }
  
  
  public void draw(int vizId) {
    if (vizId == 1) {
      fill(backgroundColor, 230);
      noStroke();
      triangle(tX1, tY1, tX2, tY2, tX3, tY3);
      rect(rX, rY, rWidth, rHeight, radius);
      
      if ((content.length >= 1) && (content[0] != null)) {
        drawContents();
      }

    }
    else if (vizId == 2) {
      fill(backgroundColor);
      noStroke();
      triangle(tX1, tY1, tX2, tY2, tX3, tY3);
      rect(rX, rY, rWidth, rHeight, radius);         
    }
    else {
      //do nothing
    }
  }
  
  private void drawContents() {
      int baseY = rY + padding;
      int baseX = rX;
      
      int currY = baseY;
      int currX = baseX;
      
      for (int i=0; i < content.length; i++) {
        if (content[i].equals("")) {
          fill(COLOR_DoDText);
          textAlign(TOP);
          textSize(textHeight);
          text(" ", baseX, currY);
          currY += textHeight;
        }
        else if (content[i].equals("--")) {
          stroke(COLOR_DoDText);
          line(baseX + padding, currY + (textHeight / 2), baseX + (rWidth - padding), currY + (textHeight / 2));
          currY += textHeight;           
        }
        else if (content[i].equals("-")) {
          stroke(COLOR_DoDText);
          line(baseX +  2 * padding, currY + (textHeight / 2), baseX + (rWidth - 2 * padding), currY + (textHeight / 2));
          currY += textHeight;
        }
        else {
          fill(COLOR_DoDText);
          textAlign(CENTER, TOP);
          textSize(textHeight);
          
          int centeringX = baseX + ceil((float)rWidth / 2);
          
          text(content[i], centeringX, currY);
          currY += textHeight;
        }
      }
  }
  
}
