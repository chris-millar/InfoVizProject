
private final int DisplayHeight = 100;
private final int DisplayWidth = 100;
private final int displayXPos = 1225; 
private final int displayYPos = 500;
private final int displayBuffer = 10;
private final int buttonRowGap = 20;
private final int roundedCorner = 10;
private final int numOfButtons = 3;

private RadioButton radio;
  
public void buildRadioButton()
{ 
   radio = cP5.addRadioButton("radio")
    .setPosition(displayXPos + displayBuffer, displayYPos + displayBuffer)
    .setSpacingRow(buttonRowGap)
    .setColorForeground(color(0,255,0)) //when highlighted
    .setColorActive(color(255,0,0)) //when clicked
    .setColorLabel(color(0)) //color font
    .setNoneSelectedAllowed(false) 
    .addItem("Top 3", 0)
    .addItem("Gender", 1)
    .addItem("Ethnicity", 2)
    .activate(0)
    ;
    //System.out.println( (int)radio.getValue() );
}

public void buildRadioDisplay()
{
  noStroke();
  fill(COLOR_LegendBackground);
  rect(displayXPos, displayYPos, DisplayWidth, radio.getHeight() * numOfButtons + numOfButtons * buttonRowGap, roundedCorner);
}

public void keyPressed() 
{
  switch(key)
  {
    case('t'): radio.activate(0); break;
    case('g'): radio.activate(1); break;
    case('e'): radio.activate(2); break;
  }
}

/*
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isGroup() && theEvent.name().equals("radio")) {
    println(theEvent.arrayValue());
  }
}
*/
