////////////////// Data Manipulation ///////////////////

public void loadData() {
  int iYear = 1999;
  for (int i=0; i < NUM_YEARS; i++) {
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
