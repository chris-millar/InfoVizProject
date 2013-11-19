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
ArrayList<ArrayList<MajorEntry>> Years;
final int NumYears = 15;
//*************** Global Variables *******************//


// Lucas Testing.

////////////// Init Methods //////////////////
void setup() {
  initGlobals();
  loadData();
}

void initGlobals() {
  Years = new ArrayList<ArrayList<MajorEntry>>();
}



///////////////// Processing Drawing /////////////////////
void draw() {
  
}



////////////////// Data Manipulation ///////////////////
void loadData() {
  int iYear = 1999;
  for (int i=0; i < NumYears; i++) {
    lines = loadStrings("data/4460_" + iYear + ".csv"); //splits the ith year file into its 11 lines (as String arrays)
    
    ArrayList<MajorEntry> iTopTen = new ArrayList<MajorEntry>(); //holds the top ten major-entries in the ith year
    for (int j=1; j < lines.length; j++) {
      String[] lineVals = split(lines[j], ',');  //splits apart the jth line (1-10, major data entry)
      
      MajorEntry entry = new MajorEntry(lineVals[0], 
                                        Integer.parseInt(lineVals[12]), Integer.parseInt(lineVals[1]), Integer.parseInt(lineVals[2]),
                                        Integer.parseInt(lineVals[3]), Integer.parseInt(lineVals[4]), Integer.parseInt(lineVals[5]), 
                                        Integer.parseInt(lineVals[6]), Integer.parseInt(lineVals[7]), Integer.parseInt(lineVals[8]),
                                        Integer.parseInt(lineVals[9]), Integer.parseInt(lineVals[10]), Integer.parseInt(lineVals[11]));
      iTopTen.Add(entry);
    }
    
    Years.Add(iTopTen);
    iYear++;
  }
}




/////////////// Class Definitions ////////////////////
class MajorEntry {
  public String name;
  public int year;
  
  public int AsianMale;
  public int AsianFemale;
  public int BlackMale;
  public int BlackFemale;
  public int HispanicMale;
  public int HispanicFemale;
  public int WhiteMale;
  public int WhiteFemale;
  
  public int TotalMale;
  public int TotalFemale;
  public int TotalMajor;
  
  public MajorEntry(String name, int year, int AsianMale, int AsianFemale,
                    int BlackMale, int BlackFemale, int HispanicMale, 
                    int HispanicFemale, int WhiteMale, int WhiteFemale,
                    int TotalMale, int TotalFemale, int TotalMajor) {
    this.name = name;
    this.year = year;
    this.AsianMale = AsianMale;
    this.AsianFemale = AsianFemale;
    this.BlackMale = BlackMale;
    this.BlackFemale = BlackFemale;
    this.HispanicMale = HispanicMale;
    this.HispanicFemale = HispanicFemale;
    this.WhiteMale = WhiteMale;
    this.WhiteFemale = WhiteFemale;
    this.TotalMale = TotalMale;
    this.TotalFemale = TotalFemale;
    this.TotalMajor = TotalMajor;
  }
  
}


