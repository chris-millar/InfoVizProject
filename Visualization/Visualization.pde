// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

import controlP5.*;

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
final int NumYears = 15;
ControlP5 cP5;
//*************** Global Variables *******************//

final int COLOR_ARCHITECTURE = color(200, 0, 0), // red
    COLOR_IVANALLEN = color(0, 0, 235), // blue
    COLOR_COMPUTING = color(0, 255, 0), // green
    COLOR_SCIENCES = color(255, 0, 200), // purple
    COLOR_MANAGEMENT = color(0, 255, 255), // cyan
    COLOR_ENGINEERING = color(255, 135, 0), // orange
    
    COLOR_MALE = color(102, 178, 255), // sky blue
    COLOR_FEMALE = color(255, 102, 178), // pink
    
    COLOR_ARCHITECTURE1 = COLOR_ARCHITECTURE, 
    COLOR_ARCHITECTURE2 = color(122, 0, 0), 
    COLOR_ARCHITECTURE3 = color(199, 99, 0), 
    COLOR_ARCHITECTURE4 = color(122, 61, 0), 
    
    COLOR_IVANALLEN1 = COLOR_IVANALLEN, 
    COLOR_IVANALLEN2 = color(0, 0, 158), 
    COLOR_IVANALLEN3 = color(94, 94, 235), 
    COLOR_IVANALLEN4 = color(63, 63, 158), 
    
    COLOR_COMPUTING1 = COLOR_COMPUTING, 
    COLOR_COMPUTING2 = color(0, 179, 0), 
    COLOR_COMPUTING3 = color(170, 255, 0), 
    COLOR_COMPUTING4 = color(119, 179, 0), 
    
    COLOR_SCIENCES1 = COLOR_SCIENCES, 
    COLOR_SCIENCES2 = color(128, 0, 125), 
    COLOR_SCIENCES3 = color(204, 82, 161), 
    COLOR_SCIENCES4 = color(128, 51, 101), 
    
    COLOR_MANAGEMENT1 = COLOR_MANAGEMENT,  
    COLOR_MANAGEMENT2 = color(0, 179, 179), 
    COLOR_MANAGEMENT3 = color(102, 153, 255), 
    COLOR_MANAGEMENT4 = color(0, 60, 179), 
    
    COLOR_ENGINEERING1 = COLOR_ENGINEERING,  
    COLOR_ENGINEERING2 = color(179, 95, 0), 
    COLOR_ENGINEERING3 = color(255, 200, 0), 
    COLOR_ENGINEERING4 = color(179, 140, 0);

////////////// Init Methods //////////////////
void setup() {
  initGlobals();
  loadData();
  test_Data();
  
  size(1180, 580);
  frameRate(30);
  
  cP5 = new ControlP5(this);
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
      
      //System.out.println("DEBUG: YEAR: " + i + "\t\t" + "ON-LINE: " + j);
      
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
      System.out.println("College: " + Years.get(i).get(j).getName() + "\t" + Years.get(i).get(j).getTotalCollege()); 
      
      System.out.println("\tMale: \t" + Years.get(i).get(j).getMale());
      System.out.println("\tFemale: \t" + Years.get(i).get(j).getFemale());
      
      System.out.println("");
      
      System.out.println("\tWhite: \t" + Years.get(i).get(j).getWhite());
      System.out.println("\tBlack: \t" + Years.get(i).get(j).getBlack());
      System.out.println("\tHispanic: \t" + Years.get(i).get(j).getHispanic());
      System.out.println("\tAsian: \t" + Years.get(i).get(j).getAsian());
     
     System.out.println("");
    
     System.out.println("\t1st: " + ((Major)Years.get(i).get(j).getTop3Majors().get(0)).getName() + "\t\t" + ((Major)Years.get(i).get(j).getTop3Majors().get(0)).getEnrollment());  
     if (Years.get(i).get(j).getTop3Majors().get(1) != null) {
       System.out.println("\t2nd: " + ((Major)Years.get(i).get(j).getTop3Majors().get(1)).getName() + "\t\t" + ((Major)Years.get(i).get(j).getTop3Majors().get(1)).getEnrollment());
     }
     if (Years.get(i).get(j).getTop3Majors().get(2) != null) {
       System.out.println("\t3rd: " + ((Major)Years.get(i).get(j).getTop3Majors().get(2)).getName() + "\t\t" + ((Major)Years.get(i).get(j).getTop3Majors().get(2)).getEnrollment());
     }
     
     System.out.println("");
   }
   
   yearNum++;
   System.out.println("\n\n\n");
 }

 
}


