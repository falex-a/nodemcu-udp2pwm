led=4
dirA_pin = 1
speedA_pin = 2
dirB_pin = 5
speedB_pin = 6

gpio.mode(led, gpio.OUTPUT)
gpio.mode(dirA_pin, gpio.OUTPUT)
gpio.mode(dirB_pin, gpio.OUTPUT)

dirA = gpio.LOW
dirB = gpio.LOW

function rest(ms) 
    gpio.write(dirA_pin, gpio.LOW) 
    gpio.write(dirB_pin, gpio.LOW)            
    gpio.write(led, gpio.LOW)                
    pwm.setduty(speedA_pin, 0)     
    pwm.setduty(speedB_pin, 0) 
    tmr.delay(ms * 1000)
end

pwm.setup(speedA_pin, 500, 0)
pwm.setup(speedB_pin, 500, 0)
rest(500)

function run_back_A(speed, ms) 
    gpio.write(dirA_pin, gpio.HIGH)
    gpio.write(led, gpio.HIGH)
    pwm.setduty(speedA_pin, 1023-speed)
    tmr.delay(ms * 1000)
end

function run_forward_A(speed, ms) 
    gpio.write(dirA_pin, gpio.LOW)
    gpio.write(led, gpio.LOW)
    pwm.setduty(speedA_pin, speed)
    tmr.delay(ms * 1000)
end

function put_motion(x_right, y_up)
    -- x,y : -1:1            
    speedA = (y_up-x_right)*1023 
    speedB = (y_up+x_right)*1023
    
    if speedA < -1023 then
        speedA = -1023
    end
    if speedA > 1023 then
        speedA = 1023
    end
    if speedB < -1023 then
        speedB = -1023
    end
    if speedA > 1023 then
        speedB = 1023
    end
    new_dirA = gpio.LOW
    new_dirB = gpio.LOW
    if speedA < 0 then
        new_dirA = gpio.HIGH
        speedA = 1023+speedA
    end
    if speedB < 0 then
        new_dirB = gpio.HIGH
        speedB = 1023+speedB  
    end
    gpio.write(dirA_pin, new_dirA)
    gpio.write(dirB_pin, new_dirB)
    pwm.setduty(speedA_pin, speedA)
    pwm.setduty(speedB_pin, speedB)    
end


-- tmr.alarm(0,4000,1, statechange)

function test()
    put_motion(0, 1) -- forward
    tmr.delay(1 * 1000 * 1000)
    rest(1000) 
    put_motion(0, -1) -- backward
    tmr.delay(1 * 1000 * 1000)
    rest(1000)
    put_motion(1, 0)  -- right
    tmr.delay(1 * 1000 * 1000)
    rest(1000)
    put_motion(-1, 0)  -- left
    tmr.delay(1 * 1000 * 1000)
    rest(1000)
end

test()

--for i=1,10 do
--  tmr.delay(200000)
--end
