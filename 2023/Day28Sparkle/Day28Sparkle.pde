//========================================================================================================================
// Day 28, Sparkle: Perhaps falling stars that leave trails behind them? And they shift color slightly as they fall?
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 28: \"Sparkling Stars\"";
String FILE_TITLE = "Day28Sparkle.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Star> star_list = new ArrayList<Star>();
float star_size = 20;
float color_offset = 100;

//========================================================================================================================
// Star creator code from: https://processing.org/examples/star.html

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//========================================================================================================================
// Class for a falling sparkle star.

class Star {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float xvel;
  float yvel;
  float rot;
  float rvel;
  
  Star() {
    spawn();
  }
  
  void spawn() {
    this.txpos = random(-(WINDOW_SIZE*2), WINDOW_SIZE);
    this.typos = WINDOW_SIZE;
    this.xpos = this.txpos + (WINDOW_SIZE*2);
    this.ypos = this.typos - (WINDOW_SIZE*2);
    this.yvel = random(1, 5);
    this.xvel = -this.yvel;
    this.rot = 0;
    this.rvel = random(2, 10);
  }
  
  void update() {
    pushMatrix();
    translate(this.xpos, this.ypos);
    rotate(radians(this.rot));
    // The slight color shifting effect.
    fill(245 + random(-color_offset, color_offset), 230 + random(-color_offset, color_offset), 23 + random(-color_offset, color_offset));
    // x, y, inner radius, outher radius, points.
    star(0, 0, star_size/2, star_size, 5);
    popMatrix();
    this.xpos += this.xvel;
    this.ypos += this.yvel;
    this.rot += this.rvel;
    // Respawn once off the screen.
    if (this.ypos >= WINDOW_SIZE + (WINDOW_SIZE/2)) {
      spawn();
    }
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
  stroke(0);
  strokeWeight(2);
  for (int temp_count = 0; temp_count != 200; temp_count++) {
    star_list.add(new Star());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Star temp_star: star_list) {
    temp_star.update();
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
