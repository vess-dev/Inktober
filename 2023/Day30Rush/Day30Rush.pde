//========================================================================================================================
// Day 30, Rush: Sonic rings that rotate within themselves that rotate within themselves that... You get the gist.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 30: \"Rushing Round\"";
String FILE_TITLE = "Day30Rush.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Ring> ring_list = new ArrayList<Ring>();
Ring handle_ring;
float ring_count = 30;

//========================================================================================================================
// Class for a ring that holds other rings.

class Ring {
  
  Ring next_ring;
  float xpos;
  float ypos;
  float size;
  float rot;
  boolean bw;
  
  Ring(float in_xpos, float in_ypos, float in_size, float in_count, boolean in_bw) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.size = in_size;
    this.rot = 0;
    if (in_count <= ring_count) {
      // Flip the color of the ring.
      this.bw = in_bw;
      // Create a next ring if there is a supply for it.
      this.next_ring = new Ring(in_xpos/2, in_ypos/2, in_size*0.8, in_count + 1, !in_bw);
    }
  }
  
  void update() {
    pushMatrix();
    translate(this.xpos, this.ypos);
    // Draw either a yellow or black ring.
    if (this.bw) {
      stroke(255, 215, 0);
    } else {
      stroke(0);
    }
    circle(0, 0, this.size);
    rotate(radians(this.rot));
    // Continue to update the sub rings.
    if (next_ring != null) {
      this.next_ring.update();
    }
    popMatrix();
    this.rot += 2;
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
  strokeWeight(5);
  noFill();
  ellipseMode(CENTER);
  handle_ring = new Ring(WINDOW_SIZE/2, WINDOW_SIZE/2, WINDOW_SIZE, 1, true);
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  handle_ring.update();
  handle_ring.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
