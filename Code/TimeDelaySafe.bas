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

'  Troubleshooting features:
' 1) If the motor times out, enters 'timeout mode'.  When either button is pressed, the status LED lights for 5 seconds.  If the button is held for more than 
'    five seconds, run the motor until the button is released
' 2) If power is applied while holding down the Lock button, enter programming mode.  Flashes status LED.

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

symbol ADCON0 = $1f   ' ADC control SFR register to turn off ADC module
symbol OSCCON = $8f   ' Oscillator control SFR register for speed up/down

dirs = %00000011
low C.0
low C.1
if pinC.3 = 1 then goto waitforprogram

disconnect 

disableBOD                ' turn off Brown Out Detection for low power
'setfreq k31 'poke OSCCON,%00000000 ' = 31 kHz slow down
peek ADCON0, b0
bit0 = 0           ' turn off the ADC module to save power
poke ADCON0, b0

' log lookup for the potentiometer: six minute intervals (i.e. 10 = 1 hour, 240 = 24 hours)
eeprom 0,(10,10,11,11,11,12,12,12,13,13,13,14,14,14,15,15,16,16,16,17,17,17,18,18,18,19,19,19,20,20,20,21,21,22,22,22,23,23,24,24,24,25,25,26,26,27,27,27,28,28,29,29,29,30,30,31,31,31,32,32,33,33,33,34,34,35,35,36,36,36,37,37,38,38,38,39,39,40,40,41,42,43,44,45,46,47,47,48,49,50,51,52,53,54,55,56,57,58,59,60,60,61,62,63,64,65,66,67,68,69,70,71,72,73,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,121,122,123,123,124,124,125,126,126,127,128,128,129,130,130,131,131,132,133,133,134,135,135,136,137,137,138,138,139,140,140,141,142,142,143,143,144,145,145,146,147,147,148,149,149,150,150,151,152,152,153,154,154,155,156,156,157,157,158,159,159,160,163,166,169,172,175,178,181,184,187,190,193,196,199,201,204,207,210,213,216,219,222,225,228,231,234,237,240,243,246,249)

b2 = 0

high C.0			' signal that we are starting main
pause 1000
low C.0

main:
' wait for
nap 2 '72 ms
if b2 <> 0 then
	if w3 = 0 then
	  if w2 = 0 then
			gosub unlock
		else
		  dec w2
		end if
		w3 = 825  ' 833 x 72ms = 1 minute; it was slightly longer when I timed it so reduce to 825
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
if w0 < 100 then goto waitlow

waithigh:
	if time >= w4 then goto timeouterror
	if pinC.2 = 0 then goto waithigh
	low C.1

	b2 = 0 ' unlocked
return

timeouterror: ' do nothing; if user presses a button, give a long LED blink, then run the motor until they release it.
	low C.0
	low C.1
	nap 2 '72 ms
	let b0 = pins & %101000
	if b0 = 0 then goto timeouterror
	high C.0
	sleep 5
	low C.0
	high C.1

runmotorwhilepressed:
	let b0 = pins & %101000
	if b0 <> 0 then goto runmotorwhilepressed
goto timeouterror

openbutton: ' if not locked: open latch, otherwise blink the number of remaining hours; round up
if b2 = 0 then
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

lockbutton: ' read the lock time: convert ADC value to duration
						' if already locked: extend the lock time if new time is longer

b1 = 0						
w4 = time + 2
readadc 4,b0 ' throw away first reading

debounce:						
	readadc 4,b0 
	if b0 > b1 then
		b1 = b0
	end if
  if time < w4 then goto debounce  

read b1,b0	; read value into b0 from table using b1 as index

w4 = b0 * 6 ' convert from 6-minute intervals to 1-minute intervals

if w4 > w2 then
	w2 = w4  
	w3 = 0	
end if
b2 = 1			' locked

' flash the LED to show the hours selected (round to nearest hour):
	w4 = w2 + 30	
	w4 = w4 / 60
	for w0 = 1 to w4
		high C.0
		pause 250
		low C.0
		pause 250
	next	
return

waitforprogram:  ' endless loop to make programming easier
		high C.0
		pause 250
		low C.0
		pause 250
  goto waitforprogram

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