# L08 - Syntes samt simulering av grindnät i VHDL (del II)

## Dagordning
* Fördjupad träning i syntes och simulering av grindnät i VHDL.
* Fördjupad träning i logisk minimering av grindnät.
* Fördjupad träning i användning av Quartus och ModelSim.

## Mål med lektionen
* Fördjupa sina färdigheter gällande logisk minimering.
* Fördjupa sina färdigheter gällande syntes samt simulering av kombinatoriska kretsar i VHDL.
* Fördjupa sina färdigheter gällande användning av Quartus och ModelSim.

## Förutsättningar
* Genomgång av L06-L07 för grundläggande kunskaper om VHDL samt installation av programvaror.

## Instruktioner

### Förberedelse
* Repetera materialet från L07.
* Vid behov, se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=gtaaarLyeXQ&authuser=0), som behandlar just syntes (konstruktion) samt simulering av ett bromsassistanssystem för fordon via ADAS (`Advanced Driver Assistance System`).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Känner ni att ni förstår hur man konstruerar och simulerar grindnät både för hand samt i VHDL?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Fördjupad träning i syntes och simulering av grindnät i VHDL.
* Fördjupad träning i logisk minimering av grindnät.
* Fördjupad träning i användning av Quartus och ModelSim.

---

## Bilaga A - Övningsuppgifter

Realisera grindnätet för en 4-bitars "adderare" bestående av fyra insignaler $ABCD$ samt tre utsignaler $XYZ$, både för hand samt via VHDL-kod. 

**OBS!** Detta grindnät är inte en traditionell binär adderare, utan en så kallad "population counter", som summerar antalet ettor bland insignalerna $ABCD$ och presenterar resultatet som ett 3-bitars binärt tal via utsignaler $XYZ$.

Grindnätets sanningstabell visas nedan:

| ABCD | XYZ |   
|------|-----|
| 0000 | 000 |
| 0001 | 001 |
| 0010 | 001 |
| 0011 | 010 |
| 0100 | 001 |
| 0101 | 010 |
| 0110 | 010 |
| 0111 | 011 |
| 1000 | 001 |
| 1001 | 010 |
| 1010 | 010 |
| 1011 | 011 |
| 1100 | 010 |
| 1101 | 011 |
| 1110 | 011 |
| 1111 | 100 |

**1.** Finn minimerade logiska ekvationer för utsignaler $X$, $Y$ och $Z$ via användning av Karnaugh-diagram eller ekvationer. 

**2.** Rita grindnätet och verifiera att det fungerar som tänkt via simulering i CircuitVerse.

**3.** Realisera projektet via hårdvarubeskrivande kod i VHDL.  
Anslut insignaler $ABCD$ till slide-switchar `SWITCH[3:0]` och utsignaler $XYZ$ till lysdioder 
`LED[2:0]` på FPGA-kortet. 

**4.** Skapa en testbänk och genomför simulering av hårdvaran i ModelSim för samtliga binära kombinationer av insignaler $ABCD$. Testkör varje kombination under $10$ $ns$.

---
