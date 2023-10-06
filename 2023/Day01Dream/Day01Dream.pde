//========================================================================================================================
// Day 1, Dream: Starting to learn Processing, keeping it simple with a bokeh effect.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 1: \"Bokeh Dreams\"";
String FILE_TITLE = "Day01Dream.mp4";
VideoExport video_handle;
boolean video_toggle = false;

//========================================================================================================================
// Sketch globals.

ArrayList<Bokeh> bokeh_list = new ArrayList<Bokeh>();

//========================================================================================================================
// Classes.

// A bokeh is a transparent circle.
class Bokeh {
  
  float xpos;
  float ypos;
  float rate;
  float glass;
  float cap;
  boolean toggle;
  boolean done;
  float size;
  float[] rgb;
  
  Bokeh() {
    this.change();
  }
  
  void change() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE);
    this.rate = 3;
    this.glass = 0;
    this.cap = random(50, 100);
    this.toggle = false;
    this.done = false;
    this.size = random(100, 200);
    this.rgb = new float[]{random(255), random(255), random(255)};
  }
  
  // A bokeh should become more opaque, hit a cap, then become more transparent.
  // Once it is once again invisible, it should regenerate itself somewhere else.
  void update() {
    fill(this.rgb[0], this.rgb[1], this.rgb[2], this.glass);
    circle(this.xpos, this.ypos, this.size);
    if (!this.toggle) {
      this.glass += this.rate;
    } else if (this.toggle) {
      this.glass -= this.rate;
    }
    if (this.glass >= this.cap) {
      this.toggle = true;
    } else if (this.glass <= 0) {
      this.change();
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
  background(255);
  noStroke();
  for (int temp_itr = 0; temp_itr < 300; temp_itr++) {
    bokeh_list.add(new Bokeh());
  }
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Bokeh temp_bokeh: bokeh_list) {
    temp_bokeh.update();
  }
  if (video_toggle) {
    video_handle.saveFrame();
  }
  video_handle = new VideoExport(this, FILE_TITLE);
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  if (!video_toggle) {
    video_handle.startMovie();
    video_toggle = true;
  } else {
    video_handle.endMovie();
    exit();
  }
}

//========================================================================================================================
