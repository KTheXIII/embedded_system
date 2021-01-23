# Pulse-width Modulation (PWM)

Pulse Width Modulation (PWM) is a technique to imitate different power level by turning on a pin on and off at a constant frequency. How long the pin is off or on will determine the output power. We call the on time as duty cycle, since the on and off is happening in a cycle at a constant frequency.

Example PWM wave

```
   │  ON: 10%
5V │ ┌─┐                           ┌─┐
   │ │ │                           │ │
   │ │ │                           │ │
   │ │ │                           │ │
   │ │ │  OFF: 90%                 │ │
0V │ ┘ └───────────────────────────┘ └───────────────────────────
–––│–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––>
   │   Time
```

```
   │  ON: 25%
5V │ ┌───────┐                     ┌───────┐
   │ │       │                     │       │
   │ │       │                     │       │
   │ │       │                     │       │
   │ │       │  OFF: 75%           │       │
0V │ ┘       └─────────────────────┘       └─────────────────────
–––│–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––>
   │   Time
```

```
   │    ON: 50%
5V │ ┌──────────────┐              ┌──────────────┐
   │ │              │              │              │
   │ │              │              │              │
   │ │              │              │              │
   │ │              │  OFF: 50%    │              │
0V │ ┘              └──────────────┘              └──────────────
–––│–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––>
   │   Time
```
