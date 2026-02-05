# L27 - Konstruktion av tillståndsmaskiner (del II)

## Dagordning
* Konstruktion av tillståndsmaskiner i VHDL.

## Mål med lektionen
* Känna till hur tillståndsmaskiner är uppbyggda med hårdvarubeskrivande kod.

## Förutsättningar
* Genomgång av L26 för kunskaper tillståndsmaskiner i hårdvara.

## Instruktioner

### Förberedelse
* Repetera innehållet från L26.
* Läs [bilaga A](#bilaga-a---introduktion-till-tillståndsmaskiner-i-vhdl) för information om tillståndsmaskiner nedan.

### Under lektionen
* Genomför bifogade [övningsuppgifter](#bilaga-b---övningsuppgifter).

## Nästa lektion
* **P04** - Egenvalt projekt (del I).

---

## Bilaga A - Introduktion till tillståndsmaskiner i VHDL

En tillståndsmaskin, ofta förkortat `FSM` *(Finite State Machine)* är en algoritm som används för att implementera logik
innefattande multipla tillstånd. Som exempel, en tillståndsmaskin hade kunnat användas för att styra en lysdiod via tre tillstånd:
* `STATE_OFF`: Lysdioden är släckt.
* `STATE_BLINK`: Lysdioden blinkar var med en viss frekvens.
* `STATE_ON`: Lysdioden är tänd.

För att modellera tillståndsmaskinens olika tillstånd används ofta en enumererad typ i VHDL. Som exempel, ovanstående
tillstånd kan realiseras via en egenskapad typ döpt `state_t` så som visas nedan:

```vhdl
type state_t is (STATE_OFF, STATE_BLINK, STATE_ON);
```

Därefter används en signal av denna typ för att hålla aktuellt tillstånd. En sådan signal kan döpas till
exempelvis `state` eller `current_state`. Nedan implementeras en signal av typen `state_t` döpt state:

```vhdl
signal state: state_t;
```

Denna signal kan därefter tilldelas ett tillstånd, exempelvis `STATE_ON`, via en tilldelning:

```vhdl
state <= STATE_ON;
```

Oftast implementeras tillståndsmaskinens beteende via en case-sats, såsom visas i exemplet nedan.
Signaler `to_next_state` samt `to_prev_state` kan antas ha implementerats på så sätt att
de signaler när vi ska byta till nästa respektive föregående tillstånd:

```vhdl
process(clock, reset_s2_n) is
begin
    if (reset_s2_n = '0') then
        state <= STATE_OFF; -- Vid reset, sätt state till STATE_OFF.
    elsif (rising_edge(clock)) then
        case (state) is
            when STATE_OFF =>
                if (to_next_state = '1') then
                    state <= STATE_BLINK;
                elsif (to_prev_state = '1') then
                    state <= STATE_ON;
                end if;
            --- Här implementerar vi cases för STATE_BLINK samt STATE_ON.
            when others =>
                state <= STATE_OFF; -- Om något går fel, återställ state till STATE_OFF.
        end case;
    end if;
end process;
```

---

## Bilaga B - Övningsuppgifter
Du ska skapa en tillståndsmaskin för att kontrollera en lysdiod. Tillståndsmaskinen ska inneha tre tillstånd:
* `STATE_OFF`:  Lysdioden ska hållas släckt.
* `STATE_BLINK`: Lysdioden ska blinka var 100:e millisekund.
* `STATE_ON`: Lysdioden ska hållas tänd.

Tillståndsmaskinen är: 
* Av Moore-typ, där utsignalen enbart beror på aktuellt tillstånd.
* Sluten på så sätt att tillståndet efter `STATE_ON` är `STATE_OFF`. På samma sätt gäller att 
tillståndet före `STATE_OFF` är `STATE_ON`. 

### Portar
* En systemklocka döpt `clock` med en periodtid på `50 MHz` ska användas i konstruktionen.
* En inverterande reset-signal döpt `reset_n` ska användas för att återställa tillståndet till startläget `STATE_OFF`.
* En inverterande tryckknapp döpt `button1_n` ska användas för att byta till föregående tillstånd (vid fallande flank).
* En inverterande tryckknapp döpt `button2_n` ska användas för att byta till nästa tillstånd (vid fallande flank).
* En lysdiod döpt `led` ska styras utefter aktuellt tillstånd enligt beskrivningen ovan.

### Detaljer
* Kretsen ska implementeras synkront med en asynkron reset; samtliga signaler i kretsen uppdateras vid stigande flank på `clock` eller när `reset_n` är låg.
* När `reset_n` är låg ska systemåterställning ske, vilket innebär att samtliga signaler ska sättas i startläget (och `led` ska då släckas).
* Kretsen ska också göras mer robust via förebyggande av metastabilitet. För att åstadkomma detta ska *double flop*-metoden användas. Därmed ska varje insignal (förutom systemklockan) synkroniseras via två vippor var.

### Uppgifter

**a)** Implementera konstruktionen i VHDL via en modul döpt `fsm_led`:
* Placera projektet i en ny underkatalog `c/quartus/fsm_led`.
* Döpt projektet till samma namn som toppmodulen (`fsm_led`).
* Välj FPGA-kort Terasic DE0 (enhet `5CEBA4F23C7`).    

**b)** Verifiera konstruktionen på ett FPGA-kort. Anslut
* insignal `clock` till en `50 MHz` klockkrets,
* insignaler `reset_n`, `button1_n` samt `button2_n` till var sin tryckknapp,
* utsignal `led` till en lysdiod.

Se [databladet](../../manuals/DE0%20User%20ManuaL.pdf) för PIN-nummer.

---
