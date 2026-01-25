# automated-washing-machine-using-verilog
This Verilog module implements a finite state machine (FSM) to control an automatic washing machine. The design manages the sequential operation of the washing process based on inputs such as door status, water fill status, detergent addition, cycle timers, and water drainage.

Inputs--

clk — System clock
reset — System reset, initializes FSM to CHECK_DOOR
door_close — Sensor indicating door is closed
start — Start button signal
filled — Water level sensor
detergent_added — Detergent detection input
cycle_timeout — Washing cycle timer done
drained — Drain completion sensor
spin_timeout — Spin cycle timer done

Outputs--
door_lock — Locks the door during washing
motor_on — Controls the washing/spin motor
fill_value_on — Controls water fill valve
drain_value_on — Controls drain valve
done — Signals washing completion
soap_wash — Indicates soap washing stage
water_wash — Indicates spinning with water stage

states--
CHECK_DOOR: Wait for the door to be closed and start signal.
FILL_WATER: Open water valve until filled.
ADD_DETERGENT: Wait for detergent to be added.
WASH_CYCLE: Run motor with soap washing for a set cycle time.
DRAIN_WATER: Open drain valve until water is drained.
SPIN: Spin the clothes to remove excess water.
DONE_STATE: Indicate cycle completion and unlock door.
