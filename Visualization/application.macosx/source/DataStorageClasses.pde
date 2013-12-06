public class College {
  private String Name;
  
  private ArrayList<Major> top3Majors;
  
  private int Male;
  private int Female;
  
  private int White;
  private int Black;
  private int Hispanic;
  private int Asian;
  
  private int TotalCollege;
  
  public College(String name, ArrayList<Major> top3Majors, 
                    int Male, int Female, 
                    int White, int Black, int Hispanic, int Asian, 
                    int TotalCollege) {
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
  
  public String getName()
  {
    return Name;
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

/////////////////////////////////////////////////////////////////////////////////////////

public class Major 
{
 private String NameMajor;
 private int Enrollment;

 public Major(String name, int enrollment) 
 {
   this.NameMajor = name;
   this.Enrollment = enrollment;
 } 
 
 public String getName() {
   return NameMajor;
 }
 
 public int getEnrollment() {
    return Enrollment; 
 }
}
