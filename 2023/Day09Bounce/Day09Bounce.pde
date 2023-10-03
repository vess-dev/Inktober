//========================================================================================================================
// Day 9, Map: I adapted my code for day 5 for many multicolored bouncing cubes.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;
import java.util.Random;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 9: \"Simon Bounces\"";
String FILE_TITLE = "Day09Bounce.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Box> box_list = new ArrayList<Box>();
float[] vel_array = new float[]{-20, -15, 15, 20};
Random handle_rand = new Random();
float curr_rotation = 0;
float box_size = 20;

//========================================================================================================================
// Classes.

class Box {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  
  Box() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE);
    this.xvel = 1;
    this.yvel = -1;
  }
  
  void bounce() {
    if (this.xpos < 0) {
      this.xvel = Math.abs(this.xvel) + 1;
    }
    if (this.xpos > WINDOW_SIZE) {
      this.xvel = -this.xvel - 1;
    }
    if (this.ypos < 0) {
      this.yvel = Math.abs(this.yvel) + 1;
    }
    if (this.ypos > WINDOW_SIZE) {
      this.yvel = -this.yvel - 1;
    }
  }
  
  void update() {
    this.xpos += this.xvel;
    this.ypos += this.yvel;
    bounce();
    // Make sure we rotate each box independently.
    pushMatrix();
    translate(this.xpos, this.ypos);
    rotate(radians(curr_rotation));
    fill(random(255), random(255), random(255));
    square(0, 0, box_size);
    popMatrix();
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
  background(255);
  strokeWeight(2);
  rectMode(CENTER);
  for (int temp_count = 0; temp_count != 5; temp_count++) {
    box_list.add(new Box());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Box temp_box : box_list) {
    temp_box.update();
  }
  curr_rotation += 5;
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
