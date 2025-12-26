# L07 - Syntes samt simulering av grindnät i VHDL (del I)

## Dagordning
* Introduktion till testbänkar i VHDL.
* Övningar grindnät – konstruktion och simulering för hand samt i VHDL.

## Mål med lektionen
* Kunna konstruera enklare grindnät både för hand samt i VHDL.
* Kunna simulera realiserat grindnät via simuleringsmjukvara (ModelSim).

## Förutsättningar
* Genomgång av L06 för grundläggande kunskaper om VHDL samt installation av programvaror.

## Instruktioner

### Förberedelse
* Repetera grunderna i VHDL från [föregående lektion](../L06/README.md#bilaga-a---grundläggande-koncept-i-vhdl).
* Se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=9ibUE7czpc4&authuser=0), som behandlar just syntes (konstruktion) samt simulering av en 3-ingångars XOR-grind i VHDL.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Skapande av testbänk för OR-grinden som konstruerades föregående lektion.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Känner ni att ni förstår hur man konstruerar och simulerar grindnät både för hand samt i VHDL?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Fördjupad träning i syntes och simulering av grindnät i VHDL.

---

## Bilaga A - Övningsuppgifter

Realisera grindnätet för en krets bestående av fyra insignaler $ABCD$ samt tre utsignaler $XYZ$, både för hand samt via VHDL-kod. Grindnätets sanningstabell visas nedan:

| ABCD | XYZ |   
|------|-----|
| 0000 | 001 |
| 0001 | 010 |
| 0010 | 001 |
| 0011 | 011 |
| 0100 | 100 |
| 0101 | 110 |
| 0110 | 100 |
| 0111 | 111 |
| 1000 | 101 |
| 1001 | 110 |
| 1010 | 101 |
| 1011 | 111 |
| 1100 | 000 |
| 1101 | 010 |
| 1110 | 000 |
| 1111 | 011 |

**1.** Finn minimerade logiska ekvationer för utsignaler $X$, $Y$ och $Z$ via användning av Karnaugh-diagram eller ekvationer. 

**2.** Rita grindnätet och verifiera att det fungerar som tänkt via simulering i CircuitVerse.

**3.** Realisera projektet via hårdvarubeskrivande kod i VHDL.  
Anslut insignaler $ABCD$ till slide-switchar `SWITCH[3:0]` och utsignaler $XYZ$ till lysdioder 
`LED[2:0]` på FPGA-kortet. 

**4.** Skapa en testbänk och genomför simulering av hårdvaran i ModelSim för samtliga binära kombinationer av insignaler $ABCD$. Testkör varje kombination under $10$ $ns$.

---
