// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       soc_system_hps_0_fpga_interfaces_uart1
// role:width:direction:                              uart1_cts:1:Input,uart1_dsr:1:Input,uart1_dcd:1:Input,uart1_ri:1:Input,uart1_dtr:1:Output,uart1_rts:1:Output,uart1_out1_n:1:Output,uart1_out2_n:1:Output,uart1_rxd:1:Input,uart1_txd:1:Output
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_system_hps_0_fpga_interfaces_uart1
(
   sig_uart1_cts,
   sig_uart1_dsr,
   sig_uart1_dcd,
   sig_uart1_ri,
   sig_uart1_dtr,
   sig_uart1_rts,
   sig_uart1_out1_n,
   sig_uart1_out2_n,
   sig_uart1_rxd,
   sig_uart1_txd
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_uart1_cts;
   input sig_uart1_dsr;
   input sig_uart1_dcd;
   input sig_uart1_ri;
   output sig_uart1_dtr;
   output sig_uart1_rts;
   output sig_uart1_out1_n;
   output sig_uart1_out2_n;
   input sig_uart1_rxd;
   output sig_uart1_txd;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_uart1_cts_t;
   typedef logic ROLE_uart1_dsr_t;
   typedef logic ROLE_uart1_dcd_t;
   typedef logic ROLE_uart1_ri_t;
   typedef logic ROLE_uart1_dtr_t;
   typedef logic ROLE_uart1_rts_t;
   typedef logic ROLE_uart1_out1_n_t;
   typedef logic ROLE_uart1_out2_n_t;
   typedef logic ROLE_uart1_rxd_t;
   typedef logic ROLE_uart1_txd_t;

   logic [0 : 0] sig_uart1_cts_in;
   logic [0 : 0] sig_uart1_cts_local;
   logic [0 : 0] sig_uart1_dsr_in;
   logic [0 : 0] sig_uart1_dsr_local;
   logic [0 : 0] sig_uart1_dcd_in;
   logic [0 : 0] sig_uart1_dcd_local;
   logic [0 : 0] sig_uart1_ri_in;
   logic [0 : 0] sig_uart1_ri_local;
   reg sig_uart1_dtr_temp;
   reg sig_uart1_dtr_out;
   reg sig_uart1_rts_temp;
   reg sig_uart1_rts_out;
   reg sig_uart1_out1_n_temp;
   reg sig_uart1_out1_n_out;
   reg sig_uart1_out2_n_temp;
   reg sig_uart1_out2_n_out;
   logic [0 : 0] sig_uart1_rxd_in;
   logic [0 : 0] sig_uart1_rxd_local;
   reg sig_uart1_txd_temp;
   reg sig_uart1_txd_out;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_uart1_cts_change;
   event signal_input_uart1_dsr_change;
   event signal_input_uart1_dcd_change;
   event signal_input_uart1_ri_change;
   event signal_input_uart1_rxd_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // uart1_cts
   // -------------------------------------------------------
   function automatic ROLE_uart1_cts_t get_uart1_cts();
   
      // Gets the uart1_cts input value.
      $sformat(message, "%m: called get_uart1_cts");
      print(VERBOSITY_DEBUG, message);
      return sig_uart1_cts_in;
      
   endfunction

   // -------------------------------------------------------
   // uart1_dsr
   // -------------------------------------------------------
   function automatic ROLE_uart1_dsr_t get_uart1_dsr();
   
      // Gets the uart1_dsr input value.
      $sformat(message, "%m: called get_uart1_dsr");
      print(VERBOSITY_DEBUG, message);
      return sig_uart1_dsr_in;
      
   endfunction

   // -------------------------------------------------------
   // uart1_dcd
   // -------------------------------------------------------
   function automatic ROLE_uart1_dcd_t get_uart1_dcd();
   
      // Gets the uart1_dcd input value.
      $sformat(message, "%m: called get_uart1_dcd");
      print(VERBOSITY_DEBUG, message);
      return sig_uart1_dcd_in;
      
   endfunction

   // -------------------------------------------------------
   // uart1_ri
   // -------------------------------------------------------
   function automatic ROLE_uart1_ri_t get_uart1_ri();
   
      // Gets the uart1_ri input value.
      $sformat(message, "%m: called get_uart1_ri");
      print(VERBOSITY_DEBUG, message);
      return sig_uart1_ri_in;
      
   endfunction

   // -------------------------------------------------------
   // uart1_dtr
   // -------------------------------------------------------

   function automatic void set_uart1_dtr (
      ROLE_uart1_dtr_t new_value
   );
      // Drive the new value to uart1_dtr.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_uart1_dtr_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // uart1_rts
   // -------------------------------------------------------

   function automatic void set_uart1_rts (
      ROLE_uart1_rts_t new_value
   );
      // Drive the new value to uart1_rts.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_uart1_rts_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // uart1_out1_n
   // -------------------------------------------------------

   function automatic void set_uart1_out1_n (
      ROLE_uart1_out1_n_t new_value
   );
      // Drive the new value to uart1_out1_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_uart1_out1_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // uart1_out2_n
   // -------------------------------------------------------

   function automatic void set_uart1_out2_n (
      ROLE_uart1_out2_n_t new_value
   );
      // Drive the new value to uart1_out2_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_uart1_out2_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // uart1_rxd
   // -------------------------------------------------------
   function automatic ROLE_uart1_rxd_t get_uart1_rxd();
   
      // Gets the uart1_rxd input value.
      $sformat(message, "%m: called get_uart1_rxd");
      print(VERBOSITY_DEBUG, message);
      return sig_uart1_rxd_in;
      
   endfunction

   // -------------------------------------------------------
   // uart1_txd
   // -------------------------------------------------------

   function automatic void set_uart1_txd (
      ROLE_uart1_txd_t new_value
   );
      // Drive the new value to uart1_txd.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_uart1_txd_temp = new_value;
   endfunction

   assign sig_uart1_cts_in = sig_uart1_cts;
   assign sig_uart1_dsr_in = sig_uart1_dsr;
   assign sig_uart1_dcd_in = sig_uart1_dcd;
   assign sig_uart1_ri_in = sig_uart1_ri;
   assign sig_uart1_dtr = sig_uart1_dtr_temp;
   assign sig_uart1_rts = sig_uart1_rts_temp;
   assign sig_uart1_out1_n = sig_uart1_out1_n_temp;
   assign sig_uart1_out2_n = sig_uart1_out2_n_temp;
   assign sig_uart1_rxd_in = sig_uart1_rxd;
   assign sig_uart1_txd = sig_uart1_txd_temp;


   always @(sig_uart1_cts_in) begin
      if (sig_uart1_cts_local != sig_uart1_cts_in)
         -> signal_input_uart1_cts_change;
      sig_uart1_cts_local = sig_uart1_cts_in;
   end
   
   always @(sig_uart1_dsr_in) begin
      if (sig_uart1_dsr_local != sig_uart1_dsr_in)
         -> signal_input_uart1_dsr_change;
      sig_uart1_dsr_local = sig_uart1_dsr_in;
   end
   
   always @(sig_uart1_dcd_in) begin
      if (sig_uart1_dcd_local != sig_uart1_dcd_in)
         -> signal_input_uart1_dcd_change;
      sig_uart1_dcd_local = sig_uart1_dcd_in;
   end
   
   always @(sig_uart1_ri_in) begin
      if (sig_uart1_ri_local != sig_uart1_ri_in)
         -> signal_input_uart1_ri_change;
      sig_uart1_ri_local = sig_uart1_ri_in;
   end
   
   always @(sig_uart1_rxd_in) begin
      if (sig_uart1_rxd_local != sig_uart1_rxd_in)
         -> signal_input_uart1_rxd_change;
      sig_uart1_rxd_local = sig_uart1_rxd_in;
   end
   


// synthesis translate_on

endmodule

