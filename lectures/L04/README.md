# L04 - Talsystem och 2-komplementsaritmetik

## Dagordning
* Talsystem och 2-komplementsaritmetik.
* Mer träning på logisk minimering med Karnaugh-diagram.

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

**1.** Härled en minimerad logisk ekvation för utsignal X ur nedanstående sanningstabell via ett Karnaugh-diagram och realisera motsvarande grindnät. Simulera konstruktionen i CircuitVerse.

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

**2.** Omvandla följande binära tal till deras respektive osignerade decimala samt hexadecimala motsvarigheter:  
**a)** $0001$ $1010_2$    
**b)** $0111$ $1111_2$  
**c)** $1101$ $0011_2$  
**d)** $1111$ $1110_2$  

---

**3.** Omvandla följande tal till deras respektive binära motsvarigheter:  
**a)** $49_{10}$  
**b)** $102_{10}$  
**c)** $212_{10}$  
**d)** $AC2_{16}$  
**e)** $FA452C_{16}$  

---

**4.** Härled en minimerad logisk ekvation för utsignal X ur nedanstående sanningstabell via ett Karnaugh-diagram, realisera motsvarande grindnät. Simulera konstruktionen i CircuitVerse.

| ABCD | X |
|------|---|
| 0000 | 1 |
| 0001 | 1 |
| 0010 | 0 |
| 0011 | 0 |
| 0100 | 1 |
| 0101 | 1 |
| 0110 | 0 |
| 0111 | 0 |
| 1000 | 0 |
| 1001 | 0 |
| 1010 | 1 |
| 1011 | 1 |
| 1100 | 0 |
| 1101 | 0 |
| 1110 | 1 |
| 1111 | 1 |

---

**5.** I nedanstående uppgifter ska 4-bitars 2-komplement användas:  
**a)** Omvandla $-6_{10}$ till dess 4-bitars binära motsvarighet.  
**b)** Omvandla det signerade binära talet $1001_2$ till dess decimala motsvarighet.  

---

**6.** I nedanstående uppgifter ska 8-bitars 2-komplement användas:  
**a)** Omvandla $-104_{10}$ till dess 8-bitars binära motsvarighet.  
**b)** Omvandla det signerade binära talet $1001$ $0100_2$ till dess decimala motsvarighet.  

---

**7.** Härled minimerade logiska ekvationer för utsignaler X och Y ur nedanstående sanningstabell via ett Karnaugh-diagram och realisera grindnätet. Simulera konstruktionen i CircuitVerse.

| ABCD | XY |
|------|----|
| 0000 | 00 |
| 0001 | 01 |
| 0010 | 11 |
| 0011 | 10 |
| 0100 | 01 |
| 0101 | 00 |
| 0110 | 10 |
| 0111 | 11 |
| 1000 | 10 |
| 1001 | 11 |
| 1010 | 01 |
| 1011 | 00 |
| 1100 | 11 |
| 1101 | 10 |
| 1110 | 00 |
| 1111 | 01 |

---
