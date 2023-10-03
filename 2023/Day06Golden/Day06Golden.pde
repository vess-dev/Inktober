//========================================================================================================================
// Day 6, Golden: I wanted to interlace multiple curved lines, like ribbons, that pass through each other.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 6: \"Golden Ribbons\"";
String FILE_TITLE = "Day06Golden.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Ribbon> ribbon_list = new ArrayList<Ribbon>();
float ribbon_size = 20;
float ribbon_vel = 4;

//========================================================================================================================
// Classes.

enum Type {
  VERT,
  HORI,
}

class Ribbon {
  
  Type type;
  float xpos;
  float ypos;
  
  Ribbon(Type in_type, float in_pos) {
    this.type = in_type;
    if (in_type == Type.VERT) {
      this.xpos = 0;
      this.ypos = 20 * (2 * in_pos - 1);
    } else {
      this.xpos = 20 * (2 * in_pos - 1);
      this.ypos = 0;
    }
  }
  
  void update() {
    // Changes the severity of the curve.
    float flux_size = (ribbon_size*6);
    // Draw the ribbons offscreen.
    float offset_size = (ribbon_size*4);
    // Draw ribbons that move vertically, or horizontally.
    if (this.type == Type.VERT) {
      strokeWeight(ribbon_size);
      stroke(253, 208, 23);
      bezier(this.xpos,this.ypos-offset_size,   WINDOW_SIZE*0.25,this.ypos+flux_size,   WINDOW_SIZE*0.75,this.ypos-flux_size,   WINDOW_SIZE,this.ypos-offset_size);
      this.ypos = (this.ypos + ribbon_vel) % (WINDOW_SIZE + offset_size);
    } else {
      strokeWeight(ribbon_size);
      stroke(251, 177, 23);
      bezier(this.xpos-offset_size,this.ypos,   this.xpos+flux_size,WINDOW_SIZE*0.25,   this.xpos-flux_size,WINDOW_SIZE*0.75,   this.xpos-offset_size,WINDOW_SIZE);
      this.xpos = (this.xpos + ribbon_vel) % (WINDOW_SIZE + offset_size);
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
  background(251, 177, 23);
  noFill();
  for (int temp_count = 0; temp_count != WINDOW_SIZE/4; temp_count++) {
    // Interlace the moving ribbons.
    ribbon_list.add(new Ribbon(Type.VERT, temp_count));
    ribbon_list.add(new Ribbon(Type.HORI, temp_count));
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Ribbon temp_ribbon: ribbon_list) {
    temp_ribbon.update();
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
