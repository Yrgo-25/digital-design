# L24 - Konstruktion av timerkretsar (del II)

## Dagordning
* Konstruktion av timerkretsar i VHDL.

## Mål med lektionen
* Kunna konstruera timerkretsar i VHDL via generiska moduler.

## Instruktioner

### Förberedelse
* Se del II (den andra timmen) av min [video tutorial](https://youtu.be/v7O0QMHzmo8?si=XSc2Qk2BDTFX6iqd&t=3802) för information gällande konstruktion av timerkretsar i VHDL.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

## Utvärdering
* Förklara hur en VHDL-process för en timerkrets kan realiseras via en räknare.

## Nästa lektion
* Genomförande av **D02** - VHDL teori (del II).

---

## Bilaga A - Övningsuppgifter

Du ska konstruera ett digitalt system i VHDL, där tre timerkretsar kan togglas via var sin tryckknapp.  
När en given timer är aktiverad ska den räkna klockpulser. Efter ett visst antal klockpulser ska en lysdiod togglas. 

Systemet ska inneha följande portar:

* Insignal $clock$ ska utgöras av en systemklocka med en frekvens på 50 MHz.
* Insignal $reset\_n$ ska utgöras av en inverterande reset-signal från en tryckknapp. När denna signal är låg ska systemåterställning ske.
* Insignaler $button\_n[2:0]$ ska utgöras av inverterande tryckknappar, som vid fallande flank togglar var sin timer.
* Utsignal $led[2:0]$ ska utgöras av lysdioder, som togglas av var sin timer. 

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan eller när reset-signalen är låg. 
* När reset-signalen är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas i startläget - timerkretsarna ska då nollställas och lysdioderna ska släckas.

Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska *double flop*-metoden användas. Därmed ska varje insignal (förutom systemklockan) synkroniseras via två vippor var.

Timerkretsar $timer0\;–\;timer2$ ska implementeras internt via en modul döpt $timer$. Timerns frekvens ska kunna väljas vid instansiering, men defaultvärdet ska vara $1 Hz$. I denna konstruktion gäller att:
* Den första timern, $timer0$, ska toggla en lysdiod var 1000:e millisekund när den är påslagen.
* Den andra timern, $timer1$, ska toggla en lysdiod var 500:e millisekund när den är påslagen.
* Den tredje timern, $timer2$, ska toggla en lysdiod var 100:e millisekund när den är påslagen.

**a)** Skapa ett projekt döpt $led\_toggle\_timer$ i Quartus:
* Välj FPGA-kort Terasic DE0 (enhet 5CEBA4F23C7). 
* Implementera portar såsom beskrivet ovan.

**b)** Lägg till följande signaler i toppmodulen:
* $reset\_s2\_n$: Asynkron inverterande reset-signal synkroniserad i enlighet med *double flop*-metoden.
* $button\_edge\_s2[2:0]$: Indikerar nedtryckning av tryckknapparna på fallande flank. Signalerna är dessutom synkroniserade i enlighet med *double flop*-metoden.
* $timer\_enabled[2:0]$: Lagrar status för respektive timer i systemet (`1` = timern är påslagen).
* $timer\_elapsed[2:0]$: Indikerar timeout för respektive timer (`1` = timeout).

Dessa signaler kommer senare anslutas till instanser av delkomponenter och kommer därigenom fungera enligt beskrivningen ovan.

**c)** Lägg till metastabilitetsskydd för insignaler $reset\_n$ samt $button\_n[2:0]$ via *double flop*-metoden:
* Använd den generiska modulen $meta\_prev$ från [L21](../L21/README.md).
* Anslut $reset\_s2\_n$ samt $button\_edge\_s2[2:0]$ till instansens utportar.

**d)** Lägg till en generisk modul döpt $timer$ med följande parameter och portar:
* Parameter $FREQUENCY$ ska utgöras av timerfrekvensen i form av ett osignerat tal som möjliggör en frekvens mellan $0.1 – 10$ $Hz$:
    * Använd datatypen `natural`.
    * Använd en range för att sätta min- och maxfrekvensen.
    * Som exempel:
        * Om vi har en systemklocka på $50$ $MHz$ ska vi räkna upp $50$ miljoner klockpulser innan en sekund har gått. 
        * För en timerfrekvens på 1 Hz ska därmed timern räkna upp till $50$ miljoner, för 2 Hz ska den räkna upp till $25$ miljoner osv. 
* Insignal $clock$ ska utgöras av konstruktionens systemklocka.
* Insignal $reset\_s2\_n$ ska utgöras av en synkroniserad inverterande reset-signal. Vid reset ska timern nollställas.
* Insignal $enabled$ indikerar om timern är på. Om timern inte är på ska ingen uppräkning ske (men timern ska dock inte nollställas).
* Utsignal $elapsed$ indikerar ifall timern har löpt ut eller inte, vilket sker när timern har räknat upp till $FREQUENCY$.

**e)** I toppmodulen, skapa tre timerkretsar $timer0\;–\;timer2$. Sätt timerfrekvenser enligt beskrivning av lysdiodernas togglingshastighet ovan:
* Enable- samt elapsed-bitar för $timer0$ ska anslutas till $timer\_enabled[0]$ samt $timer\_elapsed[0]$.
* Enable- samt elapsed-bitar för $timer1$ ska anslutas till $timer\_enabled[1]$ samt $timer\_elapsed[1]$.
* Enable- samt elapsed-bitar för $timer2$ ska anslutas till $timer\_enabled[2]$ samt $timer\_elapsed[2]$.

**f)** Lägg till kod i toppmodulen så att respektive timer togglas vid nedtryckning (fallande flank) av motsvarande tryckknapp:
* $timer0$ ska togglas vid nedtryckning av $button\_n[0]$ => toggla $timer\_enabled[0]$ när $button\_edge\_s2[0]\;=\;1$.
* $timer1$ ska togglas vid nedtryckning av $button\_n[1]$ => toggla $timer\_enabled[1]$ när $button\_edge\_s2[1]\;=\;1$.
* $timer2$ ska togglas vid nedtryckning av $button\_n[2]$ => toggla $timer\_enabled[2]$ när $button\_edge\_s2[2]\;=\;1$.

Om reset-knappen trycks ned, vilket ska kontrolleras via den synkroniserade signalen $reset\_s2\_n$, ska samtliga enable-signaler direkt nollställas.

**g)** Lägg till kod i toppmodulen så att respektive lysdiod $led[2:0]$ togglas när respektive timer löper ut:
* $led[0]$ ska togglas när $timer0$ löper ut.
* $led[1]$ ska togglas när $timer1$ löper ut.
* $led[2]$ ska togglas när $timer2$ löper ut.

Om reset-knappen trycks ned, vilket ska kontrolleras via den synkroniserade signalen $reset\_s2\_n$, ska samtliga lysdioder direkt släckas.

---
