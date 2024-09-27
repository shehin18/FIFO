###############  SDC CONSTRAINTS   ############


##### PARAMETERS #####
set_units -time 1.0ns;
set_units -capacitance  1.0pF;

set WRITE_CLOCK_PERIOD 15;
set WRITE_CLOCK_NAME   write_clk;

set WRITE_SKEW_setup  [expr $WRITE_CLOCK_PERIOD*0.025];
set WRITE_SKEW_hold   [expr $WRITE_CLOCK_PERIOD*0.025];
set WRITE_MINRISE     [expr $WRITE_CLOCK_PERIOD*0.125];
set WRITE_MAXRISE     [expr $WRITE_CLOCK_PERIOD*0.2];
set WRITE_MINFALL     [expr $WRITE_CLOCK_PERIOD*0.125];
set WRITE_MAXFALL     [expr $WRITE_CLOCK_PERIOD*0.2];

set READ_CLOCK_PERIOD 30;
set READ_CLOCK_NAME   read_clk;

set READ_SKEW_setup  [expr $READ_CLOCK_PERIOD*0.025];
set READ_SKEW_hold   [expr $READ_CLOCK_PERIOD*0.025];
set READ_MINRISE     [expr $READ_CLOCK_PERIOD*0.125];
set READ_MAXRISE     [expr $READ_CLOCK_PERIOD*0.2];
set READ_MINFALL     [expr $READ_CLOCK_PERIOD*0.125];
set READ_MAXFALL     [expr $READ_CLOCK_PERIOD*0.2];

set MIN_PORT 1;
set MAX_PORT 2.5;


####### CLOCK CONSTRAINTS #########

create_clock -name "$WRITE_CLOCK_NAME"			\
	     -period "$WRITE_CLOCK_PERIOD" 		\
	     -waveform "0 [expr $WRITE_CLOCK_PERIOD/2]"  \
	      [get_ports "i_wr_clk_pad"]


create_clock -name "$READ_CLOCK_NAME"			\
	     -period "$READ_CLOCK_PERIOD" 		\
	     -waveform "0 [expr $READ_CLOCK_PERIOD/2]"  \
	      [get_ports "i_rd_clk_pad"]

## Virtual Clock Constraints 

create_clock   -name   wr_vir_clk_i   -period   15
create_clock   -name   rd_vir_clk_i   -period   30


##  Write clock source latency
set_clock_latency   -source   -max   1.25   -late    [get_clocks  write_clk]
set_clock_latency   -source   -min   0.75   -late    [get_clocks  write_clk]
set_clock_latency   -source   -max   1.0    -early   [get_clocks  write_clk]
set_clock_latency   -source   -min   1.25   -early   [get_clocks  write_clk]

# Read clock source latency
set_clock_latency   -source   -max   1.25  -late     [get_clock read_clk]
set_clock_latency   -source   -min   0.75  -late     [get_clock read_clk]
set_clock_latency   -source   -max   1.0   -early    [get_clock read_clk]
set_clock_latency   -source   -min   1.25  -early    [get_clock read_clk]

# Write clock transition
set_clock_transition   -rise   -min   $WRITE_MINRISE   [get_clocks  write_clk]
set_clock_transition   -rise   -max   $WRITE_MAXRISE   [get_clocks  write_clk]
set_clock_transition   -fall   -min   $WRITE_MINRISE   [get_clocks  write_clk]
set_clock_transition   -fall   -max   $WRITE_MAXRISE   [get_clocks  write_clk]


# Read clock transition
set_clock_transition    -rise   -min  $READ_MINRISE   [get_clock read_clk]
set_clock_transition    -rise   -max  $READ_MAXRISE   [get_clock read_clk]
set_clock_transition    -fall   -min  $READ_MINRISE   [get_clock read_clk]
set_clock_transition    -fall   -max  $READ_MAXRISE   [get_clock read_clk]

set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[7]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[6]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[5]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[4]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[3]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[2]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[1]]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_data_pad[0]]

set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[7]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[6]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[5]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[4]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[3]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[2]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[1]]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_data_pad[0]] 

# Write clock uncertainty
set_clock_uncertainty -setup $WRITE_SKEW_setup  [get_clocks  write_clk]
set_clock_uncertainty -hold  $WRITE_SKEW_hold   [get_clocks  write_clk]

# Read clock uncertainty
set_clock_uncertainty -setup $READ_SKEW_setup  [get_clocks read_clk]
set_clock_uncertainty -hold  $READ_SKEW_hold   [get_clocks read_clk]


# Write input port delay

set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_en_pad] 
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_en_pad] 

set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[7]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[6]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[5]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[4]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[3]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[2]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[1]]
set_input_delay  -add_delay -clock wr_vir_clk_i -max 7.75 [get_ports i_wr_data_pad[0]]


set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[7]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[6]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[5]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[4]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[3]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[2]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[1]]
set_input_delay  -add_delay -clock wr_vir_clk_i -min 2.25 [get_ports i_wr_data_pad[0]]



# Read input port delay

set_input_delay  -add_delay -clock rd_vir_clk_i -max 7.75 [get_ports i_rd_en_pad] 
set_input_delay  -add_delay -clock rd_vir_clk_i -min 2.25 [get_ports i_rd_en_pad] 

#Output port delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[7]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[6]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[5]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[4]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[3]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[2]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[1]] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_rd_data_pad[0]] -add_delay

set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[7]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[6]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[5]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[4]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[3]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[2]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[1]] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_rd_data_pad[0]] -add_delay

set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_full_pad] -add_delay
set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_full_pad] -add_delay

set_output_delay -clock rd_vir_clk_i -max 3.931 [get_ports o_empty_pad] -add_delay
set_output_delay -clock rd_vir_clk_i -min 2.628 [get_ports o_empty_pad] -add_delay


# Input transition  
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_rst_n_pad]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_wr_en_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_rst_n_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_wr_en_pad]

set_input_transition	-max	$MAX_PORT 	[get_ports	i_rd_rst_n_pad]
set_input_transition	-max	$MAX_PORT 	[get_ports	i_rd_en_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	i_rd_rst_n_pad]
set_input_transition	-min	$MIN_PORT       [get_ports	i_rd_en_pad]


#######   LOAD SPECIFIACATIONS   ########

set_load	5	[get_ports	o_rd_data_pad[7]]
set_load	5	[get_ports	o_rd_data_pad[6]]
set_load	5	[get_ports	o_rd_data_pad[5]]
set_load	5	[get_ports	o_rd_data_pad[4]]
set_load	5	[get_ports	o_rd_data_pad[3]]
set_load	5	[get_ports	o_rd_data_pad[2]]
set_load	5	[get_ports	o_rd_data_pad[1]]
set_load	5	[get_ports	o_rd_data_pad[0]]

set_load	5	[get_ports	o_full_pad]
set_load	5	[get_ports	o_empty_pad]

########## FALSE PATHS ###########

set_false_path  -from   [get_clocks      read_clk]         -to     [get_clocks      write_clk]
set_false_path  -from   [get_clocks      read_clk]         -to     [get_clocks   wr_vir_clk_i]
set_false_path  -from   [get_clocks     write_clk]         -to     [get_clocks       read_clk]
set_false_path  -from   [get_clocks     write_clk]         -to     [get_clocks   rd_vir_clk_i]
set_false_path  -from   [get_ports i_wr_rst_n_pad]         -to     [all_registers] 
set_false_path  -from   [get_ports i_rd_rst_n_pad]         -to     [all_registers]
set_false_path  -from   [get_ports    i_rd_en_pad]         -to     [all_registers]
set_false_path  -from   [get_ports    i_wr_en_pad]         -to     [all_registers]


##########  GROUP PATHS  #########

group_path -name   I2R   -from   [all_inputs]      -to   [all_registers]
group_path -name   R2O   -from   [all_registers]   -to   [all_outputs]
group_path -name   R2R   -from   [all_registers]   -to   [all_registers]
group_path -name   I2O   -from   [all_inputs]      -to   [all_outputs]
