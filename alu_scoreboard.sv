`uvm_analysis_imp_decl(_exp_data)
`uvm_analysis_imp_decl(_act_data)

class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)
  
  uvm_analysis_imp_exp_data#(alu_transaction, alu_scoreboard) ap_exp_data_export;
  uvm_analysis_imp_act_data#(alu_transaction, alu_scoreboard) ap_act_data_export;
  
  alu_transaction exp_que[$];
  
  function  new(string name, uvm_component parent);
    super.new(name,parent);
    ap_exp_data_export=new("ap_exp_data_export",this);
    ap_act_data_export=new("ap_act_data_export",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write_act_data(input alu_transaction tr);
    alu_transaction exp_tr;
    if(exp_que.size()) begin
      exp_tr = exp_que.pop_front();
      if(tr.compare(exp_tr))begin
        `uvm_info("",$sformatf("MATCHED"),UVM_LOW);
      end
      else begin
        `uvm_error("","MISMATCHED");
      end
    end
    else begin
      `uvm_info("",$sformatf("No more data items in queue"),UVM_LOW);
    end
  endfunction
  
  function void write_exp_data(input alu_transaction tr);
    exp_que.push_back(tr);
  endfunction
  
endclass
    
