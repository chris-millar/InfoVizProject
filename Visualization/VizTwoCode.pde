//------------------------ BUILD METHODS -------------------------//

Chart c1;
ChartDataSet ds1;
College engi, comp, manag, sci, ivan, arch;
int year;
RadioButton r, rOther;
int mode;
int dataMode;



void buildVisualizationTwo() {
  
  dataMode = 0;
  year = 1999;
  getData();
  drawCP5();
  mode = 0;
}


//------------------------ CHECK METHODS -------------------------//
void checkVisualizationTwo() {
  
}


/////c///////// Percent, num radio buttons

void drawCP5(){
  r = cp5.addRadioButton("viewButton")
          .setPosition(1180,350)
          .setSize(2,2)
          .setColorLabel(0)
          .setItemHeight(10)
          .setItemWidth(15)
          .setItemsPerRow(2)
          .setSpacingColumn(50)
          .addItem("Percent",0)
          .addItem("Number", 1)
          .activate(0);
          
  rOther = cp5.addRadioButton("otherButton")
              .setPosition(1180,400)
              .setSize(2,2)
              .setColorLabel(0)
              .setItemHeight(10)
              .setItemWidth(15)
              .setItemsPerRow(1)
              .setSpacingColumn(50)
              .addItem("Major",0)
              .addItem("Ethnicity", 1)
              .addItem("Gender", 2)
              .activate(0);
//          
//    cp5.addToggle("toggle")
//     .setPosition(40,250)
//     .setSize(50,20)
//     .setValue(true)
//     .setMode(ControlP5.SWITCH)
//     ;
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r)) {
    dataMode = int(r.getValue());
    getData();
    drawVisualizationTwo();
  }
  
  if(theEvent.isFrom(rOther)) {
    mode = int(rOther.getValue());
    getData();
    drawVisualizationTwo();
  }
  
}


//------------------------ DRAW METHODS -------------------------//
void drawVisualizationTwo() {
  
  getData();
  
  barChart bc1 = new barChart(185, 493, "Engineering", 1, engi);
  barChart bc2 = new barChart(185, 655, "Computing", 1, comp);
  
  barChart bc3 = new barChart(540, 493, "Architecture", 1, arch);
  barChart bc4 = new barChart(540, 655, "Ivan Allen", 1, ivan);  
  
  barChart bc5 = new barChart(895, 493, "Sciences", 1, sci);
  barChart bc6 = new barChart(895, 655, "Management", 1, manag);  
  
  
  fill(175);
  noStroke();
  rect(1165, 325, 170, 150, 3);
  
  bc1.draw();
  bc2.draw();
  bc3.draw();
  bc4.draw();
  bc5.draw();
  bc6.draw();
  
  cp5.draw();
  
  
}

public int getPercent(int enrollment, int colTotal){
  float percent = float(enrollment)/colTotal;
  percent = percent * 100;
  
  return int(percent);
}

public void getData(){
  year = CurrSelectedYear;
  ArrayList<College> colObjs;
  if(year == 1999){
    colObjs = Years.get(0);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
  else if(year == 2000){
    colObjs = Years.get(1);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2001){
    colObjs = Years.get(2);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2002){
    colObjs = Years.get(3);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2003){
    colObjs = Years.get(4);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2004){
    colObjs = Years.get(5);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2005){
    colObjs = Years.get(6);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2006){
    colObjs = Years.get(7);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2007){
    colObjs = Years.get(8);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2008){
    colObjs = Years.get(9);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2009){
    colObjs = Years.get(10);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2010){
    colObjs = Years.get(11);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2011){
    colObjs = Years.get(12);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2012){
    colObjs = Years.get(13);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }
    else if(year == 2013){
    colObjs = Years.get(14);
    
    arch = colObjs.get(0);
    comp = colObjs.get(1);
    engi = colObjs.get(2);
    ivan = colObjs.get(3);
    manag = colObjs.get(4);
    sci = colObjs.get(5);
  }

  
}


public class barChart{
  
  int sizeX, sizeY;
  int posX, posY;
  String name, dMode;
  College college;
  int chartNum;
  
  Axis X, Y; 
  
  ArrayList<barChartBar> bars;
  
  public barChart(int posX, int posY, String name, int chartNum, College college){
    this.posX = posX;
    this.posY = posY;
    this.name = name;
    this.chartNum = chartNum;
    this.college = college;
    
    bars = new ArrayList<barChartBar>();
    
    //mode = "Major";

    
    sizeX = 200;
    sizeY = 140;
    
    
    X = new Axis(2, name.concat("Xaxis"), posX, posY-140, (posX+sizeX), posY-140, color(120,120,120));
    X.setWeight(1);
    Y = new Axis(2, name.concat("Yaxis"), posX, posY, posX, (posY-sizeY), color(120,120,120));
    Y.setWeight(1);
  } //end constructor
  
  

  
  public void draw(){
    
    getData();
    
   // X.draw();
   // Y.draw();
    if (CurrSelectedCollege == null || !CurrSelectedCollege.equals(college.Name)) {
      fill(150,20);
    }
    else { //(CurrSelectedCollege.equals(college.Name)) {
      fill(150,100);  
    }

    noStroke();
    rect(posX-90, posY-140-30, 345, 150, 6);
  
    fill(80,80,80);
    
    float x = 30;
    float y = 150;
    textAlign(CENTER,BOTTOM); 
 
    textSize(16);
    text(name,posX+50,posY-143);

    textSize(9);
     if(dataMode == 0)
      dMode = "by Percentage";
    else if (dataMode ==1)
      dMode = "by Number";
    text(dMode, posX+135,posY-145);
    
    drawBars();
    
  }
  
  
  public void drawBars(){
    
    int barX = posX;
    int barY = posY;
    int opacity = 255;
    
    if(mode==0){ /// 0 == MAJOR
      for(Major m : college.top3Majors){
        if(m != null){
          barChartBar b = new barChartBar(getPercent(m.Enrollment, college.TotalCollege),m.Enrollment, barX, barY, m.NameMajor, college, opacity);
          barY+= 35;
          opacity-=55;
          bars.add(b);
        }
      }
      opacity = 200;
    }
    else if(mode==1){   /// 1 == ETHNICITY
      
      
      
      barChartBar bA = new barChartBar(getPercent(college.getAsian(), college.TotalCollege),college.getAsian(), barX, barY-10, "Asian", college, opacity);
      barChartBar bB = new barChartBar(getPercent(college.getBlack(), college.TotalCollege),college.getBlack(), barX, barY+15, "Black", college, opacity);
      barChartBar bH = new barChartBar(getPercent(college.getHispanic(), college.TotalCollege),college.getHispanic(), barX, barY+40, "Hispanic", college, opacity);
      barChartBar bW = new barChartBar(getPercent(college.getWhite(), college.TotalCollege),college.getWhite(), barX, barY+65, "White", college, opacity);
      
      bars.add(bA);
      bars.add(bB);
      bars.add(bH);
      bars.add(bW);
      
    }
    else if(mode==2){   ///2 == GENDER
    
      barChartBar bF = new barChartBar(getPercent(college.getFemale(), college.TotalCollege),college.getFemale(), barX, barY, "Female", college, opacity);
      barChartBar bM = new barChartBar(getPercent(college.getMale(), college.TotalCollege),college.getMale(), barX, barY+35, "Male", college, opacity);
      
      bars.add(bF);
      bars.add(bM);
      
    }
  
    //for (int i=0; i<bars.size() && !bars.get(i).render(); i++);
    
    for(barChartBar b : bars){
      //for (int i=0; i<bars.size() && !b.render(); i++);
     b.draw(); 
     //b.render();
    }
    
  }
} ///// End Class bar chart

public class barChartBar{
  int dataPercent, dataNum;
  int x, y,n; 
  String name;
  color col;
  int w, h;
  float conversion;
  int opacity;
  color Color;
  College college;
  String abrevName;
  AniSequence s;
  
  barChartBar(int dataPercent, int dataNum, int x, int y, String name, College college, int opacity){
    
    
    this.dataPercent = dataPercent;
    this.dataNum = dataNum;
    this.x = x;
    this.y = y;
    this.name = name;
    this.opacity = opacity;
    
    n=0;
    
    
    if(name.equals("Archtecture")){
      this.name = "Architecture";
    }
    this.college=college;

    w = 22;
    initData();
    setColor();
    
    
    
  }
  
  void initData(){
    
    if(dataMode == 0){
      h = int(dataPercent*2.3);
    }
    else if (dataMode == 1){
     h = floor(float(dataNum)/25);
     
     if(h == 0)
       h = 1;
    }
      
    
  }
  
  
  void draw(){
    
    
    fill(Color, opacity);
    noStroke();
    
    if(name.equals("Female") || name.equals("Male"))
       rect(x-45,y-125,h,w);
    else
      rect(x-20,y-125,h,w);
    
    fill(10);
    textSize(8);
    textAlign(LEFT, BOTTOM);
    
    

    if(name.equals("Science. Technology and Society") || name.equals("Science Technology and Culture")){
      name = "Science, Technology and Culture";
      abrevName = "STC";
      text(abrevName, x-80, y-205, 60, 100);
    }
    else if(name.equals("History Technology and Society") || name.equals("History. Technology and Society")){
     name = "History, Technology and Society";
     abrevName = "HTS";
     text(abrevName, x-80, y-205, 60, 100);
    }
    else if(name.equals("International Affairs and Modern Languages")||name.equals("International Affair and Modern Languages")){
      name="International Affairs and Modern Languages";
     abrevName = "INTA and ML";
     text(abrevName, x-80, y-205, 60, 100);
    }
    else if(!college.Name.equals("Ivan Allen") && !college.Name.equals("Sciences") && !name.equals("Management")&& !name.equals("Architecture")&& !name.equals("International Affairs")){
      text(name, x-80, y-205, 60, 100);
    }
    else if(college.Name.equals("Ivan Allen")){
      text(name, x-80, y-205, 60, 100);
    }
    else{
      text(name, x-80, y-110);
    }
    
    textSize(10);
    if(dataMode == 0){
      String dp = String.valueOf(dataPercent);
      dp=dp.concat("%");
      if(name.equals("Female") || name.equals("Male"))
        text(dp, x+h-40, y-110);
      else
        text(dp, x+h-15, y-110);
    }
    else if(dataMode==1){
      String dn = String.valueOf(dataNum);
      if(name.equals("Female") || name.equals("Male"))
        text(dn, x+h-40, y-110);
      else
        text(dn, x+h-15, y-110);
    }
    
  }
  
  
  void setColor(){
    if(college.Name.equals("Ivan Allen"))
      Color = COLOR_IVANALLEN;
    else if(college.Name.equals("Architecture"))
      Color = COLOR_ARCHITECTURE;
    else if(college.Name.equals("Management"))
      Color = COLOR_MANAGEMENT;
    else if(college.Name.equals("Sciences"))
      Color = COLOR_SCIENCES;
    else if(college.Name.equals("Engineering"))
        Color = COLOR_ENGINEERING;
    else if(college.Name.equals("Computing"))
      Color = COLOR_COMPUTING;
      
    if(name.equals("Male"))
      Color = COLOR_MALE;
    else if(name.equals("Female"))
      Color = COLOR_FEMALE;
  }
  
  
}///End class bar chart bars
