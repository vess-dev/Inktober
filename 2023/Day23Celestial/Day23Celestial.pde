//========================================================================================================================
// Day 23, Celestial: Have an orb with other orbs that orbit around it in circles. Keep it flat in 2d.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 23: \"The Celestial Dance\"";
String FILE_TITLE = "Day23Celestial.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Planet> planet_list = new ArrayList<Planet>();
float planet_count = 1000;
float size_min = 5;
float size_max = size_min * 3;
float planet_mid = WINDOW_SIZE/2;

//========================================================================================================================
// Class for a planet.

class Planet {
  
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float size;
  
  Planet() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE);
    this.size = random(size_min, size_max);
  }
  
  // The "orbits" are essentially generated by a bit of randomness.
  // Cheap, but effective instead of comparing to every other planet.
  void velocity() {
    if (this.xpos < planet_mid) {
      this.xvel += random(1)/1000;
    } else {
      this.xvel -= random(1)/1000;
    }
    if (this.ypos < planet_mid) {
      this.yvel += random(1)/1000;
    } else {
      this.yvel -= random(1)/1000;
    }
  }
  
  void update() {
    velocity();
    circle(this.xpos, this.ypos, this.size);
    this.xpos += this.xvel;
    this.ypos += this.yvel;
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
  fill(255);
  ellipseMode(CENTER);
  for (int temp_count = 0; temp_count != planet_count; temp_count++) {
    planet_list.add(new Planet());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  for (Planet temp_planet: planet_list) {
    temp_planet.update();
    temp_planet.update();
    temp_planet.update();
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
