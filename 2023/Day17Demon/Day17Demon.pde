//========================================================================================================================
// Day 17, Demon: I want to do a demon red smile that grimaces in the dark.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 17: \"Deal Made\"";
String FILE_TITLE = "Day17Demon.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Smile handle_smile;
float window_part = WINDOW_SIZE/7;
float control_part = WINDOW_SIZE/14;

//========================================================================================================================
// Class for a realistic angel.

class Smile {
  
  float[] smile_left;
  float[] smile_right;
  float[] control_sleft;
  float[] control_sright;
  float[] eye_lleft;
  float[] eye_lright;
  float[] control_lleft;
  float[] control_lright;
  float[] eye_rleft;
  float[] eye_rright;
  float[] control_rleft;
  float[] control_rright;
  float rhue;
  
  Smile() {
    // Left smile point.
    this.smile_left = new float[] {window_part, window_part*4};
    // Right smile point.
    this.smile_right = new float[] {window_part*6, window_part*4};
    // Smile left midpoint.
    this.control_sleft = new float[] {window_part*3, window_part*4};
    // Smile right midpoint.
    this.control_sright = new float[] {window_part*4, window_part*4};
    // Left eye left point, left eye right point, left eye left midpoint, left eye right midpoint.
    this.eye_lleft = new float[] {window_part, window_part*3};
    this.eye_lright = new float[] {window_part*3, window_part*3};
    this.control_lleft = new float[] {control_part*3, window_part*3};
    this.control_lright = new float[] {control_part*5, window_part*3};
    // Repeat above but for the right eye.
    this.eye_rleft = new float[] {window_part*4, window_part*3};
    this.eye_rright = new float[] {window_part*6, window_part*3};
    this.control_rleft = new float[] {control_part*9, window_part*3};
    this.control_rright = new float[] {control_part*11, window_part*3};
    this.rhue = 255;
  }
  
  void update() {
    stroke(this.rhue, 0, 0);
    // Draw the smile then the eyes. No particular reason as to the order.
    bezier(smile_left[0], smile_left[1], control_sleft[0], control_sleft[1], control_sright[0], control_sright[1], smile_right[0], smile_right[1]);
    bezier(eye_lleft[0], eye_lleft[1], control_lleft[0], control_lleft[1], control_lright[0], control_lright[1], eye_lright[0], eye_lright[1]);
    bezier(eye_rleft[0], eye_rleft[1], control_rleft[0], control_rleft[1], control_rright[0], control_rright[1], eye_rright[0], eye_rright[1]);
    // Shape the lines.
    this.control_sleft[1] += 1;
    this.control_sright[1] += 1;
    this.control_lleft[1] -= 1;
    this.control_lright[1] -= 1;
    this.control_rleft[1] -= 1;
    this.control_rright[1] -= 1;
    this.rhue -= 1;
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
  noFill();
  strokeWeight(1);
  handle_smile = new Smile();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  handle_smile.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
