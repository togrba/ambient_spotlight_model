/*
based on sources:
https://py.processing.org/reference/class.html
https://processing.org/examples/reflection.html
https://processing.org/examples/arrayobjects.html
https://processing.org/discourse/beta/num_1198100330.html
https://www.openprocessing.org/sketch/127435
https://github.com/dhchoi/processing-countdowntimer/blob/master/examples/StopwatchExample/StopwatchExample.pde

TODO:
 - Implement countcown timer, see tab
 - Add color variations   ??? https://py.processing.org/reference/sphereDetail.html
 - Fix sound library on web
 - Add shape shifting
*/
  
import processing.sound.*;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;

// declare variables
CountdownTimer timer;
SoundFile file;
int time;
int time_interval;
float s;

// adjust variables
//final int time_in_middle = 10000; // set wait time in middle in ms
final int size_width = 1280;  // set screen width - OBS change setup too
final int size_height = 720;  // set screen height - OBS change setup too
final float sphere_size = 200;

// declare variables
float max_dist = sqrt(pow((size_height)/2, 2)+pow((size_width)/2, 2));


void setup() {
    size(1280, 720, P3D); // size(640, 360, P3D)  // size(1280, 720, P3D)
    noStroke();
    colorMode(RGB, 255, 0, 1);
    fill(0);
    //time = millis();  // time spent in the program
    //println("START", time);
    file = new SoundFile(this, "ThetaMeditation-Beat-Forest.mp3");  // audio file
    file.play();

    // create and start a timer that has been configured to trigger onTickEvents every 100 ms and run for 5000 ms
    timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, 5000).start();
}


void draw() {
  background(0);
  float s = ((dist(mouseX, mouseY, width/2, height/2)/max_dist)-1)*-1;    // when outside of the sphere
  translate(width / 2, height / 2);         // Sphere position
  file.amp(s);
  if (s < ((sphere_size / max_dist) -1) * -1) {
    lightSpecular(21, 0, 222);                // Set the specular color of lights that follow
    directionalLight(0.8, 0, 0.8, 0, 0, -1);
    println("s:", s, "time_interval: ", time_interval, "time: ", time);
    specular(s, s, s);
    sphere(sphere_size);
    //println("SPHERE EDGE",((sphere_size / max_dist) -1) * -1);
  }
  else {    // when inside the sphere
    //time_interval = millis() - time; // update time 
    //if (millis() - time >= time_in_middle) {
    lightSpecular(271, 0, 99); 
    fill(255*(sin(millis()/500.f)+1)/2);      // pulsing
    directionalLight(0.8, 0, 0.8, 0, 0, -1);
    println("MIDDLE s:", s, "time_interval: ", time_interval, "time: ", time);
    specular(s, s, s);
    sphere(sphere_size);
  }
}
