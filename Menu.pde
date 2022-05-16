public abstract class Menu {
  // Fields
  public static final int BUTTON_BUFFER = 10;
  protected List<Button> allButtons;

  /** Draws the menu */
  public abstract void drawMenu();

  /** Handles the buttons */
  protected abstract void handleButtons(Button buttonPressed);

  /** Handles mouse events on the buttons */
  public void handleMouseMoved() {
    // Highlight button if mouse is on button
    for (Button button : this.allButtons) {
      if (button.on(mouseX, mouseY)) {
        button.setState("On");
      } else {
        button.setState("Base");
      }
    }
  }
  public void handleMousePressed() {
    // Highlight button if mouse is on button
    for (Button button : this.allButtons) {
      if (button.on(mouseX, mouseY)) {
        button.setState("Pressed");
      } else {
        button.setState("Base");
      }
    }
  }
  public void handleMouseReleased() {
    // Highlight button if mouse is on button
    for (Button button : this.allButtons) {
      button.setState("Base");
      if (button.on(mouseX, mouseY)) {
        if (button.getPrevState().equals("Pressed")) {
          this.handleButtons(button);
        }
      }
    }
  }
}
