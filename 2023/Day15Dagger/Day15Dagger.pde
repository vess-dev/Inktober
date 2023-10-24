//========================================================================================================================
// Day 15, Dagger: I just want to have a dagger fly across the screen and draw lines, cuts in the page- that then bleed.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 15: \"Paper Cuts\"";
String FILE_TITLE = "Day15Dagger.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

Dagger handle_dagger = new Dagger();
float dagger_size = 50;
float dagger_coef = 50;

//========================================================================================================================
// Class for a dagger that creates cuts.

enum Dir {
  LEFT,
  RIGHT,
}

class Dagger {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float xvel;
  float yvel;
  float angle;
  Dir dir;
  ArrayList<Bleed> blood;
  
  Dagger() {
    this.xpos = -(dagger_size*2);
    this.ypos = -(dagger_size*2);
    this.blood = new ArrayList<Bleed>();
    respawn();
  }
  
  void respawn() {
    int spawn_dir = int(random(2));
    switch (spawn_dir) {
      case 0: // Moving left to right.
        this.xpos = -(dagger_size * 2);
        this.ypos = int(random(dagger_size, WINDOW_SIZE - dagger_size));
        this.txpos = WINDOW_SIZE + (dagger_size * 2);
        this.typos = int(random(dagger_size, WINDOW_SIZE - dagger_size));
        this.dir = Dir.RIGHT;
        break;
      case 1: // Moving right to left.
        this.xpos = WINDOW_SIZE + (dagger_size * 2);
        this.ypos = int(random(dagger_size, WINDOW_SIZE - dagger_size));
        this.txpos = -(dagger_size * 2);
        this.typos = int(random(dagger_size, WINDOW_SIZE - dagger_size));
        this.dir = Dir.LEFT;
        break;
    }
    float xdiff = this.txpos - this.xpos;
    float ydiff = this.typos - this.ypos;
    this.xvel = xdiff / dagger_coef;
    this.yvel = ydiff / dagger_coef;
    this.angle = atan2(ydiff, xdiff);
    // For debug purposes.
    System.out.println(String.format("%s %s %s %s %s %s", this.xpos, this.ypos, this.txpos, this.typos, this.xvel, this.yvel));
  }
  
  void check() {
    // Respawn the dagger if it runs out of bounds.
    if ((this.dir == Dir.LEFT) && (this.xpos <= this.txpos)) {
      respawn();
    } else if ((this.dir == Dir.RIGHT) && (this.xpos >= this.txpos)) {
      respawn();
    }
  }
  
  void show() {
    stroke(50, 0, 0);
    strokeWeight(0);
    fill(50, 0, 0);
    // Draw the dagger head and point it in the right direction.
    pushMatrix();
    translate(this.xpos, this.ypos);
    rotate(this.angle + HALF_PI);
    triangle(-(dagger_size/2), dagger_size, 0, -dagger_size, (dagger_size/2), dagger_size);
    popMatrix();
  }

  void update() {
    for (Bleed temp_blood: this.blood) {
      temp_blood.update();
    }
    show();
    float xnew = this.xpos + this.xvel;
    float ynew = this.ypos + this.yvel;
    this.blood.add(new Bleed(this.xpos, this.ypos, xnew, ynew));
    this.xpos = xnew;
    this.ypos = ynew;
    check();
  }

}

//========================================================================================================================
// Class for a bleed line that creates drops.

class Bleed {
  
  float xpos;
  float ypos;
  float txpos;
  float typos;
  float drip;
  
  Bleed(float in_xpos, float in_ypos, float in_txpos, float in_typos) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.txpos = in_txpos;
    this.typos = in_typos;
    this.drip = 0;
  }
  
  void update() {
    stroke(50, 0, 0);
    strokeWeight(2);
    line(this.xpos, this.ypos, this.txpos, this.typos);
    
    for (int temp_count = 0; temp_count != this.drip; temp_count++) {
      fill(200, 0, 0);
      circle(this.xpos+random(5), this.ypos + temp_count, 5);
    }
    if (this.drip <= 100) {
      this.drip += 2;
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
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(0);
  handle_dagger.update();
  video_handle.saveFrame();
}

//========================================================================================================================
// Finish with the sketch.

void mousePressed() {
  video_handle.endMovie();
  exit();
}

//========================================================================================================================
