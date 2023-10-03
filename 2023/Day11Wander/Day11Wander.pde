//========================================================================================================================
// Day 11, Wander: I ended up making a weird symmetrical butterfly using bezier curves, and so I made it jump around.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 11: \"Wandering Butterflies\"";
String FILE_TITLE = "Day11Wander.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

float rotation_val = 0;
float target_size = WINDOW_SIZE/10;

//========================================================================================================================
// Draw a flutterfly buttershy.

void flutter() {
  // The control points for the bezier curve.
  float target_x1pos = random(target_size);
  float target_y1pos = random(target_size);
  float target_x2pos = random(target_size);
  float target_y2pos = random(target_size);
  pushMatrix();
  translate(random(WINDOW_SIZE), random(WINDOW_SIZE));
  rotate(radians(rotation_val));
  rotation_val += 1;
  stroke(random(255), random(255), random(255));
  // The wings of the butterfly.
  bezier(0, 0, target_x1pos, target_y1pos, target_x2pos, target_y2pos, 0, 0);
  bezier(0, 0, target_x1pos, -target_y1pos, target_x2pos, -target_y2pos, 0, 0);
  bezier(0, 0, -target_x1pos, target_y1pos, -target_x2pos, target_y2pos, 0, 0);
  bezier(0, 0, -target_x1pos, -target_y1pos, -target_x2pos, -target_y2pos, 0, 0);
  popMatrix();
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
  strokeWeight(3);
  noFill();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (int temp_count = 0; temp_count != 10; temp_count++) {
    flutter();
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
