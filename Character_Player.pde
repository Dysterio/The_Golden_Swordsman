public class Player extends Character {
  // Fields
  private boolean left;
  private boolean right;
  private boolean attack;
  private int xOffSet;
  private List<Enemy> enemies;

  // Constructor
  public Player(PImage[][] lvl, List<Enemy> allEnemies) {
    this.currLevel = lvl;
    this.xOffSet = 0;
    this.enemies = allEnemies;
    this.hitpoints = 100 * hpFactor;
    this.totalHP = this.hitpoints;
    this.objectWidth = Game.TILE_SIZE/2;
    this.objectHeight = Game.TILE_SIZE/2;
    this.objectPos = new PVector(100, height/2);
    this.objectVel = new PVector(5 * speedFactor, 10);
    this.lastDir = "right";
    this.left = false;
    this.leftCollision = 0;
    this.right = false;
    this.rightCollision = (Level.LEVEL_WIDTH - 1) * Game.TILE_SIZE;
    this.attack = false;
    this.attackDamage = 5 * attackFactor;
    this.attackRange = int(this.objectWidth);
    this.jump = false;
    this.inJump = false;
    this.initialYVel = this.objectVel.y;
    this.charState = "idle";
    this.idleRightSprite = new Sprite("Sprites/Player/Idle/Right/idle_", 2, 0.01);
    this.idleLeftSprite = new Sprite("Sprites/Player/Idle/Left/idle_", 2, 0.01);
    this.runRightSprite = new Sprite("Sprites/Player/Run/Right/run_", 10, 0.25 * speedFactor);
    this.runLeftSprite = new Sprite("Sprites/Player/Run/Left/run_", 10, 0.25 * speedFactor);
    this.attackRightSprite = new Sprite("Sprites/Player/Attack/Right/attack_", 6, 0.15);
    this.attackLeftSprite = new Sprite("Sprites/Player/Attack/Left/attack_", 6, 0.15);
    this.alive = true;
  }

  /** Updates the player */
  public void update() {
    this.checkDead();
    this.applyGravity();
    this.moveObj();
    this.errorCheckCharPos();
    this.drawChar();
  }

  /** Draws the player */
  protected void drawChar() {
    // Draw the health bar
    this.drawHealthBar();
    // Check player state
    switch (this.charState) {
    case "idle":
      this.drawIdleState();
      break;
    case "run":
      this.drawRunState();
      break;
    case "attack":
      this.drawAttackState();
      break;
    }
  }

  /** Draws the player's health bar */
  protected void drawHealthBar() {
    // Background
    noStroke();
    fill(200, 0, 0);
    rect(50, 35, 150, 25, 12.5);
    // HP
    fill(0, 255, 0);
    rect(50, 35, (this.hitpoints/this.totalHP) * 150, 25, 12.5);
    // Border
    stroke(0);
    strokeWeight(2);
    noFill();
    rect(50, 35, 150, 25, 12.5);
    // Heart
    image(loadImage("Misc/heart.png"), 35, 30);
  }

  /** Moves the player */
  protected void moveObj() {
    // Move right
    if (right) {
      // Update variables
      this.charState = "run";
      this.lastDir = "right";
      // Check for collision
      if (this.objectPos.x + this.xOffSet + this.objectWidth/2 < this.rightCollision) {
        this.moveRight();
      } else {
        this.objectPos.x = this.rightCollision - this.objectWidth/2 - this.xOffSet;
      }
    } else if (left) {
      // Update variables
      this.charState = "run";
      this.lastDir = "left";
      // Check for collision
      if (this.objectPos.x + this.xOffSet - this.objectWidth/2 > this.leftCollision) {
        this.moveLeft();
      } else {
        this.objectPos.x = this.leftCollision + this.objectWidth/2 - this.xOffSet;
      }
    } else if (attack && !inJump) {
      this.charState = "attack";
      Hitbox attackHitbox = new Hitbox(this.objectPos.x + this.xOffSet + (this.lastDir.equals("right") ? this.objectWidth/2 : -this.objectWidth/2), this.objectPos.y, this.attackRange, this.objectHeight);
      // Check enemies being damaged
      for (Enemy enemy : this.enemies) {
        if (attackHitbox.checkCollision(new Hitbox(enemy.getXPos(), enemy.getYPos(), enemy.getWidth(), enemy.getHeight()))) {
          // Deal damage
          enemy.reduceHP(this.attackDamage);
        }
      }
    } else {
      this.charState = "idle";
    }
  }

  /** Moves the player right */
  private void moveRight() {
    if (this.objectPos.x < width/2) {
      // Move the player to the right
      this.objectPos.x += this.objectVel.x;
    } else {
      if (!(this.xOffSet + width >= Level.LEVEL_WIDTH * Game.TILE_SIZE)) {
        // Move the map backwards
        this.xOffSet += int(this.objectVel.x);
      } else {
        // Move the player to the end of the map
        this.objectPos.x += this.objectVel.x;
        this.xOffSet = (Level.LEVEL_WIDTH * Game.TILE_SIZE) - width;
      }
    }
  }

  /** Moves the player left */
  private void moveLeft() {
    if (this.objectPos.x > width/3) {
      // Move the player to the right
      this.objectPos.x -= this.objectVel.x;
    } else {
      if (this.xOffSet > 0) {
        // Move the map foward
        this.xOffSet -= int(this.objectVel.x);
      } else {
        // Move the player to the end of the map
        this.objectPos.x -= this.objectVel.x;
        this.xOffSet = 0;
      }
    }
  }

  /** Checks that the player is not past one of its boundaries */
  private void errorCheckCharPos() {
    // Right side
    if (this.objectPos.x + this.xOffSet + this.objectWidth/2 > this.rightCollision) {
      this.objectPos.x = this.rightCollision - this.objectWidth/2 - this.xOffSet;
    }
    // Left side
    if (this.objectPos.x + this.xOffSet - this.objectWidth/2 < this.leftCollision) {
      this.objectPos.x = this.leftCollision + this.objectWidth/2 - this.xOffSet;
    }
  }

  /** Returns the horizontal offset */
  public int getXOffSet() {
    return this.xOffSet;
  }

  /** Sets the player's direction */
  public void setLeft(boolean newLeft) {
    this.left = newLeft;
  }
  public void setRight(boolean newRight) {
    this.right = newRight;
  }
  public void setJump(boolean newJump) {
    this.jump = newJump;
  }
  public void setAttack(boolean newAttack) {
    this.attack = newAttack;
  }
}
