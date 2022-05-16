public class Game {
  // Fields
  public static final int TILE_SIZE = 64;
  private MainMenu mainMenu;
  private LevelOne levelOne;
  private LevelTwo levelTwo;
  private Settings settings;
  private Upgrade upgrade;
  private Pause pause;
  private Ending ending;
  private String lastLevel;

  // Constructor
  public Game() {
    this.mainMenu = new MainMenu();
  }

  /** Draws the current state of the game */
  public void drawGame() {
    switch(gameState) {
    case "Main_Menu":
      // Error check
      if (this.mainMenu == null) {
        this.mainMenu = new MainMenu();
        this.levelOne = null;
        //this.levelTwo = null;
        this.pause = null;
        this.upgrade = null;
        this.ending = null;
      }
      if (settings != null) {
        this.settings = null;
      }
      // Draw screen
      this.mainMenu.drawMenu();
      break;
    case "Level_One":
      if (this.levelOne == null) {
        this.mainMenu = null;
        this.levelOne = new LevelOne();
        this.levelTwo = null;
        this.settings = null;
        this.upgrade = null;
        this.pause = null;
        this.ending = null;
      }
      this.lastLevel = "Level_One";
      this.levelOne.updateLevel();
      break;
    case "Level_Two":
      if (this.levelTwo == null) {
        this.mainMenu = null;
        this.levelOne = null;
        this.levelTwo = new LevelTwo();
        this.settings = null;
        this.upgrade = null;
        this.pause = null;
        this.ending = null;
      }
      this.lastLevel = "Level_Two";
      this.levelTwo.updateLevel();
      break;
    case "Settings":
      if (this.settings == null) {
        this.settings = new Settings();
      }
      this.settings.drawMenu();
      break;
    case "Upgrade":
      if (this.upgrade == null) {
        this.upgrade = new Upgrade();
      }
      this.upgrade.drawMenu();
      break;
    case "Pause":
      if (this.pause == null) {
        this.pause = new Pause(this.lastLevel);
      }
      this.pause.drawMenu();
      break;
    case "Restart":
      this.levelOne = null;
      this.levelTwo = null;
      gameState = this.lastLevel;
      break;
    default:
      if (this.ending == null) {
        this.mainMenu = null;
        this.levelOne = null;
        this.levelTwo = null;
        this.settings = null;
        this.upgrade = null;
        this.pause = null;
        this.ending = new Ending(gameState);
      }
      this.ending.drawMenu();
      break;
    }
  }

  /** Handles mouse events */
  public void handleMouseMoved() {
    switch(gameState) {
    case "Main_Menu":
      this.mainMenu.handleMouseMoved();
      break;
    case "Level_One":
      this.levelOne.handleMouseMoved();
      break;
    case "Level_Two":
      this.levelTwo.handleMouseMoved();
      break;
    case "Settings":
      this.settings.handleMouseMoved();
      break;
    case "Upgrade":
      this.upgrade.handleMousePressed();
      break;
    case "Pause":
      this.pause.handleMouseMoved();
      break;
    default:
      this.ending.handleMouseMoved();
      break;
    }
  }
  public void handleMousePressed() {
    switch(gameState) {
    case "Main_Menu":
      this.mainMenu.handleMousePressed();
      break;
    case "Level_One":
      this.levelOne.handleMousePressed();
      break;
    case "Level_Two":
      this.levelTwo.handleMousePressed();
      break;
    case "Settings":
      this.settings.handleMousePressed();
      break;
    case "Upgrade":
      this.upgrade.handleMousePressed();
      break;
    case "Pause":
      this.pause.handleMousePressed();
      break;
    default:
      this.ending.handleMousePressed();
      break;
    }
  }
  public void handleMouseReleased() {
    switch(gameState) {
    case "Main_Menu":
      this.mainMenu.handleMouseReleased();
      break;
    case "Level_One":
      this.levelOne.handleMouseReleased();
      break;
    case "Level_Two":
      this.levelTwo.handleMouseReleased();
      break;
    case "Settings":
      this.settings.handleMouseReleased();
      break;
    case "Upgrade":
      this.upgrade.handleMouseReleased();
      break;
    case "Pause":
      this.pause.handleMouseReleased();
      break;
    default:
      this.ending.handleMouseReleased();
      break;
    }
  }

  /** Handles keyboard events */
  public void handleKeyPressed() {
    switch(gameState) {
    case "Level_One":
      if (this.levelOne == null) { 
        return;
      }
      this.levelOne.handleKeyPressed();
      break;
    case "Level_Two":
      if (this.levelTwo == null) { 
        return;
      }
      this.levelTwo.handleKeyPressed();
      break;
    }
  }
  public void handleKeyReleased() {
    switch(gameState) {
    case "Level_One":
      if (this.levelOne == null) { 
        return;
      }
      this.levelOne.handleKeyReleased();
      break;
    case "Level_Two":
      if (this.levelTwo == null) { 
        return;
      }
      this.levelTwo.handleKeyReleased();
      break;
    case "Settings":
      if (this.settings == null) { 
        return;
      }
      this.settings.handleKeyReleased();
      break;
    }
  }
}
