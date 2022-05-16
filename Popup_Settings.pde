public class Settings extends Popup {
  // Fields
  private Button leftButton;
  private Button jumpButton;
  private Button rightButton;
  private Button attackButton;
  private Button closeButton;
  private int buttonSize;
  String buttonToChange;

  // Constructor
  public Settings() {
    // Initialize popup
    this.wd = width/2;
    this.ht = height/2;
    this.bgColour = color(225, 225, 225);
    this.buttonSize = 60;
    this.buttonToChange = "";
    // Initialize Buttons
    this.leftButton = new Button(width/2 - (Menu.BUTTON_BUFFER * 3) - (this.buttonSize * 2) - this.buttonSize/2, height/2 + Menu.BUTTON_BUFFER/2 + this.buttonSize/2, str(char(leftKeyCode)), 22, this.buttonSize, this.buttonSize, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.jumpButton = new Button(width/2 - (Menu.BUTTON_BUFFER * 2) - this.buttonSize - this.buttonSize/2, height/2 + Menu.BUTTON_BUFFER/2 + this.buttonSize/2 - this.buttonSize - Menu.BUTTON_BUFFER, str(char(jumpKeyCode)), 22, this.buttonSize, this.buttonSize, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.rightButton = new Button(width/2 - Menu.BUTTON_BUFFER - this.buttonSize/2, height/2 + Menu.BUTTON_BUFFER/2 + this.buttonSize/2, str(char(rightKeyCode)), 22, this.buttonSize, this.buttonSize, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.attackButton = new Button(width/2 + (Menu.BUTTON_BUFFER * 2) + (this.buttonSize * 2), height/2, str(char(attackKeyCode)), 22, this.buttonSize, this.buttonSize, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.closeButton = new Button(int(width/2 + this.wd/2), int(height/2 - this.ht/2), "X", 22, 30, 30, "circle", color(0, 0, 0), color(0, 0, 0), color(255, 0, 0));
    // Store buttons in a list
    this.allButtons = new ArrayList<Button>();
    this.allButtons.add(this.leftButton);
    this.allButtons.add(this.jumpButton);
    this.allButtons.add(this.rightButton);
    this.allButtons.add(this.attackButton);
    this.allButtons.add(this.closeButton);
  }

  /** Draws the popup menu */
  public void drawMenu() {
    fill(bgColour);
    rect(width/2 - wd/2, height/2 - ht/2, wd, ht);
    // Draw the buttons
    for (Button button : this.allButtons) {
      button.drawButton();
    }
    // Draw labels
    fill(0);
    textSize(15);
    text("Left", this.leftButton.X_POS, this.leftButton.Y_POS - this.buttonSize/1.25);
    text("Jump", this.jumpButton.X_POS, this.jumpButton.Y_POS - this.buttonSize/1.25);
    text("Right", this.rightButton.X_POS, this.rightButton.Y_POS - this.buttonSize/1.25);
    text("Attack", this.attackButton.X_POS, this.attackButton.Y_POS - this.buttonSize/1.25);
    // Draw instructions box
    if (!this.buttonToChange.equals("")) {
      stroke(0);
      fill(255);
      rect(width/2 - 75, height/2 - 25, 150, 50);
      fill(0);
      text("Enter new key", width/2, height/2);
    }
    // Display title
    textAlign(CENTER, CENTER);
    textSize(25);
    text("Settings", width/2, height/2 - this.ht/2.5);
  }

  /** Start the game */
  protected void handleButtons(Button buttonPressed) {
    String label = buttonPressed.getLabel();
    if (label.equals(str(char(leftKeyCode)))) {
      this.buttonToChange = "left";
    } else if (label.equals(str(char(jumpKeyCode)))) {
      this.buttonToChange = "jump";
    } else if (label.equals(str(char(rightKeyCode)))) {
      this.buttonToChange = "right";
    } else if (label.equals(str(char(attackKeyCode)))) {
      this.buttonToChange = "attack";
    } else if (label.equals("X")) {
      gameState = "Main_Menu";
    }
  }

  /** Handles keyboard release events */
  public void handleKeyReleased() {
    switch(this.buttonToChange) {
    case "left":
      if ((keyCode != rightKeyCode) && (keyCode != jumpKeyCode) && (keyCode != attackKeyCode)) {
        leftKeyCode = keyCode;
      }
      this.buttonToChange = "";
      this.leftButton.setLabel(str(char(leftKeyCode)));
      break;
    case "jump":
      if ((keyCode != leftKeyCode) && (keyCode != rightKeyCode) && (keyCode != attackKeyCode)) {
        jumpKeyCode = keyCode;
      }
      this.buttonToChange = "";
      this.jumpButton.setLabel(str(char(jumpKeyCode)));
      break;
    case "right":
      if ((keyCode != leftKeyCode) && (keyCode != jumpKeyCode) && (keyCode != attackKeyCode)) {
        rightKeyCode = keyCode;
      }
      this.buttonToChange = "";
      this.rightButton.setLabel(str(char(rightKeyCode)));
      break;
    case "attack":
      if ((keyCode != leftKeyCode) && (keyCode != jumpKeyCode) && (keyCode != rightKeyCode)) {
        attackKeyCode = keyCode;
      }
      this.buttonToChange = "";
      this.attackButton.setLabel(str(char(attackKeyCode)));
      break;
    }
  }
}
