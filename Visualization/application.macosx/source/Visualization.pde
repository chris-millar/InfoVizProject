import controlP5.*;

// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

////////////// Init Methods //////////////////

public void setup() {
  
  selected = loadImage("selected.png");
  unselected = loadImage("unselected.png");

  if (frame != null) {
    frame.setResizable(true);
  }
  
  initGlobals();
  loadData();
  initScreen();
  
  background(255);
  
  buildVisualizationOne();
  setInitialEventTracerValuesInsideVisualObjects();
}

public void initScreen() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

public void setInitialEventTracerValuesInsideVisualObjects() {
  yearBars.get(0).setClickSelected(true);  // tells the 1999 YearBar that it is currently selected, at viz startup
 
  Event_SelectedYearChange = true;
}

///////////////// Processing Drawing /////////////////////
void mouseClicked() {
  vizOneCheckMouseClicked();  
}


void draw() {
  background(255);
  
  if (Event_VizOneCollegeToDrawChange) {
    buildVisualizationOne();
    Event_VizOneCollegeToDrawChange = false;  
  }
  
  if (Event_SelectedYearChange) {
    buildVisualizationTwo();
    Event_SelectedYearChange = false;
    
    if (Event_VizTwoDisplayModeChange) {
      Event_VizTwoDisplayModeChange = false;
    }
  }
  
  if (Event_VizTwoDisplayModeChange) {
    buildVisualizationTwo();
   
    Event_VizTwoDisplayModeChange = false; 
  }
  
  checkVisualizationOne();
  drawVisualizationOne();
  
  checkVisualizationTwo();
  drawVisualizationTwo();
  
  for(ArrayList<barChartBar> bars : collegeBars){
    for (int i=0; i<bars.size() && !bars.get(i).render(); i++);
  }
  
}
















