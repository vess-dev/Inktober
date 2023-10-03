//========================================================================================================================
// Day 14, Castle: I'm thinking of doing a bunch of castles from chess that move across the screen over and over.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 14: \"Castling Castles\"";
String FILE_TITLE = "Day14Castle.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Castle> castle_list = new ArrayList<Castle>();
float castle_size = 20;
float castle_bound = castle_size * 2;
float vel_min = 5;
float vel_max = 10;

//========================================================================================================================
// Classes.

class Castle {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
 
  Castle() {
    respawn();
  }
  
  void respawn() {
    // Create different movements for the castle- essentially- one direction.
    this.xvel = 0;
    this.yvel = 0;
    int spawn_type = int(random(4));
    float castle_speed = random(vel_min, vel_max);
    switch (spawn_type) {
      case 0: // Moving left to right.
        this.xpos = -castle_bound;
        this.ypos = random(WINDOW_SIZE);
        this.xvel = castle_speed;
        break;
      case 1: // Moving top to bottom.
        this.xpos = random(WINDOW_SIZE);
        this.ypos = -castle_bound;
        this.yvel = castle_speed;
        break;
      case 2: // Moving right to left.
        this.xpos = WINDOW_SIZE + castle_bound;
        this.ypos = random(WINDOW_SIZE);
        this.xvel = -castle_speed;
        break;
      case 3: // Moving bottom to top.
        this.xpos = random(WINDOW_SIZE);
        this.ypos = WINDOW_SIZE + castle_bound;
        this.yvel = -castle_speed;
        break;
    }
  }
  
  void check() {
    // Respawn the castle if it goes out of bounds.
    float check_x = Math.signum(this.xpos);
    float check_y = Math.signum(this.ypos);
    if (check_x == 1 && this.xpos >= (WINDOW_SIZE + castle_bound)) {
      respawn();
    } else if (check_x == -1 && this.xpos <= -castle_bound) {
      respawn();
    } else if (check_y == 1 && this.ypos >= (WINDOW_SIZE + castle_bound)) {
      respawn();
    } else if (check_y == -1 && this.ypos <= -castle_bound) {
      respawn();
    }
  }

  void update() {
    // Stem of the castle.
    rect(this.xpos+castle_size-(castle_size/2), this.ypos-(castle_size*3), castle_size, castle_size*3);
    // Top castle prongs.
    rect(this.xpos, this.ypos-(castle_size*4)+(castle_size/2), castle_size/2, castle_size/2);
    rect(this.xpos+(castle_size/1.3), this.ypos-(castle_size*4)+(castle_size/2), castle_size/2, castle_size/2);
    rect(this.xpos+castle_size+(castle_size/2), this.ypos-(castle_size*4)+(castle_size/2), castle_size/2, castle_size/2);
    // Top of the castle.
    rect(this.xpos, this.ypos-(castle_size*3), castle_size*2, castle_size*1.5);
    // Bottom of the castle.
    rect(this.xpos, this.ypos, castle_size*2, castle_size);
    this.xpos += this.xvel;
    this.ypos += this.yvel;
    check();
  }

}

//========================================================================================================================
// Describe the sketch.

void settings() {
  size(WINDOW_SIZE, WINDOW_SIZE);
}

//========================================================================================================================
// One time sketch setup.

void setup() {
  surface.setTitle(WINDOW_TITLE);
  background(0);
  stroke(2);
  strokeWeight(2);
  fill(50);
  for (int temp_count = 0; temp_count != 10; temp_count++) {
    castle_list.add(new Castle());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Castle temp_castle: castle_list) {
    temp_castle.update();
  }
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
