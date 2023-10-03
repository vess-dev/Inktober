//========================================================================================================================
// Day 10, Fortune: I don't really know what to do for today. Maybe a four leaf clover with some interesting effect?
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 10: \"Fortunate Fields\"";
String FILE_TITLE = "Day10Fortune.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Clover> clover_list = new ArrayList<Clover>();
float clover_size = 50;
// Allow clovers to rotate in opposite directions.
float[] vel_list = {-2, -1, 1, 2};

//========================================================================================================================
// Classes.

class Clover {
  
  float xpos;
  float ypos;
  float green;
  float dark;
  float vel;
  
  Clover() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE);
    // Have a darker green border.
    this.green = random(20, 200);
    this.dark = this.green + 20;
    this.vel = vel_list[int(random(vel_list.length))];
  }
  
  // Draw one of the leaves, which is two curves and a line really.
  void leaf() {
    bezier(0, 0, -(clover_size*1.2), -clover_size/2, -clover_size/3, -(clover_size*1.5), 0, -clover_size);
    bezier(0, 0, (clover_size*1.2), -clover_size/2, clover_size/3, -(clover_size*1.5), 0, -clover_size);
    line(0, 0, 0, -clover_size);
  }
  
  void update() {
    pushMatrix();
    translate(this.xpos, this.ypos);
    rotate(radians(this.vel));
    this.vel += Math.signum(this.vel);
    stroke(0, this.dark, 0);
    strokeWeight(5);
    fill(0, this.green, 0);
    // Repeat four times for a clover.
    for (int temp_count = 0; temp_count != 4; temp_count++) {
      leaf();
      rotate(HALF_PI);
    } 
    popMatrix();
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
  background(255);
  for (int temp_count = 0; temp_count != WINDOW_SIZE; temp_count++) {
    clover_list.add(new Clover());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(255);
  for (Clover temp_clover: clover_list) {
    temp_clover.update();
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
