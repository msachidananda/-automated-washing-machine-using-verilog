`timescale 10ns / 1ps

module automatic_washing_machine (
    input  wire clk,
    input  wire reset,
    input  wire door_close,
    input  wire start,
    input  wire filled,
    input  wire detergent_added,
    input  wire cycle_timeout,
    input  wire drained,
    input  wire spin_timeout,

    output reg  door_lock,
    output reg  motor_on,
    output reg  fill_value_on,
    output reg  drain_value_on,
    output reg  done,
    output reg  soap_wash,
    output reg  water_wash
);

    // ==========================
    // State encoding
    // ==========================
    localparam CHECK_DOOR    = 3'd0,
               FILL_WATER    = 3'd1,
               ADD_DETERGENT = 3'd2,
               WASH_CYCLE    = 3'd3,
               DRAIN_WATER   = 3'd4,
               SPIN          = 3'd5,
               DONE_STATE    = 3'd6;

    reg [2:0] current_state, next_state;

    // ==========================
    // 1️⃣ State Register
    // ==========================
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= CHECK_DOOR;
        else
            current_state <= next_state;
    end

    // ==========================
    // 2️⃣ Next State Logic
    // ==========================
    always @(*) begin
        next_state = current_state;

        case (current_state)
            CHECK_DOOR:
                if (start && door_close)
                    next_state = FILL_WATER;

            FILL_WATER:
                if (filled)
                    next_state = ADD_DETERGENT;

            ADD_DETERGENT:
                if (detergent_added)
                    next_state = WASH_CYCLE;

            WASH_CYCLE:
                if (cycle_timeout)
                    next_state = DRAIN_WATER;

            DRAIN_WATER:
                if (drained)
                    next_state = SPIN;

            SPIN:
                if (spin_timeout)
                    next_state = DONE_STATE;

            DONE_STATE:
                next_state = CHECK_DOOR;

            default:
                next_state = CHECK_DOOR;
        endcase
    end

    // ==========================
    // 3️⃣ Output Logic (Moore)
    // ==========================
    always @(*) begin
        // Default outputs
        door_lock       = 0;
        motor_on        = 0;
        fill_value_on   = 0;
        drain_value_on  = 0;
        done            = 0;
        soap_wash       = 0;
        water_wash      = 0;

        case (current_state)
            CHECK_DOOR: begin
                door_lock = 0;
            end

            FILL_WATER: begin
                door_lock     = 1;
                fill_value_on = 1;
            end

            ADD_DETERGENT: begin
                door_lock = 1;
                soap_wash = 1;
            end

            WASH_CYCLE: begin
                door_lock  = 1;
                motor_on   = 1;
                soap_wash  = 1;
            end

            DRAIN_WATER: begin
                door_lock      = 1;
                drain_value_on = 1;
            end

            SPIN: begin
                door_lock      = 1;
                motor_on       = 1;
                water_wash     = 1;
            end

            DONE_STATE: begin
                door_lock = 0;
                done      = 1;
            end
        endcase
    end

endmodule
