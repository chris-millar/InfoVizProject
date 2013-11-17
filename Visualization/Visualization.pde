//*************** Global Variables *******************//
/* 2D ArrayList. Top outerlist holds 15 arraylist each representing a single year.
   innerlist holds 10 MajorEntry objects, each holding the data from 1 line (out of 10)
   from a year file (each line represents one of the top-ten majors for that year and its
   associated data). */
/* 1999 --> {1stMajorEntry_1999, 2ndMajorEntry_1999, 3rdMajorEntry_1999, 4thMajorEntry_1999, ... 10thMajorEntry_1999}
   2000 --> {1stMajorEntry_2000, 2ndMajorEntry_2000, 3rdMajorEntry_2000, 4thMajorEntry_2000, ... }
   ...
   ...
   2013 --> {1stMajorEntry_2013, 2ndMajorEntry_2013, 3rdMajorEntry_2013, 4thMajorEntry_2013, ... 10thMajorEntry_2013} */
ArrayList<ArrayList<College>> Years;
final int NumYears = 6;
//*************** Global Variables *******************//


////////////// Init Methods //////////////////
void setup() {
  initGlobals();
  loadData();
  test_Data();
}

void initGlobals() {
  Years = new ArrayList<ArrayList<College>>();
}



///////////////// Processing Drawing /////////////////////
void draw() {
  
}



////////////////// Data Manipulation ///////////////////
void loadData() {
  int iYear = 1999;
  for (int i=0; i < NumYears; i++) {
    String[] lines = loadStrings("data/" + iYear + ".csv"); //splits the ith year file into its 11 lines (as String arrays)
    
    ArrayList<College> collegesInYear = new ArrayList<College>(); //holds the top ten major-entries in the ith year
    for (int j=1; j < lines.length; j++) {
      String[] lineVals = split(lines[j], ',');  //splits apart the jth line (1-10, major data entry)
      
      ArrayList<Major> top3Majors = new ArrayList<Major>();
      
      Major FirstMajor = new Major(lineVals[1], Integer.parseInt(lineVals[2]));
      top3Majors.add(FirstMajor);
      
      Major SecondMajor;
      if (!lineVals[3].equals("null")) {
        SecondMajor = new Major(lineVals[3], Integer.parseInt(lineVals[4]));
      }
      else {
        SecondMajor = null; 
      }
      top3Majors.add(SecondMajor);
      
      
      Major ThirdMajor;
      if (!lineVals[5].equals("null")) {
        ThirdMajor = new Major(lineVals[5], Integer.parseInt(lineVals[6]));
      }
      else {
        ThirdMajor = null; 
      }
      top3Majors.add(ThirdMajor);
      
      
      
      College entry = new College(lineVals[0], top3Majors,
                                        Integer.parseInt(lineVals[7]), Integer.parseInt(lineVals[8]), 
                                        Integer.parseInt(lineVals[9]), Integer.parseInt(lineVals[10]), Integer.parseInt(lineVals[11]),Integer.parseInt(lineVals[12]), 
                                        Integer.parseInt(lineVals[13]));
      collegesInYear.add(entry);
    }
    
    Years.add(collegesInYear);
    iYear++;
  }
}




/////////////// Class Definitions ////////////////////
/*
class College {
  public String Name;
  
  public ArrayList<Major> top3Majors;
  
  public int Male;
  public int Female;
  
  public int White;
  public int Black;
  public int Hispanic;
  public int Asian;
  
  public int TotalCollege;
  
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
  
}


public class Major {
 public String Name;
 public int Enrollment;

 public Major(String name, int enrollment) {
   this.Name = name;
   this.Enrollment = enrollment;
 } 
}
*/


//------------------------------ TEST METHODS ----------------------------------//


public void test_Data() {
 System.out.println("TESTING DATA INPUT");
 
 int yearNum = 1999;
 
 for (int i=0; i < Years.size(); i++) {
   System.out.println("Year: " + yearNum);
   System.out.println("-------------------"); 
   
   for (int j=0; j < Years.get(i).size(); j++) {
      System.out.println("College: " + Years.get(i).get(j).Name + "\t" + Years.get(i).get(j).TotalCollege); 
      
      System.out.println("\tMale: \t" + Years.get(i).get(j).Male);
      System.out.println("\tFemale: \t" + Years.get(i).get(j).Female);
      
      System.out.println("");
      
      System.out.println("\tWhite: \t" + Years.get(i).get(j).White);
      System.out.println("\tBlack: \t" + Years.get(i).get(j).Black);
      System.out.println("\tHispanic: \t" + Years.get(i).get(j).Hispanic);
      System.out.println("\tAsian: \t" + Years.get(i).get(j).Asian);
     
     System.out.println("");
    
     System.out.println("\t1st: " + Years.get(i).get(j).top3Majors.get(0).Name + "\t\t" + Years.get(i).get(j).top3Majors.get(0).Enrollment);
     if (Years.get(i).get(j).top3Majors.get(1) != null) {
       System.out.println("\t2nd: " + Years.get(i).get(j).top3Majors.get(1).Name + "\t\t" + Years.get(i).get(j).top3Majors.get(1).Enrollment);
     }
     if (Years.get(i).get(j).top3Majors.get(2) != null) {
       System.out.println("\t3rd: " + Years.get(i).get(j).top3Majors.get(2).Name + "\t\t" + Years.get(i).get(j).top3Majors.get(2).Enrollment);
     }
     
     System.out.println("");
   }
   
   yearNum++;
   System.out.println("\n\n\n");
 }

 
}


