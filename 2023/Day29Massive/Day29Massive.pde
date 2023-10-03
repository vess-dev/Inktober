//========================================================================================================================
// Day 29, Massive: The idea was to have a center circle that grows slowly as more circles enter into it.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 29: \"Amassing Mass\"";
String FILE_TITLE = "Day29Massive.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Mass> mass_list = new ArrayList<Mass>();
float min_size = 10;
float max_size = 20;
float vel_step = 100;
float var_step = 100;
Center handle_center = new Center();

//========================================================================================================================
// Class for a bit of mass that moves towards the center.

class Mass {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float size;
  int type;
  
  Mass() {
    spawn();
  }
  
  void spawn() {
    this.size = random(min_size, max_size);
    this.type = int(random(4));
    // Decides where offscreen to spawn the mass.
    switch (this.type) {
      case 0:
        this.xpos = random(0, WINDOW_SIZE);
        this.ypos = -this.size;
        break;
      case 1:
        this.xpos = WINDOW_SIZE + this.size;
        this.ypos = random(0, WINDOW_SIZE);
        break;
      case 2:
        this.xpos = random(0, WINDOW_SIZE);
        this.ypos = WINDOW_SIZE + this.size;
        break;
      case 3:
        this.xpos = -this.size;
        this.ypos = random(0, WINDOW_SIZE);
        break;
    }
    // Moves it towards the center mass with a bit of variation.
    float vel_var = random(var_step);
    this.xvel = (handle_center.xpos - this.xpos) / (vel_step + vel_var);
    this.yvel = (handle_center.ypos - this.ypos) / (vel_step + vel_var);
  }
  
  void check() {
    // Check if the mass has touched the center mass.
    float check_xlpos = handle_center.xpos - (handle_center.size/3);
    float check_xrpos = handle_center.xpos + (handle_center.size/3);
    float check_ylpos = handle_center.ypos - (handle_center.size/3);
    float check_yrpos = handle_center.xpos + (handle_center.size/3);
    if (this.xpos >= check_xlpos && this.xpos <= check_xrpos) {
      if (this.ypos >= check_ylpos && this.ypos <= check_yrpos) {
        handle_center.size += (this.size / handle_center.size) * 10;
        spawn();
      }
    }
  }
  
  void update() {
    circle(this.xpos, this.ypos, this.size);
    this.xpos += this.xvel;
    this.ypos += this.yvel;
    check();
  }

}

//========================================================================================================================
// Class for the center of mass that grows.

class Center {
  
  float xpos;
  float ypos;
  float size;
  
  Center() {
    this.xpos = WINDOW_SIZE/2;
    this.ypos = WINDOW_SIZE/2;
    this.size = 10;
  }
  
  void update() {
    circle(this.xpos, this.ypos, this.size);
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
  noStroke();
  fill(255);
  ellipseMode(CENTER);
  for (int temp_count = 0; temp_count != 100; temp_count++) {
    mass_list.add(new Mass());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  for (Mass temp_mass: mass_list) {
    temp_mass.update();
  }
  handle_center.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
