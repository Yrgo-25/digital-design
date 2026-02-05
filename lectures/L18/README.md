# L18 - Synkrona processers mall i VHDL

## Dagordning
* Repetition av D-latch och D-vippa.
* Introduktion av synkrona processers mall (utan reset).
* Konstruktion av D-vippa (med synkrona processers mall).
* Praktisk tillämpning: toggling av en lysdiod.

## Mål med lektionen
* Konstruera D-vippor med hjälp av synkrona processers mall i VHDL.
* Förstå skillnaden mellan kombinatorisk logik och sekventiell logik.
* Känna till att tillstånd i synkrona system endast uppdateras vid klockflank.
* Implementera enklare sekventiella system i VHDL utan reset-signaler.

## Förutsättningar
* Kännedom om D-vippan från [L17](../L17/README.md).

## Instruktioner

### Förberedelse
* Repetera [L17](../L17/README.md), specifikt delen gällande D-vippan.

### Under lektionen
* Läs om synkrona processers mall i [bilaga A](#bilaga-a---synkrona-processers-mall).
* Genomför bifogade [övningsuppgifter](#bilaga-B---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Förklara synkrona processers mall via ett enkelt VHDL-exempel.
* Förklara varför dagens konstruktion betraktas som ett synkront system.

## Nästa lektion
* Flankdetektering med D-vippor (del I).

---

## Bilaga A - Synkrona processers mall

Vänligen repetera konceptet [process](../L07/README.md#process) innan du läser vidare.

Nedan demonstreras hur man enkelt kan skapa en D-vippa med klocksignal `clock`, insignal `d` samt 
utsignal `q` via synkrona processers mall:

```vhdl
process(clock)
begin
    if (rising_edge(clock)) then
        q <= d;
    end if;
end process;
```

I ovanstående process uppdateras utsignal `q` med värdet av `d` vid stigande flank på klockpulsen.
Övrig tid har `q` samma värde föregående klockpuls.

### Viktiga regler
* `clock` ska utgöra den enda signalen i känslighetslistan. Processen aktiveras då endast vid förändring av klocksignalen.
* Eftersom vi endast vill uppdatera signaler vid stigande flank på klockan används funktionen `rising_edge` från `ieee.std_logic_1164`.  
Denna funktion returnerar true vid stigande flank; all logik som ska uppdateras synkront placeras därför inuti en if-sats.
* Varje signal som tilldelas inuti processblocket implementeras i hårdvara som en D-vippa.

---

## Bilaga B - Övningsuppgifter
**1.**  Du ska konstruera ett synkront digitalt system för toggling av en lysdiod via en slide-switch. Systemet ska inneha följande portar: 
* Insignal `clock` ska utgöras av en systemklocka med godtycklig frekvens (dock `50 MHz` på FPGA-kortet).
* Insignal `switch` ska utgöras av slide-switch, som vid uppdragning (låg till hög signal) togglar en lysdiod.
* Utsignal `led` ska utgöras av en lysdiod, som togglas vid uppdrag av slide-switch `switch`.

Kretsen ska implementeras synkront; samtliga signaler i kretsen uppdateras endast vid stigande flank av systemklockan.

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till `1000 ms`. 

**b)** Testa att toggla lysdioden genom att dra upp slide-switchen. Sker togglingen direkt eller dröjer det tills klockan slår? 

**c)** Implementera konstruktionen i VHDL via en modul döpt `led_toggle1`:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).
* Anslut 
    * `clock` till en `50 MHz` systemklocka,
    * `switch` till en slide-switch,
    * `led` till en lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

---
