# L23 – Konstruktion av timerkretsar (del II)

## Dagordning
* Konstruktion av timerkretsar i VHDL.

## Mål med lektionen
* Hantera konstruktioner som består av flera moduler skrivna i olika HDL-språk.
* Läsa och förstå befintlig HDL-kod.
* Konstruera timerkretsar i VHDL med hjälp av generiska moduler.

## Instruktioner

### Förberedelse
Se del II (den andra timmen) av min [video tutorial](https://youtu.be/v7O0QMHzmo8?si=XSc2Qk2BDTFX6iqd&t=3802) för en genomgång av hur timerkretsar kan konstrueras i VHDL.

### Under lektionen
* Genomför övningsuppgifterna i [Bilaga A](#bilaga-a--övningsuppgifter).
* Lösningsförslag finns [här](./notes/README.md).

## Utvärdering
* Förklara hur en timerkrets i VHDL kan implementeras med hjälp av en räknare i en process.

## Nästa lektion
* Övning - Synkront system med multipla komponenter.

---

# Bilaga A – Övningsuppgifter
Du ska modifiera ett befintligt digitalt system i VHDL, där tre timerkretsar kan togglas via var sin tryckknapp.

När en timer är aktiverad ska den räkna klockpulser. Efter ett visst antal klockpulser ska en lysdiod togglas.

I projektet finns två moduler skrivna i SystemVerilog, bland annat en timermodul. Dessa ska ersättas med motsvarande implementationer i VHDL.

## Systemets portar
Systemet har följande portar:

### Insignaler
* `clock`:Systemklocka med frekvensen **50 MHz**.
* `reset_n`: Aktiv låg reset-signal från en tryckknapp. När signalen är låg ska systemåterställning ske.
* `button_n[2:0]`: Aktivt låga tryckknappar. En **fallande flank** ska toggla respektive timer.

### Utsignaler
* `led[2:0]`: Lysdioder som togglas av respektive timer.

---

## Systemets funktion
Kretsen är implementerad synkront med en asynkron reset:

* Samtliga signaler uppdateras vid stigande flank på systemklockan eller när reset-signalen är låg.
* När `reset_n = 0` ska systemet återställas:
  * Alla timerkretsar nollställs.
  * Alla lysdioder släcks.

## Metastabilitet
För att göra kretsen mer robust används förebyggande av metastabilitet.
Detta görs genom att använda "double flop"-metoden:
* Varje insignal (förutom systemklockan) synkroniseras genom två efterföljande vippor.

---

## Timerkretsar
Timerkretsarna `timer0–timer2` är implementerade via en SystemVerilog-modul med namnet `timer`:
* Timerns frekvens kan väljas vid instansiering.
* Standardvärdet motsvarar **10 Hz**.

I denna konstruktion gäller att:
* När en timer är aktiv togglas motsvarande lysdiod var 100:e millisekund.
* När en timer är inaktiv hålls motsvarande lysdiod släckt.

---

## Uppgifter

**a)** Öppna projektet [led_toggle_timer.qar](./led_toggle_timer.qar) i Quartus:
* Kompilera projektet.
* Testkör systemet på FPGA-kortet.

**b)** Inspektera koden och försök få en förståelse för hur modulerna hänger samman.

**c)** Ersätt modulen `timer` med en motsvarande modul skriven i VHDL.

När detta är gjort kan du ta bort SystemVerilog-versionen av modulen.

**d)** Ersätt modulen `device_controller` med en motsvarande modul i VHDL.

När detta är gjort kan även denna SystemVerilog-modul tas bort.

---
