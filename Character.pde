public abstract class Character extends Physics {
  /** Constants */
  protected PImage[][] currLevel;
  protected float hitpoints;
  protected float totalHP;
  protected String lastDir;
  protected float attackDamage;
  protected int attackRange;
  protected String charState;
  protected Sprite idleRightSprite;
  protected Sprite idleLeftSprite;
  protected Sprite runRightSprite;
  protected Sprite runLeftSprite;
  protected Sprite attackRightSprite;
  protected Sprite attackLeftSprite;
  protected boolean alive;

  /** Updates the game character */
  public abstract void update();

  /** Draws the character */
  protected abstract void drawChar();

  /** Functions to draw the character in its different states */
  protected void drawIdleState() {
    if (this.lastDir.equals("right")) {
      this.idleRightSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.idleRightSprite.getWidth();
      this.objectHeight = this.idleRightSprite.getHeight();
    } else if (this.lastDir.equals("left")) {
      this.idleLeftSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.idleLeftSprite.getWidth();
      this.objectHeight = this.idleLeftSprite.getHeight();
    }
  }
  protected void drawRunState() {
    if (this.lastDir.equals("right")) {
      this.runRightSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.runRightSprite.getWidth();
      this.objectHeight = this.runRightSprite.getHeight();
    } else if (this.lastDir.equals("left")) {
      this.runLeftSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.runLeftSprite.getWidth();
      this.objectHeight = this.runLeftSprite.getHeight();
    }
  }
  protected void drawAttackState() {
    if (this.lastDir.equals("right")) {
      this.attackRightSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.attackRightSprite.getWidth();
      this.objectHeight = this.attackRightSprite.getHeight();
    } else if (this.lastDir.equals("left")) {
      this.attackLeftSprite.animate(this.objectPos.x, this.objectPos.y);
      this.objectWidth = this.attackLeftSprite.getWidth();
      this.objectHeight = this.attackLeftSprite.getHeight();
    }
  }

  /** Checks if the character is dead */
  protected void checkDead() {
    if (this.hitpoints <= 0) {
      this.alive = false;
    }
  }

  /** Reduces the character's hitpoints */
  public void reduceHP(float amount) {
    this.hitpoints -= amount;
  }

  /** Draws the character's health bar */
  protected abstract void drawHealthBar();

  /** Returns whether or not the character is dead */
  public boolean isDead() {
    return !this.alive;
  }
}
