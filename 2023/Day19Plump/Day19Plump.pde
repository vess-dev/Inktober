//========================================================================================================================
// Day 19, Plump: I'll do a 3D sphere that gets bigger and more "plump".
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 19: \"Plump Plum\"";
String FILE_TITLE = "Day19Plump.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Plum handle_plum;

//========================================================================================================================
// Class for a plump plum.

class Plum {
  
  float xpos;
  float ypos;
  float size;
  
  Plum() {
    this.xpos = WINDOW_SIZE/2;
    this.ypos = WINDOW_SIZE/2;
    this.size = 100;
  }
  
  void update() {
    pushMatrix();
    translate(this.xpos, this.ypos);
    sphere(this.size);
    popMatrix();
    this.size += 1;
  }

}

//========================================================================================================================
// Describe the sketch.

void settings() {
  size(WINDOW_SIZE, WINDOW_SIZE, P3D);
}

//========================================================================================================================
// One time sketch setup.

void setup() {
  surface.setTitle(WINDOW_TITLE);
  background(221, 160, 221);
  fill(186, 85, 211);
  sphereDetail(200);
  handle_plum = new Plum();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(221, 160, 221);
  lights();
  handle_plum.update();
  handle_plum.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
