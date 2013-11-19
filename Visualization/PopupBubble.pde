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
  
  private final int radius = 7;
  
  
  public PopupBubble(int side, int align, int x, int y, int rWidth, int rHeight, color Color) {
    this.side = side;
    this.align = align;
    this.xPos = x;
    this.yPos = y;
    this.rWidth = rWidth;
    this.rHeight = rHeight;
    
    this.backgroundColor = Color;
    
    calculateOtherValues();
  } 
  
  private void calculateOtherValues() {
    tX1 = xPos;
    tY1 = yPos;
    
    /*
    int triangleDividingLine_length;
    int triangleTotalBase_length;
    int triangleIndividualBase_length;
    
    int triangleCenterAlignment_distance;
    */
    
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
        
      }
    }
    else {
    
    }  
  }
  
  
  public void setBackgroundColor(color Color) {
    this.backgroundColor = Color; 
  }
  
  public void draw() {
    fill(backgroundColor);
    noStroke();
    triangle(tX1, tY1, tX2, tY2, tX3, tY3);
    rect(rX, rY, rWidth, rHeight, radius);
  }
  
}
