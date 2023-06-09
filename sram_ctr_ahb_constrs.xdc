create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add [get_ports -filter { NAME =~  "*clk*" && DIRECTION == "IN" }]

set_property PACKAGE_PIN P15 [get_ports {haddr[6]}]
set_property PACKAGE_PIN AA11 [get_ports {hrdata[30]}]
set_property PACKAGE_PIN T18 [get_ports {haddr[9]}]
set_property PACKAGE_PIN N19 [get_ports {hrdata[1]}]
set_property PACKAGE_PIN K13 [get_ports {hwdata[23]}]
set_property PACKAGE_PIN J21 [get_ports {hrdata[13]}]
set_property PACKAGE_PIN AB15 [get_ports {sram_a[8]}]
set_property PACKAGE_PIN U15 [get_ports {htrans[1]}]
set_property PACKAGE_PIN M13 [get_ports {hwdata[21]}]
set_property PACKAGE_PIN P19 [get_ports {hwdata[8]}]
set_property PACKAGE_PIN T19 [get_ports {hwdata[6]}]
set_property PACKAGE_PIN M22 [get_ports {hrdata[5]}]
set_property PACKAGE_PIN AB13 [get_ports {sram_a[10]}]
set_property PACKAGE_PIN V2 [get_ports {sram_d[27]}]
set_property PACKAGE_PIN AA5 [get_ports {sram_d[12]}]
set_property PACKAGE_PIN T5 [get_ports {sram_d[4]}]
set_property PACKAGE_PIN Y4 [get_ports {sram_d[10]}]
set_property PACKAGE_PIN W6 [get_ports {sram_d[2]}]
set_property PACKAGE_PIN V7 [get_ports {sram_q[26]}]
set_property PACKAGE_PIN Y1 [get_ports {sram_d[21]}]
set_property PACKAGE_PIN N4 [get_ports {sram_q[20]}]
set_property PACKAGE_PIN W7 [get_ports {sram_q[25]}]
set_property PACKAGE_PIN V9 [get_ports {sram_q[22]}]
set_property PACKAGE_PIN Y8 [get_ports {sram_q[4]}]
set_property PACKAGE_PIN P1 [get_ports {sram_q[17]}]
set_property PACKAGE_PIN Y7 [get_ports {sram_q[3]}]
set_property PACKAGE_PIN L6 [get_ports {sram_q[6]}]
set_property PACKAGE_PIN W15 [get_ports {hsize[0]}]
set_property PACKAGE_PIN U22 [get_ports {hwdata[26]}]
set_property PACKAGE_PIN M16 [get_ports {hwdata[12]}]
set_property PACKAGE_PIN AA13 [get_ports {sram_a[11]}]
set_property PACKAGE_PIN N20 [get_ports {hrdata[0]}]
set_property PACKAGE_PIN L20 [get_ports {hrdata[7]}]
set_property PACKAGE_PIN L21 [get_ports {hrdata[15]}]
set_property PACKAGE_PIN K18 [get_ports {hrdata[10]}]
set_property PACKAGE_PIN R17 [get_ports {haddr[1]}]
set_property PACKAGE_PIN N15 [get_ports {haddr[0]}]
set_property PACKAGE_PIN K22 [get_ports {hrdata[17]}]
set_property PACKAGE_PIN V10 [get_ports {hrdata[29]}]
set_property PACKAGE_PIN W10 [get_ports {hrdata[28]}]
set_property PACKAGE_PIN H17 [get_ports {hrdata[24]}]
set_property PACKAGE_PIN Y17 [get_ports sram_wen]
set_property PACKAGE_PIN M18 [get_ports {hrdata[4]}]
set_property PACKAGE_PIN P22 [get_ports {hwdata[30]}]
set_property PACKAGE_PIN L16 [get_ports {hwdata[15]}]
set_property PACKAGE_PIN L14 [get_ports {hwdata[17]}]
set_property PACKAGE_PIN AB10 [get_ports {sram_a[0]}]
set_property PACKAGE_PIN U2 [get_ports {sram_d[28]}]
set_property PACKAGE_PIN Y2 [get_ports {sram_d[23]}]
set_property PACKAGE_PIN U3 [get_ports {sram_d[20]}]
set_property PACKAGE_PIN W2 [get_ports {sram_d[24]}]
set_property PACKAGE_PIN M5 [get_ports {sram_q[9]}]
set_property PACKAGE_PIN AB8 [get_ports {sram_q[5]}]
set_property PACKAGE_PIN N5 [get_ports {sram_q[7]}]
set_property PACKAGE_PIN Y9 [get_ports {sram_q[1]}]
set_property PACKAGE_PIN N3 [get_ports {sram_q[19]}]
set_property PACKAGE_PIN R6 [get_ports {sram_q[30]}]
set_property PACKAGE_PIN T6 [get_ports {sram_q[29]}]
set_property PACKAGE_PIN W1 [get_ports {sram_d[22]}]
set_property PACKAGE_PIN T4 [get_ports {sram_d[5]}]
set_property PACKAGE_PIN U6 [get_ports {sram_d[0]}]
set_property PACKAGE_PIN AB5 [get_ports {sram_d[11]}]
set_property PACKAGE_PIN W21 [get_ports {hwdata[4]}]
set_property PACKAGE_PIN AB11 [get_ports {sram_a[3]}]
set_property PACKAGE_PIN AB17 [get_ports {hresp[0]}]
set_property PACKAGE_PIN AA15 [get_ports {sram_a[9]}]
set_property PACKAGE_PIN K16 [get_ports {hwdata[14]}]
set_property PACKAGE_PIN W22 [get_ports {hwdata[3]}]
set_property PACKAGE_PIN V22 [get_ports {hwdata[25]}]
set_property PACKAGE_PIN J17 [get_ports {hwdata[18]}]
set_property PACKAGE_PIN AA10 [get_ports {hrdata[31]}]
set_property PACKAGE_PIN AB16 [get_ports {hresp[1]}]
set_property PACKAGE_PIN AB12 [get_ports {sram_a[2]}]
set_property PACKAGE_PIN J19 [get_ports {hrdata[12]}]
set_property PACKAGE_PIN J22 [get_ports {hrdata[22]}]
set_property PACKAGE_PIN U18 [get_ports {haddr[13]}]
set_property PACKAGE_PIN W11 [get_ports {hrdata[26]}]
set_property PACKAGE_PIN H20 [get_ports {hrdata[20]}]
set_property PACKAGE_PIN T16 [get_ports {hburst[1]}]
set_property PACKAGE_PIN N14 [get_ports {haddr[3]}]
set_property PACKAGE_PIN H22 [get_ports {hrdata[21]}]
set_property PACKAGE_PIN AA16 [get_ports hready]
set_property PACKAGE_PIN V14 [get_ports hresetn]
set_property PACKAGE_PIN R18 [get_ports {haddr[10]}]
set_property PACKAGE_PIN L19 [get_ports {hrdata[8]}]
set_property PACKAGE_PIN L13 [get_ports {hwdata[20]}]
set_property PACKAGE_PIN L15 [get_ports {hwdata[16]}]
set_property PACKAGE_PIN T15 [get_ports {hsize[1]}]
set_property PACKAGE_PIN N18 [get_ports {hrdata[2]}]
set_property PACKAGE_PIN T14 [get_ports {hsize[2]}]
set_property PACKAGE_PIN R22 [get_ports {hwdata[29]}]
set_property PACKAGE_PIN M17 [get_ports {hwdata[11]}]
set_property PACKAGE_PIN R19 [get_ports {hwdata[7]}]
set_property PACKAGE_PIN T20 [get_ports {hwdata[5]}]
set_property PACKAGE_PIN P21 [get_ports {hwdata[28]}]
set_property PACKAGE_PIN AA14 [get_ports {sram_a[6]}]
set_property PACKAGE_PIN V15 [get_ports {htrans[0]}]
set_property PACKAGE_PIN Y14 [get_ports {sram_a[4]}]
set_property PACKAGE_PIN U1 [get_ports {sram_d[29]}]
set_property PACKAGE_PIN R3 [get_ports {sram_d[26]}]
set_property PACKAGE_PIN V3 [get_ports {sram_d[19]}]
set_property PACKAGE_PIN V5 [get_ports {sram_q[31]}]
set_property PACKAGE_PIN AB1 [get_ports {sram_d[17]}]
set_property PACKAGE_PIN U5 [get_ports {sram_d[3]}]
set_property PACKAGE_PIN P6 [get_ports {sram_q[8]}]
set_property PACKAGE_PIN N2 [get_ports {sram_q[11]}]
set_property PACKAGE_PIN M6 [get_ports {sram_q[10]}]
set_property PACKAGE_PIN R1 [get_ports {sram_q[18]}]
set_property PACKAGE_PIN P2 [get_ports {sram_q[14]}]
set_property PACKAGE_PIN AB7 [get_ports {sram_q[24]}]
set_property PACKAGE_PIN R4 [get_ports {sram_d[6]}]
set_property PACKAGE_PIN R2 [get_ports {sram_d[25]}]
set_property PACKAGE_PIN Y3 [get_ports {sram_d[14]}]
set_property PACKAGE_PIN AA3 [get_ports {sram_d[13]}]
set_property PACKAGE_PIN AA21 [get_ports {hwdata[1]}]
set_property PACKAGE_PIN H18 [get_ports {hrdata[23]}]
set_property PACKAGE_PIN R14 [get_ports {haddr[11]}]
set_property PACKAGE_PIN Y12 [get_ports {hrdata[27]}]
set_property PACKAGE_PIN G20 [get_ports {hrdata[19]}]
set_property PACKAGE_PIN P16 [get_ports {haddr[2]}]
set_property PACKAGE_PIN K21 [get_ports {hrdata[18]}]
set_property PACKAGE_PIN W16 [get_ports {hburst[2]}]
set_property PACKAGE_PIN Y16 [get_ports sram_csn]
set_property PACKAGE_PIN P14 [get_ports {haddr[12]}]
set_property PACKAGE_PIN J20 [get_ports {hrdata[14]}]
set_property PACKAGE_PIN M21 [get_ports {hrdata[16]}]
set_property PACKAGE_PIN K14 [get_ports {hwdata[22]}]
set_property PACKAGE_PIN U21 [get_ports {hwdata[9]}]
set_property PACKAGE_PIN H19 [get_ports {hrdata[11]}]
set_property PACKAGE_PIN L18 [get_ports {hrdata[3]}]
set_property PACKAGE_PIN K17 [get_ports {hwdata[19]}]
set_property PACKAGE_PIN M20 [get_ports {hwdata[24]}]
set_property PACKAGE_PIN M15 [get_ports {hwdata[13]}]
set_property PACKAGE_PIN T21 [get_ports {hwdata[10]}]
set_property PACKAGE_PIN P20 [get_ports {hwdata[31]}]
set_property PACKAGE_PIN R21 [get_ports {hwdata[27]}]
set_property PACKAGE_PIN W14 [get_ports {sram_a[5]}]
set_property PACKAGE_PIN AA9 [get_ports {sram_a[1]}]
set_property PACKAGE_PIN AA4 [get_ports {sram_d[9]}]
set_property PACKAGE_PIN V4 [get_ports {sram_d[8]}]
set_property PACKAGE_PIN AB3 [get_ports {sram_d[16]}]
set_property PACKAGE_PIN W4 [get_ports {sram_d[7]}]
set_property PACKAGE_PIN AB2 [get_ports {sram_d[15]}]
set_property PACKAGE_PIN T3 [get_ports {sram_d[31]}]
set_property PACKAGE_PIN P4 [get_ports {sram_q[15]}]
set_property PACKAGE_PIN AA8 [get_ports {sram_q[12]}]
set_property PACKAGE_PIN V8 [get_ports {sram_q[13]}]
set_property PACKAGE_PIN AB6 [get_ports {sram_q[23]}]
set_property PACKAGE_PIN L4 [get_ports {sram_q[21]}]
set_property PACKAGE_PIN P5 [get_ports {sram_q[16]}]
set_property PACKAGE_PIN U7 [get_ports {sram_q[0]}]
set_property PACKAGE_PIN W9 [get_ports {sram_q[2]}]
set_property PACKAGE_PIN Y6 [get_ports {sram_q[28]}]
set_property PACKAGE_PIN AA6 [get_ports {sram_q[27]}]
set_property PACKAGE_PIN AA1 [get_ports {sram_d[18]}]
set_property PACKAGE_PIN W5 [get_ports {sram_d[1]}]
set_property PACKAGE_PIN T1 [get_ports {sram_d[30]}]
set_property PACKAGE_PIN AA20 [get_ports {hwdata[2]}]
set_property PACKAGE_PIN Y21 [get_ports {hwdata[0]}]
set_property PACKAGE_PIN Y13 [get_ports {sram_a[7]}]
set_property PACKAGE_PIN N17 [get_ports {haddr[8]}]
set_property PACKAGE_PIN P17 [get_ports {haddr[7]}]
set_property PACKAGE_PIN U16 [get_ports {hburst[0]}]
set_property PACKAGE_PIN W12 [get_ports {hrdata[25]}]
set_property PACKAGE_PIN K19 [get_ports {hrdata[9]}]
set_property PACKAGE_PIN R16 [get_ports {haddr[5]}]
set_property PACKAGE_PIN N13 [get_ports {haddr[4]}]
set_property PACKAGE_PIN N22 [get_ports {hrdata[6]}]
set_property PACKAGE_PIN Y11 [get_ports hclk]
set_property PACKAGE_PIN V13 [get_ports hwrite]
set_property PACKAGE_PIN W19 [get_ports {haddr[26]}]
set_property PACKAGE_PIN U17 [get_ports {haddr[14]}]
set_property PACKAGE_PIN AB22 [get_ports {haddr[29]}]
set_property PACKAGE_PIN Y22 [get_ports {haddr[31]}]
set_property PACKAGE_PIN AB21 [get_ports {haddr[30]}]
set_property PACKAGE_PIN U20 [get_ports {haddr[28]}]
set_property PACKAGE_PIN V19 [get_ports {haddr[21]}]
set_property PACKAGE_PIN AB20 [get_ports {haddr[19]}]
set_property PACKAGE_PIN AB18 [get_ports {haddr[15]}]
set_property PACKAGE_PIN V17 [get_ports {haddr[18]}]
set_property PACKAGE_PIN V20 [get_ports {haddr[27]}]
set_property PACKAGE_PIN W20 [get_ports {haddr[25]}]
set_property PACKAGE_PIN Y18 [get_ports {haddr[24]}]
set_property PACKAGE_PIN AA18 [get_ports {haddr[16]}]
set_property PACKAGE_PIN V18 [get_ports {haddr[22]}]
set_property PACKAGE_PIN Y19 [get_ports {haddr[23]}]
set_property PACKAGE_PIN AA19 [get_ports {haddr[20]}]
set_property PACKAGE_PIN W17 [get_ports {haddr[17]}]
