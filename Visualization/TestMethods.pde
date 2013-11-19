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


public void test_Positions() {
  fill(COLOR_MALE);
  rect(vizOne_X, vizOne_Y, vizOne_width, vizOne_height);
  
  fill(COLOR_FEMALE);
  rect(vizTwo_X, vizTwo_Y, vizTwo_width, vizTwo_height);
  
  //fill(150);
  //line(vizOne_yAxis_x1, vizOne_yAxis_y1, vizOne_yAxis_x2, vizOne_yAxis_y2);
  //line(vizOne_xAxis_x1, vizOne_xAxis_y1, vizOne_xAxis_x2, vizOne_xAxis_y2);
  
  
  
  int baseY = 150;
  
  int currX = 30 + 25;
  
  int yearBarSpacing = 20; //27
  int innerBarSpacing = 11; // 9 + 2
  
  int collegeWidth = 40; // 36 + 4
  int collegeHeight = 100;
  
  int yearWidth = collegeWidth + 2*innerBarSpacing;
  int yearHeight = 109;
  
  for (int i = 0; i < 15; i++) {
     currX += yearBarSpacing;
     
     //draw Year-Bar
     fill(149);
     rect(currX, baseY, yearWidth, yearHeight);
     
     currX += innerBarSpacing;
     
     //draw College-Bar
     fill(COLOR_COMPUTING);
     rect(currX, baseY, collegeWidth, collegeHeight);
     
     currX = currX + collegeWidth + innerBarSpacing;
     
  }
  
}


public PopupBubble test_popupBubble() {
  PopupBubble bubble = new PopupBubble(0, 0, 400, 400, 40, 40);
  bubble.setBackgroundColor(COLOR_MALE);
  return bubble;
  
}
