# L19 - Flankdetektering med D-vippor (del I)

## Dagordning
* Flankdetektering med D-vippor för toggling av en lysdiod för hand samt i VHDL.

## Mål med lektionen
* Kunna implementera flankdetektering via D-vippor för hand samt i VHDL.

## Förutsättningar
* Kännedom om D-vippan från [L17](../L17/README.md).
* Kännedom om synkrona processers mall från [L18](../L17/README.md).

## Instruktioner

### Förberedelse
* Repetera [L18](../L18/README.md).
* Se information om flankdetektering i tredje delen av [denna tutorial](https://youtu.be/utDHdTgZUz0?si=hEZ2e2Uz4J_LVsf8&t=5450).
Videon kommer starta på tiden 01:30:50, vilket är då flankdetekteringsdelen börjar.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad är de primära fördelarna med vippor framför latchar inom digitala system?

## Nästa lektion
* Vidare arbete med flankdetektering med D-vippor.

---

## Bilaga A - Övningsuppgifter

**1.**  Du ska konstruera ett synkront digitalt system toggling av en lysdiod via en tryckknapp. Systemet ska inneha följande portar: 
* Insignal $clock$ ska utgöras av en systemklocka med godtycklig frekvens (dock 50 MHz på FPGA-kortet).
* Insignal $reset\_n$ ska utgöras av en asynkron inverterande reset-signal. När $reset\_n$ är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignal $button\_n$ ska utgöras av en inverterande tryckknapp, som vid nedtryckning (fallande flank) togglar en lysdiod.
* Utsignal $led$ ska utgöras av en lysdiod, som togglas vid nedtryckning (fallande flank) av tryckknapp $button\_n$.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan $clock$ eller när reset-signalen $reset\_n$ är låg.
* När $reset\_n$ är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioden ska då släckas).

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till $1000$ $ms$. 

**b)** Testa att toggla lysdioden via genom att trycka ned $button\_n$. Sker togglingen direkt eller dröjer det tills klockan slår? 

**c)** Implementera konstruktionen i VHDL via en modul döpt $led\_toggle2$:
* Välj FPGA-kort Terasic DE0 (enhet 5CEBA4F23C7).
* Anslut 
    * $clock$ till en $50$ $MHz$ systemklocka,
    * $reset\_n$ till en tryckknapp,
    * $button\_n$ till en tryckknapp,
    * $led$ till en lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

---
