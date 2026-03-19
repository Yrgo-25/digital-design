# L23 - Anteckningar

## Beskrivning
Implementering av en digital krets, där tre timerkretsar togglas via var sin tryckknapp.  
Varje timer togglar i sin tur en dedikerad lysdiod:
* Fallande flank på respektive tryckknapp togglar motsvarande timer (på/av).
* Varje timer är oberoende av de andra och styr en egen lysdiod.

SystemVerilog-modulerna från övningsuppgiften har här ersatts med motsvarande VHDL-moduler.

För en given timer gäller att:
* När den är aktiverad blinkar en lysdiod var 100:e millisekund.
* När timern är inaktiverad hålls motsvarande lysdiod släckt.

Konstruktionen innehåller följande portar:
* `clock`: Systemklocka, satt till 2 Hz i CircuitVerse, 50 MHz på FPGA-kortet.
* `reset_n`: Aktivt låg reset-signal från en tryckknapp.
* `button_n[2:0]`: Aktivt låga tryckknappar, som används för att toggla timerkretsarna.
* `led[2:0]`: Lysdioder som togglas varje gång motsvarande timer löper ut.

---

## Syntes i VHDL
* [led_toggle_timer.vhd](./vhdl/led_toggle_timer.vhd) innehåller konstruktionens toppmodul `led_toggle_timer`.
* [meta_prev.vhd](./vhdl/meta_prev.vhd) innehåller modulen `meta_prev`, som används för att synkronisera insignalerna med `double flop`-metoden samt att detektera fallande flank på tryckknapparna `button_n`.
* [timer.vhd](./vhdl/timer.vhd) innehåller modulen `timer`, som används för att implementera timerkretsar med godtycklig frekvens.
* [device_controller.vhd](./vhdl/device_controller.vhd) innehåller modulen `device_controller`, som används för att kontrollera en eller flera enheter.
* [led_toggle_timer.qar](./vhdl/led_toggle_timer.qar) utgör en arkiverad projektfil, som kan användas för att direkt öppna projektet, inklusive pins, i Quartus.

---