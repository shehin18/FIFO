clear -all



#to analyzing all modules
analyze -verilog {../01_Async_FIFO_src/fifo_empty.v} ;
analyze -verilog {../01_Async_FIFO_src/fifo_full.v} ; 
analyze -verilog {../01_Async_FIFO_src/fifo_mem.v} ; 
analyze -verilog {../01_Async_FIFO_src/fifo.v} ; 
analyze -verilog {../01_Async_FIFO_src/reset_sync.v} ; 
analyze -verilog {../01_Async_FIFO_src/sync_ptr_clx.v};




#for elaborating top module
elaborate -parameter {ADDRSIZE} {4} -parameter {DATASIZE} {8} -parameter {MEM_DEPTH} {16} -top {fifo}



#to declare clk with phase and factor
clock i_wr_clk {i_wr_clk} 1 1
clock i_rd_clk {i_rd_clk} 1 1



#to declare reset active low
reset -clear;
reset -expression ~i_wr_rst_n ~i_rd_rst_n


#to set clk for different ports or defining signal configuration
check_cdc -clock_domain -port o_full -clock_signal i_wr_clk
check_cdc -clock_domain -port o_empty -clock_signal i_rd_clk


#for finding different clock domains
check_cdc -clock_domain -find

#to synchronize asynchronous signal
check_cdc -clock_domain -sync_all_unclocked

#to find CDC Pair
check_cdc -pair -find

#for finding schemes
check_cdc -scheme -find

#to find CDC group
check_cdc -group -find

#to generate protocol checks
check_cdc -protocol_check -generate

#to inject metastability
check_cdc -metastability -inject

#to find reset signals
check_cdc -reset -find

#to prove signal configuration
check_cdc -signal_config -prove

#to prove protocol check
check_cdc -protocol_check -prove

#to export filtered checks
check_cdc -protocol_check -export -file export_file_cdc.txt -force

#to export Metastability checks
check_cdc -metastability -export -dir ../05_Async_FIFO_CDC_RDC -force -time_window 1000

#to generate report
check_cdc -report -violation -order category -file fifo_cdc_report.txt -force -detailed
check_cdc -report -violation -order category -detailed

#to add waiver
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check reconvergence_check] -comment {Empty and Full flags involve synchronized read/write pointers that normally converge into comparators for Empty and Full flag calculation}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check convergence_check] -comment {o_rd_data is assigned asynchronously}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check data_stable] -comment {output of sync_ptr_clx module have NDFF Scheme}