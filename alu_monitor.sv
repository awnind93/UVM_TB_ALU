class alu_monitor extends uvm_monitor;
  
  `uvm_component_utils(alu_monitor)
  
  uvm_analysis_port#(alu_transaction) item_collected_port; 
  
  virtual intf vintf;
  alu_transaction alu_trans;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    alu_trans = new();
    item_collected_port=new("item_collected_port",this);
  endfunction
  
 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"","vintf",vintf)) begin
      `uvm_error("","uvm_get_config interface failed\n");
    end
  endfunction
   
  virtual task run_phase(uvm_phase phase);
     super.run_phase(phase);
     begin
       forever begin
         @(posedge vintf.clk);
         alu_trans.A = vintf.A;
         alu_trans.B = vintf.B;
         alu_trans.Op_code = vintf.Op_code;
         item_collected_port.write(alu_trans);
         `uvm_info("",$sformatf("Monitor: A is %d Monitor: B is %d Monitor: Opcode is %d\n",vintf.A,vintf.B,vintf.Op_code), UVM_LOW)
         @(posedge vintf.clk);
     end
     end
  endtask
endclass