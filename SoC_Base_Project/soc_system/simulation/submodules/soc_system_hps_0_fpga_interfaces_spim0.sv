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
// output_name:                                       soc_system_hps_0_fpga_interfaces_spim0
// role:width:direction:                              spim0_txd:1:Output,spim0_rxd:1:Input,spim0_ss_in_n:1:Input,spim0_ssi_oe_n:1:Output,spim0_ss_0_n:1:Output,spim0_ss_1_n:1:Output,spim0_ss_2_n:1:Output,spim0_ss_3_n:1:Output
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_system_hps_0_fpga_interfaces_spim0
(
   sig_spim0_txd,
   sig_spim0_rxd,
   sig_spim0_ss_in_n,
   sig_spim0_ssi_oe_n,
   sig_spim0_ss_0_n,
   sig_spim0_ss_1_n,
   sig_spim0_ss_2_n,
   sig_spim0_ss_3_n
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output sig_spim0_txd;
   input sig_spim0_rxd;
   input sig_spim0_ss_in_n;
   output sig_spim0_ssi_oe_n;
   output sig_spim0_ss_0_n;
   output sig_spim0_ss_1_n;
   output sig_spim0_ss_2_n;
   output sig_spim0_ss_3_n;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_spim0_txd_t;
   typedef logic ROLE_spim0_rxd_t;
   typedef logic ROLE_spim0_ss_in_n_t;
   typedef logic ROLE_spim0_ssi_oe_n_t;
   typedef logic ROLE_spim0_ss_0_n_t;
   typedef logic ROLE_spim0_ss_1_n_t;
   typedef logic ROLE_spim0_ss_2_n_t;
   typedef logic ROLE_spim0_ss_3_n_t;

   reg sig_spim0_txd_temp;
   reg sig_spim0_txd_out;
   logic [0 : 0] sig_spim0_rxd_in;
   logic [0 : 0] sig_spim0_rxd_local;
   logic [0 : 0] sig_spim0_ss_in_n_in;
   logic [0 : 0] sig_spim0_ss_in_n_local;
   reg sig_spim0_ssi_oe_n_temp;
   reg sig_spim0_ssi_oe_n_out;
   reg sig_spim0_ss_0_n_temp;
   reg sig_spim0_ss_0_n_out;
   reg sig_spim0_ss_1_n_temp;
   reg sig_spim0_ss_1_n_out;
   reg sig_spim0_ss_2_n_temp;
   reg sig_spim0_ss_2_n_out;
   reg sig_spim0_ss_3_n_temp;
   reg sig_spim0_ss_3_n_out;

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
   
   event signal_input_spim0_rxd_change;
   event signal_input_spim0_ss_in_n_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // spim0_txd
   // -------------------------------------------------------

   function automatic void set_spim0_txd (
      ROLE_spim0_txd_t new_value
   );
      // Drive the new value to spim0_txd.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_txd_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // spim0_rxd
   // -------------------------------------------------------
   function automatic ROLE_spim0_rxd_t get_spim0_rxd();
   
      // Gets the spim0_rxd input value.
      $sformat(message, "%m: called get_spim0_rxd");
      print(VERBOSITY_DEBUG, message);
      return sig_spim0_rxd_in;
      
   endfunction

   // -------------------------------------------------------
   // spim0_ss_in_n
   // -------------------------------------------------------
   function automatic ROLE_spim0_ss_in_n_t get_spim0_ss_in_n();
   
      // Gets the spim0_ss_in_n input value.
      $sformat(message, "%m: called get_spim0_ss_in_n");
      print(VERBOSITY_DEBUG, message);
      return sig_spim0_ss_in_n_in;
      
   endfunction

   // -------------------------------------------------------
   // spim0_ssi_oe_n
   // -------------------------------------------------------

   function automatic void set_spim0_ssi_oe_n (
      ROLE_spim0_ssi_oe_n_t new_value
   );
      // Drive the new value to spim0_ssi_oe_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_ssi_oe_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // spim0_ss_0_n
   // -------------------------------------------------------

   function automatic void set_spim0_ss_0_n (
      ROLE_spim0_ss_0_n_t new_value
   );
      // Drive the new value to spim0_ss_0_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_ss_0_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // spim0_ss_1_n
   // -------------------------------------------------------

   function automatic void set_spim0_ss_1_n (
      ROLE_spim0_ss_1_n_t new_value
   );
      // Drive the new value to spim0_ss_1_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_ss_1_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // spim0_ss_2_n
   // -------------------------------------------------------

   function automatic void set_spim0_ss_2_n (
      ROLE_spim0_ss_2_n_t new_value
   );
      // Drive the new value to spim0_ss_2_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_ss_2_n_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // spim0_ss_3_n
   // -------------------------------------------------------

   function automatic void set_spim0_ss_3_n (
      ROLE_spim0_ss_3_n_t new_value
   );
      // Drive the new value to spim0_ss_3_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_spim0_ss_3_n_temp = new_value;
   endfunction

   assign sig_spim0_txd = sig_spim0_txd_temp;
   assign sig_spim0_rxd_in = sig_spim0_rxd;
   assign sig_spim0_ss_in_n_in = sig_spim0_ss_in_n;
   assign sig_spim0_ssi_oe_n = sig_spim0_ssi_oe_n_temp;
   assign sig_spim0_ss_0_n = sig_spim0_ss_0_n_temp;
   assign sig_spim0_ss_1_n = sig_spim0_ss_1_n_temp;
   assign sig_spim0_ss_2_n = sig_spim0_ss_2_n_temp;
   assign sig_spim0_ss_3_n = sig_spim0_ss_3_n_temp;


   always @(sig_spim0_rxd_in) begin
      if (sig_spim0_rxd_local != sig_spim0_rxd_in)
         -> signal_input_spim0_rxd_change;
      sig_spim0_rxd_local = sig_spim0_rxd_in;
   end
   
   always @(sig_spim0_ss_in_n_in) begin
      if (sig_spim0_ss_in_n_local != sig_spim0_ss_in_n_in)
         -> signal_input_spim0_ss_in_n_change;
      sig_spim0_ss_in_n_local = sig_spim0_ss_in_n_in;
   end
   


// synthesis translate_on

endmodule

