//========================================================================================================================
// Day 8, Toad: Little lilypads that float in a pool of water that has echos expand outwards.
//========================================================================================================================
// Imports.

import com.hamoid.*;
import java.util.ArrayList;

//========================================================================================================================
// Template globals.

int WINDOW_SIZE = 600;
String WINDOW_TITLE = "Day 8: \"Lotad Pond\"";
String FILE_TITLE = "Day08Toad.mp4";
VideoExport video_handle;

//========================================================================================================================
// Sketch globals.

ArrayList<Pad> pad_list = new ArrayList<Pad>();
float pad_size = WINDOW_SIZE/5;
float[] pad_vel = {-2, -1, 1, 2};

//========================================================================================================================
// Class for the lilypads.

class Pad {
  
  float timer;
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float rotation;
  ArrayList<Fade> fade;
  ArrayList<Echo> echo;
  
  Pad() {
    this.timer = 0;
    this.xpos = random(600);
    this.ypos = random(600);
    this.xvel = pad_vel[int(random(pad_vel.length))];
    this.yvel = pad_vel[int(random(pad_vel.length))];
    this.fade = new ArrayList<Fade>();
    this.echo = new ArrayList<Echo>();
  }
  
  void bounce() {
    if (this.xpos < 0) {
      smack();
      this.xvel = Math.abs(this.xvel);
    }
    if (this.xpos > WINDOW_SIZE) {
      smack();
      this.xvel = -this.xvel;
    }
    if (this.ypos < 0) {
      smack();
      this.yvel = Math.abs(this.yvel);
    }
    if (this.ypos > WINDOW_SIZE) {
      smack();
      this.yvel = -this.yvel;
    }
  }
  
  void update() {
    this.timer = (this.timer + 1) % 30;
    this.xpos += this.xvel;
    this.ypos += this.yvel;
    // Update the fade behind the lilypad.
    if (this.timer == 0) {
      this.fade.add(0, new Fade(this.xpos, this.ypos));
    }
    pushMatrix();
    // Rotate the lilypad.
    translate(this.xpos, this.ypos);
    rotate(radians(this.rotation));
    // Draw the lilypad itself.
    stroke(0);
    strokeWeight(2);
    fill(0, 78, 56);
    circle(0, 0, pad_size);
    fill(46, 139, 87);
    circle(0, 0, pad_size - 20);
    // Draw lines on the lilypads.
    stroke(0);
    strokeWeight(2);
    line(10, 0, (pad_size/2) - 20, 0);
    line(-10, 0, -(pad_size/2) + 20, 0);
    line(0, 10, 0, (pad_size/2) - 20);
    line(0, -10, 0, -(pad_size/2) + 20);
    popMatrix();
    this.rotation += random(0.5, 1);
    // Handle bouncing off the walls of the pond.
    bounce();
  }
  
  void smack() {
    // Add new echos on bounds collision.
    this.echo.add(0, new Echo(this.xpos, this.ypos));
  }
  
  void upecho() {
    boolean echo_remove = false;
    // Update all of the echoes.
    for (Echo temp_echo: this.echo) {
      temp_echo.update();
      if (temp_echo.done) {
        echo_remove = true;
      }
    }
    // Remove echoes that have finished.
    if (echo_remove) {
      this.echo.remove(this.echo.size() - 1);
    }
  }
  
  void upfade() {
    boolean fade_remove = false;
    // Update all of the fades.
    for (Fade temp_fade: this.fade) {
      temp_fade.update();
      if (temp_fade.done) {
        fade_remove = true;
      }
    }
    // Remove fades that have finished.
    if (fade_remove) {
      this.fade.remove(this.fade.size() - 1);
    }
  }
  
}

//========================================================================================================================
// Class for the fade behind the lilypads.

class Fade {
  
  float mirror;
  float xpos;
  float ypos;
  boolean done;
  
  Fade(float in_xpos, float in_ypos) {
    this.mirror = 200;
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.done = false;
  }
  
  void update() {
    // Make a fade more and more translucent.
    if (!this.done) {
      noStroke();
      fill(255, this.mirror);
      circle(this.xpos, this.ypos, pad_size);
      this.mirror -= 2;
      if (this.mirror <= 0) {
        this.done = true;
      }
    }
  }

}

//========================================================================================================================
// Class for the echo when the lilypads hit the walls.

class Echo {
  
  float xpos;
  float ypos;
  float size;
  boolean done;
  
  Echo(float in_xpos, float in_ypos) {
    this.xpos = in_xpos;
    this.ypos = in_ypos;
    this.size = pad_size;
    this.done = false;
  }
  
  void update() {
    if (!this.done) {
      this.size += 3;
      strokeWeight(1);
      stroke(56, 172, 236);
      noFill();
      circle(this.xpos, this.ypos, this.size);
      // Kill echoes that get too big.
      if (this.size == (WINDOW_SIZE * 3)) {
        this.done = true;
      }
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
  for (int temp_count = 0; temp_count != 5; temp_count++) {
    pad_list.add(new Pad());
  }
  video_handle = new VideoExport(this, FILE_TITLE);
  video_handle.startMovie();
}

//========================================================================================================================
// Draw loop per frame.

void draw() {
  background(130, 202, 250);
  // Update the fade, then the pond echoes, then the lilypads themselves.
  for (Pad temp_pad: pad_list) {
    temp_pad.upfade();
  }
  for (Pad temp_pad: pad_list) {
    temp_pad.upecho();
  }
  for (Pad temp_pad: pad_list) {
    temp_pad.update();
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
