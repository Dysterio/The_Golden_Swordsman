public class LevelTwo extends Level {
  // Constructor
  public LevelTwo() {
    // Initialize
    this.scenery = loadImage("Misc/Scenery/level_2.png");
    this.player = new Player(this.level, this.enemies);
    // Create level
    this.initializeLevel();
  }

  /** Creates the map and stores it in the 2d array */
  protected void generateMap() {
    this.placeGrass(5, 0, 5);
    this.placeGrass(4, 6, 6);
    this.placeGrass(3, 7, 7);
    this.placeGrass(3, 8, 8);
    this.placeGrass(2, 9, 9);
    this.placeGrass(3, 10, 20);
    this.placeGrass(2, 21, 23);
    this.placeGrass(3, 24, 26);
    this.placeGrass(2, 27, 29);
    this.placeGrass(1, 30, 32);
    this.placeGrass(2, 33, 59);
    this.placeGrass(3, 60, 71);
    this.placeGrass(4, 72, 72);
    this.placeGrass(3, 73, 73);
    this.placeGrass(4, 74, 74);
    this.placeGrass(3, 75, 96);
    this.placeGrass(2, 97, 101);
    this.placeGrass(3, 102, 109);
    this.placeGrass(2, 110, 120);
    this.fillLevel();
  }

  /** Places the enemies in their respective positions in the map */
  protected void deployEnemies() {
    for (int i = 0; i < 5; i++) {
      this.enemies.add(new Enemy(this.level, this.player, "2", 50, 0.5, (20 * (i + 1)) * Game.TILE_SIZE, 4, 5, 10));
    }
  }

  /** Checks if the player has won */
  protected void checkWon() {
    if (int((this.player.getXPos() + this.player.getXOffSet())/Game.TILE_SIZE) >= Level.LEVEL_WIDTH - 2) {
      gameState = "Won";
    }
  }
}
