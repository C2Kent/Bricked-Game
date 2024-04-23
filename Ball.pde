class Ball{
  //////// Initial ball variables
  int x;
  int y;
  int d;
  
  color c;
  
  float xSpeed;
  float ySpeed;
  
   float top;
   float bottom;
   float right;
   float left;
  
  
  //////// Constructor function
  Ball(int startingX, int startingY, int startingD, color startingC){

    x = startingX;
    y = startingY;
    d = startingD;
    
    c = startingC;
    
    xSpeed = 50;
    ySpeed = 50;
    
  }
  
 //////// Ball functions
 void render() {
    fill(c);
    noStroke();
    circle(x, y, d);
  }

  /*
This function takes updates the position the ball according to its speed.
   */
  void move() {
    x += xSpeed;
    y += ySpeed;
  }
  //This function allows the player to move
  void playerMove(){
  if (isMovingLeft == true && x > 50){
   x -= 10; 
  }
  
  if (isMovingRight == true && x < width-50){
  x += 10; 
   }
  }


   void wallDetect() {
    // wall detection for the right wall
    if (x+d/2 >= width) {
      xSpeed = -abs(xSpeed);
      bounceSound.play();
    }
    // wall detection for left wall
    if (x-d/2 <= 0) {
      xSpeed = abs(xSpeed);
      bounceSound.play();
    }

    // wall detection for the bottom wall
    if (y-(d*3) >= height) {
      println(y);
      ballReset();
    }
    // wall detection for left wall
    if (y-d/2 <= 0) {
       bounceSound.play();
      ySpeed = abs(ySpeed);
    }
  }
  //Resets the ball when it goes past the bottom of the screen.
  void ballReset(){
    println("RESET BALL");
    progress();
    generate();
    preLaunch();
    //ballListModify();
    
    ball = new Ball(width/2, height-50, 50, color(200, 200, 200));
    
     ballMove = false;
    //balls();
    delay(200);

  }
  //Creates hitboxes for the ball
  void hitboxes(){
   top = y-d/2;
   bottom = y+d/2;
   right = x+d/2;
   left = x-d/2;
  }
}
