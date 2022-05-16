public abstract class Physics {
  // Fields
  protected PVector objectPos;
  protected PVector objectVel;
  protected float objectWidth;
  protected float objectHeight;
  protected int leftCollision;
  protected int rightCollision;
  protected boolean jump;
  protected boolean inJump;
  protected float initialYVel;
  protected float groundYPos;
  protected boolean onGround;

  /**
   * Applies gravity to the character and
   * allows them to jump
   */
  protected void applyGravity() {
    // Update onGround
    this.onGround = this.objectPos.y + this.objectHeight/2 >= this.groundYPos;
    // Apply gravity
    if (!onGround) {
      if (!inJump) {
        this.objectVel.y = 0;
        this.inJump = true;
      }
      this.objectVel.y -= Level.GRAVITY;
      this.objectPos.y -= min(this.objectVel.y, this.groundYPos - this.objectPos.y + this.objectHeight/2);
    } else {
      this.objectVel.y = this.initialYVel;
      this.objectPos.y = this.groundYPos - this.objectHeight/2;
      this.inJump = false;
    }
    // Jump
    if (this.jump && !this.inJump) {
      this.inJump = true;
      this.objectPos.y -= this.objectVel.y;
    }
  }

  /** Moves the object */
  protected abstract void moveObj();

  /** Sets the character's ground vertical position */
  public void setGround(int newGround) { 
    this.groundYPos = newGround;
  }

  /** Sets the left and right collision values */
  public void setLeftCollision(int leftWall) {
    this.leftCollision = leftWall;
  }
  public void setRightCollision(int rightWall) {
    this.rightCollision = rightWall;
  }

  /** Returns the character's dimensions and positions */
  public float getWidth() {
    return this.objectWidth;
  }
  public float getHeight() {
    return this.objectHeight;
  }
  public float getXPos() {
    return this.objectPos.x;
  }
  public float getYPos() {
    return this.objectPos.y;
  }
}
