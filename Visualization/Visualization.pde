// Authors: Nina Flaherty, Chris Millar, Lucas Pessoa, Huy Tran
// CS4460 Information Visualization
// Info Viz Project
// December-03-2013


////////////// Init Methods //////////////////

public void setup() 
{
  initGlobals();
  loadData();
  //test_Data();
  initScreen();
  Grid GridMain = new Grid(GRID_1_VERT_X, GRID_1_VERT_Y, GRID_1_THICKNESS, GRID_1_VERT_HEIGHT, 
                          GRID_1_HOR_X, GRID_1_HOR_Y, GRID_1_HOR_WIDTH, GRID_1_THICKNESS);
  setupTotalBars(); //work in progress, has not been normalized
}

public void initScreen() 
{
  background(WHITE); 
  size(SCREEN_WIDTH, SCREEN_HEIGHT); 
  frameRate(30);
}

///////////////// Processing Drawing /////////////////////
void draw() 
{

}

void mouseMoved() 
{
  for(int x=0; x<totalBarList.size(); x++)
  {
    if( totalBarList.get(x).isHoveredOver() )
    {
      //change this to fancy detail on demand stuff
      System.out.println( totalBarList.get(x).getTotal() );
    }
  }
}








