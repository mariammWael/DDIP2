set_property PACKAGE_PIN W5 [get_ports clk_100MHz]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_100MHz]
 
 ##Buttons
set_property PACKAGE_PIN T18 	 [get_ports up_1]						
set_property IOSTANDARD LVCMOS33 [get_ports up_1]
set_property PACKAGE_PIN W19 	 [get_ports up_2]						
set_property IOSTANDARD LVCMOS33 [get_ports up_2]
set_property PACKAGE_PIN R2 	 [get_ports reset]						  
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN T17 	 [get_ports down_1]						
set_property IOSTANDARD LVCMOS33 [get_ports down_1]
set_property PACKAGE_PIN U17 	 [get_ports down_2]						
set_property IOSTANDARD LVCMOS33 [get_ports down_2]

##VGA Connector
set_property PACKAGE_PIN G19     [get_ports {rgb[0]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]
set_property PACKAGE_PIN H19     [get_ports {rgb[1]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]
set_property PACKAGE_PIN J19     [get_ports {rgb[2]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]
set_property PACKAGE_PIN N19     [get_ports {rgb[3]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[3]}]
set_property PACKAGE_PIN J17     [get_ports {rgb[4]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[4]}]
set_property PACKAGE_PIN H17     [get_ports {rgb[5]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[5]}]
set_property PACKAGE_PIN G17     [get_ports {rgb[6]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[6]}]
set_property PACKAGE_PIN D17     [get_ports {rgb[7]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[7]}]
set_property PACKAGE_PIN N18     [get_ports {rgb[8]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[8]}]
set_property PACKAGE_PIN L18     [get_ports {rgb[9]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[9]}]
set_property PACKAGE_PIN K18     [get_ports {rgb[10]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[10]}]
set_property PACKAGE_PIN J18     [get_ports {rgb[11]}]				
set_property IOSTANDARD LVCMOS33 [get_ports {rgb[11]}]
set_property PACKAGE_PIN P19     [get_ports hsync]						
set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property PACKAGE_PIN R19     [get_ports vsync]						
set_property IOSTANDARD LVCMOS33 [get_ports vsync]
set_property PACKAGE_PIN W7 [get_ports {segments[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[0]}]

set_property PACKAGE_PIN W6 [get_ports {segments[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[1]}]

set_property PACKAGE_PIN U8 [get_ports {segments[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[2]}]

set_property PACKAGE_PIN V8 [get_ports {segments[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[3]}]

set_property PACKAGE_PIN U5 [get_ports {segments[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[4]}]

set_property PACKAGE_PIN V5 [get_ports {segments[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[5]}]

set_property PACKAGE_PIN U7 [get_ports {segments[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {segments[6]}]
	
set_property PACKAGE_PIN U2 [get_ports {anodes[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[0]}]

set_property PACKAGE_PIN U4 [get_ports {anodes[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[1]}]

set_property PACKAGE_PIN V4 [get_ports {anodes[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[2]}]

set_property PACKAGE_PIN W4 [get_ports {anodes[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[3]}]

