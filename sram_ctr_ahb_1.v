module sram_ctr_ahb(
        //ahb side
        hclk,
        hresetn,
        hwrite,
        htrans,
        hsize,
        haddr,
        hburst,
        hwdata,
        hready,
        hresp,
        hrdata,
        //sram side
        sram_csn,
        sram_wen,
        sram_a,
        sram_d,
        sram_q
	);

    //htrans types
    localparam  IDLE=2'b00;
    localparam  BUSY=2'b01;
    localparam  NONSEQ=2'b10;
    localparam  SEQ=2'b11;
    //hresp types
    localparam  OKAY=2'b00;
    localparam  ERROR=2'b01;
    localparam  RETRY=2'b10;
    localparam  SPLIT=2'b11;
    //hburst types
    localparam  SINGLE=3'b000;
    localparam  INCR=3'b001;
    localparam  WRAP4=3'b010;
    localparam  INCR4=3'b011;
    localparam  WRAP8=3'b100;
    localparam  INCR8=3'b101;
    localparam  WRAP16=3'b110;
    localparam  INCR16=3'b111;
    //hsize types
    localparam  SIZE_BYTE=3'b000;
    localparam  SIZE_HW=3'b001;
    localparam  SIZE_W=3'b010;
    localparam  SIZE_W_2=3'b011;
    localparam  SIZE_W_4=3'b100;
    localparam  SIZE_W_8=3'b101;
    localparam  SIZE_W_16=3'b110;
    localparam  SIZE_W_32=3'b111;  

    //ports on ahb side
    input   wire                hclk;
    input   wire                hresetn;
    input   wire                hwrite;
    input   wire    [1:0]       htrans;
    input   wire    [2:0]       hsize;
    input   wire    [31:0]      haddr;
    input   wire    [2:0]       hburst;
    input   wire    [31:0]      hwdata;
    output  wire                hready;
    output  wire    [1:0]       hresp;
    output  wire    [31:0]      hrdata;
    //ports on sram side
    output  wire                sram_csn;
    output  wire                sram_wen;
    output  wire    [11:0]      sram_a;
    output  wire    [31:0]      sram_d;
    input   wire    [31:0]      sram_q;

    wire        error_check;
    wire [1:0]  state;

    //fsm: state trans & conditional jump
    sram_ctr_ahb_fsm inst_sram_ctr_ahb_fsm (
            .hclk        (hclk),
            .hresetn     (hresetn),
            .hwrite      (hwrite),
            .htrans      (htrans),
            .error_check (error_check),
            .state       (state)
        );

    //state output
    //general control logic
    sram_ctr_ahb_ctrl_logic inst_sram_ctr_ahb_ctrl_logic (
            .hclk        (hclk),
            .hresetn     (hresetn),
            .hwrite      (hwrite),
            .htrans      (htrans),
            .state       (state),
            .error_check (error_check),
            .hresp       (hresp),
            .hready      (hready),
            .sram_csn    (sram_csn),
            .sram_wen    (sram_wen)
        );

    //burst related control logic
    sram_ctr_ahb_addr inst_sram_ctr_ahb_addr (
            .hclk        (hclk),
            .hresetn     (hresetn),
            .htrans      (htrans),
            .hburst      (hburst),
            .haddr       (haddr),
            .error_check (error_check),
            .sram_a      (sram_a)
        );

    //error check
    sram_ctr_ahb_error_check inst_sram_ctr_ahb_error_check (
            .hsize            (hsize),
            .htrans           (htrans),
            .haddr            (haddr),
            .hburst           (hburst),
            .state            (state),
            .error_check     (error_check)
        );

    //data bypass
    assign sram_d = hwdata;
    assign hrdata = sram_q;
    
endmodule