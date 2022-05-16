public class Pause extends Popup {
  // Fields
  private Button restartButton;
  private Button mainMenuButton;
  private Button settingsButton;
  private Button closeButton;
  private String parent;

  // Constructor
  public Pause(String p) {
    // Initialize popup
    this.parent = p;
    this.wd = width/3;
    this.ht = height/2;
    this.bgColour = color(225, 225, 225);
    // Initialize Buttons
    this.mainMenuButton = new Button(width/2, height/2, "Main Menu", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.restartButton = new Button(width/2, this.mainMenuButton.Y_POS - this.mainMenuButton.HEIGHT - Menu.BUTTON_BUFFER, "Restart", 22, 140, 60, "roundedRect", color(0), color(0), color(100, 100, 255));
    this.settingsButton = new Button(width/2, this.mainMenuButton.Y_POS + this.mainMenuButton.HEIGHT + Menu.BUTTON_BUFFER, "Quit", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.closeButton = new Button(int(width/2 + this.wd/2), int(height/2 - this.ht/2), "X", 22, 30, 30, "circle", color(0, 0, 0), color(0, 0, 0), color(255, 0, 0));
    // Store buttons in a list
    this.allButtons = new ArrayList<Button>();
    this.allButtons.add(this.restartButton);
    this.allButtons.add(this.mainMenuButton);
    this.allButtons.add(this.settingsButton);
    this.allButtons.add(this.closeButton);
  }
  
  /** Draws the popup menu */
  public void drawMenu() {
    // Draw popup
    fill(bgColour);
    rect(width/2 - wd/2, height/2 - ht/2, wd, ht);
    // Draw the buttons
    for (Button button : this.allButtons) {
      button.drawButton();
    }
    // Display title
    textAlign(CENTER, CENTER);
    textSize(18);
    text("Paused", width/2, this.restartButton.Y_POS - this.restartButton.HEIGHT/1.11);
  }

  /** Start the game */
  protected void handleButtons(Button buttonPressed) {
    switch(buttonPressed.getLabel()) {
    case "Restart":
      gameState = "Restart";
      break;
    case "Main Menu":
      gameState = "Main_Menu";
      break;
    case "Quit":
      exit();
      break;
    case "X":
      gameState = this.parent;
      break;
    }
  }
}
