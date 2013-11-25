import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import controlP5.*;

// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013

boolean debug = false;
////////////// Init Methods //////////////////

public void setup() {
  
  //frameRate(4);
  initGlobals();
  loadData();
  if (debug) { test_Data(); }
  initScreen();
  
  background(255);
  
  buildVisualizationOne();
  setInitialEventTracerValuesInsideVisualObjects();
}

public void initScreen() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  //frameRate(30);
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
  
//  Axis br = new Axis(0, "horizontalLine", 0, 285, 1350, 285, color(0));
//  br.setWeight(1);
//  br.setColor(color(210));
//  br.draw();
  
  if (Event_SelectedYearChange) {
      //println("EVENT -- SelectedYearChange -- recieved\n");
    
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
  
  updateElementsForBrushing();
  
  checkVisualizationOne();
  drawVisualizationOne();
  
  checkVisualizationTwo();
  drawVisualizationTwo();
}



void updateElementsForBrushing() {
  //TODO: last thing to do after both visualizations are completed 
}
















