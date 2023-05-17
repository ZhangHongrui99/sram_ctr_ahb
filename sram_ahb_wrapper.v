//`define TEST

module sram_ahb_wrapper(
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
`ifdef TEST
        sram_csn,
        sram_a,
        sram_d,
        sram_q,
`endif
        hrdata
	);

    parameter   WIDTH=32;
    parameter   DEPTH=4096;
    parameter   WIDTH_ADDR=$clog2(DEPTH);

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

`ifdef TEST
    output  wire                            sram_csn;
    wire                                    sram_wen;
    output  wire    [WIDTH_ADDR-1:0]        sram_a;
    output  wire    [WIDTH-1:0]             sram_d;
    output  wire    [WIDTH-1:0]             sram_q;
`else
    wire                            sram_csn;
    wire                            sram_wen;
    wire    [WIDTH_ADDR-1:0]        sram_a;
    wire    [WIDTH-1:0]             sram_d;
    wire    [WIDTH-1:0]             sram_q;
`endif

    sram_ctr_ahb inst_sram_ctr_ahb
        (
            .hclk     (hclk),
            .hresetn  (hresetn),
            .hwrite   (hwrite),
            .htrans   (htrans),
            .hsize    (hsize),
            .haddr    (haddr),
            .hburst   (hburst),
            .hwdata   (hwdata),
            .hready   (hready),
            .hresp    (hresp),
            .hrdata   (hrdata),
            .sram_csn (sram_csn),
            .sram_wen (sram_wen),
            .sram_a   (sram_a),
            .sram_d   (sram_d),
            .sram_q   (sram_q)
        );

        sram #(
                .WIDTH(WIDTH),
                .DEPTH(DEPTH),
                .WIDTH_ADDR(WIDTH_ADDR)
            ) inst_sram (
                .clk      (hclk),
                .rst_n    (hresetn),
                .csen_n   (sram_csn),
                .we       (sram_wen),
                .addr     (sram_a),
                .din      (sram_d),
                .dout_reg (),
                .dout     (sram_q)
            );

endmodule