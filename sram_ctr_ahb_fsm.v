module sram_ctr_ahb_fsm(
        hclk,
        hresetn,
        hwrite,
        htrans,
        error_check,
        state
	);

    input   wire            hclk;
    input   wire            hresetn;
    input   wire            hwrite;
    input   wire [1:0]      htrans;
    input   wire            error_check;
    output  wire [1:0]      state;

    //htrans types
    localparam  IDLE=2'b00;
    localparam  BUSY=2'b01;
    localparam  NONSEQ=2'b10;
    localparam  SEQ=2'b11;
    //FSM reg
    localparam  [1:0]   STATE_IDLE=2'b00;
    localparam  [1:0]   STATE_WRITE=2'b01;
    localparam  [1:0]   STATE_WR2RD=2'b11;
    localparam  [1:0]   STATE_READ=2'b10;

    reg [1:0]   state_cur;
    reg [1:0]   state_nxt;

    assign state = state_cur;

    //state trans
    always @(posedge hclk or negedge hresetn) begin
        if (~hresetn) begin
            // reset
            state_cur <= STATE_IDLE;
        end
        else begin
            state_cur <= state_nxt;
        end
    end

    //conditional jump
    always @(*) begin
        if (error_check) begin
            state_nxt = STATE_IDLE;
        end
        else begin
            case(state_cur)
                STATE_IDLE:begin
                    if ((htrans==NONSEQ)&hwrite) begin
                        state_nxt = STATE_WRITE;
                    end
                    else if ((htrans==NONSEQ)&(~hwrite)) begin
                        state_nxt = STATE_READ;
                    end
                    else begin
                        state_nxt = STATE_IDLE;
                    end
                end
                STATE_WRITE:begin
                    if (htrans==IDLE) begin
                        state_nxt = STATE_IDLE;
                    end
                    else if (~hwrite) begin
                        state_nxt = STATE_WR2RD;
                    end
                    else begin
                        state_nxt = STATE_WRITE;
                    end
                end
                STATE_WR2RD:begin
                    state_nxt = STATE_READ;
                end
                STATE_READ:begin
                    if (htrans==IDLE) begin
                        state_nxt = STATE_IDLE;
                    end
                    else if (hwrite) begin
                        state_nxt = STATE_WRITE;
                    end
                    else begin
                        state_nxt = STATE_READ;
                    end
                end
            endcase
        end
    end

endmodule