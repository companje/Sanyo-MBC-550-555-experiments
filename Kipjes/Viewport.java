//package viewport;
import processing.core.*;
import processing.event.*;
import java.awt.Rectangle; 

public class Viewport {

  PApplet p;
  public float x,y, scale = 1;
  public int mouseX, mouseY, pmouseX, pmouseY; //mouse values in this viewport
  public Rectangle bounds;
  public boolean dragging, mouseEnabled = true;
  public float contentWidth, contentHeight;
  public float minScale = 0.5f, maxScale = 40.0f;
  public boolean enableDragging = true;
  PVector contentTopLeftInScreenCoords = new PVector();
  PVector contentBottomRightInScreenCoords = new PVector();
  public float toScreenScale;

  public Viewport(PApplet applet, int x, int y, int w, int h, int contentWidth, int contentHeight) {
    p = applet;
    p.registerMethod("mouseEvent", this);
    this.bounds = new Rectangle(x, y, w, h);
    this.contentWidth = contentWidth;
    this.contentHeight = contentHeight;
  }

  public Viewport(PApplet applet, int x, int y, int w, int h) {
    this(applet,x,y,w,h,w,h);
  }

  public void begin() {
    p.clip(bounds.x, bounds.y, bounds.width, bounds.height);
    p.pushMatrix();
    p.translate(bounds.x, bounds.y);
    p.scale(scale);
    p.translate(-x, -y);
    
    //content
    p.translate(bounds.width/2, bounds.height/2); //center in viewport
    p.scale(PApplet.min((float)(bounds.width)/contentWidth, (float)(bounds.height)/contentHeight)); //scale to fit content
    p.translate(-contentWidth/2, -contentHeight/2); //imageMode center

    contentTopLeftInScreenCoords.set(new PVector(p.screenX(0, 0), p.screenY(0, 0)));
    contentBottomRightInScreenCoords.set(new PVector(p.screenX(contentWidth, contentHeight), p.screenY(contentWidth, contentHeight)));
    toScreenScale = 1 / (scale * PApplet.min(bounds.width/contentWidth, bounds.height/contentHeight));
  }

  PVector fromScreenToView(float x, float y) {
    x = PApplet.map(x, contentTopLeftInScreenCoords.x, contentBottomRightInScreenCoords.x, 0, contentWidth);
    y = PApplet.map(y, contentTopLeftInScreenCoords.y, contentBottomRightInScreenCoords.y, 0, contentHeight);
    return new PVector(x, y);
  }

  public void end() {
    p.popMatrix();
    p.noClip();
  }

  private void mouseDragged() {
    if (!enableDragging) return;
    x -= (mouseX-pmouseX)/scale;
    y -= (mouseY-pmouseY)/scale;
  }

  private void mouseWheel(MouseEvent event) {
    //zoom factor needs to be between about 0.99 and 1.01 to be able to multiply so add 1
    float zoomFactor = -event.getCount()*.01f + 1.0f; 
    float newScale = PApplet.constrain(scale * zoomFactor, minScale, maxScale);

    //next two lines are the most important lines of the code.
    //subtract mouse in 'old' scale from mouse in 'new' scale and apply that to position.
    x -= (mouseX/newScale - mouseX/scale);
    y -= (mouseY/newScale - mouseY/scale);

    //apply the new scale
    scale = newScale;
  }

  public void mouseEvent(MouseEvent event) {
    if (!mouseEnabled) return;
    boolean mouseOver = bounds.contains(event.getX(), event.getY());
    pmouseX = mouseX;
    pmouseY = mouseY;
    mouseX = event.getX() - bounds.x;
    mouseY = event.getY() - bounds.y;

    switch (event.getAction()) {
    case MouseEvent.PRESS:
      if (mouseOver) dragging = true;
      break;
    case MouseEvent.RELEASE:
      dragging = false;
      break;
    case MouseEvent.CLICK:
      break;
    case MouseEvent.DRAG:
      if (dragging) this.mouseDragged();
      break;
    case MouseEvent.MOVE:
      break;
    case MouseEvent.WHEEL:
      if (mouseOver) this.mouseWheel(event);
      break;
    }
  }
  
  public void reset() {
    scale = 1;
    x = y = 0;
  }
}
