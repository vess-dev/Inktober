//========================================================================================================================
// Day 20, Frost: It's pretty obvious to do a snowflake for today. Perhaps lines and rotations?
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 20: \"Frosty Lattice\"";
String FILE_TITLE = "Day20Frost.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Flake> flake_list = new ArrayList<Flake>();
ArrayList<Flake> flake_new = new ArrayList<Flake>();
float[] move_list = {0, 10, 20};

//========================================================================================================================
// Class for a plump plum.

class Flake {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float timer;
  float dead;
  float breed;
  
  Flake(float in_xpos, float in_ypos, float in_breed) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.breed = in_breed;
    this.timer = 0;
    change();
  }
  
  float rand() {
    return move_list[int(random(move_list.length))];
  }
  
  void change() {
    this.xvel = rand();
    this.yvel = rand();
  }
  
  void grow() {
    float xnew = this.xpos + this.xvel;
    float ynew = this.ypos + this.yvel;
    stroke(0, 0, random(255));
    line(this.xpos, this.ypos, xnew, ynew);
    this.xpos = xnew;
    this.ypos = ynew;
    change();
    // Make it harder for newer flakes to breed more flakes.
    float breed_chance = int(random(this.breed));
    if (breed_chance == 0) {
      flake_new.add(new Flake(this.xpos, this.ypos, this.breed + 1));
    }
  }
  
  void update() {
    // A delay so we can watch it progress.
    this.timer = (this.timer + 1) % 10;
    if (this.timer == 0) {
      grow();
    }
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
  background(80, 133, 188);
  strokeWeight(0.5);
  flake_list.add(new Flake(0, 0, 1));
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  // Check if all the flakes are off the screen yet.
  boolean toggle_test = true;
  for (Flake temp_flake: flake_list) {
    temp_flake.update();
    if (temp_flake.xpos <= WINDOW_SIZE || temp_flake.ypos <= WINDOW_SIZE) {
      toggle_test = false;
    }
  }
  // Kill the video if all the flakes are off the screen.
  if (toggle_test) {
    video_handle.saveFrame();
    video_handle.endMovie();
    exit();
  } else {
    video_handle.saveFrame();
  }
  flake_list.addAll(flake_new);
  flake_new.clear();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
