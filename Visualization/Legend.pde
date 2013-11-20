public class Legend {
  private int bottomLeftX;
  private int bottomLeftY;
  
  private int rX, rY;
  private int rWidth, rHeight;
  
  private final int Legend_PADDING = 8;
  private final int Legend_TEXTSIZE = 10;
  
  private int colorBoxWidth;
  private int colorBoxHeight;
  
  
  private final int RADIUS = 7;
  
  /*
  private final String text_ARCHITECTURE = "College of Architecture";
  private final String text_COMPUTING = "College of Computing";
  private final String text_ENGINEERING = "College of Engineering";
  private final String text_IVANALLEN = "College of Ivan Allen";
  private final String text_MANAGMENT = "College of Managment";
  private final String text_SCIENCES = "College of Sciences";
  */
  
  private final int NUM_ELEMENTS = 6;
  
  private final String[] collegeTEXT = {"College of Architecture", "College of Computing", "College of Engineering",
                                        "College of Ivan Allen", "College of Managment", "College of Sciences"};
  
  private final color[] colorBoxColors = {COLOR_ARCHITECTURE, COLOR_COMPUTING, COLOR_ENGINEERING, 
                                         COLOR_IVANALLEN, COLOR_MANAGEMENT, COLOR_SCIENCES };
    
    
  
  public Legend(int bottomLeftX, int bottomLeftY) {
    this.bottomLeftX = bottomLeftX;
    this.bottomLeftY = bottomLeftY;
    
    buildLegend();
  }  
  
  private void buildLegend() {
    colorBoxHeight = Legend_TEXTSIZE;
    colorBoxWidth = ceil(1.5 * colorBoxHeight);
    
    int maxStringWidth = determineMaxStringPixelSize();
    
    rWidth = (2 * Legend_PADDING) + colorBoxWidth + Legend_PADDING + maxStringWidth;
    rHeight = (2 * Legend_PADDING) + (6 * Legend_TEXTSIZE) + (5 * Legend_PADDING);
    
    rX = bottomLeftX;
    rY = bottomLeftY - rHeight; 
    //rY = bottomLeftY;
   
   
   //start here
    
  }
  
  
  public void draw() {
    fill(COLOR_LegendBackground);
    noStroke();
    rect(rX, rY, rWidth, rHeight, RADIUS);
    
    int relativeY = rY;
    int relativeX;
    for (int i=0; i < NUM_ELEMENTS; i++) {
      relativeY += Legend_PADDING;
      relativeX = rX + Legend_PADDING;
      
      //draw color rect
      fill(colorBoxColors[i]);
      noStroke();
      rect(relativeX, relativeY, colorBoxWidth, colorBoxHeight);
      relativeX += colorBoxWidth;
      
      //draw college name
      relativeX += Legend_PADDING;
      textAlign(LEFT, TOP);
      fill(COLOR_LegendText);
      stroke(COLOR_LegendText);
      textSize(Legend_TEXTSIZE);
      text(collegeTEXT[i], relativeX, relativeY);
      
      relativeY += Legend_TEXTSIZE;
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
