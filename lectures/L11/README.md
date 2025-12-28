# L11 - Konstruktion av komparatorer

## Dagordning
* Klassisk samt modern konstruktion av komparatorer:
   * **a)** För hand med simulering i CircuitVerse.
   * **b)** I VHDL med simulering i ModelSim.

## Mål med lektionen
* Känna till komparatorns konstruktion.
* Få mängdträna klassisk digitalteknik samt syntes och simulering i VHDL.

## Förutsättningar
* Genomgång av L06-L10 för kunskaper om syntes och simulering i VHDL.

## Instruktioner

### Förberedelse
* Repetera materialet från lektioner L07-L09.
* Vid behov, se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=gtaaarLyeXQ&authuser=0), som behandlar just syntes (konstruktion) samt simulering av ett bromsassistanssystem för fordon via ADAS (`Advanced Driver Assistance System`).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Konstruktion av multiplexers för hand samt i VHDL.

---

## Bilaga A - Övningsuppgifter

Du ska realisera en 4-bitars komparator med insignaler ABCD samt utsignaler XYZ. 

Komparatorn ska fungera enligt nedan:
* Om AB > CD => XYZ = 100 => X = 1 indikerar att AB är större än CD.
* Om AB = CD => XYZ = 010 => Y = 1 indikerar att AB och CD är samma.
* Om AB < CD => XYZ = 001 => Z = 1 indikerar att AB är mindre än CD.

**a)** Ta fram minimerade ekvationer för utsignaler X, Y och Z, antingen matematiskt eller via Karnaugh-diagram.

**b)** Simulera grindnätet i CircuitVerse, verifiera att konstruktionen fungerar korrekt.  

**c)** Implementera konstruktionen i VHDL via en modul döpt `comparator_4bit`:
* Placera projektet i en ny underkatalog `c/quartus/comparator_4bit`.
* Döpt projektet till samma namn som toppmodulen (`comparator_4bit`).
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).    

**d)** Skapa en testbänk döpt `comparator_4bit_tb` och simulera samtliga $16$ kombinationer $0000 – 1111$ av insignaler ABCD under $10$ $ns$ var.  

**e)** Validera konstruktionen i ModelSim. Inspektera att in- och utsignalerna matchar ovanstående sanningstabell.  

**f)** Verifiera konstruktionen på ett FPGA-kort. Anslut insignaler ABCD till var sin slide-switch och utsignaler XYZ till var sin lysdiod, se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för PIN-nummer.

---
