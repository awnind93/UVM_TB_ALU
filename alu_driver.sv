class alu_driver extends uvm_driver#(alu_transaction);
  
  `uvm_component_utils(alu_driver)
    
  virtual intf vintf;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"","vintf",vintf)) begin
      `uvm_error("","iDriver:uvm_get_config interface failed\n");
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
     begin
       forever begin
       seq_item_port.get_next_item(req);
       vintf.A = req.A;
       vintf.B = req.B;
       vintf.Op_code = req.Op_code;
         `uvm_info("",$sformatf("Diver: A is %d B is %d Op_code is %d", vintf.A,vintf.B,vintf.Op_code), UVM_MEDIUM)
         @(posedge vintf.clk);
         seq_item_port.item_done();
       end
     end
  endtask
  
endclass
       
           
       
       