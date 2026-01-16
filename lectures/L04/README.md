# L04 - Övningslabb (del I)

## Dagordning
* Övningslabb som förberedelse inför P01.
* Mer träning på logisk minimering med Karnaugh-diagram.
* OR- samt NOR-grinden på transistornivå.

## Mål med lektionen
* Öva på minimera enkla logiska funktioner via användning av Karnaugh-diagram. 

## Förutsättningar
* Genomgång av L03 för kunskap om minimering av logiska grindnät med Karnaugh-diagram.
* Grundläggande färdigheter i [CircuitVerse](https://circuitverse.org/simulator).

## Instruktioner

### Förberedelse
* Se information om 74-seriegrindar [här](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/). 
Kolla specifikt databladet för AND, OR-, NAND- och NOR-grinden, vilket är de grindar som finns tillgängliga under labben:
    * [74x00 - NAND](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc00-74ls00/)
    * [74x02 - NOR](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc02-74ls02/)
    * [74x08 - AND](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc08-74ls08/)
    * [74x32 - OR](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc32-74ls32/)
* **Tips**: En NOT-grind med insignal $A$ samt utsignal $X$ kan implementeras genom att koppla $A$ till båda ingångarna på en NAND-grind. Utsignalen $X$ blir då $(A * A)' = A'$.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.
* Genomför bifogad [övningslabb](./P01%20exempel%20-%20Logiska%20grindnät%20med%2074-serien.pdf).

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?

## Nästa lektion
* Fortsättning på övningslabben.

---

## Bilaga A - Övningsuppgifter

**1.** Rita ut en OR-grind med CMOS-transistorer i LTspice.  
***Tips**: OR-grinden kan implementeras som en NOR-grind i serie med en NOT-grind.*

Lösningsförslag finns [här](./solutions/exercise1/README.md).

---

**2.** Härled minimerade logiska ekvationer för utsignaler X och Y ur nedanstående sanningstabell via ett Karnaugh-diagram och realisera grindnätet. Simulera konstruktionen i CircuitVerse.

| ABCD | XY |
|------|----|
| 0000 | 01 |
| 0001 | 00 |
| 0010 | 00 |
| 0011 | 01 |
| 0100 | 11 |
| 0101 | 10 |
| 0110 | 10 |
| 0111 | 11 |
| 1000 | 11 |
| 1001 | 10 |
| 1010 | 10 |
| 1011 | 11 |
| 1100 | 01 |
| 1101 | 00 |
| 1110 | 00 |
| 1111 | 01 |

Lösningsförslag finns [här](./solutions/exercise2/README.md).

---
