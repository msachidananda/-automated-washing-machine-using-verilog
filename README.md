# Automated Washing Machine using Verilog

## 📌 Overview
This project implements an **Automated Washing Machine Controller** using Verilog, designed as a **Finite State Machine (FSM)**. The system simulates the real-world working of a washing machine by managing sequential operations such as water filling, detergent addition, washing, draining, and spinning.

The design ensures **safe operation, proper sequencing, and efficient control** of all washing stages based on sensor inputs and timing signals.

---

## 🚀 Key Features

- **FSM-Based Control System**
  - Ensures proper sequencing of washing operations
  - Transitions between states based on sensor inputs and timers

- **Sensor-Driven Automation**
  - Responds to real-time inputs such as:
    - Door status
    - Water level
    - Detergent presence
    - Drain completion

- **Safety Mechanisms**
  - Door locking during operation
  - Prevents execution unless door is closed

- **Stage-wise Operation Indicators**
  - Separate outputs for:
    - Soap wash
    - Water wash (spin stage)

---

## 🧠 System Architecture

The system is implemented as a **Moore FSM**, where outputs depend on the current state.

### Main Module: `washing_machine_fsm.v`
- Contains:
  - State definitions
  - State transition logic
  - Output control logic
- Controls the entire washing sequence

---

## ⚙️ Inputs and Outputs

### 🔹 Inputs

| Signal Name        | Description |
|------------------|------------|
| `clk`            | System clock |
| `reset`          | Resets FSM to initial state (`CHECK_DOOR`) |
| `door_close`     | Indicates whether the door is closed |
| `start`          | Start button signal |
| `filled`         | Water level sensor (tank full) |
| `detergent_added`| Indicates detergent has been added |
| `cycle_timeout`  | Washing cycle completion signal |
| `drained`        | Indicates water has been drained |
| `spin_timeout`   | Spin cycle completion signal |

---

### 🔹 Outputs

| Signal Name        | Description |
|------------------|------------|
| `door_lock`      | Locks the door during operation |
| `motor_on`       | Controls washing/spin motor |
| `fill_value_on`  | Activates water inlet valve |
| `drain_value_on` | Activates drain valve |
| `done`           | Indicates completion of washing cycle |
| `soap_wash`      | Indicates washing with detergent |
| `water_wash`     | Indicates spinning stage |

---

## 🔄 FSM States and Operation

### 1. `CHECK_DOOR`
- Initial state after reset
- Waits for:
  - Door to be closed
  - Start signal
- Transitions to `FILL_WATER`

---

### 2. `FILL_WATER`
- Opens water inlet valve
- Waits until `filled = 1`
- Moves to `ADD_DETERGENT`

---

### 3. `ADD_DETERGENT`
- Waits for detergent input (`detergent_added = 1`)
- Ensures proper washing conditions
- Transitions to `WASH_CYCLE`

---

### 4. `WASH_CYCLE`
- Activates:
  - Motor (`motor_on = 1`)
  - Soap wash indicator
- Runs until `cycle_timeout = 1`
- Moves to `DRAIN_WATER`

---

### 5. `DRAIN_WATER`
- Opens drain valve
- Waits until `drained = 1`
- Transitions to `SPIN`

---

### 6. `SPIN`
- Spins clothes to remove excess water
- Activates:
  - Motor
  - Water wash indicator
- Runs until `spin_timeout = 1`
- Moves to `DONE_STATE`

---

### 7. `DONE_STATE`
- Washing process completed
- Actions:
  - Turns off all actuators
  - Unlocks door
  - Sets `done = 1`
- Returns to `CHECK_DOOR` for next cycle

---

## 📊 Design Highlights

- **Deterministic Control:** FSM ensures predictable behavior
- **Modular Design:** Easy to expand with additional features (e.g., rinse cycles)
- **Hardware Efficient:** Minimal logic with clear state transitions
- **Real-World Mapping:** Closely resembles actual washing machine operation

---

## 📈 Applications

- Home appliance controllers
- Embedded system design learning
- FSM-based control system projects
- Digital logic and hardware design demonstrations

---

## 📌 Future Enhancements

- Add multiple washing modes (quick wash, heavy wash)
- Introduce temperature control
- Include rinse cycles
- Add display interface (LCD/7-segment)
- Integrate IoT-based remote control


