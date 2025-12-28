# L13 - Konstruktion av AD-omvandlare med prioritetsavkodare 

## Dagordning
* Konstruktion av AD-omvandlare med prioritetsavkodare i LTspice.
* Konstruktion av prioritetsavkodare i VHDL.

## Mål med lektionen
* Erhålla grundläggande kunskap gällande konstruktion av AD-omvandlare.
* Känna till prioritetsavkodarens konstruktion.

## Förutsättningar
* Genomgång av L06 - L12 för kunskaper om syntes och simulering i VHDL.

## Instruktioner

### Förberedelse
* Läs om konstruktion av AD-omvandlare [här](../../tutorials/docs/1.5%20-%20Konstruktion%20av%20AD-omvandlare.pdf).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Genomförande av **D01** - VHDL teori (del I).

---

## Bilaga A - Övningsuppgifter

Vi ska realisera en 2-bitars prioritetsavkodare, som under lektion ska användas i en AD-omvandlare konstruerad i LTspice.

Prioritetsavkodaren ska ha fyra insignaler ABCD samt två utsignaler XY.  
Prioritetsavkodaren bryr sig endast om den mest signifikanta höga insignalen i ABCD.

Prioritetsavkodarens sanningstabell visas nedan:

| ABCD | XY |
|------|----|
| 0000 | 00 |
| 0001 | 00 |
| 0010 | 01 |
| 0011 | 01 |
| 0100 | 10 |
| 0101 | 10 |
| 0110 | 10 |
| 0111 | 10 |
| 1000 | 11 |
| 1001 | 11 |
| 1010 | 11 |
| 1011 | 11 |
| 1100 | 11 |
| 1101 | 11 |
| 1110 | 11 |
| 1111 | 11 |

---

**Tips:** Eftersom prioritetsavkodaren endast bryr sig om den mest signifikanta höga insignalen kan sanningstabellen förenklas med "don't care"-värden (symboliserade med `X`). Dessa värden spelar ingen roll och kan användas för att förenkla de logiska ekvationerna. Om det blir enklare kan man även utelämna dem.

Ovanstående sanningstabell kan därmed förenklas med "don't care"-värden såsom visas nedan:

| ABCD | XY |
|------|----|
| 0000 | 00 |
| 001X | 01 |
| 01XX | 10 |
| 1XXX | 11 |

---


**a)** Ta fram minimerade ekvationer för utsignalerna X och Y via någon av sanningstabellerna ovan.

**b)** Simulera grindnätet i CircuitVerse, verifiera att konstruktionen fungerar korrekt.

**c)** Implementera konstruktionen i VHDL via en modul döpt `priority_encoder`:
* Placera projektet i en ny underkatalog `c/quartus/priority_encoder`.
* Döpt projektet till samma namn som toppmodulen (`priority_encoder`).
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).    

**d)** Verifiera konstruktionen på ett FPGA-kort. Anslut
* insignaler `ABCD` till var sin slide-switch,
* utsignaler `XY` till en lysdiod.

Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för PIN-nummer.

---