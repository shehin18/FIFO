`timescale 1 ns/10 ps
                                                                                           
module reset_sync  ( o_sync_rst                         , // Synchronized Reset Output
                     i_clk                              , // Input clock
                     i_rst_n                              // Asynchronous Reset
                   )                                    ;

//input declaration
input      i_clk                                        ; //input clock
input      i_rst_n                                      ; //input active low reset

//output declaration
output reg o_sync_rst                                   ; //output reset synchronizer

//reg declaration
reg        syncrst_reg                                  ; //register for reset synchronizing


//The always block given below will synchronize reset using 2 D-FF synchronizer Scheme
always @(posedge i_clk or negedge i_rst_n)
begin
   if (!i_rst_n)
   begin
      syncrst_reg <= 1'b0                               ;   
      o_sync_rst  <= 1'b0                               ;
   end
   else 
   begin
      syncrst_reg <= 1'b1                               ;   
      o_sync_rst  <= syncrst_reg                        ; 
   end
end

endmodule