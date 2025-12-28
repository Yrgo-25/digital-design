# L12 - Konstruktion av multiplexers

## Dagordning
* Klassisk samt modern konstruktion av multiplexers:
   * **a)** För hand med simulering i CircuitVerse.
   * **b)** I VHDL med simulering i ModelSim.

## Mål med lektionen
* Känna till multiplexerns konstruktion.
* Få mängdträna klassisk digitalteknik samt syntes och simulering i VHDL.

## Förutsättningar
* Genomgång av L06 - L11 för kunskaper om syntes och simulering i VHDL.

## Instruktioner

### Förberedelse
* Repetera materialet från L11.
* Läs [Bilaga A](#bilaga-a---logik-för-en-liten-multiplexer) nedan för information om konstruktion av en enkel multiplexer i VHDL.
* Vid behov, se gärna min tutorial [Syntes och simulering i VHDL](https://www.youtube.com/watch?v=gtaaarLyeXQ&authuser=0), som behandlar just syntes (konstruktion) samt simulering av ett bromsassistanssystem för fordon via ADAS (`Advanced Driver Assistance System`).

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter) nedan.

### Demonstration
* Varje del av övningsuppgiften gås igenom i helklass efter att ni fått tid att implementera den på egen hand.

## Utvärdering
* Vad tyckte ni var mest intressant eller lärorikt under lektionen?
* Har ni förslag på förbättringar eller önskemål inför kommande lektioner?

## Nästa lektion
* Konstruktion av AD-omvandlare med prioritetsavkodare.

---

## Bilaga A - Logik för en liten multiplexer

### Case-satsen i VHDL
För att implementera logiken för multiplexern kan vi använda en så kallad case-sats, vilket motsvarar switch-satsen i C.  
Switch-satsen i C har följande syntax för en multiplexer med insignaler `a` och `b`, selektorsignal `sel` samt utsignal `x`:

```c
switch (sel)
{
   case 0:
       x = b;
   case 1:
       x = a;
   default:
       x = 0;
}
```

Motsvarande case-sats i VHDL har följande syntax:

```vhdl
case (sel) is
    when '0'    => x <= b;
    when '1'    => x <= a;
    when others => x <= '0';
end case; 
```

***OBS!** Apostrofer används runt enskilda bitar i VHDL, så '0' innebär en bit som är lika med 0.*

Case-satsen måste placeras i ett sekventiellt block, vilket kallas `process` i VHDL. Processer har tidigare presenterats under [L06](../L06/README.md#process).

Nedan visas case-satsen placerad i en process, som aktiveras för förändring av `a`, `b` och `sel`.  
Om värdet på någon av dessa portar ändras kommer då följande block att exekvera:

```vhdl
process(ab, sel) is
begin
   case (sel) is
      when '0'    => x <= b;
      when '1'    => x <= a;
      when others => x <= '0';
   end case; 
end process;
```

### Konstruktion med case-satsen
Funktionaliteten för en liten 1-bitars multiplexer hade kunnat realiseras via en entity döpt `small_mux` såsom visas nedan:

```vhdl
entity small_mux is
    port(ab: in std_logic_vector(1 downto 0);
         sel: in std_logic;
         x: out std_logic);
end entity;
```

Modulen i fråga har följande portar:
* `ab[1:0]` utgörs av multiplexerns två insignaler `a` och `b` sammansatt till en 2-bitars vektor.
* `sel` utgör en selektorsignal, som avgör vilket av insignalerna som skrivs till utporten `x`.
* `x` utgör multiplexerns utsignal.

Notera att signalen `ab` är en 2-bitars vektor som motsvarar tidigare signaler `a` samt `b`:
* För att indikerar att detta är en 2-bitars vektor skriver man ofta `ab[1:0]`, där `1:0` utläses som `1 down to 0` och indikerar mest respektive minst signifikant bit.
* Den mest signifikanta biten av `ab[1:0]`, vilket är `ab[1]`, utgörs av `a`.
* Den minst signifikanta biten av `ab[1:0]`, vilket är `ab[0]`, utgörs av `b`.

I modulens arkitektur realiserar vi logiken för multiplexern via en case-sats, som placeras i en `process` döpt `MUX_PROCESS`.  
Processen i fråga exekverar vid förändring av någon av insignaler `ab` och `sel`, vilket implementeras genom att deklarera dessa portar i den så kallade känslighetslistan  
(innehållet i parentesen efter nyckelordet `process`):

```vhdl
architecture behaviour of small_mux is
begin
    MUX_PROCESS: process(ab, sel) is
    begin
        case (sel) is
            when '0'    => x <= ab(0);
            when '1'    => x <= ab(1);
            when others => x <= '0';
        end case;
    end process;
end architecture;
```

Via case-satsen ovan sätts utsignal `x` till:
   * `ab[0]` när `sel` = 0, 
   * `ab[1]` när `sel` = 1, 
   * 0 för övriga fall (om något går fel exempelvis).  

***Notering**: Det är valfritt att döpa processer, så `MUX_PROCESS:` ovan kan slopas.*

---

## Bilaga B - Övningsuppgifter

På mikrodatorn ATmega328P används en multiplexer för att analoga kanaler PORTC0 – PORTC7 ska kunna dela på en enda AD-omvandlare.

Enbart en av de analoga kanalernas insignaler släpps igenom till AD-omvandlaren vid ett givet tillfälle, vilket kontrolleras via selektorbitar `MUX[2:0]` i registret `ADMUX` (*ADC Multiplexer Select Register*) enligt tabellen nedan:

| MUX[2:0] | Kanal  |
|--------:|--------|
| 000 | PORTC0 |
| 001 | PORTC1 |
| 010 | PORTC2 |
| 011 | PORTC3 |
| 100 | PORTC4 |
| 101 | PORTC5 |
| 110 | PORTC6 |
| 111 | PORTC7 |

---

Vi ska i denna uppgift konstruera en sådan *8-to-1 multiplexer*  (*8-to-1* indikerar åtta inportar samt en utport).

För läsbarhetens skull sätter vi att:
* A - H = `PORTC[7:0]`
* S[2:0] = `MUX[2:0]`

Vi kan också beteckna multiplexerns utsignal till `X`.

Sanningstabellen ovan kan därmed skrivas om såsom visas nedan:

| S[2:0] | X |
|-------:|---|
| 000 | A |
| 001 | B |
| 010 | C |
| 011 | D |
| 100 | E |
| 101 | F |
| 110 | G |
| 111 | H |

---

**a)** Härled en logisk ekvation för multiplexerns utsignal `X` via insignaler `A - H` samt selektorbitar `S[2:0]`.

**b)** Simulera grindnätet i CircuitVerse, verifiera att konstruktionen fungerar korrekt.

**c)** Implementera konstruktionen i VHDL via en modul döpt `mux_8_to_1`:
* Placera projektet i en ny underkatalog `c/quartus/mux_8_to_1`.
* Döpt projektet till samma namn som toppmodulen (`mux_8_to_1`).
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).    

**d)** Verifiera konstruktionen på ett FPGA-kort. Anslut
* insignaler `A - H` till var sin slide-switch,
* selektorbitar `S[2:0]` till var sin tryckknapp,
* utsignal `X` till en lysdiod.

Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för PIN-nummer.

**OBS!** Tryckknapparna har **aktivt låg insignal**, så insignalen är låg vid nedtryckning.  
Detta kan lösas genom att använda **inverterande signaler** i toppmodulen.

---