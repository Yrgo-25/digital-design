# L20 - Generiska parametrar i VHDL

## Dagordning
* Användning av generiska parametrar i VHDL för att göra moduler återanvändbara och skalbara.

## Mål med lektionen
* Kunna använda generiska parametrar (`generic`) och `generic map` för att konfigurera en modul vid instansiering.

## Förutsättningar
* Kännedom om metastabilitetsprevention från [L19](../L19/README.md).

## Instruktioner

### Förberedelse
* Repetera [L19](../L19/README.md).
* Läs [Bilaga A](#bilaga-a---kortfattad-introduktion-till-generiska-parametrar-i-vhdl) som en introduktion till generics.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter).
* Lektionsanteckningar finns [här](./notes/README.md).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad är de primära fördelarna med att använda generiska parametrar i VHDL-moduler?
* Vad är syftet med att ange ett default-värde för en generisk parameter?  
  Hur påverkar detta hur modulen instansieras?
* Anta att en modul använder parametern `DEVICE_COUNT`.  
  Vad händer i designen om värdet ändras från `1` till `3`?

## Nästa lektion
* **P03** - Praktisk labb med synkron logik i VHDL.

---

## Bilaga A - Kortfattad introduktion till generiska parametrar i VHDL
I VHDL används generiska parametrar (*generics*) för att göra en komponent konfigurerbar utan att behöva ändra själva koden. En generic fungerar ungefär som en konstant parameter som kan sättas när en komponent instansieras.

Detta gör att samma VHDL-modul kan användas i flera sammanhang, till exempel med olika databredd eller olika räknargränser.

Generiska parametrar deklareras i entity-deklarationen. Ett vanligt exempel är att sätta antalet enheter konfigurerbart, såsom visas nedan:

```vhdl
entity device_controller is
    generic(DEVICE_COUNT: natural range 1 to 5 := 1);
    port(clock, reset_n: in std_logic;
         button_n: in std_logic_vector((DEVICE_COUNT - 1) downto 0);
         led     : out std_logic_vector((DEVICE_COUNT - 1) downto 0));
end entity;
```

Här definieras en generic med namnet `DEVICE_COUNT`, vilket är antalet enheter. Defaultvärdet är `1`, vilket innebär att en device-kontroller använder en tryckknapp och en lysdiod om inget annat anges:

```vhdl
device_controller1: entity work.device_controller
    port map(clock, reset_n, button_n, led);
```

När komponenten instansieras kan värdet ändras med en `generic map`:

```vhdl
device_controller2: entity work.device_controller
    generic map(DEVICE_COUNT => 3),
    port map(clock, reset_n, button_n, led);
```

I detta fall används samma device-kontroller, men med tre tryckknappar + tre lysdioder istället för defaultantalet ett.

När värdet på `DEVICE_COUNT` ändras kommer hela konstruktionen automatiskt skalas så att rätt antal tryckknappar och lysdioder används.

Fördelarna med generiska parametrar är bland annat:
* Återanvändbar kod.
* Enklare konfiguration av komponenter.
* Mindre behov av duplicerad kod.

Generics används ofta för:
* Bussbredd/storlek på vektorer (t.ex. 8, 16 eller 32 bitar).
* Maxtal för uppräkning.
* Tidskonstanter eller prescalers.

---

## Bilaga B - Övningsuppgifter
I denna övning ska konstruktionen från L19 generaliseras så att samma modul kan användas för ett valfritt antal knappar och lysdioder via en generisk parameter `DEVICE_COUNT`. Detta görs genom att använda generiska parametrar.

Du ska konstruera ett synkront digitalt system för toggling av lysdioder via tryckknappar. Systemet ska inneha följande portar:
* Insignal `clock` ska utgöras av en systemklocka med godtycklig frekvens (dock `50 MHz` på FPGA-kortet).
* Insignal `reset_n` ska utgöras av en asynkron inverterande reset-signal. När `reset_n` är låg ska systemåterställning ske, oavsett systemklockans tillstånd.
* Insignaler `button_n[DEVICE_COUNT-1:0]` ska utgöras av inverterande tryckknappar, som vid nedtryckning (fallande flank) togglar var sin lysdiod.
* Utsignaler `led[DEVICE_COUNT-1:0]` ska utgöras av lysdioder, som togglas vid nedtryckning (fallande flank) av motsvarande tryckknappar `button_n[DEVICE_COUNT-1:0]`.

**Notering**: I VHDL kan en signal `state[DEVICE_COUNT-1:0]` implementeras såsom visas nedan: 

```vhdl
signal state: std_logic_vector((DEVICE_COUNT - 1) downto 0);
```

För toppmodulen gäller att:
* `DEVICE_COUNT = 3`
* `button_n(2)` → `led(2)`
* `button_n(1)` → `led(1)`
* `button_n(0)` → `led(0)`

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan `clock` eller när reset-signalen `reset_n` är låg.
* När `reset_n` är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas till startläget (och lysdioderna ska då släckas).

Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska "double flop"-metoden användas:
* Varje asynkron insignal (förutom systemklockan) ska synkroniseras via två D-vippor var:
    * Två D-vippor placeras i serie med respektive insignal.
    * Utsignalen ur den andra vippan är med mycket hög sannolikhet stabil och används därefter i systemet.
* Ska flankdetektering genomföras behövs tre seriekopplade vippor per insignal - två som metastabilitetsskydd och en för att lagra föregående tillstånd:
    * Den första och andra vippan används för metastabilitetsskydd (synkronisering till systemklockan).
    * Den tredje vippan används för flankdetektering och lagrar föregående värde på insignalen.
    * Därmed gäller att:
        * Vippa 1 – metastabilitetsskydd.
        * Vippa 2 – stabiliserad ("nuvarande") insignal.
        * Vippa 3 – föregående värde (används för flankdetektering).

**OBS:** `DEVICE_COUNT` ska vara en generic av typen `natural range 1 to 3` (dvs. 1, 2 eller 3 knappar/lysdioder).

---

**a)** Realisera motsvarande grindnät för hand med tre trycknappar/lysdioder och simulera i CircuitVerse. Sätt klockans periodtid till `1000 ms`.

**b)** Testa att toggla respektive lysdiod genom att trycka ned motsvarande knappar. Sker togglingen direkt eller dröjer det tills klockan slår? Dröjer det en eller flera klockpulser?

**c)** Implementera konstruktionen i VHDL via en modul döpt `led_toggle_meta_prev`, som ska vara **generic** via parametern `DEVICE_COUNT`:
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).
* Anslut:
  * `clock` till en `50 MHz` systemklocka.
  * `reset_n` till en tryckknapp.
  * `button_n[DEVICE_COUNT-1:0]` till var sin tryckknapp.
  * `led[DEVICE_COUNT-1:0]` till var sin lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

**d)** Deklarera följande signaler i toppmodulen:
* `led_state[DEVICE_COUNT-1:0]`: Håller lysdiodernas tillstånd internt.
* `reset_s2_n`: Reset-signal framtagen med två seriekopplade D-vippor, där reset aktiveras asynkront när `reset_n = 0`.
* `button_edge_s2[DEVICE_COUNT-1:0]`: Indikerar nedtryckning av tryckknapparna på fallande flank. Signalen är dessutom synkroniserad med seriekopplade D-vippor ("double flop"-metoden).

**Notering**: Postfix `s2` indikerar att signalerna har synkroniserats med två vippor.

**e)** Anslut `led` till `led_state`:

```vhdl
led <= led_state;
```

**f)** Skapa en delkomponent döpt `meta_prev` i en fil döpt `meta_prev.vhd`. Denna delkomponent ska kunna användas för att:
* Synkronisera insignalerna med "double flop"-metoden (i syfte att förebygga metastabilitet).
* Detektera nedtryckning av tryckknapparna på fallande flank.

Modulen `meta_prev` ska vara generisk via parametern `DEVICE_COUNT`, där:
* `DEVICE_COUNT : natural range 1 to 3 := 1`.

Använd följande portar:
* `clock`: `50 MHz` systemklocka på FPGA-kortet.
* `reset_n`: Asynkron inverterande reset-signal ansluten till en tryckknapp.
* `button_n[DEVICE_COUNT-1:0]`: Tryckknappar för toggling av lysdioderna (inverterande).
* `reset_s2_n`: Synkroniserad reset (double flop).
* `button_edge_s2[DEVICE_COUNT-1:0]`: Ettställd vid nedtryckning (fallande flank) på respektive knapp (baserat på synkroniserad signal).

**g)** Skapa en instans av delkomponenten `meta_prev` i toppmodulen:
* Döp instansen till `meta_prev1`.
* Anslut portarna till motsvarande signaler i toppmodulen.
* Se till att `DEVICE_COUNT` i toppmodulen skickas vidare till `meta_prev`:

```vhdl
meta_prev1: entity work.meta_prev
    generic map(DEVICE_COUNT => DEVICE_COUNT)
    port map(...);
```

**h)** Lägg till kod i toppmodulen så att:
* Respektive lysdiod `led[i]` togglas vid fallande flank på motsvarande tryckknapp (motsvarande synkroniserad signal `button_edge_s2[i]` kommer då vara ettställd).
* Om reset-knappen trycks ned, vilket ska kontrolleras via den synkroniserade signalen `reset_s2_n`, ska lysdioderna direkt släckas.


**i)** Kontrollera att systemet fungerar som tänkt på FPGA-kortet.

---
