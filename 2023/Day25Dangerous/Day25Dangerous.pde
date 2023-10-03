//========================================================================================================================
// Day 25, Dangerous: I'll do a simple radiation warning sign that has the eaves of the sign slowly spin around.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 25: \"Danger Glow\"";
String FILE_TITLE = "Day25Dangerous.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Sign handle_sign;
float rad_size = 100;
float[] rad_color = {250, 229, 0};

//========================================================================================================================
// Class for a warning.

class Sign {
  
  float xpos;
  float ypos;
  float rot;
  float vel;
  
  Sign() {
    this.xpos = WINDOW_SIZE/2;
    this.ypos = WINDOW_SIZE/2;
    this.rot = 0;
    this.vel = 2;
  }
  
  void update() {
    // Instead of translate + rotate I just did an offset. Shrug, it works and is clean.
    arc(this.xpos, this.ypos, rad_size*5, rad_size*5, (TWO_PI/6)+this.rot, (TWO_PI/6)*2+this.rot);
    arc(this.xpos, this.ypos, rad_size*5, rad_size*5, (TWO_PI/6)*3+this.rot, (TWO_PI/6)*4+this.rot);
    arc(this.xpos, this.ypos, rad_size*5, rad_size*5, (TWO_PI/6)*5+this.rot, (TWO_PI/6)*6+this.rot);
    fill(rad_color[0], rad_color[1], rad_color[2]);
    circle(this.xpos, this.ypos, rad_size*2);
    fill(0);
    circle(this.xpos, this.ypos, rad_size);
    this.rot += this.vel;
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
  background(rad_color[0], rad_color[1], rad_color[2]);
  fill(0);
  noStroke();
  ellipseMode(CENTER);
  handle_sign = new Sign();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(rad_color[0], rad_color[1], rad_color[2]);
  handle_sign.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
