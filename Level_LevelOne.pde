public class LevelOne extends Level {
  // Constructor
  public LevelOne() {
    // Initialize
    this.scenery = loadImage("Misc/Scenery/level_1.png");
    this.player = new Player(this.level, this.enemies);
    // Create level
    this.initializeLevel();
  }

  /** Creates the map and stores it in the 2d array */
  protected void generateMap() {
    this.placeGrass(1, 0, 20);
    this.placeGrass(2, 21, 22);
    this.placeGrass(3, 23, 25);
    this.placeGrass(4, 26, 29);
    this.placeGrass(5, 30, 48);
    this.placeGrass(4, 49, 50);
    this.placeGrass(2, 51, 52);
    this.placeGrass(1, 53, 54);
    this.placeGrass(2, 55, 56);
    this.placeGrass(3, 57, 75);
    this.placeGrass(4, 76, 78);
    this.placeGrass(5, 79, 82);
    this.placeGrass(4, 83, 85);
    this.placeGrass(3, 86, 89);
    this.placeGrass(2, 90, 92);
    this.placeGrass(1, 93, 96);
    this.placeGrass(0, 97, 98);
    this.placeGrass(1, 99, 109);
    this.placeGrass(2, 110, 120);
    this.fillLevel();
  }

  /** Places the enemies in their respective positions in the map */
  protected void deployEnemies() {
    for (int i = 0; i < 5; i++) {
      this.enemies.add(new Enemy(this.level, this.player, "1", 25, 0.25, (20 * (i + 1)) * Game.TILE_SIZE, 3, 2, 6));
    }
  }

  /** Checks if the player has won */
  protected void checkWon() {
    if (int((this.player.getXPos() + this.player.getXOffSet())/Game.TILE_SIZE) >= Level.LEVEL_WIDTH - 2) {
      gameState = "Level_Two";
    }
  }
}
