//========================================================================================================================
// Day 27, Beast: I want to have an image of The Beast from OtGW with lightning flashing behind him.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 27: \"Edelwood Trees\"";
String FILE_TITLE = "Day27Beast.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Flash handle_flash;
PImage handle_image;

//========================================================================================================================
// Provides for oscillation between two numbers.

float osci(float input_counter, float input_min, float input_max) {
    float range_diff = input_max - input_min;
    return input_min + Math.abs(((input_counter + range_diff) % (range_diff * 2)) - range_diff);
}

//========================================================================================================================
// Class for a flash of lightning.

class Flash {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float counter;
  
  Flash() {
    this.counter = 0;
    spawn();
  }
  
  void spawn() {
    // These are the general locations for the eyes.
    this.xpos = random(225, 340);
    this.ypos = 152;
    this.txpos = random(240, 325);
    this.typos = 205;
  }
  
  void strike() {
    line(this.xpos, this.ypos, this.txpos, this.typos);
    spawn();
  }
  
  void update() {
    // Oscillate the background in the dark for a bit.
    fill(255, osci(this.counter, -50, 10));
    square(-50, -50, WINDOW_SIZE*2);
    // Repeat 10 times for effect and highlight.
    for (int temp_count = 0; temp_count != 10; temp_count++) {
      strike();
    }
    this.counter += 1;
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
  stroke(255);
  strokeWeight(2);
  handle_flash = new Flash();
  handle_image = loadImage("Beast.png");
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  // Background, flash, beast image.
  background(0);
  handle_flash.update();
  image(handle_image, 0, 0);
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
