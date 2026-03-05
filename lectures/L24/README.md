# L24 - Övning - Synkront system med multipla komponenter

## Dagordning
* Sammankoppling av tidigare skapade moduler:
    * `display`
    * `meta_prev`
    * `timer`

## Mål med lektionen
* Kunna sammankoppla multipla komponenter för att skapa ett större synkront system.

## Instruktioner

### Förberedelse
* 

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

## Utvärdering
* Hur kopplas flera VHDL-moduler samman i en toppmodul?
* Vad är syftet med att använda en toppmodul i ett större system?
* Varför används `meta_prev` innan signaler från tryckknappar används i logiken?
* Vilken signal i systemet orsakar att räknaren inkrementeras?

## Nästa lektion
* Genomförande av **D02** - VHDL teori (del II).

---

## Bilaga A - Övningsuppgifter
Du ska konstruera ett digitalt system i VHDL där en tryckknapp `button_n` används för att starta och stoppa en timer.
* När timern är på ska denna räkna upp en intern 4-bitars räknare `counter` vid timeout.
* Timern ska få timeout var 500:e millisekund när den är aktiv:
    * När detta sker ettställs utporten `timeout`.
    * Denna signal används för att inkrementera `counter`.
* Värdet `0-F` av den interna räknaren `counter` ska visas på en 7-segmentsdisplay `hex`. 
* När timern är av ska uppräkning upphöra och talet på displayen ska då förbli oförändrat.
* Vid nedtryckning av reset-knappen ska talet på displayen sättas till `0` och timern ska stoppas.

---

### Portar
Systemet ska inneha följande portar:
* Insignal `clock` ska utgöras av en systemklocka med en frekvens på `50 MHz`.
* Insignal `reset_n` ska utgöras av en inverterande reset-signal från en tryckknapp. När denna signal är låg ska systemåterställning ske.
* Insignal `button_n` ska utgöras av en inverterande tryckknapp, som vid fallande flank togglar en timer.
* Utsignal `hex[6:0]` ska utgöras av en 7-segmentsdisplay, som visar värdet `0-F` av en intern räknare.

---

### Systemarkitektur

```text
button_n
   ↓
meta_prev
   ↓ button_edge
toggle timer_enable
   ↓
timer
   ↓ timeout
counter
   ↓
display
   ↓
hex
```

---

### Synkront system
Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan eller när reset-signalen är låg. 
* När reset-signalen är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas i startläget:
    * Timern ska nollställas och stängas av.
    * Räknaren ska nollställas och stängas av.
    * 7-segmentsdisplayen ska visa värdet `0`.

---

### Metastabilitetsskydd
Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska "double flop"-metoden användas. Därmed ska varje insignal (förutom systemklockan) synkroniseras via två vippor var.

---

### Uppgifter
**a)** Skapa ett projekt döpt `timer_display_system` i Quartus:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`). 
* Anslut:
  * `clock` till en `50 MHz` systemklocka.
  * `reset_n` till en tryckknapp.
  * `button_n` till en tryckknapp.
  * `hex[6:0]` till en 7-segmentsdisplay.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

**b)** Lägg till tidigare skapade moduler från kursen:
* `display` från [L16](../L16/README.md).
* `meta_prev` från [L20](../L20/README.md).
* `timer` från [L23](../L23/README.md).

**c)** Implementera systemet via instansiering av ovanstående moduler:
* Lägg till en instans av respektive modul.
* Koppla samman modulerna med portar och signaler:
    * Lägg till signaler för submodulerna i toppmodulen, t.ex. `timer_enable`.
    * Se till att `timer_enable` togglas vid fallande flank på `button_n` och används för att starta och stoppa timermodulen.

**d)** Skapa en 4-bitars räknare i toppmodulen:

```vhdl
signal counter: natural range 0 to 15;
```

Denna räknare ska räkna från `0-15`. Via ovanstående deklaration blir räknaren fyra bitar:
* Detta medför att overflow sker vid uppräkning till `16`.
* Räknaren kommer då automatiskt slå över till `0` utan manuell nollställning.

**e)** Skapa en synkron process i toppmodulen, som ansvarar för uppräkning av räknaren:
* Vid reset ska `counter` nollställas.
* Vid stigande klockflank ska `counter` inkrementeras när timern löper ut.
* Lägg till en intern räknare som räknar från `0-15` när timern löper ut. Vid reset ska denna nollställas.

---
