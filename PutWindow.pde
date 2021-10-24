import java.awt.Frame;
import processing.awt.PSurfaceAWT;

int mWidth  = 1392;
int mHeight = 874-28; // minus the window bar height. 
int mTop    = 283;
int mLeft   = 1024;

void settings(){
  size(mWidth, mHeight);
}

void setup(){ 
  textAlign(LEFT, TOP);
  textSize(24);
  
  surface.setAlwaysOnTop(true);
  surface.setLocation(mLeft, mTop);
  surface.setResizable(true);
}

Frame getFrame(){
    PSurfaceAWT.SmoothCanvas canvas;
    canvas = (PSurfaceAWT.SmoothCanvas)getSurface().getNative();
    return(canvas.getFrame());
}
 
void draw() { 
  background(0);
  text("Width=" + getFrame().getWidth() + ", Height=" + getFrame().getHeight(), 0, 0);
  text("X=" + getFrame().getX() + ", Y=" + getFrame().getY(), 0, 30);
}
