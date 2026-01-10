# L04 - Talsystem och 2-komplementsaritmetik

## Dagordning
* Talsystem och 2-komplementsaritmetik.
* Mer träning på logisk minimering med Karnaugh-diagram.
* OR- samt NOR-grinden på transistornivå.

## Mål med lektionen
* Kunna omvandla mellan olika talsystem.
* Kunna använda 2-komplement för tal på signerad form.
* Känna till hur signerade och osignerade tal allokeras i mjukvara.
* Öva på minimera enkla logiska funktioner via användning av Karnaugh-diagram. 

## Förutsättningar
* Genomgång av L03 för kunskap om minimering av logiska grindnät med Karnaugh-diagram.
* Grundläggande färdigheter i [CircuitVerse](https://circuitverse.org/simulator).

## Instruktioner

### Förberedelse
* Läs [1.2 - Talsystem](../../tutorials/docs/1.2%20-%20Talsystem.pdf) för information om vanliga talsystem samt 2-komplementsrepresentation.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Omvandling mellan binära och decimala talsystem och tvärtom.
* Omvandling mellan binära och hexadecimala talsystemet och tvärtom.
* Hantering av signerade tal.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Känner ni er trygga med omvandlingar mellan talbaser samt 2-komplementsrepresentation?
* Känner ni er trygga med att minimera logiska funktioner med Karnaugh-diagram?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* **P01** - Praktisk labb med 74-seriegrindar.

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

**3.** Omvandla följande binära tal till deras respektive osignerade decimala samt hexadecimala motsvarigheter:  
**a)** $0001$ $1010_2$    
**b)** $0111$ $1111_2$  
**c)** $1101$ $0011_2$  
**d)** $1111$ $1110_2$  

---

**4.** Omvandla följande tal till deras respektive binära motsvarigheter:  
**a)** $49_{10}$  
**b)** $102_{10}$  
**c)** $212_{10}$  
**d)** $AC2_{16}$  
**e)** $FA452C_{16}$  

---

**5.** I nedanstående uppgifter ska 4-bitars 2-komplement användas:  
**a)** Omvandla $-6_{10}$ till dess 4-bitars binära motsvarighet.  
**b)** Omvandla det signerade binära talet $1001_2$ till dess decimala motsvarighet.  

---

**6.** I nedanstående uppgifter ska 8-bitars 2-komplement användas:  
**a)** Omvandla $-104_{10}$ till dess 8-bitars binära motsvarighet.  
**b)** Omvandla det signerade binära talet $1001$ $0100_2$ till dess decimala motsvarighet.  

---
