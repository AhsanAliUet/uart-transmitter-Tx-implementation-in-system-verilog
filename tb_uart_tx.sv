module tb_uart_tx();
   parameter     DW            = 8;
   parameter     CLOCK         = 100e6;       //FPGA's clock frequency 
   parameter     BAUD_RATE     = 20000000;  
   parameter int BAUD_COUNTER  = CLOCK/BAUD_RATE;
   parameter     BRW           = $clog2(BAUD_COUNTER + 1);
   parameter     BITS_TO_COUNT = 9;

   logic          clk_i;
   logic          rst_i;
   logic [DW-1:0] data_i;
   logic          byte_ready_i;
   logic          t_byte_i;
   logic          Tx;

uart_tx i_uart_tx(
   .clk_i(clk_i),
   .rst_i(rst_i),
   .data_i(data_i),
   .byte_ready_i(byte_ready_i),
   .t_byte_i(t_byte_i),
   .Tx(Tx)
);
   initial begin
      clk_i = 0;
      forever #5 clk_i = ~clk_i;
   end

   initial begin
      rst_i = 1;
      byte_ready_i = 0; t_byte_i = 0;
      #7; rst_i = 0;
      data_i = 8'b10101010;

      #30; byte_ready_i = 1;
      #30; t_byte_i = 1;
      #10; data_i = 8'b11110000;
   end

   initial begin
      $dumpfile("dumpFile.vcd");
      $dumpvars;
   end

   // initial begin
   //    $monitor('A = %d,    B = %d    alu_control = %d    y = %d', A, B, alu_control, y);
   // end
endmodule