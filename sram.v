//`define WRITE_TEST

module sram #(
        parameter WIDTH=10,
        parameter DEPTH=64,
        parameter WIDTH_ADDR=$clog2(DEPTH)
    )
    (
		clk,
		rst_n,
		csen_n,
		we,
		addr,
		din,
		dout_reg,
        dout
	);

    input   wire                        clk;
    input   wire                        rst_n;
    input   wire                        csen_n;
    input   wire                        we;
    input   wire    [WIDTH_ADDR-1:0]    addr;
    input   wire    [WIDTH-1:0]         din;
    output  reg     [WIDTH-1:0]         dout_reg;
    output  wire    [WIDTH-1:0]         dout;

    reg [WIDTH-1:0] ram [0:DEPTH-1];

`ifdef WRITE_TEST

    reg [WIDTH_ADDR-1:0]    addr_d;

    always @(posedge clk) begin
        addr_d <= addr;
    end

    assign dout = ram[addr_d];

`else

    assign dout = ram[addr];

`endif

    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            for (i=0; i<DEPTH; i=i+1) begin
                ram[i] <= 0;
            end
        end
        else if (~csen_n) begin
            if (we) begin
                ram[addr] <= din;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            dout_reg <= 0;
        end
        else if (~csen_n) begin
            if (~we) begin
                dout_reg <= ram[addr];
            end
        end
    end

endmodule