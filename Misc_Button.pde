public class Button {
  // Fields
  public final int X_POS;
  public final int Y_POS;
  private String label;
  public final int LABEL_SIZE;
  public final int WIDTH;
  public final int HEIGHT;
  public final String BUTTON_SHAPE;
  public final color LABEL_COLOUR;
  public final color STROKE_COLOUR;
  public final color ON_FILL_COLOUR;
  public final color PRESS_FILL_COLOUR;
  public final color BASE_FILL_COLOUR;
  private color fillColour;
  private String prevState;
  private String state;

  // Constructor
  public Button(int x, int y, String text, int labelSize, int buttonWidth, int buttonHeight, String shape, color labelColour, color strokeColour, color baseFillColour) {
    // Pos
    X_POS = x;
    Y_POS = y;
    this.label = text;
    LABEL_SIZE = labelSize;
    WIDTH = buttonWidth;
    HEIGHT = buttonHeight;
    BUTTON_SHAPE = shape;
    // Colour
    LABEL_COLOUR = labelColour;
    STROKE_COLOUR = strokeColour;
    BASE_FILL_COLOUR = baseFillColour;
    ON_FILL_COLOUR = color(min(red(BASE_FILL_COLOUR) * 1.5, 255), min(green(BASE_FILL_COLOUR) * 1.5, 255), min(blue(BASE_FILL_COLOUR) * 1.5, 255));
    PRESS_FILL_COLOUR = color(red(BASE_FILL_COLOUR)/1.5, green(BASE_FILL_COLOUR)/1.5, blue(BASE_FILL_COLOUR)/1.5);
    // State
    this.prevState = "Base";
    this.state = "Base";
  }

  /** Draws the button */
  public void drawButton() {
    // Update button colour
    this.updateColour();
    // Set button colour
    fill(this.fillColour);
    stroke(STROKE_COLOUR);
    // Draw the button
    switch (BUTTON_SHAPE) {
    case "rect":
      rect(X_POS - WIDTH/2, Y_POS - HEIGHT/2, WIDTH, HEIGHT);
      break;
    case "roundedRect":
      rect(X_POS - WIDTH/2, Y_POS - HEIGHT/2, WIDTH, HEIGHT, (WIDTH < HEIGHT) ? WIDTH/2 : HEIGHT/2);
      break;
    case "circle":
      ellipse(X_POS, Y_POS, WIDTH, HEIGHT);
      break;
    }
    // Display button label
    textAlign(CENTER, CENTER);
    textSize(LABEL_SIZE);
    fill(LABEL_COLOUR);
    text(this.label, X_POS, Y_POS);
  }

  /**
   * Chages the button's current colour
   */
  private void updateColour() {
    switch (this.state) {
    case "Base":
      this.fillColour = BASE_FILL_COLOUR;
      break;
    case "On":
      this.fillColour = ON_FILL_COLOUR;
      break;
    case "Pressed":
      this.fillColour = PRESS_FILL_COLOUR;
      break;
    }
  }

  /**
   * Checks if a coordinate is on the button
   */
  public boolean on(int x, int y) {
    return (((x >= X_POS - WIDTH/2) && (x <= X_POS + WIDTH/2)) &&
      ((y >= Y_POS - HEIGHT/2) && (y <= Y_POS + HEIGHT/2)));
  }

  /** Returns the button's current state */
  public String getState() {
    return this.state;
  }
  /** Returns the button's previous state */
  public String getPrevState() {
    return this.prevState;
  }

  /**
   * Update the button's state
   */
  public void setState(String newState) {
    this.prevState = this.state;
    this.state = newState;
  }
  
  /** Set and get the button label */
  public void setLabel(String newLabel) {
    this.label = newLabel;
  }
  public String getLabel() {
    return this.label;
  }
}
