# L10 - Konstruktion av komparatorer

## Dagordning
* Klassisk samt modern konstruktion av komparatorer:
   * **a)** För hand med simulering i CircuitVerse.
   * **b)** I VHDL med simulering i ModelSim.

## Mål med lektionen
* Känna till komparatorns konstruktion.
* Få mängdträna klassisk digitalteknik samt syntes och simulering i VHDL.

## Förutsättningar
* Genomgång av L07-L09 för kunskaper om syntes och simulering i VHDL.

## Instruktioner

### Förberedelse
* Repetera materialet från lektioner L07-L09.
* Vid behov, se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=gtaaarLyeXQ&authuser=0), som behandlar syntes (konstruktion) samt simulering av ett bromsassistanssystem för fordon via ADAS (`Advanced Driver Assistance System`).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.
* Lösningsförslag finns [här](./notes/README.md).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* **P02** - Praktisk labb med kombinatorisk logik i VHDL.

---

## Bilaga A - Övningsuppgifter

Du ska realisera en 4-bitars komparator med insignaler `ABCD` samt utsignaler `XYZ`. 

Komparatorn ska fungera enligt nedan:
* Om `AB > CD` => `XYZ = 100` => `X = 1` indikerar att `AB` är större än `CD`.
* Om `AB = CD` => `XYZ = 010` => `Y = 1` indikerar att `AB` är lika med `CD`.
* Om `AB < CD` => `XYZ = 001` => `Z = 1` indikerar att `AB` är mindre än `CD`.

**a)** Ta fram minimerade ekvationer för utsignaler `X`, `Y` och `Z`, antingen matematiskt eller via Karnaugh-diagram.

**b)** Simulera grindnätet i CircuitVerse, verifiera att konstruktionen fungerar korrekt.  

**c)** Realisera konstruktionen via hårdvarubeskrivande kod i VHDL:
* Döp projektet `comparator_4bit`.
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).

**d)** Verifiera konstruktionen på ett FPGA-kort. Anslut
* insignaler `ABCD` till slide-switchar `SWITCH[3:0]`,
* utsignaler `XYZ` till lysdioder `LED[2:0]`.

Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för PIN-nummer.

**e)** Skapa en testbänk och genomför simulering av hårdvaran i ModelSim för samtliga binära kombinationer av insignaler `ABCD`. Testkör varje kombination under `10 ns`. 

---
