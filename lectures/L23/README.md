# L23 - Konstruktion av timerkretsar (del I)

## Dagordning
* Konstruktion av timerkretsar för hand.

## Mål med lektionen
* Förstå övergripande hur timerkretsar är uppbyggda i hårdvara.

## Instruktioner

### Förberedelse
* Se del I (den första timmen) av min [video tutorial](https://youtu.be/v7O0QMHzmo8) för information gällande konstruktion
av timerkretsar för hand.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-a---övningsuppgifter).

## Utvärdering
* Förklara kortfattat hur en 4-bitars räknare realiseras via parallella räknarkretsar.

## Nästa lektion
* Konstruktion av timerkretsar i VHDL.

---

## Bilaga A - Övningsuppgifter

Du ska konstruera en krets i CircuitVerse, där en timer kan togglas via en tryckknapp. När timern är aktiverad räknar den klockpulser. Efter tio klockpulser ska en lysdiod togglas.

Systemet ska inneha följande portar:

* Insignal `clock` ska utgöras av en systemklocka med en frekvens på 1 Hz, vilket motsvarar en klockperiod på `1000 ms`.
* Insignal `reset_n` ska utgöras av en inverterande reset-signal ansluten till en tryckknapp. När denna signal är låg ska systemåterställning ske.
* Insignal `button_n` ska utgöras av en inverterande tryckknapp, som vid fallande flank togglar en timer.
* Utsignal `led` ska utgöras av en lysdiod, som togglas via en timer. 

När timern är aktiverad räknar den klockpulser. Var tionde klockpuls lysdioden togglas.

Kretsen ska implementeras synkront med en asynkron reset:
* Samtliga signaler i kretsen uppdateras vid stigande flank på systemklockan eller när reset-signalen är låg. 
* När reset-signalen är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas i startläget - timern ska då nollställas och lysdioden ska släckas.

Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska *double flop*-metoden användas. Därmed ska varje insignal (förutom systemklockan) synkroniseras via två vippor var.

**a)** Lägg till metastabilitetsskydd för insignaler `reset_n` samt `button_n` via *double flop*-metoden.

**b)** Detektera fallande flank på `button_n` (dvs. knapptryckning).

**c)** Lägg till en signal (via en vippa) döpt `timer_enabled`, som togglas vid fallande flank på `button_n`.

**d)** Lägg till en 4-bitars timer/räknare, som räknar klockpulser från `0-10`:
* Lägg till fyra räknarkretsar och sammankoppla dem via `Cin` samt `Cout`. 
* Summan ska nå upp till `10` ($1010_2$ på binär form) för att timern ska få timeout.
* När timern får timeout ska en utsignal döpt `timer_elapsed` ettställas, samtidigt som timern ska nollställas. 

### Tips
* Spara summan vi har räknat upp till via en D-vippa per räknare. 
* Jämför summan ut ur respektive räknare med motsvarande bit $1010_2$ via XNOR-grindar (som ger hög utsignal ifall insignalerna är samma). 
* När utsignalen ur respektive XNOR-grind är hög har timern räknat upp till `10` och `timer_elapsed` ska då ettställas.

**e)** Se till att lysdioden uppdateras som tänkt:
* Se till att lysdioden togglas varje gång `timer_elapsed` är hög. 
* Se till att lysdioden släcks vid nästa klockpuls om `timer_enabled` är låg.

---
