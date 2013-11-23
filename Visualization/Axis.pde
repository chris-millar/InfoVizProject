public class Axis {
  int VizBelongsTo;
  String Name;
  
  int x1;
  int y1;
  int x2;
  int y2; 
  
  color Color;
  
  int weight;
  
  
  public Axis(int belongsTo, String Name, int x1, int y1, int x2, int y2, color Color) {
    this.VizBelongsTo = belongsTo;
    this.Name = Name; 
    
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    
    this.Color = Color;
    
    weight = 3;
  }
  
  public int getHeight() {
    return (y2 - y1);
  }
  
  public int getWidth() {
    return (x2 - x1);
  }
  
  public void draw() {
    stroke(Color);
    strokeWeight(weight);
    line(x1, y1, x2, y2);
    
    strokeWeight(1); 
  }
  
  public void setWeight(int w){
    weight = w;
  }
  
  public void setColor(color Color){
    this.Color = Color;
  }
  
  
}
