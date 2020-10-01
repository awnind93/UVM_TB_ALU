// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
`include "alu_interface.sv"
module top;
import uvm_pkg::*;
`include "alu_transaction.sv"
`include "alu_sequence.sv"
`include "alu_monitor.sv"
`include "alu_driver.sv"
`include "alu_scoreboard.sv"
`include "alu_bus_monitor.sv"
`include "alu_agent.sv"
`include "alu_env.sv"
`include "alu_test.sv"
  
  bit clk;

  intf arbif(clk);
  
  ALU dut (.A(arbif.A),.B(arbif.B),.Y(arbif.Y),.Op_code(arbif.Op_code));
  
  initial begin
    forever begin
      #5 clk = !clk;
    end
  end
  initial begin
    uvm_config_db#(virtual intf)::set(null,"*","vintf",arbif);
    run_test("alu_test");
  end


  
  initial begin
    // Dump waves
    $dumpvars(0, top);
  end
  
endmodule