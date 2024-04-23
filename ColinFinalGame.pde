//Create the original ball.
Ball ball; 
//Create list for the blocks
ArrayList<Block> blockList;
//Creates button and images
Button modeButton;
PImage logo;
PImage lose;
//Imports sound library and creates sound variables
import processing.sound.*;

SoundFile bounceSound;
SoundFile breakSound;
SoundFile menuSong;
SoundFile gameTheme;
SoundFile loseSong;

//Creates booleans for the game
boolean isMovingLeft = false;
boolean isMovingRight = false;
boolean desktopView = false;
boolean firstTime = true;
boolean firstGenerate = true;
boolean ballMove = false;
boolean levelAdvance = false;
boolean gameStart = false;
boolean gameLost = false;

 //Creates global variables for the game
int screen = 1;
int levelCount = 1;
int score = 0;
int finalScore = 0;
int blockSize;
int spawnX;
int spawnY;

void setup(){
    println("SETUP");
  size(600, 1000);
  //Sets initial values for the ball, button, and the blocks. Sets their position, health, and color.
  ball = new Ball(width/2, height-50, 50, color(200, 200, 200));
  modeButton = new Button(width/2, 900, 200, 50, color(114, 37, 193));
  blockList = new ArrayList<Block>();
  //Loads all sound files and images
  bounceSound = new SoundFile (this, "clickSound.mp3");
  bounceSound.rate(0.8);
  breakSound = new SoundFile (this, "popsound.mp3");
  breakSound.rate(0.8);
  menuSong = new SoundFile (this, "menusong.mp3");
  gameTheme = new SoundFile (this, "gameTheme.mp3");
  loseSong = new SoundFile (this, "lose.mp3");
  logo = loadImage("logo.png");
  logo.resize(600, 600);
  lose = loadImage("lose.png");
  lose.resize(400, 400);
  imageMode(CENTER);
  menuScreen();
}

void draw(){
  //If the game has not started, render the menu screen, gamemode button, and play the menu song.
  if(gameStart == false){
    menuScreen();
    modeButton.render(); 
   if (!menuSong.isPlaying()){
   menuSong.play();
 }
 //If the game has started, begin a switch state between the game screen and the lose screen.
  }
  if(gameStart == true){
  switch (screen){
  case 0:
   if(desktopView == false && firstGenerate == true){
    generate(); 
    firstGenerate = false;
    }
    //Makes sure the right music is playing during the game.
   if (menuSong.isPlaying()){
   menuSong.pause();
   }
   if (!gameTheme.isPlaying()){
   gameTheme.play();
   }
      if (loseSong.isPlaying()){
   loseSong.pause();
      }
   background(59, 73, 100);
   //If the game is played for the first time, it shows instructions on the screen.
      if(firstTime == true){
        textAlign(CENTER);
        fill(200, 200, 200);
        textSize(20);
        text("Use the arrow keys to move the player", width/2, 800);
        text("Click the mouse to fire", width/2, 750);
        println("Starting Text");
      }
      //Runs the aiming feature
  preLaunch();
  //Runs the physics of the ball
  ball.render();
  ball.playerMove();
  ball.wallDetect();
  ball.hitboxes();
  //Sets the final score of the game
  if(ballMove == true){
  firstTime = false;
  ball.move();
  finalScore = score;
  }
   //Renders all the blocks and their hitboxes
  for(Block aBlock : blockList){
  aBlock.render();
  aBlock.ballBounce();
  aBlock.hitboxes();
  }
  //Removes unwanted blocks
  for (int i = blockList.size()-1; i >= 0; i=i-1){
  if(blockList.get(i).shouldRemove == true){
  blockList.remove(blockList.get(i)); 
  } 
  textSize(40);
  fill(200);
  //Shows the score in the bottom corner
  if(desktopView == false){
  text(score, 550, 950);
  }
  else if (desktopView == true){
  text(score, 1550, 930);
  }
    }
    break;
    //Handles the end screen of the game
    case 1:
   if (gameTheme.isPlaying()){
   gameTheme.pause();
   }
   if (!loseSong.isPlaying()){
   loseSong.play();
   }
    loseScreen();
    break;
    default:
   
  }
  }
  //Constantly checks to see if the game is lost
  loseCondition();
  
}
//Moves the ball when you click the mouse
void mousePressed(){
 println("MOUSE PRESSED");
 ballMove = true; 
 //Handles the resizing windows button
 if(modeButton.buttonPressed() == true)
 resize();
}

//Handles the aiming of the ball and the trajectory of the ball.
void preLaunch(){
  println("PRELAUNCH");
  if(ballMove == false){
    //LINES 165-178 WERE GENERATED BY CHATGPT. I ASKED IT TO CREATE A FUNCTION THAT ACCELERATES THE BALL TOWARD THE MOUSE CURSOR
    // Calculate velocity vector towards the mouse cursor
    PVector mouse = new PVector(mouseX, mouseY);
    PVector location = new PVector(ball.x, ball.y);
    PVector velocity = PVector.sub(mouse, location).normalize().mult(20); // Adjust the magnitude as needed

    // Assign the calculated velocity to the ball's speed
    if(desktopView == false){
    ball.ySpeed = velocity.y;
    ball.xSpeed = velocity.x;
    }
    else if (desktopView == true){
    ball.ySpeed = 2*velocity.y;
    ball.xSpeed = 2*velocity.x;
    }
  fill(255, 255, 255, 50);
  noStroke();
  //Draws a triangle that is on the ball's approximate path.
  triangle(ball.x, ball.y, mouseX+10, mouseY, mouseX-10, mouseY);
  }
}

//Allows the player to move left or right.
void keyPressed(){
  println("KEY PRESSED");
  if (keyCode == LEFT){
    if (ballMove == false){
      isMovingLeft = true; 
    }
  }
  
  if (keyCode == RIGHT){
    if (ballMove == false){
      isMovingRight = true; 
    }
  }
  
  if(key == ' '){
    // If on the losing screen, reset the game
    if (screen == 0) {
      screen = 1;
      if(gameStart == true){
      resetGame();
      }
    } else if (screen == 1){
      // Otherwise, proceed to the next screen
      screen = 0;
      gameStart = true;
      }
    }
  }


void keyReleased(){
  println("KEY RELEASED");
  if (keyCode == LEFT){
  isMovingLeft = false; 
  }
  
  if (keyCode == RIGHT){
  isMovingRight = false; 
  }
}
//Generates new blocks for every row
void generate(){
  println("GENERATE");
 int health;
 //Sets the block size and starting position based on the gamemode
 if(desktopView == false){
  blockSize = 100;
 }
 else if(desktopView == true){
  blockSize = 200; 
 }
 float r;
  if(desktopView == true){
  spawnX = 100;
  spawnY = 100;
  }
  else if (desktopView == false){
  spawnX = 50;
  spawnY = 50;
  }
 float levelHold;
 noStroke();
 //Sets the blocks at a health based on the progression of the game. When the score gets higher, bigger health blocks are spawned.
 while (spawnX <= width){
 r = random(1, 10);
   levelHold = random(-1, 4);
   levelCount = int(levelHold);
     if(score >= 500){
      levelHold = random(1, 3);
   levelCount = int(levelHold);
   }
   if(score >= 1000){
      levelHold = random(1, 5);
   levelCount = int(levelHold);
   }
   if(score >= 2500){
      levelHold = random(3, 6);
   levelCount = int(levelHold);
   }
     if(score >= 5000){
      levelHold = random(5, 8);
   levelCount = int(levelHold);
   }
 health = levelCount + 2;
 if (r > 7){
   //Adds the blocks to a list.
 blockList.add(new Block(spawnX, spawnY, blockSize, health)); 
 }
 spawnX += blockSize;
 }
 }
//Moves the blocks up every time the player shoots.
void progress(){
   println("PROGRESS");
  for(Block aBlock : blockList){
  aBlock.y += blockSize;
}
}
//Starting screen, only shown once.
void menuScreen(){
 println("MENU SCREEN");
 background(59, 73, 100);
 fill(255);
 strokeWeight(20);
 stroke(1, 1, 1);
 textAlign(CENTER);
  if(desktopView == true){
 textSize(40);
 }
 else if (desktopView == false){
  textSize(30); 
 }
 text("Press the spacebar to start", width/2, 800);
 image(logo, width/2, 350);
}
//Checks to see if the blocks have reached the bottom and if so, loses the game.
void loseCondition(){
  if(gameLost == false){
   for(Block aBlock : blockList){
  if(aBlock.y >=900){
  screen = 1;
  loseScreen();
  }
   }
}
else {
 resetGame(); 
}
}
//Losing screen of the game
void loseScreen(){
  println("LOSE SCREEN");
 background(59, 73, 100);
 textSize(100);
 fill(255);
 strokeWeight(20);
 stroke(1, 1, 1);
 textAlign(CENTER);
 if(desktopView == false){
 textSize(50);
 }
 else if(desktopView == true){
   textSize(100);
 }
 text("Your score:  " +finalScore, width/2, 600);
 image(lose, width/2, 250);
  if(desktopView == false){
 textSize(30);
 }
 else if(desktopView == true){
   textSize(60);
 }
 text("Press the spacebar to try again", width/2, 900);
 gameLost = true;
}
//Resets the game when the player plays again
void resetGame() {
  println("RESET GAME");
  // Reset ball position
  ball.x = width/2;
  ball.y = height-50;
  ball.xSpeed = 0;
  ball.ySpeed = 0;
  ballMove = false;
  levelCount = 1;
  gameLost = false;
  score = 0;

  // Clear block list and regenerate blocks
  blockList.clear();
  generate();
}
//Resizes the window if desktop or mobile mode is enabled.
void resize(){
   if(desktopView == true){
  windowResize(600, 1000);
  logo.resize(600, 600);
  desktopView = false;
 }
 else if (desktopView == false){
 windowResize(1600, 1000);
 logo.resize(850, 850);
 desktopView = true;
 }
}
