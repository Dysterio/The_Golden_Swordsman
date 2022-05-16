public class Ending extends Menu {
  // Fields
  private String why;
  private PImage endingImage;
  private Button retryButton;
  private Button mainMenuButton;
  private Button quitButton;
  
  // Constructor
  public Ending(String reason) {
    this.why = reason;
    this.endingImage = loadImage("Misc/ending.png");
    // Initialize Buttons
    this.retryButton = new Button(width/4, height * 5/6, "Play Again", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.mainMenuButton = new Button(width * 2/4, height * 5/6, "Main Menu", 22, 140, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.quitButton = new Button(width * 3/4, height * 5/6, "Quit", 22, 150, 60, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    // Store buttons in a list
    this.allButtons = new ArrayList<Button>();
    this.allButtons.add(this.retryButton);
    this.allButtons.add(this.mainMenuButton);
    this.allButtons.add(this.quitButton);
  }
  
  /** Draws the ending screen */
  public void drawMenu() {
    background(0, 255, 255);
    fill(0);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("You " + this.why, width/2, 50);
    // Image
    image(this.endingImage, width/2 - this.endingImage.width/2, height/2 - this.endingImage.height/1.75);
    // Draw the buttons
    for (Button button : this.allButtons) {
      button.drawButton();
    }
  }

  /** Handles the buttons */
  protected void handleButtons(Button buttonPressed) {
    switch(buttonPressed.getLabel()) {
    case "Play Again":
      gameState = "Level_One";
      break;
    case "Main Menu":
      gameState = "Main_Menu";
      break;
    case "Quit":
      exit();
      break;
    }
  }
}
