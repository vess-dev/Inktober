//========================================================================================================================
// Day 21, Chains: I want to have chain links that move past each other side by side, like rising and falling chains.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 21: \"Chainlink\"";
String FILE_TITLE = "Day21Chains.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Chain> chain_list = new ArrayList<Chain>();
float chain_count = 10;
float chain_size = WINDOW_SIZE/chain_count;

//========================================================================================================================
// Class for a chain link.

class Chain {
  
  float xpos;
  float ypos;
  float yvel;
  
  Chain(float in_xpos) {
    this.xpos = in_xpos * chain_size;
    this.ypos = 0;
    this.yvel = (float) Math.pow(-1, in_xpos);
  }
  
  void update() {
    // Draw all of the chain loops.
    for (float temp_count = -chain_size; temp_count != (WINDOW_SIZE + (chain_size*2)); temp_count += chain_size) {
      circle(this.xpos, temp_count + this.ypos, chain_size); 
    }
    // Draw all of the chain connectors.
    for (float temp_count = -chain_size; temp_count != (WINDOW_SIZE + (chain_size*2)); temp_count += chain_size) {
      ellipse(this.xpos, this.ypos + temp_count + (chain_size/2), chain_size/3, chain_size);
    }
    this.ypos = (this.ypos + this.yvel) % chain_size;
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
  strokeWeight(chain_size/10);
  fill(93, 93, 93);
  for (int temp_count = 0; temp_count <= chain_count; temp_count += 1) {
    chain_list.add(new Chain(temp_count));
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  for (Chain temp_chain: chain_list) {
    temp_chain.update();
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
