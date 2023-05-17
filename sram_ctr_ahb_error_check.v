module sram_ctr_ahb_error_check(
        hsize,
        htrans,
        haddr,
        hburst,
        state,
        error_check
	);

    //htrans types
    localparam  IDLE=2'b00;
    localparam  BUSY=2'b01;
    localparam  NONSEQ=2'b10;
    localparam  SEQ=2'b11;
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
    //FSM reg
    localparam  [1:0]   STATE_IDLE=2'b00;
    localparam  [1:0]   STATE_WRITE=2'b01;
    localparam  [1:0]   STATE_WR2RD=2'b11;
    localparam  [1:0]   STATE_READ=2'b10;

    input   wire    [2:0]   hsize;
    input   wire    [1:0]   htrans;
    input   wire    [31:0]  haddr;
    input   wire    [2:0]   hburst;
    input   wire    [1:0]   state;
    output  wire            error_check;

    wire    aligned_check;
    wire    size_check;
    reg     addr_boundary_check;
    wire    state_related_check;

    assign error_check = (aligned_check | size_check) | (addr_boundary_check | state_related_check);

    assign aligned_check = (htrans == NONSEQ) & (haddr[1:0] != 2'b00);
    
    assign size_check = (htrans == NONSEQ) & (hsize != SIZE_W);

    always @(*) begin
        addr_boundary_check = 0;

        if (htrans==NONSEQ) begin
            case(hburst)
                INCR4:begin
                    if ((haddr[13:2]+3) > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
                INCR8:begin
                    if ((haddr[13:2]+7) > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
                INCR16:begin
                    if ((haddr[13:2]+15) > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
                WRAP4:begin
                    if ({haddr[13:4], 2'b11} > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
                WRAP8:begin
                    if ({haddr[13:5], 3'b111} > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
                WRAP16:begin
                    if ({haddr[13:6], 4'b1111} > 12'd4095) begin
                        addr_boundary_check = 1;
                    end
                end
            endcase
        end
    end

    assign state_related_check = (state==STATE_IDLE) & ((htrans==SEQ)|(htrans==BUSY));

endmodule