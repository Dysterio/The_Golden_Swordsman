public class MainMenu extends Menu{
  // Fields
  private PImage title;
  private PImage bg;
  private Button startButton;
  private Button settingsButton;
  private Button upgradeButton;
  private Button quitButton;
  private int xOffSet;
  private int offSetInc;

  // Constructor
  public MainMenu() {
    this.offSetInc = -2;
    this.xOffSet = 0;
    this.bg = loadImage("Misc/titleBG.png");
    // Created online at https://www10.flamingtext.com/
    this.title = loadImage("Misc/title.png");
    // Initialize Buttons
    this.startButton = new Button(width/2, height/2, "Start", 22, 140, 60, "roundedRect", color(0), color(0), color(100, 100, 255));
    this.settingsButton = new Button(width/2, this.startButton.Y_POS + this.startButton.HEIGHT + Menu.BUTTON_BUFFER, "Settings", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.upgradeButton = new Button(width/2, this.settingsButton.Y_POS + this.settingsButton.HEIGHT + Menu.BUTTON_BUFFER, "Upgrade", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.quitButton = new Button(60, height - 60, "Quit", 22, 60, 60, "circle", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    // Store buttons in a list
    this.allButtons = new ArrayList<Button>();
    this.allButtons.add(this.startButton);
    this.allButtons.add(this.settingsButton);
    this.allButtons.add(this.upgradeButton);
    this.allButtons.add(this.quitButton);
  }

  /** Draws the main menu */
  public void drawMenu() {
    // Background
    if ((this.xOffSet - width <= -this.bg.width) || (this.xOffSet > 0)) {
      this.offSetInc *= -1;
    }
    image(this.bg, this.xOffSet, 0);
    this.xOffSet += this.offSetInc;
    // Draw the buttons
    for (Button button : this.allButtons) {
      button.drawButton();
    }
    // Title
    image(this.title, width/2 - this.title.width/2, 100);
  }

  /** Handles the buttons */
  protected void handleButtons(Button buttonPressed) {
    switch(buttonPressed.getLabel()) {
    case "Start":
      gameState = "Level_One";
      break;
    case "Settings":
      gameState = "Settings";
      break;
    case "Upgrade":
      gameState = "Upgrade";
      break;
    case "Quit":
      exit();
      break;
    }
  }
}
