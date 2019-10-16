/*
based on sources:
https://processing.org/examples/reflection.html
https://github.com/dhchoi/processing-countdowntimer
*/
  
import processing.sound.*;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;

// declare variables
CountdownTimer timer;
SoundFile file;
float s;

// adjust variables
final long time_in_middle = 5000; // set wait time in middle in ms
final int size_width = 1280;  // set screen width - OBS change setup size too  
final int size_height = 720;  // set screen height - OBS change setup size too 
final float sphere_size = 200;



void setup() {
    size(1280, 720, P3D);
    noStroke();
    colorMode(RGB, 255, 0, 1); 
    fill(0);
    file = new SoundFile(this, "your_file.mp3");  // audio file
    file.play();
    file.loop();
    // create and start a timer that has been configured to trigger onTickEvents every second (100 ms) and run for x ms, set by variable time_in_middle
    timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, time_in_middle).start();
}

void draw() {
  background(0);
  float max_dist = sqrt(pow((size_height)/2, 2)+pow((size_width)/2, 2));
  float s = ((dist(mouseX, mouseY, width/2, height/2)/max_dist)-1)*-1;      // s, distance from the center of the sphere, 0 furthest away, 1 middle
  translate(width / 2, height / 2);                   // Sphere position
  file.amp(s);
  if (s < ((sphere_size / max_dist) -1) * -1) {    // when outside of the sphere
    lightSpecular(2, 0, 222);                // Set the specular color of lights that follow
    directionalLight(0.8, 0, 0.8, 0, 0, -1);
    specular(s, s, s);
    sphere(sphere_size);
    timer.stop(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
    timer.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
    timer.start();    // start timer when entering sphere
    //println("SPHERE EDGE",((sphere_size / max_dist) -1) * -1);
    //println("s:", s);
  }
  else {        // when inside the sphere
    if (timer.getTimeLeftUntilFinish()/1000 == 0) {
      lightSpecular(2, 0, 222); 
      fill(255*(cos(millis()/800.f)+1)/4);      // pulsing
      directionalLight(0.8, 0, 0.8, 0, 0, -1);
      specular(s, s, s);
      sphere(sphere_size);
      println("MIDDLE Resting. s: ", s);
    }
    else {
      lightSpecular(2, 0, 222); 
      directionalLight(0.8, 0, 0.8, 0, 0, -1);
      specular(s, s, s);
      sphere(sphere_size);
      println("MIDDLE s:", s);
    }
  }
}

void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
   println("TIME left until resting: " + timeLeftUntilFinish/1000 + "s");
}

void onFinishEvent(CountdownTimer t) {
   println("FINISHED!");
}
