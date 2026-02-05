# L20 - Flankdetektering med D-vippor (del II)

## Dagordning
* Flankdetektering med D-vippor för toggling av multipla lysdioder för hand samt i VHDL.

## Mål med lektionen
* Träna på användning av vippor samt flankdetektering i digitala system.
* Kunna implementera system innehållande flankdetektering för multipla signaler, både för hand samt i VHDL.

## Förutsättningar
* Kännedom om flankdetektering från [L19](../L19/README.md).

## Instruktioner

### Förberedelse
* Repetera [L19](../L19/README.md).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Förklara hur flanktetektering kan implementeras för multipla signaler via parallellkopplade nät med seriekopplade D-vippor.

## Nästa lektion
* Förebyggande av metastabilitet med vippor.

---

## Bilaga A - Övningsuppgifter

**1.**  Du ska konstruera ett synkront digitalt system toggling av tre lysdioder via tre tryckknappar. Systemet ska inneha följande portar: 
* Insignal `clock` ska utgöras av en systemklocka med godtycklig frekvens (dock `50 MHz` på FPGA-kortet).
* Insignal `reset_n` ska utgöras av en asynkron inverterande reset-signal. När `reset_n` är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignaler `button_n[2:0]` ska utgöras av tre inverterande tryckknappar, som vid nedtryckning (fallande flank) togglar var sin lysdiod.
* Utsignaler `led[2:0]` ska utgöras av tre lysdioder, som togglas vid nedtryckning (fallande flank) av motsvarande tryckknappar `button_n[2:0]`.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan `clock` eller när reset-signalen `reset_n` är låg.
* När `reset_n` är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioderna ska då släckas).

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till `1000 ms`. 

**b)** Testa att toggla respektive lysdiod genom att trycka ned motsvarande knappar. Sker togglingen direkt eller dröjer det tills klockan slår? 

**c)** Implementera konstruktionen i VHDL via en modul döpt `led_toggle3`:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).
* Anslut 
    * `clock` till en `50 MHz` systemklocka,
    * `reset_n` till en tryckknapp,
    * `button_n[2:0]` till var sin tryckknapp,
    * `led[2:0]` till var sin lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

---
