//========================================================================================================================
// Day 26, Remove: I want to have a black bar slowly removed from a risque image before changing into a joke.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 26: \"Slow Reveal\"";
String FILE_TITLE = "Day26Remove.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Censor handle_censor;
PImage handle_image;
String[] dot_list = {".", "..", "..."};

//========================================================================================================================
// Class for a censor bar.

class Censor {
  
  float xpos;
  float ypos;
  float counter;
  float dot;
  float vel;
  
  Censor() {
    this.xpos = 0;
    this.ypos = 0;
    this.dot = 0;
    this.vel = 0.5;
  }
  
  void update() {
    fill(0);
    square(this.xpos, this.ypos, WINDOW_SIZE);
    fill(255);
    String handle_text;
    // Funny meme. Note: The image has to be pre-censored for this to work.
    if (this.ypos >= 350) {
      handle_text = "[ Nope ]";
    } else {
      handle_text = "[ Revealing " + dot_list[int(this.dot)] + "]";
    }
    text(handle_text, WINDOW_SIZE/2, this.ypos + WINDOW_SIZE/10);
    // Tick the dots on the revealing text slower than frame count.
    if (this.counter == 0) {
      this.dot = (this.dot + 1) % 3;
    }
    this.counter = (this.counter + 1) % 20;
    this.ypos += this.vel;
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
  fill(0);
  noStroke();
  textSize(WINDOW_SIZE/10);
  textAlign(CENTER);
  handle_censor = new Censor();
  handle_image = loadImage("Remove.jpg");
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  image(handle_image, 0, 0);
  handle_censor.update();
  if (handle_censor.ypos == WINDOW_SIZE) {
    video_handle.endMovie();
  } else {
    video_handle.saveFrame();
  }
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
