//========================================================================================================================
// Day 16, Angel: I want to do a glowing realistic 3d angel. We'll see if I can get that to work though.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 16: \"Be Not\"";
String FILE_TITLE = "Day16Angel.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Angel handle_angel = new Angel(WINDOW_SIZE/2, WINDOW_SIZE/2);
float angel_size = 100;
float orb_size = 10;
float dist_size = orb_size*20;
float[] z_list = {-dist_size, 0, dist_size};
float jitter_size = 50;

//========================================================================================================================
// Class for a realistic angel.

class Angel {
  
  float xpos;
  float ypos;
  float xangle;
  float yangle;
  float zangle;
  float trans;
  float clock;
  float shake;
  float[] hue;
  
  Angel(float in_xpos, float in_ypos) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.xangle = 0;
    this.yangle = 0;
    this.zangle = 0;
    this.clock = 0;
    this.shake = jitter();
    this.hue = new float[] {random(255), random(255), random(255)};
  }
  
  void orb(float in_xpos, float in_ypos, float in_zpos) {
    pushMatrix();
    fill(this.hue[0], this.hue[1], this.hue[2]);
    translate(-in_xpos, in_ypos, in_zpos);
    sphere(orb_size);
    popMatrix();
  }
  
  void rot() {
    // We skew the rotation so it ends up funky.
    rotateX(radians(this.xangle));
    rotateY(radians(this.yangle));
    rotateZ(radians(this.zangle));
    this.xangle += 1;
    this.yangle += 2;
    this.zangle += 3;
  }
  
  float jitter() {
    return random(-jitter_size, jitter_size);
  }

  void update() {
    fill(255);
    pushMatrix();
    translate(this.xpos, this.ypos, 0);
    sphere(100);
    pushMatrix();
    rot();
    // Creating the orbs isn't great, but it... Works.
    for (int temp_count = 0; temp_count != 3; temp_count++) {
      orb(-dist_size + this.shake, -dist_size + this.shake, z_list[temp_count] + this.shake);
      orb(dist_size + this.shake, -dist_size + this.shake, z_list[temp_count] + this.shake);
      orb(-dist_size + this.shake, dist_size + this.shake, z_list[temp_count] + this.shake);
      orb(dist_size + this.shake, dist_size + this.shake, z_list[temp_count] + this.shake);
    }
    popMatrix();
    popMatrix();
    // Every so often we jump the orbs around by an offset, for fun.
    this.clock = (this.clock + 1) % 50;
    if (this.clock == 0) {
      this.shake = jitter();
      this.hue = new float[] {random(255), random(255), random(255)};
    }
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
  background(0);
  noStroke();
  lights();
  ellipseMode(CENTER);
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  handle_angel.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
