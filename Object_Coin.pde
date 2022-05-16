public class Coin extends Physics {
  // Fields
  public final PImage COIN_SPRITE = loadImage("Misc/coin.png");
  public static final int PICKUP_RANGE = Game.TILE_SIZE/2;
  public static final float FRICTION = 0.5;
  private boolean pickupable;

  // Constructor
  public Coin(boolean right, float xPos, float yPos) {
    // Initialize
    this.objectPos = new PVector(xPos, yPos);
    this.objectVel = new PVector(random(3, 6), random(7, 15));
    this.objectWidth = COIN_SPRITE.width;
    this.objectHeight = COIN_SPRITE.height;
    this.jump = true;
    this.inJump = true;
    this.pickupable = false;
    // Check direction
    if (right) {
      this.objectVel.x *= -1;
    }
  }

  /** Updates the coin */
  public void update() {
    this.reduceVel();
    this.drawCoin();
  }

  /** Reduces the coin's velocities */
  private void reduceVel() {
    this.applyGravity();
    this.moveObj();
  }

  /** Applies friction to the coin */
  protected void moveObj() {
    if (!onGround) {
      if (this.objectPos.x + this.objectWidth < this.rightCollision) {
        if (this.objectPos.x - this.objectWidth > this.leftCollision) {
          this.objectPos.x += this.objectVel.x;
        } else {
          this.objectVel.x = 0;
          this.objectPos.x = this.leftCollision + this.objectWidth;
        }
      } else {
        this.objectVel.x = 0;
        this.objectPos.x = this.rightCollision - this.objectWidth;
      }
    } else {
      this.objectVel.set(0, 0);
      this.pickupable = true;
    }
  }

  /** Draws the coin */
  private void drawCoin() {
    image(COIN_SPRITE, this.objectPos.x - this.objectWidth/2, this.objectPos.y - this.objectHeight/2);
  }
  
  /** Returns whether the coins can be picked up */
  public boolean canBePicked() {
    return this.pickupable;
  }
}
