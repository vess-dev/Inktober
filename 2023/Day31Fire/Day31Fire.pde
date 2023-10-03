//========================================================================================================================
// Day 31, Fire: From the bottom middle of the screen there will be many lines that go outwards, and twist and curve.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 31: \"Furling Flames\"";
String FILE_TITLE = "Day31Fire.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Flame> flame_list = new ArrayList<Flame>();
float flame_count = 100;
float flame_offset = 20;
float flame_tick = 10;

//========================================================================================================================
// Provides for an oscillation between two numbers.

float osci(float input_counter, float input_min, float input_max) {
    float range_diff = input_max - input_min;
    return input_min + Math.abs(((input_counter + range_diff) % (range_diff * 2)) - range_diff);
}

//========================================================================================================================
// Class for each line of flame.

class Flame {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float red;
  float offg;
  float offb;
  float counter1;
  float counter2;
  
  Flame() {
    // Starting pos, and then target pos.
    this.xpos = random(WINDOW_SIZE);
    this.ypos = WINDOW_SIZE;
    this.txpos = random(WINDOW_SIZE);
    this.typos = 0;
    // Color offsets.
    this.red = random(100, 255);
    this.offg = random(0, flame_offset);
    this.offb = random(0, flame_offset);
    this.counter1 = random(WINDOW_SIZE);
    this.counter2 = random(WINDOW_SIZE); 
  }
  
  void update() {
    stroke(this.red, this.offg, this.offb);
    // Oscillate the lines left and right.
    float wave_x1 = osci(this.counter1, 0, WINDOW_SIZE);
    float wave_x2 = osci(this.counter2, 0, WINDOW_SIZE);
    bezier(this.xpos, this.ypos, wave_x1, this.ypos*0.75, wave_x2, this.ypos*0.25, this.txpos, this.typos);
    this.counter1 += flame_tick;
    this.counter2 += flame_tick;
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
  strokeWeight(10);
  noFill();
  for (int temp_count = 0; temp_count != flame_count; temp_count++) {
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
