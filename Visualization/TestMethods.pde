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
