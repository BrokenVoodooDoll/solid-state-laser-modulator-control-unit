; Created: 25.03.2017 23:14:22
; Author: Maksim Vinogradov
;
;-----Ports setup-----
        ldi r16, 0b10000000
        out DDRD, r16
        out PORTD, r16
;-----Waiting for start signal-----
start:  sbis PIND, 3    ; Check for sync pulse on the 3rd pin
        rjmp start

;-----Pulse formation-----
        
        ldi  r18, 5     ; Delay 210 us 
        ldi  r19, 92
delay:  dec  r19
        brne delay
        dec  r18
        brne delay

        ldi r19, 11     ; Setup 11 pulses

pulses: cbi PORTD, 7    ; Setup 1 onto the 7th pin
        
        ldi  r18, 13    ; Delay 2.6 us
pause1: dec  r18
        brne pause1

        sbi PORTD, 7    ; Setup 0 onto the 7th pin

        ldi  r18, 33    ; Delay 6.5 us
pause2: dec  r18
        brne pause2

        dec r19
        brne pulses
;-----Waiting for the end of the start signal-----
wait:   sbic PIND, 3    ; Check for the end of the sync pulse on the 3rd pin
        rjmp wait
        rjmp start

		
