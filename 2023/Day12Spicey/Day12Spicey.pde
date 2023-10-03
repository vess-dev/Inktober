//========================================================================================================================
// Day 12, Spicey: I want to make a spicey bonfire made of little flames that shift in color and wiggle.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 12: \"Sputtering Flames\"";
String FILE_TITLE = "Day12Spicey.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Flame> flame_list = new ArrayList<Flame>();
float flame_size = 100;
float flame_third = flame_size/3;
float hue_shift = 10;

//========================================================================================================================
// Classes.

class Flame {
  
  float xpos;
  float ypos;
  float red;
  float shift;
 
  Flame() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE) + random(flame_size);
    this.red = random(200);
    this.shift = 0;
  }
  
  void update() {
    float color_shift = random(5, 10);
    stroke(this.red, color_shift, color_shift);
    fill(this.red, color_shift, color_shift);
    pushMatrix();
    translate(this.xpos, this.ypos);
    // Give the flames some sputter.
    bezier(1,0, -flame_third*2,-flame_third, -this.shift,(-flame_third*2) + random(flame_third), 0,-flame_size);
    bezier(-1,0, flame_third*2,-flame_third, this.shift,(-flame_third*2) + random(flame_third), 0,-flame_size);
    popMatrix();
    // Shift the sides and the red hue of the flames.
    this.shift = (this.shift + random(-hue_shift*2, hue_shift*2)) % 20;
    this.red = (this.red + random(-hue_shift, hue_shift)) % 200;
    if (this.red <= 20) {
      this.red = 20;
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
  for (int temp_count = 0; temp_count != WINDOW_SIZE + 100; temp_count++) {
    flame_list.add(new Flame());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  for (Flame temp_flame: flame_list) {
    temp_flame.update();
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
