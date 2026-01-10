# L02 - Logiska grindnät (del II)

## Dagordning
* Mer arbete med logiska grindnät.
* Simulering av NOT-grinden samt buffern i LTspice.
* Algebraisk minimering med boolesk algebra.

## Mål med lektionen
* Känna till funktion och symboler för alla logiska grindar.
* Kunna minimera enkla logiska funktioner algebraiskt.

## Förutsättningar
* Genomgång av L01 för grundläggande kunskap om logiska grindar och grindnät samt boolesk algegra.
* Grundläggande färdigheter i [CircuitVerse](https://circuitverse.org/simulator).

## Instruktioner

### Förberedelse
* Läs [1.4 - Konstruktion av logiska grindar med CMOS-teknologi](../../tutorials/docs/1.4%20-%20Konstruktion%20av%20logiska%20grindar%20med%20CMOS-teknologi.pdf), specifikt avsnitt `1.4.1` samt `1.4.8` för information om logiska grindars uppbyggnad med CMOS-transistorer.

### Under lektionen
* Se bifogat [exempel](#bilaga-a---exempel-på-bestämning-av-logisk-ekvation-från-sanningstabell) på hur en logisk ekvation kan bestämmas ur en sanningstabell.
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter) nedan.

### Demonstration
* Algebraisk minimering av ett par logiska funktioner med simulering i [CircuitVerse](https://circuitverse.org/simulator), bland annat ADAS-systemet.
* Konstruktion av NOT-grinden med CMOS-transistorer i LTspice.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Kan ni rita och förklara funktionen för en AND-grind på transistornivå?
* Kan ni visa hur man använder en sanningstabell för att analysera ett grindnät?
* Känner ni er trygga med att minimera logiska funktioner algebraiskt?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Mer arbete med logiska grindnät.
* AND- samt NAND-grinden på transistornivå.
* Visuell minimering av logiska ekvationer med Karnaugh-diagram.

---

## Bilaga A - Exempel på bestämning av logisk ekvation från sanningstabell

Anta att ni har följande sanningstabell för en funktion X med två insignaler A och B:

| A | B | X |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

För att bestämma ekvationen för X:
1. Identifiera de rader där $X = 1$.
2. Skriv en produktterm (AND-term) för varje sådan rad:
	* Rad 2: $X = 1$ då $AB = 01$ => Vi lägger därmed till AND-termen $A'B$.
	* Rad 3: $X = 1$ då $AB = 10$ => Vi lägger därmed till AND-termen $AB'$.
3. Sätt ihop termerna med OR (+). Därmed gäller att
	* $X = A'B + AB'$

Notera att detta är XOR-funktionen. Motsvarande grindnät hade därmed kunnat realiseras med en XOR-grind av med A och B som insignaler och X som utsignal.

> **Tips:**
> 
> I boolesk algebra används primtecken (\') för att visa att en variabel är inverterad (t.ex. A' betyder NOT A). Glöm inte att använda primtecken när ni skriver ut produkttermer från sanningstabellen!

---

## Bilaga B - Övningsuppgifter

**1.** Rita ut en buffer med CMOS-transistorer i LTspice.  
***Tips**: Buffern kan implementeras som två NOT-grindar i serie.*

---

**2.** Ett grindnät innehållande två insignaler AB samt en utsignal X ska realiseras.  
Sanningstabellen för grindnätet visas nedan:

| AB | X |
|----|---|
| 00 | 1 |
| 01 | 0 |
| 10 | 1 |
| 11 | 0 |

**a)** Bestäm grindnätets ekvation via sanningstabellen.  
**b)** Minimera den bestäma ekvationen algebraiskt.  
**c)** Konstruera motsvarande grindnät i CircuitVerse.

---

**3.** Ett grindnät innehållande tre insignaler ABC samt en utsignal Y ska realiseras.  Sanningstabellen för grindnätet visas nedan:

| ABC | Y |
|-----|---|
| 000 | 0 |
| 001 | 1 |
| 010 | 1 |
| 011 | 0 |
| 100 | 1 |
| 101 | 0 |
| 110 | 0 |
| 111 | 1 |

**a)** Bestäm grindnätets ekvation via sanningstabellen.  
**b)** Minimera den bestäma ekvationen algebraiskt.  
**c)** Konstruera motsvarande grindnät i CircuitVerse.

---

**4.** Ett grindnät innehållande fyra insignaler ABCD samt två utsignaler XY ska realiseras.   Sanningstabellen för grindnätet visas nedan:

| ABCD | XY |
|------|----|
| 0000 | 01 |
| 0001 | 11 |
| 0010 | 01 |
| 0011 | 11 |
| 0100 | 10 |
| 0101 | 10 |
| 0110 | 00 |
| 0111 | 00 |
| 1000 | 01 |
| 1001 | 11 |
| 1010 | 01 |
| 1011 | 11 |
| 1100 | 10 |
| 1101 | 10 |
| 1110 | 00 |
| 1111 | 00 |

**a)** Bestäm grindnätets ekvation via sanningstabellen.  
**b)** Minimera den bestäma ekvationen algebraiskt.  
**c)** Konstruera motsvarande grindnät i CircuitVerse.

---
