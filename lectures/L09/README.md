# L09 - Syntes samt simulering av grindnät i VHDL (del III)

## Dagordning
* Fördjupad träning i syntes och simulering av grindnät i VHDL.
* Fördjupad träning i logisk minimering av grindnät.
* Fördjupad träning i användning av Quartus och ModelSim.

## Mål med lektionen
* Känna sig bekväm med logisk minimering av kombinatoriska kretsar.
* Känna sig bekväm med syntes samt simulering av kombinatoriska kretsar i VHDL.
* Känna sig bekväm med Quartus och ModelSim.

## Förutsättningar
* Genomgång av L06-L08 för grundläggande kunskaper om VHDL samt installation av programvaror.

## Instruktioner

### Förberedelse
* Repetera materialet från lektioner L07-L08.
* Vid behov, se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=9ibUE7czpc4&authuser=0), som behandlar just syntes (konstruktion) samt simulering av en 3-ingångars XOR-grind i VHDL.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter) nedan.

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Börjar ni känna er bekanta med syntes och simulering av kombinatoriska kretsar i VHDL?
* Börjar ni känna er bekanta med använda verktyg (Quartus samt ModelSim)?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* **P02** - Praktisk labb med kombinatorisk logik i VHDL.

---

## Bilaga A - Övningsuppgifter

Realisera grindnätet för en dividerare, som dividerar två 2-bitars insignaler AB samt CD. Resultatet erhålles via fyra bitar XYZW, där XY utgör heltalsdel och ZW utgör decimaldel. Därmed gäller att

```man
XYZW = \frac{AB}{CD} = XY.ZW
```

där XYZW utgör grindnätets utsignal och ABCD utgör insignalerna.

**1.** Rita en sanningstabell och finn minimerade logiska ekvationer för utsignaler $X$, $Y$, $Z$ och $W$ via användning av Karnaugh-diagram eller ekvationer. Vid behov, avrunda till två decimaler.

**2.** Rita grindnätet och verifiera att det fungerar som tänkt via simulering i CircuitVerse.

**3.** Realisera projektet via hårdvarubeskrivande kod i VHDL.  
Anslut 
* insignaler $ABCD$ till slide-switchar `SWITCH[3:0]`, 
* utsignaler $XY$ (heltalsdelen) till lysdioder `LED[4:3]`,
* utsignaler $ZW$ till lysdioder `LED[1:0]`.

**Notering**: Använd inte `LED2` för att separera heltals- och decimaldelen.

**4.** Skapa en testbänk och genomför simulering av hårdvaran i ModelSim för samtliga binära kombinationer av insignaler $ABCD$. Testkör varje kombination under $10$ $ns$.

### Tips 
Vid fixpunktsaritmetik minskar värdet på bitarna i decimaldelen med en faktor två för varje steg åt höger, där den mest signifikanta decimalbiten är värd $\frac{1}{2} = 0.5$, andra biten $\frac{1}{4} = 0.25$, tredje biten $\frac{1}{8} = 0.125$ och så vidare. 

Därmed gäller att:
* Decimaldelen $00$ är ekvivalent med $0 + 0 = 0.0$.
* Decimaldelen $01$ är ekvivalent med $0 + 0.25 = 0.25$.
* Decimaldelen $10$ är ekvivalent med $0.5 + 0 = 0.5$.
* Decimaldelen $11$ är ekvivalent med $0.5 + 0.25 = 0.75$.

#### Exempel på division med fixpunktsaritmetik 
Divisionen $\frac{3}{2} = 1.5$ skrivs på binär form enligt följande:

```math
\frac{11_2}{10_2} = 01.10
```

där heltalsdelen $01_2$ motsvarar heltalet $1$ och decimaldelen $10$ motsvarar flyttalet $0.5$.

---
