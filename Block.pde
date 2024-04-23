class Block{
  //Initializes block variables
  
  int x;
  int y;
  int w;
  color blockColor;
  
  color c;
  
  int hp;
  boolean shouldRemove = false;
  
  int top;
  int bottom;
  int left;
  int right;
  
  Block(int startingX, int startingY, int startingW, int startingHP){
    
    x = startingX;
    y = startingY;
    w = startingW;
    
    hp = startingHP;
    
  }
  //Renders the blocks if they have health left.
  void render(){
 if(desktopView == false){
  w = 100;
 }
 else if(desktopView == true){
 w = 200; 
 }
    if(hp > 0){
   rectMode(CENTER);
   //Sets the color of the block based on how much health it has left.
   if(hp <= 1){
 blockColor = color(240, 27, 91);
 }
 else if(hp <= 2){
 blockColor = color(247, 149, 57);
 }
  else if(hp <= 3){
    blockColor = color(229, 221, 53);
 }
 else if(hp <= 4){
    blockColor = color(88, 203, 53);
 }
  else if(hp <= 5){
    blockColor = color(44, 106, 227);
 }
 else if(hp <= 6){
    blockColor = color(114, 37, 193);
 }
 else if(hp <= 7){
      blockColor = color(216, 46, 214); 
 }
  else if(hp <= 8){
      blockColor = color(11, 118, 60); 
 }
  else if(hp <= 9){
      blockColor = color(2, 148, 155); 
 }
 else{
  blockColor = color(0, 0, 0); 
 }
   fill(blockColor);
   rect(x, y, w, w, 20);
   textAlign(CENTER);
   fill(59, 73, 100);
   //Sets the text on the block to display its health.
   if(desktopView == false){
   textSize(70);
   text(hp, x, y+22);
   }
   else {
   textSize(120); 
   text(hp, x, y+35);
   }
    }
   else {
     //REMOVE FROM THE ARRAY LIST
     shouldRemove = true;
   }
    }
  //Allows the ball to bounce if it collides with the hitbox of the block.
 
 //Renders the hitboxes of the blocks and bounces the ball if a collision is detected.

void ballBounce(){
 if(ball.bottom >= top && ball.top <= top && ball.right <= right && ball.left >= left){
  println("BOUNCE TOP");
  ball.ySpeed = -abs(ball.ySpeed);
  hp -= 1;
  breakSound.play();
  score = score+10;
    }
    
  if(ball.top <= bottom && ball.bottom >= bottom && ball.right <= right && ball.left >= left){
  println("BOUNCE BOTTOM");
  ball.ySpeed = abs(ball.ySpeed);
  hp -= 1;
   breakSound.play();
  score = score+10;
    }
  
  if(ball.right >= left && ball.right <= right && ball.bottom <= bottom && ball.top >= top){
   ball.xSpeed = -abs(ball.xSpeed); 
   hp -= 1;
   breakSound.play();
   score = score+10;
   println("BOUNCE LEFT");
  }
  
    if(ball.left <= right && ball.left >= left && ball.bottom <= bottom && ball.top >= top){
  ball.xSpeed = abs(ball.xSpeed); 
  hp -= 1;
  breakSound.play();
  score = score+10;
  println("BOUNCE RIGHT");
  }
 }

//Creates and updates the hitboxes of the blocks.

void hitboxes(){
  if(desktopView == false){
    top = y - 50;
   bottom = y + 50;
   left = x - 50;
   right = x + 50; 
  }
  else if (desktopView == true){
   top = y - 100;
   bottom = y + 100;
   left = x - 100;
   right = x + 100; 
  }
}
}
