class alu_env extends uvm_env;
  
  `uvm_component_utils(alu_env)
  
  //uvm_tlm_port#(alu_transaction) drv2sb_export;
  //uvm_tlm_port#(alu_transaction) mon2sb_export;
  
  alu_agent agent;
  alu_bus_monitor bus_monitor;
  alu_scoreboard scoreboard;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent=alu_agent::type_id::create("agent",this);
    bus_monitor= alu_bus_monitor::type_id::create("bus_monitor",this);
    scoreboard= alu_scoreboard::type_id::create("scoreboard",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(scoreboard.ap_exp_data_export);
    bus_monitor.ap.connect(scoreboard.ap_act_data_export);
  endfunction
  
endclass
    
