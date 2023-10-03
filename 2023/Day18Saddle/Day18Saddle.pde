//========================================================================================================================
// Day 18, Saddle: I guess I'll draw a saddle with stirrups that wave back and forth slowly.
// SORRY FOR THIS BEING BAD. THINGS WENT WRONG AND I DIDN'T CARE TO REFACTOR. F*** IT AND SEND IT.
//========================================================================================================================
// Imports.

import com.hamoid.*;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 18: \"Swaying Saddle\"";
String FILE_TITLE = "Day18Saddle.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Saddle handle_saddle;
float window_part = WINDOW_SIZE/6;

//========================================================================================================================
// Class for a simple animated saddle.

class Saddle {
  
  // The biggest part of the seat.
  float[][] line_cover;
  float[] color_cover;
  // The smaller part on the seat.
  float[][] line_seat;
  float[][] line_top;
  float[] color_seat;
  // The strap and stirrup.
  float[] rect_strap;
  float[] circle_hoop;
  float[] color_hoop;
  float[] color_inner;
  // The tilt maxes for the animation.
  float tilt_seatmax;
  float sway_seat;
  float change_seat;
  float tilt_hoopmax;
  float sway_hoop;
  float change_hoop;
  
  Saddle() {
    this.line_cover = new float[][] {{window_part, window_part*2}, {window_part*2, window_part*4}, {window_part*4, window_part*4}, {window_part*5, window_part*2}};
    this.line_top = new float[][] {{window_part, window_part*2}, {window_part, window_part*2}, {window_part*5, window_part*2}, {window_part*5, window_part*2}};
    this.color_cover = new float[] {90, 39, 41};
    this.line_seat = new float[][] {{window_part*1.5, window_part*2}, {window_part*2.9, window_part*3.5}, {window_part*3.1, window_part*3.5}, {window_part*4.5, window_part*2}};
    this.color_seat = new float[] {30, -11, -9};
    this.rect_strap = new float[] {window_part*3.5, window_part*3, window_part*0.5, window_part*2};
    this.circle_hoop = new float[] {window_part*4, window_part*5, window_part};
    this.color_hoop = new float[] {50, 50, 50};
    this.color_inner = new float[] {0, 0, 0};
    this.tilt_seatmax = 5;
    this.sway_seat = 0;
    this.change_seat = 0.5;
    this.tilt_hoopmax = 20;
    this.sway_hoop = 0;
    this.change_hoop = -1;
  }
  
  void set(float[] in_color, float in_offset) {
    fill(in_color[0], in_color[1], in_color[2]);
    stroke(in_color[0] + in_offset, in_color[1] + in_offset, in_color[2] + in_offset);
  }
  
  void make(float[][] in_array, float[] in_offset) {
    bezier(in_array[0][0]-in_offset[0],in_array[0][1]-in_offset[1],   in_array[1][0]-in_offset[0],in_array[1][1]-in_offset[1],   in_array[2][0]-in_offset[0],in_array[2][1]-in_offset[1],   in_array[3][0]-in_offset[0],in_array[3][1]-in_offset[1]);
  }
  
  void show() {
    // Draw the strap and hoop.
    pushMatrix();
    translate(this.rect_strap[0], this.rect_strap[1]);
    rotate(radians(this.sway_hoop)); 
    strokeWeight(10);
    set(this.color_cover, 0);
    rect(0, 0, this.rect_strap[2], this.rect_strap[3]);
    set(this.color_hoop, 0);
    circle(circle_hoop[0]-this.rect_strap[0], circle_hoop[1]-this.rect_strap[1], circle_hoop[2]);
    set(this.color_inner, 0);
    strokeWeight(0);
    circle(circle_hoop[0]-this.rect_strap[0], circle_hoop[1]-this.rect_strap[1], circle_hoop[2]);
    popMatrix();
    this.sway_hoop += this.change_hoop;
    // Draw the saddle and seat.
    pushMatrix();
    translate(this.line_cover[0][0], this.line_cover[0][1]);
    rotate(radians(this.sway_seat)); 
    strokeWeight(20);
    set(this.color_cover, -50);
    // Hack patch because I forgot how animations work.
    float[] new_offset = {line_top[0][0], line_top[0][1]};
    make(this.line_cover, new_offset);
    set(this.color_seat, 0);
    make(this.line_seat, new_offset);
    make(this.line_top, new_offset);
    popMatrix();
    this.sway_seat += this.change_seat;
  }
  
  void update() {
    show();
    if (this.sway_seat == this.tilt_seatmax || this.sway_seat == -this.tilt_seatmax) {
      this.change_seat *= -1;
    }
    if (this.sway_hoop == this.tilt_hoopmax || this.sway_hoop == -this.tilt_hoopmax) {
      this.change_hoop *= -1;
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
  handle_saddle = new Saddle();
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  handle_saddle.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
