Block obstacle, red;
String message = "";

//==================================== SETUP =====================================
void setup()
{
    size(400, 400);

    obstacle = new Block();
    obstacle.w = 90;
    obstacle.h = 90;
    obstacle.x = width / 2 - obstacle.w / 2;
    obstacle.y = height / 2 - obstacle.h / 2;
    obstacle.clr = color (0, 0, 255);

    red = new Block();
    red.w = 50;
    red.h = 50;
    red.x = 0;
    red.y = 0;
    red.clr = color (255, 0, 0);
}

//==================================== DRAW =====================================

void draw()
{
    // ============================= MOVE STUFF  ================================
    // Make shapes move, update variables, etc
    
    red.x = mouseX;
    red.y = mouseY;


    // ============================= COLLISION ===================================
    // Objects bouncing off walls, object to object collision, etc 
    
    collisionCheck();                    //do "red" and "obstacle" collide?
    //collisionCheckWithLocation();      //do "red" and "obstacle" collide?  If so, where?


    // ============================= DRAW STUFF  =================================
    // background, fill, stroke, rect, ellipse, text, etc
    
    background (255);

    obstacle.drawBlock();
    red.drawBlock();

    textSize(20);
    stroke(0);
    text (message, width / 2 - textWidth(message) / 2, height - 40);
}


// ================================ MOUSE ========================================


// =============================== KEYBOARD ====================================== 


// ============================ OTHER FUNCTIONS ==================================


void collisionCheck()
{
    if (collideRectRect(red.x, red.y, red.w, red.h, obstacle.x, obstacle.y, obstacle.w, obstacle.h))
        obstacle.clr = color (0, 255, 0);
    else
        obstacle.clr = color (0, 0, 255);
}

void collisionCheckWithLocation ()
{
    String collisionResult = collideRectRectLocation(red.x, red.y, red.w, red.h, obstacle.x, obstacle.y, obstacle.w, obstacle.h); 
    if ( collisionResult != "none") {
        if (collisionResult == "left")
            print("COLLISON (LEFT)");
        else if (collisionResult == "right")
            print("COLLISON (RIGHT)");
        else if (collisionResult == "top")
            print("COLLISON (TOP)");
        else
            print("COLLISON (BOTTOM)");
        obstacle.clr = color (0, 255, 0);
    } else {
        message = "";
        obstacle.clr = color (0, 0, 255);
    }
}


boolean collideRectRect (float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    return x1 <= x2+w2 && x1+w1 >= x2 && y1 <= y2+h2 && y1+h1 >= y2;
}

String collideRectRectLocation (float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    if (x1 <= x2+w2 && x1+w1 >= x2 && y1 <= y2+h2 && y1+h1 >= y2) {
        float collisionLeft = x2 + w2 - x1;
        float collisionRight = x1 + w1 - x2;
        float collisionTop = y2 + h2 - y1;
        float collisionBottom = y1 + h1 - y2;
        if (collisionLeft <= collisionBottom && collisionLeft <= collisionTop && collisionLeft <= collisionRight)
            print("COLLISON (LEFT)");
        else if (collisionRight <= collisionBottom && collisionRight <= collisionTop && collisionRight <= collisionLeft)
            return "right" ;
        else if (collisionTop <= collisionBottom && collisionTop <= collisionLeft && collisionTop <= collisionRight)
            return "top" ;
        else if (collisionBottom <= collisionTop && collisionBottom <= collisionLeft && collisionBottom <= collisionRight) 
            return "bottom" ;
    }

    return "none";
}


// ==================================== CLASSES  =================================

class Block{
    float x, y, w, h;
    color clr;

    void drawBlock ()
    {
        fill (clr);
        rect (x, y, w, h);
    }
}
