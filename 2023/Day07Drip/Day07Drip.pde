//========================================================================================================================
// Day 7, Drip: I wanted to do drips of rain over a moving landscape, with random flashes of lightning.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 7: \"Landscape Rain\"";
String FILE_TITLE = "Day07Drip.mp4";
VideoExport video_handle;
boolean video_toggle = false;

//========================================================================================================================
// Sketch globals.

ArrayList<Land> land_list = new ArrayList<Land>();
ArrayList<Rain> rain_list = new ArrayList<Rain>();
Strike handle_strike = new Strike();
float land_size = WINDOW_SIZE/2;
float rain_min = 20;
float rain_max = 30;

//========================================================================================================================
// Class for the land shapes.

class Land {
  
  float hue;
  float xpos;
  float ypos;
  float size;
  float vel;
  
  Land(float in_color, float in_xpos, float in_ypos, float in_vel) {
    this.hue = in_color;
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.vel = in_vel;
  }
  
  void update() {
    stroke(0);
    strokeWeight(10);
    fill(0, this.hue, 0);
    circle(this.xpos, this.ypos, land_size);
    this.xpos += this.vel;
    // This wrapping isn't great but it works.
    if (this.xpos >= WINDOW_SIZE + land_size * 2) {
      this.xpos = -land_size;
    }
  }
  
}

//========================================================================================================================
// Class for the rain drops.

class Rain {
  
  float x1pos;
  float y1pos;
  float x2pos;
  float y2pos;
  float vel;
  float hue;
  
  Rain() {
    move();
  }
  
  void move() {
    // Spawn rain above the draw window so it falls in.
    this.x1pos = random(WINDOW_SIZE * 2);
    this.y1pos = -random(WINDOW_SIZE);
    this.x2pos = this.x1pos + random(rain_min, rain_max);
    this.y2pos = this.y1pos - random(rain_min, rain_max);
    this.vel = random(10, 20);
    this.hue = random(50, 200);
  }
  
  void update() {
    stroke(0, 0, this.hue);
    strokeWeight(2);
    line(this.x1pos, this.y1pos, this.x2pos, this.y2pos);
    // Let the rain fall.
    this.x1pos -= this.vel;
    this.y1pos += this.vel;
    this.x2pos -= this.vel;
    this.y2pos += this.vel;
    if (this.y2pos > WINDOW_SIZE) {
      move();
    }
  }
  
}

//========================================================================================================================
// Class for the lightning strikes.

class Strike {
  
  float timer;
  float xpos;
  float ypos;
  
  Strike() {
    this.timer = 0;
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE);
  }
  
  void update() {
    // Lightning strikes every 200 frames for 20 frames.
    this.timer = (this.timer + 1) % 200;
    if (this.timer <= 20) {
      // Reduce epilepsy.
      fill(100, random(50, 70));
      square(0, 0, WINDOW_SIZE);
      stroke(255);
      strokeWeight(20);
      line(this.xpos + random(-100, 100), 0, this.ypos + random(-100, 100), WINDOW_SIZE);
    } else {
      this.xpos = random(WINDOW_SIZE);
      this.ypos = random(WINDOW_SIZE);
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
  ellipseMode(CENTER);
  // Create landmasses in the fore, middle, and background.
  float[] green_list = {20, 40, 60};
  float pos_xchunk = WINDOW_SIZE/5;
  float pos_ychunk = WINDOW_SIZE/12;
  float land_vel = 1;
  for (int temp_count = 0; temp_count != 12; temp_count++) {
    land_list.add(new Land(green_list[0], (pos_xchunk * temp_count), pos_ychunk * 10, land_vel * 2));
  }
  for (int temp_count = 0; temp_count != 12; temp_count++) {
    land_list.add(new Land(green_list[1], (pos_xchunk * temp_count), pos_ychunk * 11, land_vel * 4));
  }
  for (int temp_count = 0; temp_count != 12; temp_count++) {
    land_list.add(new Land(green_list[2], (pos_xchunk * temp_count), pos_ychunk * 12, land_vel * 6));
  }
  // Create a bunch of raindrops to fall.
  for (int temp_count = 0; temp_count != 1000; temp_count++) {
    rain_list.add(new Rain());
  }
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  // Update the lightning.
  handle_strike.update();
  // Simple hack for wrapping the land masses through translation.
  translate(-land_size, 0);
  for (Land temp_land : land_list) {
    temp_land.update();
  }
  translate(land_size, 0);
  // Update the rain.
  for (Rain temp_rain: rain_list) {
    temp_rain.update();
  }
  if (video_toggle) {
    video_handle.saveFrame();
  }
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  if (!video_toggle) {
    video_handle = new VideoExport(this, FILE_TITLE);
    video_handle.startMovie();
    video_toggle = true;
  } else {
    video_handle.endMovie();
    exit();
  }
}

//========================================================================================================================
