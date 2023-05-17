module sram_ctr_ahb_addr(
        hclk,
        hresetn,
        htrans,
        hburst,
        haddr,
        error_check,
        sram_a
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

    input   wire            hclk;
    input   wire            hresetn;
    input   wire    [1:0]   htrans;
    input   wire    [2:0]   hburst;
    input   wire    [31:0]  haddr;
    input   wire            error_check;
    output  wire    [11:0]  sram_a;

    reg [11:0]  addr;

    assign sram_a = addr;

    always @(posedge hclk or negedge hresetn) begin
        if (~hresetn) begin
            addr <= 12'd0;
        end
        else begin
            if (~error_check) begin
                case(htrans)
                    NONSEQ:begin
                        addr <= haddr[13:2];
                    end
                    SEQ:begin
                        case(hburst)
                            INCR, INCR4, INCR8, INCR16:begin
                               addr <= addr+1;
                            end
                            WRAP4:begin
                                if (addr[1:0]==2'b11) begin
                                    addr <= {addr[11:2], 2'b00};
                                end
                                else begin
                                    addr <= addr+1;
                                end
                            end
                            WRAP8:begin
                                if (addr[2:0]==3'b111) begin
                                    addr <= {addr[11:3], 3'b000};
                                end
                                else begin
                                    addr <= addr+1;
                                end
                            end
                            WRAP16:begin
                                if (addr[3:0]==4'b1111) begin
                                    addr <= {addr[11:4], 4'b0000};
                                end
                                else begin
                                    addr <= addr+1;
                                end
                            end
                        endcase
                    end
                    default:begin
                        addr <= addr;
                    end
                endcase
            end
        end
    end

endmodule