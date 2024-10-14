module tb_flipflops_counters;

    // Clock and reset signals
    reg clk, reset;
    wire [3:0] Q_up, Q_down, Q_bcd;

    // Instantiate MOD-12 Up Counter
    MOD12_UpCounter up_counter (
        .clk(clk),
        .reset(reset),
        .Q(Q_up)
    );

    // Instantiate MOD-13 Down Counter
    MOD13_DownCounter down_counter (
        .clk(clk),
        .reset(reset),
        .Q(Q_down)
    );

    // Instantiate BCD Down Counter
    BCD_DownCounter bcd_counter (
        .clk(clk),
        .reset(reset),
        .Q(Q_bcd)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0;  // Release reset after 10 time units

        // Let the counters run for some time
        #1000 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0d | MOD12_Up=%b | MOD13_Down=%b | BCD_Down=%b", $time, Q_up, Q_down, Q_bcd);
    end

endmodule
