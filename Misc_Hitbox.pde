public class Hitbox {
  // Fields
  private PVector hitboxPos;
  private float hitboxWidth;
  private float hitboxHeight;

  // Constructor
  public Hitbox(float x, float y, float hbWidth, float hbHeight) {
    this.hitboxPos = new PVector(x, y);
    this.hitboxWidth = hbWidth;
    this.hitboxHeight = hbHeight;
  }

  /** Checks for collision between this hitbox and some other object */
  public boolean checkCollision(Hitbox other) {
    return ((this.hitboxPos.x + this.hitboxWidth/2 >= other.getPos().x) &&
      (this.hitboxPos.x <= other.getPos().x + other.getWidth()/2) &&
      (this.hitboxPos.y + this.hitboxHeight/2 >= other.getPos().y) &&
      (this.hitboxPos.y <= other.getPos().y + other.getHeight()/2));
  }

  /**
   * Returns the hitbox's properties
   */
  public PVector getPos() {
    return this.hitboxPos;
  }
  public float getWidth() {
    return this.hitboxWidth;
  }
  public float getHeight() {
    return this.hitboxHeight;
  }
  
  public void drawHB() {
    fill(255, 0, 0);
    rect(this.hitboxPos.x - this.hitboxWidth/2, this.hitboxPos.y - this.hitboxHeight/2, this.hitboxWidth, this.hitboxHeight);
  }
}
