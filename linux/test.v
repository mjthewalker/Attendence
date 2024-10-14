// Flip-Flops and Counter Implementations

// JK Flip-Flop (Behavioral Model)
module JK_FF_Behavioral (
    input clk,
    input J,
    input K,
    input reset,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else begin
            case ({J, K})
                2'b00: Q <= Q;     // No change
                2'b01: Q <= 1'b0;  // Reset
                2'b10: Q <= 1'b1;  // Set
                2'b11: Q <= ~Q;    // Toggle
            endcase
        end
    end
endmodule

// SR Flip-Flop (Behavioral Model)
module SR_FF_Behavioral (
    input clk,
    input S,
    input R,
    input reset,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else begin
            if (S && ~R)
                Q <= 1'b1;  // Set
            else if (~S && R)
                Q <= 1'b0;  // Reset
        end
    end
endmodule

// D Flip-Flop (Behavioral Model)
module D_FF_Behavioral (
    input clk,
    input D,
    input reset,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule

// T Flip-Flop (Behavioral Model)
module T_FF_Behavioral (
    input clk,
    input T,
    input reset,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else if (T)
            Q <= ~Q;  // Toggle
    end
endmodule

// MOD-12 Asynchronous Up Counter using T Flip-Flop
module MOD12_UpCounter (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] T;

    // T flip-flops for each bit
    T_FF_Behavioral TFF0 (clk, 1'b1, reset, Q[0]);
    T_FF_Behavioral TFF1 (Q[0], 1'b1, reset, Q[1]);
    T_FF_Behavioral TFF2 (Q[1], 1'b1, reset, Q[2]);
    T_FF_Behavioral TFF3 (Q[2], 1'b1, reset, Q[3]);

    // Reset the counter at count 12 (1100)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1100)
            Q <= 4'b0000;
    end
endmodule

// MOD-13 Asynchronous Down Counter using T Flip-Flop
module MOD13_DownCounter (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] T;

    // T flip-flops for each bit
    T_FF_Behavioral TFF0 (clk, 1'b1, reset, Q[0]);
    T_FF_Behavioral TFF1 (Q[0], 1'b1, reset, Q[1]);
    T_FF_Behavioral TFF2 (Q[1], 1'b1, reset, Q[2]);
    T_FF_Behavioral TFF3 (Q[2], 1'b1, reset, Q[3]);

    // Reset the counter at count 13 (1101)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1101)
            Q <= 4'b0000;
    end
endmodule

// BCD Asynchronous Down Counter using T Flip-Flop
module BCD_DownCounter (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] T;

    // T flip-flops for each bit
    T_FF_Behavioral TFF0 (clk, 1'b1, reset, Q[0]);
    T_FF_Behavioral TFF1 (Q[0], 1'b1, reset, Q[1]);
    T_FF_Behavioral TFF2 (Q[1], 1'b1, reset, Q[2]);
    T_FF_Behavioral TFF3 (Q[2], 1'b1, reset, Q[3]);

    // Reset the counter at BCD 9 (1001)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1001)
            Q <= 4'b0000;
    end
endmodule
// Flip-Flops and Counter Implementations using Gate-level modeling

// JK Flip-Flop (Gate-Level Model)
module JK_FF_Gate (
    input clk,
    input J,
    input K,
    input reset,
    output Q,
    output Qn
);
    wire S, R, Q_int, Qn_int;

    // NAND gate logic for JK Flip-Flop
    assign S = ~(J & clk & Qn_int);  // Set condition
    assign R = ~(K & clk & Q_int);   // Reset condition

    // SR latch logic
    assign Q_int = ~(S & Qn_int);
    assign Qn_int = ~(R & Q_int);

    // Handle reset
    assign Q = reset ? 1'b0 : Q_int;
    assign Qn = reset ? 1'b1 : Qn_int;

endmodule

// SR Flip-Flop (Gate-Level Model)
module SR_FF_Gate (
    input clk,
    input S,
    input R,
    input reset,
    output Q,
    output Qn
);
    wire Q_int, Qn_int;

    // SR latch logic
    assign Q_int = ~(S & clk & Qn_int);
    assign Qn_int = ~(R & clk & Q_int);

    // Handle reset
    assign Q = reset ? 1'b0 : Q_int;
    assign Qn = reset ? 1'b1 : Qn_int;

endmodule

// D Flip-Flop (Gate-Level Model)
module D_FF_Gate (
    input clk,
    input D,
    input reset,
    output Q,
    output Qn
);
    wire S, R;

    // D Flip-Flop as gated SR Flip-Flop
    assign S = D & clk;
    assign R = ~D & clk;

    SR_FF_Gate SR_FF_inst (
        .clk(clk),
        .S(S),
        .R(R),
        .reset(reset),
        .Q(Q),
        .Qn(Qn)
    );

endmodule

// T Flip-Flop (Gate-Level Model)
module T_FF_Gate (
    input clk,
    input T,
    input reset,
    output Q,
    output Qn
);
    wire D;

    // Toggle Flip-Flop logic using D Flip-Flop
    assign D = T ? ~Q : Q;

    D_FF_Gate D_FF_inst (
        .clk(clk),
        .D(D),
        .reset(reset),
        .Q(Q),
        .Qn(Qn)
    );

endmodule

// MOD-12 Asynchronous Up Counter using Gate-Level T Flip-Flop
module MOD12_UpCounter_Gate (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] Qn;

    // Instantiate T flip-flops for each bit
    T_FF_Gate TFF0 (clk, 1'b1, reset, Q[0], Qn[0]);
    T_FF_Gate TFF1 (Q[0], 1'b1, reset, Q[1], Qn[1]);
    T_FF_Gate TFF2 (Q[1], 1'b1, reset, Q[2], Qn[2]);
    T_FF_Gate TFF3 (Q[2], 1'b1, reset, Q[3], Qn[3]);

    // Reset the counter at count 12 (1100)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1100)
            Q <= 4'b0000;
    end
endmodule

// MOD-13 Asynchronous Down Counter using Gate-Level T Flip-Flop
module MOD13_DownCounter_Gate (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] Qn;

    // Instantiate T flip-flops for each bit
    T_FF_Gate TFF0 (clk, 1'b1, reset, Q[0], Qn[0]);
    T_FF_Gate TFF1 (Q[0], 1'b1, reset, Q[1], Qn[1]);
    T_FF_Gate TFF2 (Q[1], 1'b1, reset, Q[2], Qn[2]);
    T_FF_Gate TFF3 (Q[2], 1'b1, reset, Q[3], Qn[3]);

    // Reset the counter at count 13 (1101)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1101)
            Q <= 4'b0000;
    end
endmodule

// BCD Asynchronous Down Counter using Gate-Level T Flip-Flop
module BCD_DownCounter_Gate (
    input clk,
    input reset,
    output [3:0] Q
);
    wire [3:0] Qn;

    // Instantiate T flip-flops for each bit
    T_FF_Gate TFF0 (clk, 1'b1, reset, Q[0], Qn[0]);
    T_FF_Gate TFF1 (Q[0], 1'b1, reset, Q[1], Qn[1]);
    T_FF_Gate TFF2 (Q[1], 1'b1, reset, Q[2], Qn[2]);
    T_FF_Gate TFF3 (Q[2], 1'b1, reset, Q[3], Qn[3]);


    // Reset the counter at BCD 9 (1001)
    always @(posedge clk or posedge reset) begin
        if (reset || Q == 4'b1001)
            Q <= 4'b0000;
    end
endmodule


