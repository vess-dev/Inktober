//========================================================================================================================
// Day 13, Rise: I'm thinking of doing a field of flowers that sway from side to side while rotating.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 13: \"Rising Bloom\"";
String FILE_TITLE = "Day13Rise.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Flower> flower_list = new ArrayList<Flower>();
float flower_height = 50;
float flower_parth = flower_height / 3;
float flower_width = 10;
float flower_partw = flower_width * 2;
float flower_size = 20;
float petal_size = 2;
float sway_max = 10;
float[] dir_list = {-1, 1};

//========================================================================================================================
// Classes.

class Flower {
  
  float xpos;
  float ypos;
  float stem;
  float dir;
  float sway;
  float[] flower;
  float offset;
  float spin;
 
  Flower() {
    this.xpos = random(WINDOW_SIZE);
    this.ypos = random(WINDOW_SIZE + 30);
    this.stem = random(100, 150);
    this.dir = dir_list[int(random(1))];
    this.sway = 0;
    this.flower = new float[] {random(230), random(230), random(230)};
    this.offset = random(360);
    this.spin = 0;
  }
  
  void sway() {
    // Try and get it to sway side to side. Doesn't work? But I went with it.
    if (this.sway == sway_max || this.sway == -sway_max) {
      if (this.dir == dir_list[0]) {
        this.dir = dir_list[1];
      } else {
        this.dir = dir_list[0];
      }
      sway_max += 2;
    }
    this.sway += this.dir;
  }
  
  void bloom() {
    fill(this.flower[0], this.flower[1], this.flower[2]);
    strokeWeight(petal_size);
    stroke(this.flower[0] + random(25), this.flower[1] + random(25), this.flower[2] + random(25));
    pushMatrix();
    translate(this.xpos+this.sway,this.ypos-flower_height);
    rotate(radians(this.offset + this.spin));
    // Draw each of the petals in the bloom.
    for (int temp_count = 0; temp_count != 4; temp_count++) {
      rotate(HALF_PI);
      bezier(0, 0, -(flower_size*1.2), -flower_size/2, -flower_size/3, -(flower_size*1.5), 0, -flower_size);
      bezier(0, 0, (flower_size*1.2), -flower_size/2, flower_size/3, -(flower_size*1.5), 0, -flower_size);
    }
    popMatrix();
    this.spin += 2;
  }
  
  void update() {
    stroke(0, this.stem, 0);
    strokeWeight(flower_width);
    noFill();
    bezier(this.xpos,this.ypos,   this.xpos-flower_partw+this.sway,this.ypos-(flower_parth),   this.xpos+flower_partw+this.sway,this.ypos-(flower_parth*2),   this.xpos+this.sway,this.ypos-flower_height);
    bloom();
    sway();
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
  for (int temp_count = 0; temp_count != 150; temp_count++) {
    flower_list.add(new Flower());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  for (Flower temp_flower: flower_list) {
    temp_flower.update();
    temp_flower.update();
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
