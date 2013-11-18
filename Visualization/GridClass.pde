public class Grid
{
  private int vertX, vertY, vertWidth, vertHeight, horX, horY, horWidth, horHeight;
  
  public Grid()
  {
    super();
  }
  
  public Grid(int vertX, int vertY, int vertWidth, int vertHeight, int horX, int horY, int horWidth, int horHeight)
  {
    this.vertX = vertX;
    this.vertY = vertY;
    this.vertWidth = vertWidth;
    this.vertHeight = vertHeight;
    this.horX = horX;
    this.horY = horY;
    this.horWidth = horWidth;
    this.horHeight = horHeight;
    
    draw(vertX, vertY, vertWidth, vertHeight, horX, horY, horWidth, horHeight);
  }
  
  private void draw(int vertX, int vertY, int vertWidth, int vertHeight, int horX, int horY, int horWidth, int horHeight)
  {
    fill(GRID_COLOR);
    noStroke();
    rect(vertX, vertY, vertWidth, vertHeight);
    rect(horX, horY, horWidth, horHeight);
  }
}
