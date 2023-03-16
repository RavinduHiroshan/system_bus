// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Wed Mar 15 15:49:57 2023
// Host        : Hiroshan-Laptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Academic/System_bus/system_bus/src/bram/ip/bram_blk_mem_gen_0_0/bram_blk_mem_gen_0_0_sim_netlist.v
// Design      : bram_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bram_blk_mem_gen_0_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2021.2" *) 
(* NotValidForBitStream *)
module bram_blk_mem_gen_0_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  output rsta_busy;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.5485 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  bram_blk_mem_gen_0_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oESHD2Q5NORrmTVTCApB+YFZJwjA1ezq7U6VZh96by+ofPCvSFp06AIoCLvB4BhPvxfob6kIkBpR
xVCOLM7HsDk7nO1JVWiYIJ6okoWTA8hAlPj3sdGuMwRlZNSBKn/c6F+CW5Jl37TEGotkhycSB3Bg
B/uu1THUZwIG87RPahE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RovEhaqHrFqzjckk+DIWG8LQeqg2Y/nACQDyXKKtSav7YHlgpKmgHZnsxwwNpqrqVRGyjTecSQ+e
6Mr/Pi9au3AgJVPL6VOgwNVE0yj2LpA4LPyWzxLN3+DiSDmsaCBNCBlVQi2MRKUabou8nLaXldbL
+7pv4pYhQdcyjDzuC2dx3HmzADqstdEiyXeU3ktJ29CDLDmGwDWdmsrl90s4YQSfBV2nj4/Vut3L
p/8dzphf1htPaNMujMxxgp3z4JzUEDJJokDL+gNutEEHiaWpI3URIA5v22vJu+NPD+eEraSioHfL
DPKAajZTwK5FHnonu4O2D0co8GWqWW5cUqZz9A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jBQ6Th9yy7jtKQD1h235YLT6qO6XiBaBKGJrV1Z8H9M9ePJ9R/fA8E1okt4LyBvoWjR7tmCbIg7A
0/vuKOogkLtDE/BtTlp4z1iurO8rQrAcdZy/e+7GATawyJxFY7kZhnXASu9zB8TiOBELSlapkpxe
WuAzXLde9FBMBkq4RSc=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eucSNV2Zbm4zYc2tIGRlGmlVM8+WHY1NHe9drZdgDhGPOHz8PTqHapfnZ1kWuTLtPBLSMvcXNScn
UTvpULofBV6qD7WHLPg7UJcjpZVDL69lk88chgqrlc/RqaJXKNVv+Ubku53ZLU20uZK71bNymjSM
855RVWw5lvTHTCNC2MYIS94Fmrzuq8i0+tFh5qBKkHK2BC+fD7xVyyfuh4mZR2yr/hRs/emoI79E
IKoJnLiglVp6RXTsXFzZW4pIthbjWSuZlOQvoYkS2RMj8a0r9lyariphRQunoudc0bLO4Phk578c
40gusaaS/MI7idMT7k1Di96kvu5mHi23loRcZQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E/syLaRG2Ss/xTTkuAkOKXzm53+rCptYO2DkVukWhvlLmEB2daHCPrXt4gKeuG+0hIGWedSwCiLJ
7KNtEAiTumJ/j+3p7s3oXN9ftCSRolXoACsCclEAmwYjVM0ubCXUx6JNFOGt0yDl2Jsd5+W10mSJ
bYEKvRKi7koXM/eYJqbhTrtsrHDwRJEY0JVUPh8EOkLLqaIKbnjb6ENEY6qZOamp5PaWsSS30gJM
N6fB8D1AmGKnFbfY+d5TexS55Z92aYcAHNX2XwHsKnm45az1vHeZ0rTEU/oONIaSZfikRni1iDBg
x2GOue6sLiwxTEHaVkTJsOVR4mx0VsfFxavwRg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dSHHpkQiOEzzKs4D71WVyDXLpkKuR9h9h3pBLtnCq2bXiwE/eQHmk5HeQb+qREg0Yv193OukqaQz
RZyuF5GQcqOpqFHMxO62HQ2pdjdpMT5CC7gHvmgiw9qBkJJrXpihIHER4X7OF2iNUfeqxJ8eiSz3
C0V20NlIwKG7Mxg8MVj++xmb32KMUqL7ptikkym20vVdhecVMNvpPoXp8uvaGT7991enWP9HGKUC
9kLY2DEYwRGE71UJJLGWo4n49R50ExFRj91xWnYfvp7uJsMNwnBp5l3GTZiMELX2RkRVSPOHr7l1
n2p5Vq7Uee2drny1IxZ/4c0hYY6y3QWSEqpESw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HUtfqZ9dh5oZTOAt9a0ebo+wQbzg3izFQ0kVqZN81S4cBjQEF53WUiVlTKBDVjvLNUby4Se9WZjj
j86TQzuGJxLPDTohmbytErsg5JrlXHbHGwR4zGNGTbBs12X7PkxtS8wVCp+7b1rX6pOGOPqm6FoG
g6rZY/bTzVfGYF2CAOhjJUqUOXEAKnZRehspRyiBI28/ZZPSAUD/abKprW8PWCxMx2zPWztZz4No
R96jgvHezNzB1Ta8W7uRBFTMp+XVSToxTp2jzSXJZ0V5xJl+gdVjAMmf6+te2vqrK2wDWdMxk3Sf
iyLI4d0s25vCybcY2fZWacq5iO9pSlSaOQWgCA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
vYYu2Kvhv3RZi0pFbjRTQ/BBwfilCrGpkMls+Dz6HBGTZvSaC/anWgymoDS0XnoSENGG3Pz3EBF0
19OqLbyna95IHFe2bA7f8RgU9SEUffZ8eXGigfOjAWpZCN07Q77RkhGUKal7okWe3Q6xHtZy83l2
kW8ma3kOYL7GzQjtpbP3lINHLMqpGEo0dzbOHiJ5r6W5U6DsILGsoLQOXcw+MwrevvNRB0KkSklj
QnL8K2AK8PIsJGM6F8dj5KwRYhSBYNb1opuVpiJWlbHgADoeM+dhiRxBLmnaDE8PWs1ReY6uMzzH
SvvO6UEyxQtvS/Smm/uogr1eUFedUaBHPMEXnYlTAv/SKrh942GeknsqfrjGkZxWTN2NEnvpRUwT
fS0pyd/Err0s94b0srmcTYyxZfJGRUct2T8MCphZFaScAlhn655pxW9RaHMfcvDJUHpW8Qa+KhRt
9CWYScPIH6YNDByLQbhKL5BTpAYMNYPF2W7vM2ZzDob2NB7m6GGeKRr3

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QSNmIeTT4pBji+CTjknWXN6sH9Wff8+t8KF+AC3fIoIw08jtLtShcB9ZGeEKG02RGCO4lNIUf5YB
2TVYk6EJ5XyCav12qDhc60n56UVrnpfo7drorY0NmOypuxECgO43h6SDWp9W7px3r4CJnQ4+X2Mj
943GdP30WfL5kbWHZJC1Dz9cBIqRa1EbNXvvAqBvRPS2+aXBXAPOC4rNVZGeIUspn/33IW3yJLSp
Jm5GIct87ZuSoz8+DXhUvsTj4hq8lgirVhfz1qhHm8SfODcE91FGUPw3vbpGWXsBX73t2zxFC1Hz
/6m4YqQJVxd+H5iGE4kbHxHyHnH7FIerqc8Phw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UhfxKxECbuHK/o9ZExa2zP/MIPmFXuDNZwgpiawuBmPeRI1nJsYB7vzbBGMPKny4yIHLT8mHrQRc
fs05atkjIAbLea4+WNoCdCeg7/0PzuodM1ol3it6BHQ6Yzq4mnZbzlk8Xtwmk8ACAbzOr2SYxYWX
ueuUlimUSRusIe4+NiPvzbfHMAOVPjdmSY7zaSyeJuhdAR+fUGeHy5B23Xe2X6cDPeJ75IqcBeul
ox3dTXi3L8r/s1bTKX3FhxRyPZuh/xCWuEajsF2fEYdwWHKtLX6IQniLBJ5ZnVSS8D7IYPsvV4t0
9rWJqto5O1n3rAM44OvKvc9pOYXJupuv7g3gWg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fmo66vhS7nigYtLDMjdj7hgUnDG/fnO+cIaY/3qHrcwT7u/paj5enLuWHovegu9O9WRq3pPNnjuN
6vZRpuCgz5p4VAV7dVg9fuzg99BAjThp1Q/+HIPfdQ2LM14ZpTh4FXxthHGkTyS5PJArvZ3/UMpW
zwfdYd5+k2/emJ4/nuqoJHQG8k+O5EjSprLTvNZ/wrE1cT/fW/Lu2pxI4msHqVVYAXz7sJ13cQ+C
7tKxCV8vTyf0rpStdE+kZXg+jrc7vFKuPJO0U9axMsC0nXyeYx2jzfAHptGWKvfQaPg/Eo9mgLyN
qSJfFS6aIycuxNmg7L82WK401aWhnUn7GNrudg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 29920)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
