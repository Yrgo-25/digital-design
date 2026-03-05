# L19 - Förebyggande av metastabilitet med vippor

## Dagordning
* Förebyggande av metastabilitet med D-vippor ("double flop"-metoden), både för hand samt i VHDL.

## Mål med lektionen
* Känna till vad som menas med metastabilitet samt hur D-vippor kan användas för att förebygga detta.
* Kunna applicera "double flop"-metoden via seriekopplade D-vippor för att förebygga metastabilitet.

## Förutsättningar
* Kännedom om flankdetektering från [L18](../L18/README.md).

## Instruktioner

### Förberedelse
* Repetera [L18](../L18/README.md).
* Läs [Bilaga A](#bilaga-a---kortfattad-introduktion-till-metastabilitet) som en introduktion till metastabilitet.
* Se min [video tutorial](https://www.youtube.com/watch?reload=9&v=KrssJRgF13I&feature=youtu.be) för ytterligare information om metastabilitet.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Förklara vad som menas med metastabilitet, specifikt om en insignal i en vippa förändras för nära inpå en klockpuls.
* Förklara hur "double flop"-metoden kan användas för att hantera detta.

## Nästa lektion
* Generiska parametrar i VHDL.

---

## Bilaga A - Kortfattad introduktion till metastabilitet
Metastabilitet är ett tillstånd där utsignalen ur en vippa varken är låg eller hög, vilket kan uppstå när en insignal ändrar värde för nära en klockpuls. Då hinner signalen inte stabilisera sig (som `0` eller `1`) och vippans utsignal kan då sväva någonstans mellan hög och låg en viss tid. Oftast stabiliserar sig sedan vippans utsignal till låg eller hög, annars kan systemfel uppstå, då vissa efterföljande grindar kan tolka vippans utsignal som låg, andra som hög, vilket kan få märkliga effekter.

För att förebygga metastabilitet används ofta den så kallade "double flop"-metoden, som innebär att samtliga insignaler förutom
systemklockan synkroniseras via två vippor var. Utsignalen ur den andra vippan (ofta märkt med postfix `s2` för att indikera synkronisering med två vippor) kommer vara stabil, dvs. låg eller hög.

Ytterligare information om metastabilitet finns [här](https://nandland.com/lesson-13-metastability/) 
och [här](https://vhdlwhiz.com/terminology/metastability/).

---

## Bilaga B - Övningsuppgifter
**1.**  Du ska konstruera ett synkront digitalt system toggling av en lysdiod via en tryckknapp. Systemet ska inneha följande portar: 
* Insignal `clock` ska utgöras av en systemklocka med godtycklig frekvens (dock `50 MHz` på FPGA-kortet).
* Insignal `reset_n` ska utgöras av en asynkron inverterande reset-signal. När `reset_n` är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignal `button_n` ska utgöras av en inverterande tryckknapp, som vid nedtryckning (fallande flank) togglar var sin lysdiod.
* Utsignal `led` ska utgöras av en lysdiod, som togglas vid nedtryckning (fallande flank) av tryckknapp `button_n`.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan `clock` eller när reset-signalen `reset_n` är låg.
* När `reset_n` är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioden ska då släckas).

**Kretsen ska också göras mer robust via förebyggande av metastabilitet**. För att åstadkomma detta ska "double flop"-metoden användas:
* Varje insignal (förutom systemklockan) ska synkroniseras via två D-vippor var. Två D-vippor måste då placeras i serie med respektive insignal. Utsignalen ur den andra vippan är stabil och är den signal som används i systemet.
* Ska flankdetektering genomföras behövs tre seriekopplade vippor per insignal - två som metastabilitetsskydd och en för att lagra föregående tillstånd. Vippa två innehåller då "nuvarande" insignal, medan den tredje vippan innehåller "föregående" insignal.

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till `1000 ms`. 

**b)** Testa att toggla respektive lysdiod genom att trycka ned motsvarande knappar. Sker togglingen direkt eller dröjer det tills klockan slår? Dröjer det en eller flera klockpulser?

**c)** Implementera konstruktionen i VHDL via en modul döpt `led_toggle_meta_prev1`:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).
* Anslut:
    * `clock` till en `50 MHz` systemklocka.
    * `reset_n` till en tryckknapp.
    * `button_n` till en tryckknapp.
    * `led` till var en lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.
* Lägg till följande synkroniserade signaler i toppmodulen (*s2* indikerar att signalerna har synkroniserats med två vippor):
    * `reset_s2_n`: Asynkron inverterande reset-signal synkroniserad i enlighet med "double flop"-metoden.
    * `button_edge_s2[2:0]`: Indikerar nedtryckning av tryckknapparna på fallande flank. Signalerna är dessutom synkroniserade i enlighet med "double flop"-metoden.
Dessa signaler kommer anslutas till en instans av en delkomponent och därigenom fungera enligt beskrivningen ovan.

**d)** Lägg till kod i toppmodulen så att:
* `led` togglas vid fallande flank på `button_n` (motsvarande synkroniserad signal `button_edge_s2` kommer då vara ettställd).
* Om reset-knappen trycks ned, vilket ska kontrolleras via den synkroniserade signalen `reset_s2_n`, ska lysdioderna direkt släckas.

**e)** Skapa en delkomponent döpt `meta_prev` i en fil döpt `meta_prev.vhd`. Denna delkomponent ska kunna användas för att synkronisera insignalerna med "double flop"-metoden (i syfte att att förebygga metastabilitet) samt detektera nedtryckning av tryckknapparna på fallande flank.

Använd följande portar:
* `clock`: `50 MHz` systemklocka på FPGA-kortet.
* `reset_n`: Asynkron inverterande reset-signal ansluten till en tryckknapp.
* `button_n`: Tryckknapp för toggling av lysdioden.
* `reset_s2_n`: Enligt beskrivningen av motsvarande signal i toppmodulen.
* `button_edge_s2`: Enligt beskrivningen av motsvarande signal i toppmodulen.

**f)** Skapa en instans av delkomponenten `meta_prev` i toppmodulen:
* Döp instansen till `meta_prev1`.
* Anslut portarna till motsvarande signaler i toppmodulen.

Kontrollera att systemet fungerar som tänkt på FPGA-kortet.

---
