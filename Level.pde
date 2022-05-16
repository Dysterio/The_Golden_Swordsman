public abstract class Level {
  /** Constants */
  protected PImage scenery;
  public final PImage BLOCK_SKY = loadImage("Blocks/sky.png");
  public final PImage BLOCK_GRASS = loadImage("Blocks/grass.png");
  public final PImage BLOCK_DIRT = loadImage("Blocks/dirt.png");
  public final PImage OBJ_COIN = loadImage("Misc/coin.png");
  public static final int LEVEL_WIDTH = 121;
  public static final int LEVEL_HEIGHT = 9;
  public static final float GRAVITY = 0.75;
  protected PImage[][] level = new PImage[LEVEL_HEIGHT][LEVEL_WIDTH];
  protected Player player;
  protected List<Enemy> enemies = new ArrayList<Enemy>();
  protected int coinsCollected = 0;
  protected List<Coin> coins = new ArrayList<Coin>();
  protected Button pauseButton = new Button(width - 40, 40, "II", 22, 40, 40, "circle", color(0, 0, 0), color(0, 0, 0), color(128, 128, 128));
  
  /** Update the level */
  public void updateLevel() {
    this.checkGameOver();
    
    // Handle enemies
    this.removeDeadEnemies();
    this.handleEnemyCollision();
    
    // Handle coins
    this.handleCoinCollision();
    this.pickupCoins();
    
    // Draw level
    pushMatrix();
    translate(-this.player.getXOffSet(), 0);
    this.drawLevel();
    
    // Manage enemies
    for (Enemy enemy : this.enemies) {
      enemy.update();
    }
    
    // Manage coins
    for (Coin coin : this.coins) {
      coin.update();
    }
    popMatrix();
    
    // Manage player
    this.handlePlayerCollision();
    this.player.update();
    
    // Display coins collected
    image(OBJ_COIN, 35, 75);
    fill(0);
    text("x " + this.coinsCollected, 65 + OBJ_COIN.width, 87.5);
    
    // Draw pause button
    this.pauseButton.drawButton();
    
    // Check if the level has been cleared */
    this.checkWon();
  }

  /** Draw the level */
  protected void drawLevel() {
    for (int row = 0; row < LEVEL_HEIGHT; row++) {
      for (int col = 0; col < LEVEL_WIDTH; col++) {
        image(this.level[row][col], col * Game.TILE_SIZE, height - ((row + 1) * Game.TILE_SIZE));
      }
    }
    // Draw Scenery
    image(this.scenery, 0, 0);
  }

  /** Initializes the level */
  protected void initializeLevel() {
    this.generateMap();
    this.deployEnemies();
  }

  /** Creates a map and stores it in the 2D array */
  protected abstract void generateMap();

  /** Puts the enemies on the map */
  protected abstract void deployEnemies();

  /**
   * Places a row of grass blocks along the
   * row, startCol and endCol specified
   */
  protected void placeGrass(int row, int startCol, int endCol) {
    for (int col = startCol; col <= endCol; col++) {
      this.level[row][col] = BLOCK_GRASS;
    }
  }

  /**
   * Fills the remaining tiles with either a
   * sky block or a dirt block
   */
  protected void fillLevel() {
    boolean foundGrass = false;
    // Loops through each column
    for (int col = 0; col < LEVEL_WIDTH; col++) {
      for (int row = LEVEL_HEIGHT - 1; row >= 0; row--) {
        // Check for the grass block
        if (this.level[row][col] == BLOCK_GRASS) {
          foundGrass = true;
          continue;
        }
        // Place tile
        if (foundGrass) {
          this.level[row][col] = BLOCK_DIRT;
        } else {
          this.level[row][col] = BLOCK_SKY;
        }
      }
      foundGrass = false;
    }
  }

  /** Removes all dead enemies */
  protected void removeDeadEnemies() {
    // Loop through enemies
    for (int i = 0; i < this.enemies.size(); i++) {
      // Get enemy
      Enemy currEnemy = this.enemies.get(i);
      // Remove enemy if dead
      if (currEnemy.isDead()) {
        // Create coins
        for (int c = 0; c < random(currEnemy.MIN_COINS, currEnemy.MAX_COINS); c++) {
          this.coins.add(new Coin(currEnemy.facingRight(), currEnemy.getXPos(), currEnemy.getYPos()));
        }
        // Remove enemy
        this.enemies.remove(i);
        i--;
      }
    }
  }

  /** Check if player dead */
  protected void checkGameOver() {
    if (this.player.isDead()) {
      gameState = "Lose";
    }
  }
  
  /** Checks if the player has cleared the current level */
  protected abstract void checkWon();

  /** Checks for player collisions */
  protected void handlePlayerCollision() {
    // Get player pos
    int row = int((height - this.player.getYPos())/Game.TILE_SIZE);
    int col = int((this.player.getXPos() + this.player.getXOffSet())/Game.TILE_SIZE);

    // Update ground height
    for (int r = 1; r < LEVEL_HEIGHT; r++) {
      if (this.level[r - 1][col] == BLOCK_GRASS) {
        this.player.setGround(height - (r * Game.TILE_SIZE));
        break;
      }
    }

    // Update right collision
    this.player.setRightCollision(LEVEL_WIDTH * Game.TILE_SIZE);
    for (int c = col + 1; c < LEVEL_WIDTH; c++) {
      if (this.level[row][c] != BLOCK_SKY) {
        this.player.setRightCollision(c * Game.TILE_SIZE);
        break;
      }
    }

    // Update left collision
    this.player.setLeftCollision(0);
    for (int c = col - 1; c >= 0; c--) {
      if (this.level[row][c] != BLOCK_SKY) {
        this.player.setLeftCollision((c + 1) * Game.TILE_SIZE);
        break;
      }
    }
  }

  /** Checks for enemy collisions */
  protected void handleEnemyCollision() {
    // Loops through all enemies
    for (Enemy enemy : this.enemies) {
      // Get enemy pos
      int row = int((height - enemy.getYPos())/Game.TILE_SIZE);
      int col = int(enemy.getXPos()/Game.TILE_SIZE);

      // Update ground height
      for (int r = 1; r < LEVEL_HEIGHT; r++) {
        if (this.level[r - 1][col] == BLOCK_GRASS) {
          enemy.setGround(height - (r * Game.TILE_SIZE));
          break;
        }
      }

      // Update right collision
      enemy.setRightCollision(LEVEL_WIDTH * Game.TILE_SIZE);
      for (int c = col + 1; c < LEVEL_WIDTH; c++) {
        if (this.level[row][c] != BLOCK_SKY) {
          enemy.setRightCollision(c * Game.TILE_SIZE);
          break;
        }
      }

      // Update left collision
      enemy.setLeftCollision(0);
      for (int c = col - 1; c >= 0; c--) {
        if (this.level[row][c] != BLOCK_SKY) {
          enemy.setLeftCollision((c + 1) * Game.TILE_SIZE);
          break;
        }
      }
    }
  }

  /** Checks for coin collisions */
  protected void handleCoinCollision() {
    // Loops through all enemies
    for (Coin coin : this.coins) {
      // Get coin pos
      int row = int((height - coin.getYPos())/Game.TILE_SIZE);
      int col = int(coin.getXPos()/Game.TILE_SIZE);

      // Update ground height
      for (int r = 1; r < LEVEL_HEIGHT; r++) {
        if (this.level[r - 1][col] == BLOCK_GRASS) {
          coin.setGround(height - (r * Game.TILE_SIZE));
          break;
        }
      }

      // Update right collision
      coin.setRightCollision(LEVEL_WIDTH * Game.TILE_SIZE);
      for (int c = col + 1; c < LEVEL_WIDTH; c++) {
        if (this.level[row][c] != BLOCK_SKY) {
          coin.setRightCollision(c * Game.TILE_SIZE);
          break;
        }
      }

      // Update left collision
      coin.setLeftCollision(0);
      for (int c = col - 1; c >= 0; c--) {
        if (this.level[row][c] != BLOCK_SKY) {
          coin.setLeftCollision((c + 1) * Game.TILE_SIZE);
          break;
        }
      }
    }
  }

  /** Allows the player to pick up coins */
  protected void pickupCoins() {
    for (int i = 0; i < this.coins.size(); i++) {
      Coin coin = this.coins.get(i);
      if (!coin.canBePicked()) {
        continue;
      }
      float distance = dist(this.player.getXPos() + this.player.getXOffSet(), this.player.getYPos(), coin.getXPos(), coin.getYPos());
      if (distance <= Coin.PICKUP_RANGE) {
        this.coins.remove(i);
        coinsCollected++;
        totalCoinsCollected++;
        i--;
      }
    }
  }

  /** Handles mouse events on the buttons */
  public void handleMouseMoved() {
    // Highlight button if mouse is on button
    if (this.pauseButton.on(mouseX, mouseY)) {
      this.pauseButton.setState("On");
    } else {
      this.pauseButton.setState("Base");
    }
  }
  public void handleMousePressed() {
    // Highlight button if mouse is on button
    if (this.pauseButton.on(mouseX, mouseY)) {
      this.pauseButton.setState("Pressed");
    } else {
      this.pauseButton.setState("Base");
    }
  }
  public void handleMouseReleased() {
    // Highlight button if mouse is on button
    this.pauseButton.setState("Base");
    if (this.pauseButton.on(mouseX, mouseY)) {
      if (this.pauseButton.getPrevState().equals("Pressed")) {
        gameState = "Pause";
      }
    }
  }

  /** Functions to handle key events */
  public void handleKeyPressed() {
    // Horizontal movement
    if (keyCode == leftKeyCode) {  // 'a' - left
      this.player.setLeft(true);
    } else if (keyCode == rightKeyCode) { // 'd' - right
      this.player.setRight(true);
    }
    // Jumping
    if (keyCode == jumpKeyCode) {  // 'w' - jump
      this.player.setJump(true);
    }
    // Attacking
    if (keyCode == attackKeyCode) {  // 'j' - attack
      this.player.setAttack(true);
    }
  }
  public void handleKeyReleased() {
    // Horizontal movement
    if (keyCode == leftKeyCode) {  // 'a' - left
      this.player.setLeft(false);
    } else if (keyCode == rightKeyCode) { // 'd' - right
      this.player.setRight(false);
    }
    // Jumping
    if (keyCode == jumpKeyCode) {  // 'w' - jump
      this.player.setJump(false);
    }
    // Attacking
    if (keyCode == attackKeyCode) {  // 'j' - attack
      this.player.setAttack(false);
    }
  }
}
