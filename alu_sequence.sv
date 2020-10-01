class alu_sequence extends uvm_sequence#(alu_transaction);  
  `uvm_object_utils(alu_sequence)
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    repeat(5) begin
      `uvm_do(req)
    end
  endtask
endclass