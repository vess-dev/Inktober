//========================================================================================================================
// Day 1, "": 
//========================================================================================================================
// Imports.

import com.hamoid.*;
import gifAnimation.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 1: \"\"";
String FILE_TITLE = "Day01Dream.mp4";
VideoExport video_handle;
boolean video_toggle;

//========================================================================================================================
// Sketch globals.



//========================================================================================================================
// Classes.



//========================================================================================================================
// Describe the sketch.

void settings() {
  size(WINDOW_SIZE, WINDOW_SIZE);
}

//========================================================================================================================
// One time sketch setup.

void setup() {
  surface.setTitle(WINDOW_TITLE);
  noStroke();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_toggle = false;
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  if (video_toggle) {
    video_handle.saveFrame();
  }
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  if (!video_toggle) {
    video_handle.startMovie();
    video_toggle = true;
  } else if (video_toggle) {
    video_handle.endMovie();
    exit();
  }
}

//========================================================================================================================