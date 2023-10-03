//========================================================================================================================
// Day 2, Spiders: The idea here is that we start with one skitter that will split until the screen is blotted out.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 2: \"Webbing\"";
String FILE_TITLE = "Day02Spiders.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Skitter> skitter_list = new ArrayList<Skitter>();
ArrayList<Skitter> skitter_new = new ArrayList<Skitter>();

//========================================================================================================================
// Classes.

class Skitter {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  int counter;
  
  Skitter(float in_xpos, float in_ypos) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.xvel = random(-2, 2);
    this.yvel = random(-2, 2);
    this.counter = 0;
  }
  
  // Skitters shoot off in only one direction.
  void update() {
    fill(0);
    circle(this.xpos, this.ypos, 3);
    this.counter = (this.counter + 1) % 20;
    if (this.counter == 0) {
      skitter_new.add(new Skitter(this.xpos, this.ypos));
    }
    this.xpos += this.xvel;
    this.ypos += this.yvel;
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
  noStroke();
  // Spawn the first Skitter in the middle of the screen.
  int sketch_mid = WINDOW_SIZE/2;
  skitter_list.add(new Skitter(sketch_mid, sketch_mid));
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  //background(255);
  for (Skitter temp_skit: skitter_list) {
    temp_skit.update();
  }
  // Keep a new Skitter list so they don't conflict mid loop.
  skitter_list.addAll(skitter_new);
  skitter_new.clear();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
