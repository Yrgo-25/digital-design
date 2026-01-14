# L05 - Övningslabb (del II)

## Dagordning
* Slutförande av övningslabb som förberedelse inför P01.

## Mål med lektionen
* Kunna realisera en logisk krets med hjälp av 74-seriegrindar.
* Förstå varför hårdvarubeskrivande språk används för att implementera digitala kretsar.

## Förutsättningar
* Genomgång av L03-L04 för kunskap om minimering av logiska grindnät med Karnaugh-diagram.
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
* Genomför bifogad [övningslabb](./P01%20exempel%20-%20Logiska%20grindnät%20med%2074-serien.pdf).

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Känner ni er trygga inför P01?

## Nästa lektion
* **P01** - Praktisk labb med 74-seriegrindar.

---
