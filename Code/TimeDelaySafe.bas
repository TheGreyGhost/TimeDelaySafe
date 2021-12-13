' Time Delay Safe
'Prosthetic Willpower!
' 1) Insert your phone/block of chocolate/object of addition into the safe and close the lid
' 2) Turn the dial to the desired time delay (1 hour -> 24 hours on a non-linear scale)
' 3) Push the Lock button
' 4) After the desired time has elapsed, the safe opens

' Other features:
' 5a) Push the "Open button" to open the safe (if not locked)
' 5b) .. If the safe is locked, the LED blinks.  One blink for each hour.
'
' Uses several techniques to reduce power consumption (see code).

#picaxe 08m2
' pinC.0=DigOut=Status LED (high = on)
' pinC.1=DigOut=Motor control (high = run)
' pinC.2=DigIn=Motor home position switch (only valid when pin1 = high: high = home)
' pinC.3=DigIn=LockButton push (high = pushed)
' pinC.4=ADCIn=Lock Potentiometer (min -> max)
' pinC.5=DigIn=OpenButton push (high = pushed)

' variables
' b0 = scratch
' b1 = scratch
' b2 = locked (non-zero = locked)
' w2 = minutes remaining till unlock
' w3 = naps remaining in this minute
' w4 = scratch

symbol mainsOn = bit0
symbol scratch = b1   ' reusable elsewhere for scratch
symbol loopCnt = b13  ' we have a 200ms pause each loop, so 25=5 sec
symbol mainsSensor = pin3
symbol ADCON0 = $1f   ' ADC control SFR register to turn off ADC module
symbol OSCCON = $8f   ' Oscillator control SFR register for speed up/down
symbol ADCtime = $7f  ' counts # of 50 second loops; at 72 (1hr), ADC battery
symbol Red_LED = 0
symbol Green_LED = 1

dirs = %00000011

for b0 = 0 to 100	' allow time for a new program download
  pause 100
next b0	
disconnect

disableBOD                ' turn off Brown Out Detection for low power
'setfreq k31 'poke OSCCON,%00000000 ' = 31 kHz slow down
peek ADCON0, b0
bit0 = 0           ' turn off the ADC module to save power
poke ADCON0, b0

' log lookup for the potentiometer: six minute intervals (i.e. 10 = 1 hour, 240 = 24 hours)
eeprom 0,(10,10,10,10,11,11,11,11,11,11,11,11,12,12,12,12,12,12,13,13,13,13,13,13,13,14,14,14,14,14,15,15,15,15,15,15,16,16,16,16,16,17,17,17,17,18,18,18,18,18,19,19,19,19,20,20,20,20,21,21,21,21,22,22,22,22,23,23,23,24,24,24,25,25,25,25,26,26,26,27,27,27,28,28,28,29,29,30,30,30,31,31,31,32,32,33,33,33,34,34,35,35,36,36,37,37,37,38,38,39,39,40,40,41,41,42,42,43,44,44,45,45,46,46,47,47,48,49,49,50,51,51,52,52,53,54,54,55,56,57,57,58,59,59,60,61,62,62,63,64,65,66,66,67,68,69,70,71,72,73,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,89,90,91,92,93,94,95,97,98,99,100,102,103,104,105,107,108,109,111,112,114,115,116,118,119,121,122,124,126,127,129,130,132,134,135,137,139,140,142,144,146,148,149,151,153,155,157,159,161,163,165,167,169,171,174,176,178,180,182,185,187,189,192,194,197,199,202,204,207,209,212,215,217,220,223,226,228,231,234,237,240)	

b1 = 0

main:
' wait for
nap 2 '72 ms
if b1 <> 0 then
	if w3 = 0 then
	  if w2 = 0 then
			gosub unlock
		else
		  dec w2
		end if
		w3 = 833  ' 833 x 72ms = 1 minute
	else 	
	  dec w3
	end if	
end if
let b0 = pins & %101000
if b0 = 0 then goto main
if b0 = %1000 then
	gosub lockbutton
else if b0 = %100000 then
	gosub openbutton
end if
goto main
	
unlock: ' run the motor and
' 1) wait until the home sensor is low for some time, then
' 2) stop when the home sensor becomes high
' 3) if it takes longer than 10 seconds, a problem has occurred; stop the motor and enter error state
w0 = 0
w4 = time + 10
high C.1

waitlow:
if pinC.2 = 0 then 
	inc w0
end if
if time >= w4 then goto timeouterror
if w0 < 1000 then goto waitlow

waithigh:
if time >= w4 then goto timeouterror
if pinC.2 = 0 then goto waithigh
low C.1

b1 = 0 ' unlocked
return

timeouterror: ' do nothing; if user presses a button, give a long LED blink.
low C.0
low C.1
nap 2 '72 ms
let b0 = pins & %101000
if b0 = 0 then goto timeouterror
high C.0
sleep 5
low C.0
goto timeouterror

openbutton: ' if not locked: open latch, otherwise blink the number of remaining hours
if b1 = 0 then
	gosub unlock
else
	w4 = w2 / 60
	for w0 = 0 to w4
		high C.0
		pause 250
		low C.0
		pause 250
	next	
end if
return

lockbutton: ' read the lock time: convert log scale (powers of 2 from 1 hr to 24 h)
						' if already locked: extend the lock time if new time is longer
readadc 4,b0 ' pre-read to stabilise -required?
readadc 4,b0 '

read b0,b1	; read value from table
w2 = b0 * 6 ' convert from 6-minute intervals to 1-minute intervals
w3 = 0	
b1 = 1			' locked

peek ADCON0, b0
bit0 = 0           ' turn off the ADC module to save power
poke ADCON0, b0

gosub openbutton ' flash the LEDs to show the remaining hours
return


;pause 5000
;poke ADCtime,0            ' initialize counter
;if mainsSensor = 1 then   ' if we have mains power
;  readadc 4,scratch       ' check battery voltage: 3V should be ok
;  if scratch > 153 then   ' 255/5v*3v = 153
;    high Green_LED
;  endif
;else                       ' we're starting up on battery
;  mainsOn = 1              ' pretend we're coming from a mains-on state
;endif
;'sertxd("  Restarted ",#scratch,CR,LF)
;
;main:
;  do
;    if mainsOn = 1 then
;      pause 200            ' allow a little debounce time & a little loop time
;                           '  Note: instead of pause, "nap" will save
;                           '    power, but pwm and servo commands cease
;                           '  at 4mHz we will have about 5 loops per second
;    else 
;'      pause 1              ' we're running at 1/128th the speed on battery
;                            ' timings will be based on slow instruction speed
;    endif
;    if mainsSensor = 1 then ' mains power is on
;      if mainsOn = 0 then  ' power is just coming on
;        poke OSCCON,%01100000 ' = 4 MHz; speed back up
;'        high Red_LED        ' indicate that we have mains power
;        mainsOn = 1
;      endif
;    else                   ' we're running on battery
;      if mainsOn = 1 then  ' power just went off
;        scratch = b0            ' save bit settings
;        peek ADCON0, b0
;        bit0 = 0           ' turn off the ADC module to save power
;        poke ADCON0, b0
;        b0 = scratch
;        mainsOn = 0
;        low Green_LED      ' can't monitor battery with mains off
;        poke OSCCON,%00000000 ' = 31 kHz slow down
;      endif
;'      low Red_LED          ' turn off mains indicator or turn off blink
;    endif
;    inc loopCnt
;    scratch = loopCnt // 10  ' 10 loops @ 31kHz = 5-7 seconds (experimentally)
;    if mainsOn = 0 then    ' we're on battery--give a 128ms flash every 5 sec
;      if scratch = 0 then  ' about 5-7 seconds passed (on battery)
;        high Green_LED       ' flash led
;        pause 1              ' 1*128 = 128ms
;        low Green_LED
;      endif
;    else                   ' we're on mains
;'  sertxd("  ",#loopCnt)
;      if loopCnt = 250 then   ' about 50+ seconds passed (on mains)
;        peek ADCtime,scratch
;        inc scratch
;        poke ADCtime,scratch
;        if b1 = 72 then    ' 250 loops = 50secs * 72 = 1 hour
;          readadc 4,scratch       ' check battery voltage 3V should be ok
;'  sertxd("  ",#scratch,CR,LF)
;          if scratch > 153 then   ' 255/5v*3v = 153
;            high Green_LED
;          else
;            low Green_LED  ' battery needs to be replaced
;          endif
;          poke ADCtime,0   ' restart 1-hour clock
;        endif
;        loopCnt = 0
;      endif
;    endif
;  loop
;