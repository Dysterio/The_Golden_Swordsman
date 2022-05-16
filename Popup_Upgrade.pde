public class Upgrade extends Popup {
  // Fields
  private Button attackButton;
  private int attackMax;
  private int attackPerCost;
  private Button hpButton;
  private int hpMax;
  private int hpPerCost;
  private Button speedButton;
  private int speedMax;
  private int speedPerCost;
  private Button closeButton;
  public final PImage OBJ_COIN = loadImage("Misc/coin.png");

  // Constructor
  public Upgrade() {
    // Initialize popup
    this.wd = width/2;
    this.ht = height/2;
    this.bgColour = color(225, 225, 225);
    // Initialize Buttons
    this.attackButton = new Button(int(width/2 - this.wd/2 + this.wd/4), height/2, "Attack\n" + (attackFactor == 3 ? "MAX" : "x " + attackFactor), 22, 90, 70, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.hpButton = new Button(int(width/2 - this.wd/2 + this.wd * 2/4), height/2, "HP\n" + (hpFactor == 3 ? "MAX" : "x " + hpFactor), 22, 90, 70, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.speedButton = new Button(int(width/2 - this.wd/2 + this.wd * 3/4), height/2, "Speed\n" + (speedFactor == 3 ? "MAX" : "x " + speedFactor), 22, 90, 70, "roundedRect", color(0, 0, 0), color(0, 0, 0), color(100, 100, 255));
    this.closeButton = new Button(int(width/2 + this.wd/2), int(height/2 - this.ht/2), "X", 22, 30, 30, "circle", color(0, 0, 0), color(0, 0, 0), color(255, 0, 0));
    // Store buttons in a list
    this.allButtons = new ArrayList<Button>();
    this.allButtons.add(this.attackButton);
    this.allButtons.add(this.hpButton);
    this.allButtons.add(this.speedButton);
    this.allButtons.add(this.closeButton);
    // Initialize upgrade values
    this.attackMax = 3;
    this.attackPerCost = 10;
    this.hpMax = 3;
    this.hpPerCost = 25;
    this.speedMax = 2;
    this.speedPerCost = 5;
  }

  /** Displays the total number of coins the user has collected */
  public void displayCoins(float xPos, float yPos, String coins) {
    image(OBJ_COIN, xPos, yPos);
    fill(0);
    text("x " + coins, xPos + 30 + OBJ_COIN.width, yPos + 12.5);
  }

  public void drawMenu() {
    fill(bgColour);
    rect(width/2 - wd/2, height/2 - ht/2, wd, ht);
    // Draw the buttons
    for (Button button : this.allButtons) {
      button.drawButton();
    }
    // Draw total coins
    this.displayCoins(width/2 - this.wd/2 + 20, height/2 - this.ht/2 + 20, str(totalCoinsCollected));
    // Display costs
    this.displayCoins(this.attackButton.X_POS - this.attackButton.WIDTH/2, this.attackButton.Y_POS + this.attackButton.HEIGHT/1.75, (attackFactor != this.attackMax) ? str(attackFactor * this.attackPerCost) : "∞");
    this.displayCoins(this.hpButton.X_POS - this.hpButton.WIDTH/2, this.hpButton.Y_POS + this.hpButton.HEIGHT/1.75, (hpFactor != this.hpMax) ? str(hpFactor * this.hpPerCost) : "∞");
    this.displayCoins(this.speedButton.X_POS - this.speedButton.WIDTH/2, this.speedButton.Y_POS + this.speedButton.HEIGHT/1.75, (speedFactor != this.speedMax) ? str(speedFactor * this.speedPerCost) : "∞");
    // Display title
    textAlign(CENTER, CENTER);
    textSize(25);
    text("Upgrade", width/2, height/2 - this.ht/2.5);
  }

  /** Start the game */
  protected void handleButtons(Button buttonPressed) {
    if (buttonPressed.getLabel().equals("X")) {
      gameState = "Main_Menu";
    } else if (buttonPressed.getLabel().substring(0, 2).equals("HP")) {
      if (hpFactor != this.hpMax) {
        // Check coins
        if (totalCoinsCollected >= (hpFactor * this.hpPerCost)) {
          totalCoinsCollected -= hpFactor * this.hpPerCost;
          hpFactor++;
          this.hpButton.setLabel("HP\nx " + hpFactor);
        }
      }
      if (hpFactor == this.hpMax) {
        this.hpButton.setLabel("HP\nMAX");
      }
    } else if (buttonPressed.getLabel().substring(0, 5).equals("Speed")) {
      if (speedFactor != this.speedMax) {
        // Check coins
        if (totalCoinsCollected >= (speedFactor * this.speedPerCost)) {
          totalCoinsCollected -= speedFactor * this.speedPerCost;
          speedFactor++;
          this.speedButton.setLabel("Speed\nx " + speedFactor);
        }
      }
      if (speedFactor == this.speedMax) {
        this.speedButton.setLabel("Speed\nMAX");
      }
    } else if (buttonPressed.getLabel().substring(0, 6).equals("Attack")) {
      if (attackFactor != this.attackMax) {
        // Check coins
        if (totalCoinsCollected >= (attackFactor * this.attackPerCost)) {
          totalCoinsCollected -= attackFactor * this.attackPerCost;
          attackFactor++;
          this.attackButton.setLabel("Attack\nx " + attackFactor);
        }
      } 
      if (attackFactor == this.attackMax) {
        this.attackButton.setLabel("Attack\nMAX");
      }
    }
  }
}
