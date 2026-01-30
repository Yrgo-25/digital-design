# L17 - D-latchen och D-vippan

## Dagordning
* Konstruktion av D-latchen och D-vippan.

## Mål med lektionen
* Känna till D-latchens samt D-vippans funktion och uppbyggnad.
* Känna till för- och nackdelar mellan vippor och latchar.
* Känna till vad som menas med synkron respektive asynkron logik.

## Förutsättningar
* Kännedom om kombinatorisk logik från tidigare lektioner.

## Instruktioner

### Förberedelse
* Repetera [L16](../L16/README.md).
* Se video tutorial gällande D-latchen och D-vippan i VHDL [här](https://www.youtube.com/watch?v=utDHdTgZUz0&authuser=0).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad är de primära fördelarna med vippor framför latchar inom digitala system?

## Nästa lektion
* Synkrona processers mall i VHDL – hur D-vippor realiseras korrekt i kod.

---

## Bilaga A - Övningsuppgifter
**1.** Konstruera en D-latch innehållande insignal $D$ och $enable$ samt utsignaler $Q$ och $Qn$:
* Insignal $enable$ ska användas för att låsa / låsa upp latchen; när $enable = 1$ är latchen öppen, annars är den låst.
* Utsignal $Q$ ska utgöra D-latchens ordinarie utsignal.
* Utsignal $Qn$ ska utgöra inversen av D-latchens ordinarie utsignal.

Därmed gäller följande:

```math
enable = 1 => \text{latchen är öppen} => Q=D, Qn=D'
```

samt

```math
enable = 0 => \text{latchen är låst} => Q=Q, Qn=Qn
```

D-latchens utsignaler kan realiseras via följande ekvationer:

```math
Q = (D * enable + Qn)'
```

samt

```math
Qn = (D * enable + Q)'
```

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. 
**b)** Testa att ändra insignal $D$ när latchen är öppen respektive låst, notera utsignalerna. 
**c)** Testa kombinationer 00 – 11 av insignalerna två gånger, så att vi ser hur latchen beter sig när den blir låst efter att ha varit öppen och tilldelats $D = 1$, annars ser vi enbart när den låses när $D = 0$.

---

**2.** Konstruera en D-vippa innehållande insignaler $clock$, $reset\_n$, $D$ och $enable$ samt utsignaler $Q$ och $Qn$:
* Insignal $clock$ ska utgöras av en systemklocka med godtycklig frekvens (dock $50 MHz$ på FPGA-kortet).
* Insignal $reset\_n$ ska utgöras av en inverterande reset-signal, när $reset\_n = 0$ ska systemåterställning ske.
* Insignal $enable$ ska användas för att låsa / låsa upp vippan; när $enable = 1$ är vippan öppen (aktiverad) och kan uppdateras vid klockflank, annars är den låst.
* Utsignal $Q$ ska utgöra D-vippans ordinarie utsignal.
* Utsignal $Qn$ ska utgöra inversen av D-vippans ordinarie utsignal.

Därmed gäller följande:

```math
reset\_n = 0 => \text{Systemåterställning} => Q = 0, Qn = 1
```

```math
reset\_n = 1 \; \text{och} \; enable = 1 => \text{vippan är öppen} => Q = D, Qn = D' \; \text{när klockan slår}
```

```math
reset\_n = 1 \; \text{och} \; enable = 0 => \text{vippan är låst} => Q =Q, Qn = Qn \; \text{när klockan slår}
```

D-vippans utsignaler (utan asynkron reset) kan realiseras via följande ekvationer:

```math
Q = (D * enable * clock + Qn)'
```

samt

```math
Qn = (D * enable * clock + Q)'
```

***OBS!** Detta är en förenklad modell för förståelse. I praktiken realiseras D-vippor med flankkänsliga strukturer,
vilket innebär att utsignalerna endast uppdateras på stigande klockflank.*

**a)** Realisera motsvarande grindnät för hand och simulera i CircuitVerse. Sätt klockans periodtid till $1000$ $ms$. 
**b)** Testa att ändra insignal $D$ när vippan är öppen respektive låst, notera utsignalerna och hur de följer klockpulserna i normalfall. Testa sedan utsignalerna vid systemåterställning (då $reset\_n = 0$). 
**c)** Om $Q = 1$ när systemåterställning sker, dröjer det tills klockan slår innan $Q$ nollställs eller sker det direkt? Förklara varför/varför inte.
**d)** Om tid finns, realisera konstruktionen i VHDL via en modul döpt `d_flip_flop`:
*  Välj FPGA-kort Terasic DE0 (enhet 5CEBA4F23C7).
* Anslut 
    * $clock$ till en $50$ $MHz$ systemklocka,
    * $D$ samt $enable$ till var sin slide-switch,
    * $Q$ samt $Qn$ till var sin lysdiod.
* Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för pin-nummer.

**Tips**: 
* Lägg till en AND-grind med insignaler $Q$ samt reset_n på D-vippans utgång för att enkelt implementera en asynkron inverterande reset, så att vippans utsignaler återställs direkt utan att vänta på klockan. 
* Den inverterande utsignalen $Qn$ kan enkelt sättas till inversen av den utsignalen $Q$ via en NOT-grind.

---
