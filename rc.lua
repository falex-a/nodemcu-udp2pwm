print(wifi.sta.getip())
wifi.setmode(wifi.STATION)
wifi.sta.config("Edimax","groo1985")
tmr.delay(1)
print(wifi.sta.getip())

-- Try to identify myself now and then..
tmr.alarm(0,3000,1,
    function()
        if wifi.sta.getip()==nil then
            print "IP is nil, WTF"
            return
        end
        conn = net.createConnection(net.UDP, 0)
        -- TODO: fix broadcast
        -- conn:connect(6666, "0.0.0.0")
        conn:connect(6666, "192.168.2.105")
        conn:send(wifi.sta.getip())
        conn:close() -- t("groo")
    end
)

led=4

dofile("mot.lua")
srv = net.createServer(net.UDP)
srv:listen(1234)
srv:on("receive", function(s, data)
    -- print("received: " .. data)
    xs, ys = data:match("([^,]+),([^,]+)")
    x = tonumber(xs)
    y = tonumber(ys)
    print("x: " .. x .. "y: " .. y)
    if y<200 and y>-200 and x<200 and x>-200 then
        -- freq = (210+x)/20 -- 0.5-20 Hz
        -- duty = (200+y)/400 * 1023
        -- pwm.setup(led, freq, duty)
        -- pwm.setduty(led, duty)
        x = x/200
        y = y/200
        if x==0 and y==0 then
            rest(50)
        else
            put_motion(x, y)
            tmr.delay(50 * 1000)
        end
    end
    -- s:send("echo: " .. data)
end)

-- srv=net.createServer(net.TCP) 
-- print("groo")
-- srv:listen(80,function(conn) 
--     conn:on("receive",function(conn,payload) 
--    print(payload) 
--    conn:send("<h1> good night babe.</h1>")
--    end) 
-- end)
