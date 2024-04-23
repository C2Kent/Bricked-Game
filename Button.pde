class Button{
  //////// Initial variables
  int x;
  int y;
  int w;
  int h;
  
  color c;
  
  //////// Constructor function
  Button(int X, int Y, int W, int H, color C){
  // Initialize variables
    x = X;
    y = Y;
    w = W;
    h = H;
    
    c = C;
  }
    
 void render(){ // This draws the buttons.
   fill(c);
   noStroke();
   rectMode(CENTER);
   rect(width/2, y, w, h, 2);
   textSize(17);
   fill(255);
   if(desktopView == true){
   text("ENTER MOBILE VIEW", width/2, y+5);
   }
   else if(desktopView == false){
   text("ENTER DESKTOP VIEW", width/2, y+5);
   }
 }
  
 boolean buttonPressed(){ // Creates a basic hitbox
  int left = width/2 - w/2;
  int right = width/2 + w/2;
  int top = y - h/2;
  int bottom = y + h/2; 
  
  if(mouseX > left && mouseX < right && mouseY > top && mouseY < bottom){ // Checks to see whether or not the mouse is within the hitbox, returns true or false
   return true;
  }
  else{
   return false; 
  }

}
}
