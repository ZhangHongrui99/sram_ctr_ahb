module sram_ctr_ahb_ctrl_logic(
        hclk,
        hresetn,
        hwrite,
        htrans,
        state,
        error_check,
        hresp,
        hready,
        sram_csn,
        sram_wen
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

    localparam  [1:0]   STATE_IDLE=2'b00;
    localparam  [1:0]   STATE_WRITE=2'b01;
    localparam  [1:0]   STATE_WR2RD=2'b11;
    localparam  [1:0]   STATE_READ=2'b10;

    input   wire            hclk;
    input   wire            hresetn;
    input   wire            hwrite;
    input   wire    [1:0]   htrans;
    input   wire    [1:0]   state;
    input   wire            error_check;
    output  reg     [1:0]   hresp;
    output  wire            hready;
    output  reg             sram_csn;
    output  reg             sram_wen;

    //sram_csn
    //propagate if the master is ready or not which depends on htrans
    always @(posedge hclk or negedge hresetn) begin
        if (~hresetn) begin
            sram_csn <= 1;
        end
        else begin
            if (error_check) begin
                sram_csn <= 1;
            end
            else begin
                sram_csn <= ~((htrans==NONSEQ)|(htrans==SEQ));
            end
        end
    end

    always @(posedge hclk) begin
        sram_wen <= hwrite;
    end

    always @(posedge hclk or negedge hresetn) begin
        if (~hresetn) begin
            // reset
            hresp <= OKAY;
        end
        else begin
            if (error_check) begin
                hresp <= ERROR;
            end
            else begin
                hresp <= OKAY;
            end
        end
    end

    assign hready = ~((state==STATE_WRITE) & (~hwrite));  //inditate the slave is not ready which depends on states of slave

endmodule