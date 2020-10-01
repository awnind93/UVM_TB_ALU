class alu_bus_monitor extends uvm_monitor;
  
  `uvm_component_utils(alu_bus_monitor)
  
  uvm_analysis_port#(alu_transaction) ap;
  
  virtual intf vintf;
  alu_transaction alu_trans;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    ap=new("ap",this);
    alu_trans=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"*","vintf", vintf)) begin
      `uvm_error("","BUS_MONITOR interface failed")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    begin
    forever begin
      @(posedge vintf.clk);
      alu_trans.Y = vintf.Y;
      `uvm_info("",$sformatf("BusMonitor: Y is %d\n", vintf.Y), UVM_MEDIUM)
      ap.write(alu_trans);
    end
    end
  endtask
endclass