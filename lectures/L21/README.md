# L21 - Förebyggande av metastabilitet med vippor

## Dagordning
* Förebyggande av metastabilitet med D-vippor (*double flop*-metoden), både för hand samt i VHDL.

## Mål med lektionen
* Känna till vad som menas med metastabilitet samt hur D-vippor kan användas för att förebygga detta.
* Kunna applicera *double flop*-metoden via seriekopplade D-vippor för att förebygga metastabilitet.

## Förutsättningar
* Kännedom om flankdetektering från [L19](../L19/README.md) samt [L20](../L20/README.md).

## Instruktioner

### Förberedelse
* Repetera [L20](../L20/README.md).
* Läs [Bilaga A](#bilaga-a---kortfattad-introduktion-till-metastabilitet) som en introduktion till metastabilitet.
* Se min [video tutorial](https://www.youtube.com/watch?reload=9&v=KrssJRgF13I&feature=youtu.be) för ytterligare information om metastabilitet.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Förklara vad som menas med metastabilitet, specifikt om en insignal i en vippa förändras för nära inpå en klockpuls.
* Förklara hur *double flop*-metoden kan användas för att hantera detta.

## Nästa lektion
* **P03** - Praktisk labb med synkron logik i VHDL.

---

## Bilaga A - Kortfattad introduktion till metastabilitet

Metastabilitet är ett tillstånd där utsignalen ur en vippa varken är 0 eller 1, vilket kan uppstå när en insignal ändrar värde för nära en klockpuls. Då hinner signalen inte stabilisera sig på 0 eller 1 och vippans utsignal kan då sväva någonstans mellan 0 - 1 en viss tid. Oftast stabiliserar sig sedan vippans utsignal till 0 eller 1, annars kan systemfel uppstå, då vissa efterföljande grindar kan tolka vippans utsignal som 0, andra som 1, vilket kan få märkliga effekter.

För att förebygga metastabilitet används ofta den så kallade *double flop*-metoden, som innebär att samtliga insignaler förutom
systemklockan synkroniseras via två vippor var. Utsignalen ur den andra vippan (ofta märkt med postfix s2 för att indikera synkronisering med två vippor) kommer vara stabil, dvs. 1 eller 0.

Ytterligare information om metastabilitet finns [här](https://nandland.com/lesson-13-metastability/) 
och [här](https://vhdlwhiz.com/terminology/metastability/).

---

## Bilaga B - Övningsuppgifter

**1.**  Du ska konstruera ett synkront digitalt system toggling av tre lysdioder via tre tryckknappar. Systemet ska inneha följande portar: 
* Insignal $clock$ ska utgöras av en systemklocka med godtycklig frekvens (dock 50 MHz på FPGA-kortet).
* Insignal $reset\_n$ ska utgöras av en asynkron inverterande reset-signal. När $reset\_n$ är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignaler $button\_n[2:0]$ ska utgöras av tre inverterande tryckknappar, som vid nedtryckning (fallande flank) togglar var sin lysdiod.
* Utsignaler $led[2:0]$ ska utgöras av tre lysdioder, som togglas vid nedtryckning (fallande flank) av motsvarande tryckknappar $button\_n[2:0]$.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan $clock$ eller när reset-signalen $reset\_n$ är låg.
* När $reset\_n$ är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioderna ska då släckas).

Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska *double flop*-metoden användas:
* Varje insignal (förutom systemklockan) ska synkroniseras via två D-vippor var. Två D-vippor måste då placeras i serie med respektive insignal. Utsignalen ur den andra vippan är stabil och är den signal som används i systemet.
* Ska flankdetektering genomföras behövs tre seriekopplade vippor per insignal - två som metastabilitetsskydd och en för att lagra föregående tillstånd. Vippa två innehåller då "nuvarande" insignal, medan den tredje vippan innehåller "föregående" insignal.

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till $1000$ $ms$. 

**b)** Testa att toggla respektive lysdiod genom att trycka ned motsvarande knappar. Sker togglingen direkt eller dröjer det tills klockan slår? Dröjer det en eller flera klockpulser?

**c)** Implementera konstruktionen i VHDL via en modul döpt $led\_toggle\_meta\_prev$:
* Välj FPGA-kort Terasic DE0 (enhet 5CEBA4F23C7).
* Anslut 
    * $clock$ till en $50$ $MHz$ systemklocka,
    * $reset\_n$ till en tryckknapp,
    * $button\_n[2:0]$ till var sin tryckknapp,
    * $led[2:0]$ till var sin lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.
* Lägg till följande synkroniserade signaler i toppmodulen (*s2* indikerar att signalerna har synkroniserats med två vippor):
    * $reset\_s2\_n$: Asynkron inverterande reset-signal synkroniserad i enlighet med *double flop*-metoden.
    * $button\_edge\_s2[2:0]$: Indikerar nedtryckning av tryckknapparna på fallande flank. Signalerna är dessutom synkroniserade i enlighet med *double flop*-metoden.
Dessa signaler kommer anslutas till en instans av en delkomponent och därigenom fungera enligt beskrivningen ovan.

**d)** Lägg till kod i toppmodulen så att:
* Lysdioderna togglas vid fallande flank på motsvarande tryckknapp (motsvarande synkroniserad signal $button\_edge\_s2[x]$ kommer då vara ettställd).
* Om reset-knappen trycks ned, vilket ska kontrolleras via den synkroniserade signalen $reset\_s2\_n$, ska lysdioderna direkt släckas.

**e)** Skapa en delkomponent döpt $meta\_prev$ i en fil döpt `meta_prev.vhd`. Denna delkomponent ska kunna användas för att synkronisera insignalerna med *double flop*-metoden (i syfte att att förebygga metastabilitet) samt detektera nedtryckning av tryckknapparna på fallande flank.

Använd följande portar:

* $clock$: 50 MHz systemklocka på FPGA-kortet.
* $reset\_n$: Asynkron inverterande reset-signal ansluten till en tryckknapp.
* $button\_n[2:0]$: Tryckknappar för toggling av lysdioderna.
* $reset\_s2\_n$: Enligt beskrivningen av motsvarande signal i toppmodulen.
* $button\_edge\_s2[2:0]$: Enligt beskrivningen av motsvarande signaler i toppmodulen.

**f)** Skapa en instans av delkomponenten $meta\_prev$ i toppmodulen:
* Döp instansen till $meta\_prev1$.
* Anslut portarna till motsvarande signaler i toppmodulen.

Kontrollera att systemet fungerar som tänkt på FPGA-kortet.

---
