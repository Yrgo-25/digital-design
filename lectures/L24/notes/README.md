# L24 - Anteckningar

## Beskrivning
Implementering av en digital krets, där en intern timer togglas via en tryckknapp (fallande flank).
* När timern är aktiverad räknar denna upp en intern 4-bitars räknare var 500:e millisekund.
* Eftersom räknaren är 4-bitar bred sker naturlig nollställning på grund av overflow vid uppräkning till 16.
* När timern är av sker ingen uppräkning. 
* Räknarens värde skrivs ut hexadecimalt på en 7-segmentsdisplay (`0-F`).

Konstruktionen innehåller följande portar:
* `clock`: 50 MHz systemklocka på FPGA-kortet.
* `reset_n`: Aktivt låg reset-signal från en tryckknapp.
* `button_n`: Aktivt låg tryckknapp, som används för att toggla den interna timern.
* `hex[6:0]`: Hex-display som visas den interna räknarens värde (`0-F`).

---

## Syntes i VHDL
* [timer_display_system.vhd](./vhdl/timer_display_system.vhd) innehåller konstruktionens toppmodul `timer_display_system`.
* [meta_prev.vhd](./vhdl/meta_prev.vhd) innehåller modulen `meta_prev`, som används för att synkronisera insignalerna med `double flop`-metoden samt att detektera fallande flank på tryckknappen `button_n`.
* [timer.vhd](./vhdl/timer.vhd) innehåller modulen `timer`, som används för att implementera timerkretsen.
* [display.vhd](./vhdl/display.vhd) innehåller modulen `display`, som används för att skriva ut räknarens värde på 7-segmentsdisplayen.
* [timer_display_system.qar](./vhdl/timer_display_system.qar) utgör en arkiverad projektfil, som kan användas för att direkt öppna projektet, inklusive pins, i Quartus.

---