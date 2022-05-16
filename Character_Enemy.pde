public class Enemy extends Character {
  // Fields
  private Player player;
  private int followRange;
  public final int MIN_COINS;
  public final int MAX_COINS;

  // Constructor
  public Enemy(PImage[][] lvl, Player p, String enemyType, int hp, float dmg, float xPos, float xVel, int minCoins, int maxCoins) {
    this.currLevel = lvl;
    this.player = p;
    this.hitpoints = hp;
    this.totalHP = hp;
    this.objectWidth = Game.TILE_SIZE/2;
    this.objectHeight = Game.TILE_SIZE/2;
    this.objectPos = new PVector(xPos, Game.TILE_SIZE);
    this.objectVel = new PVector(xVel, 10);
    this.lastDir = "left";
    this.leftCollision = 0;
    this.rightCollision = (Level.LEVEL_WIDTH - 1) * Game.TILE_SIZE;
    this.attackDamage = dmg;
    this.attackRange = int(this.objectWidth);
    this.followRange = 7 * Game.TILE_SIZE;
    this.jump = false;
    this.inJump = false;
    this.initialYVel = this.objectVel.y;
    this.charState = "idle";
    this.idleRightSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Idle/Right/idle_", 1, 0);
    this.idleLeftSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Idle/Left/idle_", 1, 0);
    this.runRightSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Run/Right/run_", enemyType.equals("1") ? 2 : 4, enemyType.equals("1") ? 0.5 : 0.25);
    this.runLeftSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Run/Left/run_", enemyType.equals("1") ? 2 : 4, enemyType.equals("1") ? 0.5 : 0.25);
    this.attackRightSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Attack/Right/attack_", 6, 0.15);
    this.attackLeftSprite = new Sprite("Sprites/Enemy/Enemy_" + enemyType + "/Attack/Left/attack_", 6, 0.15);
    this.alive = true;
    MIN_COINS = minCoins;
    MAX_COINS = maxCoins;
  }

  /** Updates the enemy */
  public void update() {
    this.checkDead();
    this.updateEnemyState();
    this.updateEnemyDirection();
    this.applyGravity();
    this.moveObj();
    this.errorCheckCharPos();
    this.drawChar();
  }

  /** Updates the enemy's state based on the player's position */
  private void updateEnemyState() {
    // Calculate distance between the player and enemy
    float distance = dist(this.player.getXPos() + this.player.getXOffSet(), this.player.getYPos(), this.objectPos.x, this.objectPos.y);
    // Update state based on distance
    if (distance <= this.attackRange) {
      this.charState = "attack";
    } else if (distance <= this.followRange) {
      this.charState = "follow";
    } else {
      this.charState = "idle";
    }
  }

  /** Updates the enemy's movement direction based on the player's position */
  private void updateEnemyDirection() {
    this.lastDir = (this.player.getXPos() + this.player.getXOffSet() < this.objectPos.x) ? "left" : "right";
  }

  /** Draws the enemy */
  protected void drawChar() {
    // Draw the enemy's health bar
    this.drawHealthBar();
    // Check the enemy's state
    switch (this.charState) {
    case "idle":
      this.drawIdleState();
      break;
    case "follow":
      this.drawRunState();
      break;
    case "attack":
      this.drawAttackState();
      break;
    }
  }

  /** Draws the enemy's health bar */
  protected void drawHealthBar() {
    // Background
    noStroke();
    fill(200, 0, 0);
    rect(this.objectPos.x - 25, this.objectPos.y - this.objectHeight, 50, 10);
    // HP
    fill(0, 255, 0);
    rect(this.objectPos.x - 25, this.objectPos.y - this.objectHeight, (this.hitpoints/this.totalHP) * 50, 10);
    // Border
    stroke(0);
    strokeWeight(2);
    noFill();
    rect(this.objectPos.x - 25, this.objectPos.y - this.objectHeight, 50, 10);
  }

  /** Moves the enemy */
  protected void moveObj() {
    switch(this.charState) {
    case "follow":
      if (this.lastDir.equals("right")) {  // Move right
        // Check for collision
        if (this.objectPos.x + this.objectWidth/2 < this.rightCollision) {
          this.objectPos.x += this.objectVel.x;
          this.jump = false;
        } else {
          this.objectPos.x = this.rightCollision - this.objectWidth/2;
          this.jump = true;
        }
      } else {  // Move left
        // Check for collision
        if (this.objectPos.x - this.objectWidth/2 > this.leftCollision) {
          this.objectPos.x -= this.objectVel.x;
          this.jump = false;
        } else {
          this.objectPos.x = this.leftCollision + this.objectWidth/2;
          this.jump = true;
        }
      }
      break;
    case "attack":
      // Create hitbox
      Hitbox attackHitbox = new Hitbox(this.objectPos.x + (this.lastDir.equals("right") ? this.objectWidth/2 : -this.objectWidth/2), this.objectPos.y, this.attackRange, this.objectHeight);
      // Check if player is being damaged
      if (attackHitbox.checkCollision(new Hitbox(this.player.getXPos() + this.player.getXOffSet(), this.player.getYPos(), this.player.getWidth(), this.player.getHeight()))) {
        // Deal damage
        this.player.reduceHP(this.attackDamage);
      }
      break;
    }
  }

  /** Checks that the enemy is not past one of its boundaries */
  private void errorCheckCharPos() {
    // Right side
    if (this.objectPos.x + this.objectWidth/2 > this.rightCollision) {
      this.objectPos.x = this.rightCollision - this.objectWidth/2;
      this.jump = true;
    }
    // Left side
    if (this.objectPos.x - this.objectWidth/2 < this.leftCollision) {
      this.objectPos.x = this.leftCollision + this.objectWidth/2;
    }
  }
  
  /** Returns the enemy's facing direction */
  public boolean facingRight() {
    return this.lastDir.equals("right");
  }
}
