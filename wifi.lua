print(wifi.sta.getip())
wifi.setmode(wifi.STATION)
wifi.sta.config("Edimax","groo1985")
tmr.delay(1)
print(wifi.sta.getip())