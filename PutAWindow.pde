import controlP5.*;
import java.awt.Frame;
import processing.awt.PSurfaceAWT;

PWindow mControlWindow;
boolean flagApply = false;

int gBarHeight = 28;
int gBarWidth  = 0;
int gWidth  = 1398 - gBarWidth;
int gHeight = 874  - gBarHeight; // minus the window bar height. 
int gTop    = 283;
int gLeft   = 1024;

void settings(){
  size(gWidth, gHeight);
  String osname = System.getProperty("os.name");
  if(osname.substring(0, 7).equals("Windows")){
    gBarHeight = 56;
    gBarWidth  = 22;
  }
}

void setup(){ 
  mControlWindow = new PWindow();
  
  textAlign(LEFT, TOP);
  textSize(24);
  
  surface.setAlwaysOnTop(true);
  surface.setLocation(gLeft, gTop);
  surface.setResizable(true);
}

Frame getFrame(){
    PSurfaceAWT.SmoothCanvas canvas;
    canvas = (PSurfaceAWT.SmoothCanvas)getSurface().getNative();
    return(canvas.getFrame());
}
 
void draw() { 
  background(0);
  if(flagApply){
    flagApply = false;
  }else{
    gWidth  = getFrame().getWidth()  - gBarWidth;
    gHeight = getFrame().getHeight() - gBarHeight;
    gTop    = getFrame().getY();
    gLeft   = getFrame().getX();
  }
  
  surface.setLocation(gLeft, gTop);
  surface.setSize(gWidth, gHeight);
  text("Width=" + (gWidth + gBarWidth) + ", Height=" + (gHeight + gBarHeight), 0, 0);
  text("Left="  + gLeft  + ", Top="    + gTop  , 0, 30);
  text("Right=" + (gLeft + gWidth + gBarWidth) + ", Bottom=" + (gTop + gHeight + gBarHeight), 0, 60); 
}


class PWindow extends PApplet {
  
  ControlP5 cp5;
  boolean flagLock = true;
  
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(300, 300);
  }

  void setup() {
    background(150);
    surface.setLocation(gLeft+gWidth, gTop);
    surface.setTitle("PutAWindow: Controller");
    
    cp5 = new ControlP5(this);
    
    cp5.addTextfield("Width")
     .setPosition(10,10)
     .setSize(100,20)
     .setValue(Integer.toString(gWidth))
     .setColor(color(255,0,0));
     
    cp5.addTextfield("Height")
     .setPosition(10,60)
     .setSize(100,20)
     .setValue(Integer.toString(gHeight))
     .setColor(color(255,0,0));
     
    cp5.addTextfield("Top")
     .setPosition(10,110)
     .setSize(100,20)
     .setValue(Integer.toString(gTop))
     .setColor(color(255,0,0));
     
    cp5.addTextfield("Left")
     .setPosition(10,160)
     .setSize(100,20)
     .setValue(Integer.toString(gLeft))
     .setColor(color(255,0,0));
     
    cp5.addButton("State")
     .setPosition(10,230)
     .setSize(100,20)
     .setValue(0)
     .setLabel("Do Unlock")
     .activateBy(ControlP5.PRESS);
    
    flagLock = true;
  }

  void draw() {
    if(flagLock){
      cp5.get(Textfield.class,"Width").setText(String.valueOf(gWidth));
      cp5.get(Textfield.class,"Height").setText(String.valueOf(gHeight));
      cp5.get(Textfield.class,"Top").setText(String.valueOf(gTop));
      cp5.get(Textfield.class,"Left").setText(String.valueOf(gLeft));
    }
  }
  
  public void State(){
    if(flagLock){
      flagLock = false;
      cp5.get(Button.class,"State").setLabel("Apply");     
    }else{
      gWidth  = int(cp5.get(Textfield.class,"Width").getText());
      gHeight = int(cp5.get(Textfield.class,"Height").getText());
      gTop    = int(cp5.get(Textfield.class,"Top").getText());
      gLeft   = int(cp5.get(Textfield.class,"Left").getText());
      flagApply = true;
      flagLock = true;
      cp5.get(Button.class,"State").setLabel("Do Unlock");
    }
  }
}
