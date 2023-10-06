//========================================================================================================================
// Day 4, Dodge: Not sure about this day so keeping it to a simple joke that is quick and easy to program.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 4: \"Anime Fights\"";
String FILE_TITLE = "Day04Dodge.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

int MAX_SIZE = 200;
int MIN_SIZE = 50;

//========================================================================================================================
// Functions.

// The dodge text random jumps around the screen.
void dodge() {
  float rand_size = random(MIN_SIZE, MAX_SIZE);
  float half_size = rand_size/2;
  float rand_xpos = random(half_size, WINDOW_SIZE - half_size);
  float rand_ypos = random(half_size, WINDOW_SIZE - half_size);
  textSize(rand_size);
  text("Dodge", rand_xpos, rand_ypos);
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
  textAlign(CENTER);
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  for (int temp_loop = 0; temp_loop <= random(6); temp_loop++) {
    dodge();
  }
  delay(100);
  if (frameCount >= 20) {
    video_handle.endMovie();
    exit();
  }
  // Pad out the extra frames so it's not instant.
  for (int temp_frame = 0; temp_frame <= 3; temp_frame++) {
    video_handle.saveFrame();
  }
}

//========================================================================================================================
