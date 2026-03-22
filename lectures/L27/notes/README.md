# L27 - Anteckningar

## Beskrivning
Implementering av en tillståndsmaskin för att styra en lysdiod via två tryckknappar.

Tillståndsmaskinen innehar tre tillstånd:
* `STATE_OFF`: Lysdioden är släckt.
* `STATE_BLINK`: Lysdioden blinkar var 100:e millisekund.
* `STATE_ON`: Lysdioden är tänd.

Konstruktionen innehåller följande portar:
* `clock`: 50 MHz systemklocka.
* `reset_n`: Aktivt låg reset-signal från en tryckknapp.
* `button_n[1:0]`: Inverterande tryckknappar `button_n[1:0]` för att byta till föregående respektive nästa tillstånd:
    * Fallande flank på `button_n[1]` byter till föregående tillstånd.
    * Fallande flank på `button_n[0]` byter till nästa tillstånd.
* `led`: Lysdioden som styrs via tillståndsmaskinen.

---

## Syntes i VHDL
* [fsm_led.vhd](./vhdl/fsm_led.vhd) innehåller konstruktionens toppmodul `fsm_led`.
* [meta_prev.vhd](./vhdl/meta_prev.vhd) innehåller modulen `meta_prev`, som används för att synkronisera insignalerna med `double flop`-metoden samt att detektera fallande flank på tryckknappen `button_n`.
* [timer.vhd](./vhdl/timer.vhd) innehåller modulen `timer`, som används för att implementera timerkretsen.
* [fsm_led.qar](./vhdl/fsm_led.qar) utgör en arkiverad projektfil, som kan användas för att direkt öppna projektet, inklusive pins, i Quartus.

---
