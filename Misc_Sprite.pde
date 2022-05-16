public class Sprite {
  // Fields
  private PImage[] images;
  public final int IMAGE_COUNT;
  private int frame;
  private float delay;
  private float delayCounter;
  
  // Constructor
  public Sprite(String spriteFilePrefix, int numOfImages, float delayBetweenFrames) {
    // Initialize fields
    this.images = new PImage[numOfImages];
    IMAGE_COUNT = numOfImages;
    this.delay = delayBetweenFrames;
    this.delayCounter = 0;
    // Get images
    for (int i = 0; i < this.IMAGE_COUNT; i++) {
      this.images[i] = loadImage(spriteFilePrefix + i + ".png");
    }
  }
  
  /** Displays and animates the sprite */
  public void animate(float xPos, float yPos) {
    this.delayCounter += this.delay;
    this.frame = (this.frame + floor(this.delayCounter)) % this.IMAGE_COUNT;
    if (this.delayCounter >= 1) { this.delayCounter = 0; }
    PImage currImage = this.images[this.frame];
    image(currImage, xPos - currImage.width/2, yPos - currImage.height/2);
  }
  
  /** Return the sprite's current frame */
  public int getFrame() {
    return this.frame;
  }
  
  /** Returns the sprite's dimensions */
  public int getWidth() {
    return this.images[0].width;
  }
  public int getHeight() {
    return this.images[0].height;
  }
}
