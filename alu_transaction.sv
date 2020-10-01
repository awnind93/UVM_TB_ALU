class alu_transaction extends uvm_sequence_item;
  
  `uvm_object_utils(alu_transaction)
  
  randc bit [31:0] A,B;
  randc bit [2:0] Op_code;
  bit [31:0] Y;
  
  //constraint c1{wr_en inside {1};};
  //constraint c2{rd_en inside {0};};
  
  constraint A_c {A >=32'd0; A <=32'd100;};
  constraint B_c {B >=32'd0; B <=32'd100;};
  
  function new(string name = "");
    super.new(name);
  endfunction
  
endclass