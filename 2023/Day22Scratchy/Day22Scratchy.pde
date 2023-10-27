//========================================================================================================================
// Day 22, Scratchy: I guess I want scratches that appear on the screen and fade similar to Dead by Daylight.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 22: \"The Deep Itch\"";
String FILE_TITLE = "Day22Scratchy.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Scratch> scratch_list = new ArrayList<Scratch>();
Scratch handle_scratch;

//========================================================================================================================
// Class for a scratch on the skin.

class Scratch {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float trans;
  
  Scratch() {
    spawn();
  }
  
  void spawn() {
    int scratch_type = int(random(2));
    this.trans = 255;
    switch (scratch_type) {
      case 0:
        this.xpos = random(WINDOW_SIZE);
        this.txpos = random(WINDOW_SIZE);
        this.ypos = 0;
        this.typos = WINDOW_SIZE;
        break;
      case 1:
        this.xpos = 0;
        this.txpos = WINDOW_SIZE;
        this.ypos = random(WINDOW_SIZE);
        this.typos = random(WINDOW_SIZE);
        break;
    }
  }
  
  void rip(float in_offset) {
    line(this.xpos + in_offset, this.ypos + in_offset, this.txpos + in_offset, this.typos + in_offset);
  }
  
  void update() {
    stroke(255, 0, 0, this.trans);
    rip(-100);
    rip(-50);
    rip(0);
    rip(50);
    rip(100);
    this.trans -= 10;
    if (this.trans <= 0) {
      spawn();
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
  background(255, 220, 177);
  strokeWeight(10);
  handle_scratch = new Scratch();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(255, 220, 177);
  handle_scratch.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
