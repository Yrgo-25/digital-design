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
* Lektionsanteckningar finns [här](./notes/README.md).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Förklara vad som menas med metastabilitet, specifikt om en insignal i en vippa förändras för nära inpå en aktiv klockflank.
* Förklara hur "double flop"-metoden kan användas för att hantera detta.

## Nästa lektion
* Generiska parametrar i VHDL.

---

## Bilaga A - Kortfattad introduktion till metastabilitet
Metastabilitet är ett tillstånd där utsignalen ur en vippa varken är låg eller hög, vilket kan uppstå när en insignal ändrar värde för nära inpå en aktiv klockflank:
* Då hinner signalen inte stabilisera sig (som `0` eller `1`) och vippans utsignal kan då sväva någonstans mellan hög och låg en viss tid.
* Oftast stabiliserar sig sedan vippans utsignal till låg eller hög, annars kan systemfel uppstå, då vissa efterföljande grindar kan tolka vippans utsignal som låg, andra som hög, vilket kan få märkliga effekter.

För att förebygga metastabilitet används ofta den så kallade "double flop"-metoden, som innebär att:
* Varje asynkron insignal (förutom systemklockan) synkroniseras via två D-vippor:
    * Två D-vippor placeras då i serie med respektive insignal.
    * Utsignalen från den andra vippan kommer med mycket stor sannolikhet vara stabil och är den signal som används i systemet.
    * Om signalen fortfarande skulle vara instabil (t.ex. vid mycket hög klockfrekvens i förhållande till signalens stabiliseringstid) kan en tredje vippa läggas till.

Ytterligare information om metastabilitet finns [här](https://nandland.com/lesson-13-metastability/) och [här](https://vhdlwhiz.com/terminology/metastability/).

---

## Bilaga B - Övningsuppgifter
Du ska konstruera ett synkront digitalt system där en lysdiod togglas via en tryckknapp.

Systemet ska inneha följande portar: 
* Insignal `clock` ska utgöras av en systemklocka med godtycklig frekvens (dock `50 MHz` på FPGA-kortet).
* Insignal `reset_n` ska utgöras av en asynkron inverterande reset-signal. När `reset_n` är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignal `button_n` ska utgöras av en inverterande tryckknapp, som vid nedtryckning (fallande flank) togglar lysdioden `led`.
* Utsignal `led` ska utgöras av en lysdiod, som togglas vid nedtryckning (fallande flank) av tryckknapp `button_n`.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan `clock` eller när reset-signalen `reset_n` är låg.
* När `reset_n` är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioden ska då släckas).

**Kretsen ska också göras mer robust via förebyggande av metastabilitet**. För att åstadkomma detta ska "double flop"-metoden användas:
* Varje asynkron insignal (förutom systemklockan) ska synkroniseras via två D-vippor var:
    * Två D-vippor placeras då i serie med respektive insignal.
    * Utsignalen ur den andra vippan är (med mycket hög sannolikhet) stabil och används därefter i systemet.
* Ska flankdetektering genomföras behövs tre seriekopplade vippor per insignal - två som metastabilitetsskydd och en för att lagra föregående tillstånd:
    * Den första och andra vippan används för metastabilitetsskydd (synkronisering till systemklockan).
    * Den tredje vippan används för flankdetektering och lagrar föregående värde på insignalen.
    * Därmed gäller att:
        * Vippa 1 – metastabilitetsskydd.
        * Vippa 2 – stabiliserad ("nuvarande") insignal.
        * Vippa 3 – föregående värde (används för flankdetektering).
    * Detta kan också visas i ett diagram såsom visas nedan (FF = `Flip Flop`, dvs. vippa):

```text
button_n
   │
   ▼
[FF1] → [FF2] → [FF3]
        │        │
        │        └─ previous value
        └─ current value
```

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till `1000 ms`. 

**b)** Testa att toggla lysdioden genom att trycka ned tryckknappen. Sker togglingen direkt eller dröjer det tills klockan slår? Dröjer det en eller flera klockpulser?

**c)** Implementera konstruktionen i VHDL via en modul döpt `led_toggle2`:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).
* Anslut:
    * `clock` till en `50 MHz` systemklocka.
    * `reset_n` till en tryckknapp.
    * `button_n` till en tryckknapp.
    * `led` till en lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

**d)** Deklarera följande signaler i toppmodulen:
* `led_state`: Håller lysdiodens tillstånd internt.
* `reset_s2_n`: Reset-signal framtagen med två seriekopplade D-vippor, där reset aktiveras asynkront när `reset_n = 0`.
* `button_edge_s2`: Indikerar nedtryckning av tryckknappen på fallande flank. Signalen är dessutom synkroniserad med seriekopplade D-vippor ("double flop"-metoden).

**Notering**: Postfix `s2` indikerar att signalerna har synkroniserats med två vippor.

**e)** Anslut `led` till `led_state`:

```vhdl
led <= led_state;
```

**f)** Skapa en delkomponent döpt `meta_prev` i en fil döpt `meta_prev.vhd`. Denna delkomponent ska kunna användas för att synkronisera insignalerna med "double flop"-metoden (i syfte att förebygga metastabilitet) samt detektera nedtryckning av tryckknappen `button_n` på fallande flank.

Använd följande portar:
* `clock`: `50 MHz` systemklocka på FPGA-kortet.
* `reset_n`: Asynkron inverterande reset-signal ansluten till en tryckknapp.
* `button_n`: Tryckknapp för toggling av lysdioden.
* `reset_s2_n`: Enligt beskrivningen av motsvarande signal i toppmodulen.
* `button_edge_s2`: Enligt beskrivningen av motsvarande signal i toppmodulen.

**g)** Skapa en instans av delkomponenten `meta_prev` i toppmodulen:
* Döp instansen till `meta_prev1`.
* Anslut portarna till motsvarande signaler i toppmodulen.

**h)** Lägg till en process i toppmodulen så att:
* `led_state` togglas när `button_edge_s2 = 1`.
* Om reset-knappen trycks ned, vilket indikeras av `reset_s2_n = 0`, ska `led_state` sättas till `0` direkt.

**i)** Kontrollera att systemet fungerar som tänkt på FPGA-kortet.

---
