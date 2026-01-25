`timescale 10ns / 1ps

module automatic_washing_machine_tb;

    // Inputs
    reg clk;
    reg reset;
    reg door_close;
    reg start;
    reg filled;
    reg detergent_added;
    reg cycle_timeout;
    reg drained;
    reg spin_timeout;

    // Outputs
    wire door_lock;
    wire motor_on;
    wire fill_value_on;
    wire drain_value_on;
    wire done;
    wire soap_wash;
    wire water_wash;

    // DUT instantiation (NAMED PORTS)
    automatic_washing_machine dut (
        .clk(clk),
        .reset(reset),
        .door_close(door_close),
        .start(start),
        .filled(filled),
        .detergent_added(detergent_added),
        .cycle_timeout(cycle_timeout),
        .drained(drained),
        .spin_timeout(spin_timeout),
        .door_lock(door_lock),
        .motor_on(motor_on),
        .fill_value_on(fill_value_on),
        .drain_value_on(drain_value_on),
        .done(done),
        .soap_wash(soap_wash),
        .water_wash(water_wash)
    );

    // Clock generation (100 ns period)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initial values
        clk = 0;
        reset = 1;
        start = 0;
        door_close = 0;
        filled = 0;
        detergent_added = 0;
        cycle_timeout = 0;
        drained = 0;
        spin_timeout = 0;

        // Reset
        #20 reset = 0;

        // Start machine
        @(posedge clk) start = 1;
            door_close = 1;

        // Fill water
        @(posedge clk)  filled = 1;

        // Add detergent
        @(posedge clk)  detergent_added = 1;

        // Washing cycle complete
        @(posedge clk)  cycle_timeout = 1;

        // Drain water
        @(posedge clk)  drained = 1;

        // Spin
        @(posedge clk)  spin_timeout = 1;

        // End simulation
        #100 $stop;
    end

    // Monitor
    initial begin
        $monitor(
            "T=%0t | state=%b | start=%b door=%b filled=%b detergent=%b cycle_to=%b drained=%b spin_to=%b | motor=%b fill=%b drain=%b soap=%b water=%b done=%b",
            $time,
            dut.current_state,
            start, door_close, filled, detergent_added,
            cycle_timeout, drained, spin_timeout,
            motor_on, fill_value_on, drain_value_on,
            soap_wash, water_wash, done
        );
    end

endmodule
