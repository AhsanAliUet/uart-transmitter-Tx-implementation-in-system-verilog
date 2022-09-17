
module tb_shift_register ();
   parameter DW = 8;
   logic clk_i;
   logic rst_i;     

   logic [DW-1:0] data_i;
   logic          shift_i;
   logic          load_byte_i;
   logic          serial_o;  

   shift_register #(.DW(DW))
   dut_shift_register(
      clk_i,
      rst_i,     //active high
      data_i,
      shift_i,
      load_byte_i,
      serial_o     //single bit serial out from shift register
);  

   initial begin
      clk_i = 0;
      forever begin
         #5; clk_i = ~clk_i;
      end
   end

   initial begin
      rst_i = 1;
      #10; rst_i = 0;
      data_i = 8'b10000000;
      load_byte_i = 1;
      shift_i = 1;
      #20; load_byte_i = 0;
      #5;  load_byte_i = 1;
   end

   endmodule
