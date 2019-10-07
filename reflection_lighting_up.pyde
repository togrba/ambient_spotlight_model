# based on sources:
# https://py.processing.org/reference/class.html
# https://processing.org/examples/reflection.html
# https://processing.org/examples/arrayobjects.html
# https://processing.org/discourse/beta/num_1198100330.html
# https://www.openprocessing.org/sketch/127435

''' TODO:
    - Reset time/make counter work
    - Fix mouseY, mouse approaching from all angles
    - Add color variations
    - Add sound
'''

add_library('CountdownTimer')
timer = CountdownTimer

SECOND_IN_MILLIS = 1000
HOUR_IN_MILLIS = 36000000

#start_timer = int
#interval = 1

def setup():
    size(1280, 720, P3D) # size(640, 360, P3D)  # size(1280, 720, P3D)
    noStroke()
    colorMode(RGB, 255, 0, 1)
    fill(0)
    timer = CountdownTimerService.getNewCountdownTimer(this).configure(SECOND_IN_MILLIS, HOUR_IN_MILLIS);

    
def draw():
    background(0)
    translate(width / 2, height / 2) # Sphere position
    start_timer = millis() / 1000 # Returns the number of seconds since starting the program
    print("START TIMER: ", start_timer)
    if (mouseX < (float(width / 2))-50): # Left
        lightSpecular(21, 0, 222) # Set the specular color of lights that follow
        directionalLight(0.8, 0, 0.8, 0, 0, -1)
        s = mouseX / float(width / 2)
        print("LEFT SIDE s:", s, "mouseX:", mouseX)
        specular(s, s, s)
        sphere(120)
    elif (mouseX < (float(width / 2))+50): # Middle
        #enter_timer = second() + (minute() * 60)
        enter_timer = start_timer + 1
        print("ENTER TIMER: ", enter_timer, "START TIMER: ", start_timer)

        enter_timer = enter_timer - start_timer
        print("ENTER TIMER: ", enter_timer, "START TIMER: ", start_timer)
        # if (second() > 10):
        #     print("MORE THAN 10 SEC IN MIDDLE:", enter_timer)
        # else:
        #     print("LESS THAN 10 SEC IN MIDDLE:", enter_timer)
        if (mouseX < float(width / 2)): # To the left of the exact middle
            lightSpecular(109, 0, 255)
            directionalLight(0.8, 0, 0.8, 0, 0, -1)
            s = mouseX / float(width / 2)
            print("MID LEFT s:", s, "mouseX:", mouseX)
            specular(s, s, s)
            sphere(120)
        elif (mouseX > float(width / 2)): # To the right of the exact middle
            lightSpecular(109, 0, 255)
            directionalLight(0.8, 0, 0.8, 0, 0, -1)
            s = (mouseX / float(width / 2) - 2) * -1
            print("MID RIGHT s:", s, "mouseX:", mouseX)
            specular(s, s, s)
            sphere(120)
        else: # Exact middle
            lightSpecular(109, 0, 255)
            directionalLight(0.8, 0, 0.8, 0, 0, -1)
            s = mouseX / float(width / 2)
            print("EXACT MIDDLE s:", s, "mouseX:", mouseX)
            specular(s, s, s)
            sphere(120)
    else: # Right
        lightSpecular(21, 0, 222)
        directionalLight(0.8, 0, 0.8, 0, 0, -1)
        s = (mouseX / float(width / 2) - 2) * -1
        print("RIGHT SIDE s:", s, "mouseX:", mouseX)
        specular(s, s, s)
        sphere(120)
