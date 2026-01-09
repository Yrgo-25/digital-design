# L01 - Logiska grindnät (del I)

## Dagordning
* Introduktion till digitalteknik.
* Grundläggande boolesk algebra.
* Logiska grindar och enkla grindnät.
* NOT-grinden på transistornivå.

## Mål med lektionen
* Känna till skillnaden mellan digitala och analoga signaler samt varför digitala kretsar föredras framför analoga.
* Känna till funktion och symboler för de vanligaste logiska grindarna.
* Känna till de mest grundläggande reglerna för Boolesk algebra.
* Kunna konstruera samt simulera enkla grindnät utefter en logisk funktion.
* Kunna rita upp NOT-grinden CMOS-transistorer och förklara dess funktion.

## Instruktioner

### Förberedelse
* Läs [1.1 - Introduktion till digitalteknik](../../tutorials/docs/1.1%20-%20Introduktion%20till%20digitalteknik.pdf) för lite
information om vad digitalteknik är.
* Läs [1.3 - Logiska grindar, kombinatorik och boolesk algebra](../../tutorials/docs/1.3%20-%20Logiska%20grindar,%20kombinatorik%20och%20boolesk%20algebra.pdf), specifikt avsnitt 
`1.3.1 – 1.3.4` för information om logiska grindar och grindnät.
* Se till att ha [LTspice](https://www.analog.com/en/resources/design-tools-and-calculators/ltspice-simulator.html) installerat.
* **Om tid finns**: Läs [1.4 - Konstruktion av logiska grindar med CMOS-teknologi](../../tutorials/docs/1.4%20-%20Konstruktion%20av%20logiska%20grindar%20med%20CMOS-teknologi.pdf), specifikt avsnitt `1.4.1` samt `1.4.8` för information om logiska grindars uppbyggnad med CMOS-transistorer.

### Under lektionen
* Se bifogat [exempel](#bilaga-a---exempel-på-realisering-av-en-logisk-funktion) på realisering av en logisk funktion nedan.

### Demonstration
* Simulering av ett par enklare logiska grindnät i [CircuitVerse](https://circuitverse.org/simulator).
* Konstruktion av NOT-grinden med CMOS-transistorer i LTspice.

## Anteckningar
Lektionsanteckningar finns [här](./notes/README.md).

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Känner ni att ni kan förklara skillnaden mellan digitala och analoga signaler?
* Kan ni rita och förklara funktionen för en NOT-grind på transistornivå?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Mer arbete med logiska grindnät.
* Simulering av NOT-grind samt buffern i LTspice.
* Algebraisk minimering med boolesk algebra.

---

## Bilaga A - Exempel på realisering av en logisk funktion

Anta att vi har ett grindnät med fyra insignaler ABCD samt en utsignal X. Anta att vi ska realisera funktionen $X = AB' + CD`$.

### Steg 1: Rita sanningstabellen

Vi ritar ut för samtliga 16 kombinationer av insignaler ABCD ($0000 - 1111$). Vi skriver också ut motsvarande värde på X:

| A | B | C | D | X |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 0 | 0 | 1 | 1 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 0 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 |
| 1 | 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 | 1 |

### Steg 2: Rita grindnätet

- Använd en AND-grind för AB' (koppla A och NOT B till AND).
- Använd en AND-grind för CD.
- Använd en OR-grind för att slå ihop resultaten från de två AND-grindarna.

> **Tips:**
> När du realiserar en funktion, börja med att identifiera vilka grindar du behöver för varje term i uttrycket. Använd NOT-grindar för inverterade variabler (t.ex. B'), AND-grindar för produkttermer och OR-grindar för att summera termerna.

---