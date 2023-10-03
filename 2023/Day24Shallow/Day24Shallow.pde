//========================================================================================================================
// Day 24, Shallow: Perhaps etch out waves that move back and forth, and slightly up and down? We shall see.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 24: \"Shallow Shallows\"";
String FILE_TITLE = "Day24Shallow.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Wave> wave_list = new ArrayList<Wave>();
float wave_count = 10;
float wave_chunk = WINDOW_SIZE/wave_count;
float color_rangemin = 100;
float color_rangemax = 200;
float color_count = 0;
float wave_osci = 50;

//========================================================================================================================
// Class for a wave.

class Wave {
  
  float xpos;
  float ypos;
  float xvel;
  float counter;
  
  Wave(float in_ypos) {
    this.xpos = 0;
    this.ypos = in_ypos * wave_chunk;
    this.xvel = (float) Math.pow(-1, in_ypos);
    this.counter = 0;
  }
  
  void update() {
    // Oscillate the waves up and down, and left and right.
    float osci_xchange = osci(this.counter, -wave_osci, wave_osci) * this.xvel;
    float osci_ychange = osci(this.counter, -wave_osci, wave_osci);
    for (float temp_count = -wave_chunk; temp_count <= WINDOW_SIZE + wave_chunk; temp_count += wave_chunk) {
      // Draw the up arc swoop, then he down arc swoop.
      arc(this.xpos + temp_count + osci_xchange, this.ypos + osci_ychange, wave_chunk, wave_chunk, 0, HALF_PI);
      arc(this.xpos + temp_count + osci_xchange, this.ypos + osci_ychange, wave_chunk, wave_chunk, HALF_PI, PI);
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
  stroke(0);
  strokeWeight(wave_chunk/10);
  noFill();
  for (float temp_count = -wave_count; temp_count <= wave_count; temp_count += 1) {
    wave_list.add(new Wave(temp_count));
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Provides for an oscillation between two numbers.

float osci(float input_counter, float input_min, float input_max) {
    float range_diff = input_max - input_min;
    return input_min + Math.abs(((input_counter + range_diff) % (range_diff * 2)) - range_diff);
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  float color_blue = osci(color_count, color_rangemin, color_rangemax);
  background(0, 0, color_blue);
  color_count += 1;
  for (Wave temp_wave: wave_list) {
    temp_wave.update();
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
