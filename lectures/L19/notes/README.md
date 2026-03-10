# L19 - Anteckningar
Implementering av ett digitalt system innefattande flankdetektering för toggling av en lysdiod.
Metastabilitetsskydd har lagts till för att säkerhetsställa att samtliga insignaler är stabila
(0 eller 1) när de används i konstruktionen. När detta genomförs säger man att insignalerna synkroniseras.

Konstruktionen innehåller följande portar:
* `clock`: Systemklocka, satt till 1 Hz i CircuitVerse, 50 MHz på FPGA-kortet.
* `reset_n`: Aktivt låg reset-signal från en tryckknapp.
* `button_n`: Aktivt låg tryckknapp, som används för att toggla lysdioden.
* `led`: Lysdioden som togglas vid nedtryckning av tryckknappen (på fallande flank).

Reset-signalen `reset_n` synkroniseras via två D-vippor. Motsvarande synkroniserad reset-signal `reset_s2_n` används sedan i resten av kretsen. Postfix `s2` innebär att signalen i fråga har synkroniserats med två vippor i enlighet med `double flop`-metoden.

Tryckknappen `button_n` synkroniseras via två D-vippor och ytterligare en vippa används för flankdetektering, där `button_s2_n` utgör "nuvarande" insignal och `button_s3_n` utgör "föregående" insignal. Vid nedtryckning (fallande flank) gäller att `button_s2_n` = 0 och `button_s3_n` = 1. Då ettställs signalen `button_edge_s2` för att indikera knapptryckning.
När `button_edge_s2` ettställs togglas lysdioden `led`.

## Kretsschema
Konstruktionens kretsschema visas nedan:

![Kretsschema för konstruktionen](./circuit/led_toggle2.png)

Gällande kretsschemat:
* `reset_s2_n` är vår stabila reset-signal, som används i resten av nätet.
* Vi lägger till två vippor för att stabilisera knappsignalen, samt en tredje för att implementera flankdetektering:
    * `button_s2_n` är "nuvarande" värde. 
    * `button_s3_n` är "föregående" värde.
* Vi detekterar fallande flank på `button_n` med `button_edge_s2`:
    * `button_edge_s2 = 1` när `button_s2_n = 0` och `button_s3_n = 1`.
    * Med andra ord, knappen är nu nedtryckt, men var inte det föregående klockpuls.
* `led_state` håller lysdiodens tillstånd:
    * Vi skapar en toggle-vippa genom att koppla inversen av utsignalen till ingången.
    * Vi kopplar `button_edge_s2` till enable-ingången så att toggling bara sker vid fallande flank, dvs. när `button_edge_s2 = 1`.

Ovanstående krets kan simuleras genom att öppna filen [led_toggle2.cv](./circuit/led_toggle2.cv) 
i [CircuitVerse](https://circuitverse.org/simulator).

## Syntes samt simulering i VHDL
* [led_toggle2.vhd](./vhdl/led_toggle2.vhd) innehåller konstruktionens toppmodul `led_toggle2`.
* [meta_prev.vhd](./vhdl/meta_prev.vhd) innehåller modulen `meta_prev`, som används för att synkronisera insignalerna med `double flop`-metoden samt att detektera fallande flank på tryckknappen `button_n`.
* [led_toggle2.qar](./vhdl/led_toggle2.qar) utgör en arkiverad projektfil, som kan användas för att direkt öppna projektet, inklusive pins och testbänk, i Quartus.

---
