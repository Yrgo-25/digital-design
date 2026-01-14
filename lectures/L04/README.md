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

**2.** Härled en minimerad logisk ekvation för utsignal X ur nedanstående sanningstabell via ett Karnaugh-diagram och realisera motsvarande grindnät. Simulera konstruktionen i CircuitVerse.

| ABC | X |
|-----|---|
| 000 | 0 |
| 001 | 1 |
| 010 | 0 |
| 011 | 1 |
| 100 | 1 |
| 101 | 0 |
| 110 | 1 |
| 111 | 0 |

---
