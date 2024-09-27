`timescale 1 ns/10 ps

module fifo_mem ( o_rd_data                                 ,         //output read data
                  i_full                                    ,         //full flag
                  i_wr_data                                 ,         //write data
                  i_wr_clk                                  ,         //write clock
                  i_wr_en                                   ,         //write enable
                  i_wr_addr                                 ,         //write address 
                  i_rd_addr                                 ,         //read address
                  i_wr_rst_n                                          //active low write reset
                )                                           ;

//parameter declaration
parameter DATASIZE     = 8                                  ;	      //memory data word width
parameter ADDRSIZE     = 4                                  ;	      //number of memory address bits
parameter MEM_DEPTH    = 16                                 ;         //depth of memory     

//input declaration
input  [DATASIZE-1:0] i_wr_data                             ;	      //data written into the memory
input                 i_wr_clk                              ;         //clock from write domain
input                 i_wr_rst_n                            ;         //active low write reset
input                 i_wr_en                               ;         //enable for write operation
input  [ADDRSIZE-1:0] i_wr_addr                             ;	      //write addres 
input  [ADDRSIZE-1:0] i_rd_addr                             ;	      //read address 
input                 i_full                                ;         //full flag   

//output declaration
output [DATASIZE-1:0] o_rd_data                             ;         //data read from memory

//wire declaration
wire wr_en_r                                                ;         //write enable

//array of registers(memory) with data width(8) and depth(16)
reg [DATASIZE-1:0] mem [MEM_DEPTH-1:0]                      ;         

//comobinational logic for write enable signal 
assign wr_en_r = (i_wr_en && !i_full)                       ;

//sequential block for writting in a memory when write enable is high
always @(posedge i_wr_clk or negedge i_wr_rst_n)
begin
   if (!i_wr_rst_n)
   begin
      mem[0]  <= 8'b0                                       ;
      mem[1]  <= 8'b0                                       ;
      mem[2]  <= 8'b0                                       ;
      mem[3]  <= 8'b0                                       ;
      mem[4]  <= 8'b0                                       ;
      mem[5]  <= 8'b0                                       ;
      mem[6]  <= 8'b0                                       ;
      mem[7]  <= 8'b0                                       ;
      mem[8]  <= 8'b0                                       ;
      mem[9]  <= 8'b0                                       ;
      mem[10] <= 8'b0                                       ;
      mem[11] <= 8'b0                                       ;
      mem[12] <= 8'b0                                       ;
      mem[13] <= 8'b0                                       ;
      mem[14] <= 8'b0                                       ;
      mem[15] <= 8'b0                                       ;
     
   end
   else 
   begin
      if (wr_en_r) 
         mem[i_wr_addr] <= i_wr_data                        ;
   end
end


//assigning output read data from memory asynchronously
assign o_rd_data = mem[i_rd_addr]                           ;


endmodule