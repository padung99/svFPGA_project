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
// output_name:                                       soc_system_hps_0_fpga_interfaces_i2c2
// role:width:direction:                              i2c_emac0_out_data:1:Output,i2c_emac0_sda:1:Input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_system_hps_0_fpga_interfaces_i2c2
(
   sig_i2c_emac0_out_data,
   sig_i2c_emac0_sda
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output sig_i2c_emac0_out_data;
   input sig_i2c_emac0_sda;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_i2c_emac0_out_data_t;
   typedef logic ROLE_i2c_emac0_sda_t;

   reg sig_i2c_emac0_out_data_temp;
   reg sig_i2c_emac0_out_data_out;
   logic [0 : 0] sig_i2c_emac0_sda_in;
   logic [0 : 0] sig_i2c_emac0_sda_local;

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
   
   event signal_input_i2c_emac0_sda_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // i2c_emac0_out_data
   // -------------------------------------------------------

   function automatic void set_i2c_emac0_out_data (
      ROLE_i2c_emac0_out_data_t new_value
   );
      // Drive the new value to i2c_emac0_out_data.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_i2c_emac0_out_data_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // i2c_emac0_sda
   // -------------------------------------------------------
   function automatic ROLE_i2c_emac0_sda_t get_i2c_emac0_sda();
   
      // Gets the i2c_emac0_sda input value.
      $sformat(message, "%m: called get_i2c_emac0_sda");
      print(VERBOSITY_DEBUG, message);
      return sig_i2c_emac0_sda_in;
      
   endfunction

   assign sig_i2c_emac0_out_data = sig_i2c_emac0_out_data_temp;
   assign sig_i2c_emac0_sda_in = sig_i2c_emac0_sda;


   always @(sig_i2c_emac0_sda_in) begin
      if (sig_i2c_emac0_sda_local != sig_i2c_emac0_sda_in)
         -> signal_input_i2c_emac0_sda_change;
      sig_i2c_emac0_sda_local = sig_i2c_emac0_sda_in;
   end
   


// synthesis translate_on

endmodule

