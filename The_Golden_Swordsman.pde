// Import Libraries
import java.util.*;

// Variables
Game game;
String gameState;
// Keys
int leftKeyCode = 65;
int rightKeyCode = 68;
int jumpKeyCode = 87;
int attackKeyCode = 74;
// Coins
int totalCoinsCollected = 0;
// Upgrades
int attackFactor = 1;
int hpFactor = 1;
int speedFactor = 1;

void setup() {
  // Setup Canvas
  size(1088, 576);
  // Set up the game
  game = new Game();
  gameState = "Main_Menu";
  totalCoinsCollected = 0;
}

void draw() {
  // Game
  game.drawGame();
}

/** Handle mouse events */
void mouseMoved() {
  game.handleMouseMoved();
}
void mousePressed() {
  game.handleMousePressed();
}
void mouseReleased() {
  game.handleMouseReleased();
}

/** Handle keyboard events */
void keyPressed() {
  game.handleKeyPressed();
}
void keyReleased() {
  game.handleKeyReleased();
}
