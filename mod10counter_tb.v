///testbench
module mod10counter_tb();

  reg clk;
  reg reset;
  wire [3:0] q;


  mod10counter dut (.clk(clk), .reset(reset), .q(q));

  initial begin
    $dumpfile("mod10counter.vcd");
    $dumpvars;
  end

  initial begin
    clk=0;
    forever #10 clk= ~clk;
  end


  initial begin
    reset=0;
    #30
    reset=1;
    #200
    reset=0;
    #100
    reset=1;
    #250
    reset=0;
    #50
    reset=1;
    #500
    $finsh;
  end
endmodule

    
    
  
