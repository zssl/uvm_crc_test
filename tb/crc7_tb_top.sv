`include "uvm_pkg.sv"
`include "crc7_pkg.sv"
`include "crc7.v"
`include "crc7_if.sv"

module crc7_tb_top;
  import uvm_pkg::*;
  import crc7_pkg::*;
  
  //interface declaration
  crc7_if vif();
  
  //connect the interface to the DUT
  crc7 dut(vif.sig_clk,
  vif.sig_rst,
  vif.sig_data,
  vif.sig_crc);
  
  initial begin
    uvm_resource_db#(virtual crc7_if)::set
      (.scope("ifs"), .name("crc7_if"), .val(vif));
      
    run_test("crc7_test");
  end
  
  initial begin
    vif.sig_clk <= 1'b1;
  end
  
  always
    #5 vif.sig_clk =~ vif.sig_clk;
  endmodule
  
    
  
