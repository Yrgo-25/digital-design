# L05 - Praktisk labb med 74-seriegrindar

## Dagordning
* Genomförande av **P01**, vilket innefattar konstruktion av en logisk krets med 74-seriegrindar.

## Mål med lektionen
* Kunna realisera en logisk krets med hjälp av 74-seriegrindar.
* Förstå varför hårdvarubeskrivande språk används för att implementera digitala kretsar.

## Förutsättningar
* Genomgång av L01-L04 för kunskaper om logiska grindnät.

## Instruktioner

### Förberedelse
* Gå igenom tidigare lektioner.
* Förbered labbuppgifterna hemma - ta fram logiska ekvationer och simulera kretsarna i CircuitVerse.
* Se information om 74-seriegrindar [här](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/). 
Kolla specifikt databladet för AND, OR-, NAND- och NOR-grinden, vilket är de grindar som finns tillgängliga under labben:
    * [74x00 - NAND](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc00-74ls00/)
    * [74x02 - NOR](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc02-74ls02/)
    * [74x08 - NAND](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc08-74ls08/)
    * [74x32 - OR](https://www.build-electronic-circuits.com/7400-series-integrated-circuits/74hc32-74ls32/)
* **Tips**: En NOT-grind med insignal $A$ samt utsignal $X$ kan implementeras genom att koppla $A$ till båda ingångarna på en NAND-grind. Utsignalen $X$ blir då $(A * A)' = A'$.

### Under lektionen
* Labbuppgiften ska genomföras självständigt.
* Ställ frågor vid behov.

## Utvärdering
* Hur upplevde ni att realisera ett logiskt grindnät i fysisk hårdvara?
* Förstår ni varför hårdvarubeskrivande språk föredras framför manuell uppkoppling när kretsarna blir mer komplexa?

## Nästa lektion
* Installation av Quartus och ModelSim.
* Introduktion till VHDL – syntes av en OR-grind.

---
