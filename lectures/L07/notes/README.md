# L07 - Anteckningar

Syntes samt simulering av en OR-grind i VHDL.

OR-grinden är realiserad via en digital konstruktion döpt `or_gate`, bestående av inportar `a` och `b` samt en utport `x`, såsom visas nedan:

![Modulen `or_gate`](../images/or_gate_module.png)

## Filer
* [or_gate.vhd](./or_gate.vhd) innehåller modulen `or_gate`, som utgör själva implementationen av OR-grinden.
* [or_gate_tb.vhd](./or_gate_tb.vhd) utgör en testbänk för modulen `or_gate`.
* [or_gate.qar](./or_gate.qar) utgör en arkiverad projektfil, som kan användas för att direkt öppna projektet, inklusive pins och testbänk, i Quartus.

---
