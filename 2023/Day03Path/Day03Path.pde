//========================================================================================================================
// Day 3, Path: I would like to slowly make an image visible through small transparent lines.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 3: \"Crisscrossed\"";
String FILE_TITLE = "Day03Path.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

PImage handle_image;
float curr_x;
float curr_y;
int counter;

//========================================================================================================================
// Functions.

void line(float in_xpos, float in_ypos) {
  float start_xpos = random(600);
  float start_ypos = 600;
  color pixel_color = handle_image.pixels[int(in_ypos) * WINDOW_SIZE + int(in_xpos)];
  stroke(pixel_color);
  line(start_xpos, start_ypos, in_xpos, in_ypos);
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
  video_handle = new VideoExport(this, FILE_TITLE);
  handle_image = loadImage("Path.jpg");
  handle_image.loadPixels();
  curr_x = 0;
  curr_y = 0;
  counter = 0;
  strokeWeight(10);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  line(curr_x, curr_y);
  curr_x = (curr_x + 5) % WINDOW_SIZE;
  if (curr_x == 0) {
    curr_y += 5;
  }
  if (curr_y >= 600) {
    video_handle.endMovie();
    exit();
  }
  if (counter == 0) {
    video_handle.saveFrame();
  }
  counter = (counter + 1) % 10;
}

//========================================================================================================================
