
`timescale 1ns/1ps

module tb_sram_ahb_wrapper (); /* this is automatically generated */

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

	// clock
	logic hclk;
	initial begin
		hclk = '0;
		forever #(0.5) hclk = ~hclk;
	end

	// synchronous reset
	logic hresetn;
	initial begin
		hresetn <= '0;
		repeat(10)@(posedge hclk);
		hresetn <= '1;
	end

	// (*NOTE*) replace reset, clock, others

	parameter      WIDTH = 32;
	parameter      DEPTH = 4096;
	parameter WIDTH_ADDR = $clog2(DEPTH);

	logic        hwrite;
	logic  [1:0] htrans;
	logic  [2:0] hsize;
	logic [31:0] haddr;
	logic  [2:0] hburst;
	logic [31:0] hwdata;
	logic        hready;
	logic  [1:0] hresp;
	logic [31:0] hrdata;
	logic 	     sram_csn;
	logic [11:0] sram_a;
	logic [31:0] sram_d;
	logic [31:0] sram_q;

	sram_ahb_wrapper #(
			.WIDTH(WIDTH),
			.DEPTH(DEPTH),
			.WIDTH_ADDR(WIDTH_ADDR)
		) inst_sram_ahb_wrapper (
			.hclk    (hclk),
			.hresetn (hresetn),
			.hwrite  (hwrite),
			.htrans  (htrans),
			.hsize   (hsize),
			.haddr   (haddr),
			.hburst  (hburst),
			.hwdata  (hwdata),
			.hready  (hready),
			.hresp   (hresp),
			.sram_csn(sram_csn),
			.sram_a  (sram_a),
			.sram_d  (sram_d),
			.sram_q  (sram_q),
			.hrdata  (hrdata)
		);

	// always_ff @(posedge hclk) begin
	// 	if (hresp==ERROR) begin
	// 		$display("ERROR happens when\n");
	// 		$display("hwrite=%b\n", hwrite);
	// 		$display("htrans=%b\n", htrans);
	// 		$display("hsize=%b\n", hsize);
	// 		$display("haddr=%b\n", haddr);
	// 		$display("hburst=%b\n", hburst);
	// 		$stop;
	// 	end
	// end

	initial begin

		init();
		repeat(12)@(posedge hclk);

		// write_single(2);

		// write_burst_incr4(2);

		// write_burst_incr8();

		// write_burst_incr16();

		// write_burst_wrap4(2);

		// read_single(4);

		// write_single();

		// read_burst_incr4(2);

		// read_burst_incr8();

		// read_burst_incr16();

		// read_burst_wrap4(2);

		//wr2rd();

		//rd2wr();

		// error_state_related();

		// error_size_check();

		 error_addr_boundary_check();

		// error_aliagned_check();

		repeat(10)@(posedge hclk);
		$stop;
	end

	task init();
		hwrite  <= '0;
		htrans  <= IDLE;
		hsize   <= SIZE_W;
		haddr   <= '0;
		hburst  <= SINGLE;
		hwdata  <= 0;
	endtask

	integer wait_i=0;

	task write_single(int ITER);
		$display("the single write test begin\n");
		//the first control+addr
		hwrite <= 1;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		//the current data & the next control+addr
		for (int i = 1; i <= ITER; i++) begin
			if (i==ITER) begin
				htrans <= IDLE;
			end
			hwdata <= i;
			haddr <= (i+1)<<2;
			$display("the hwdata(%d) is being stored into sram[%d]\n", hwdata, sram_a);
			@(posedge hclk);
			while (hready == 0) begin
				$display("this is the %d times that hready=0", (wait_i+1));
				wait_i <= wait_i+1;
				@(posedge hclk);
			end
			$display("the %d times store finishes", i);
		end

		$display("the single write test end\n");

	endtask

	task write_burst_incr4(int ITER);
		for (int i = 0; i < ITER; i++) begin
			//the first control+addr
			hwrite <= 1;
			htrans <= NONSEQ;
			hburst <= INCR4;
			haddr  <= (4*i+1)<<2;
			@(posedge hclk);

			//the current data & the next control+addr
			for (int j = 0; j < 4; j++) begin
				hwdata <= (4*i+1)+j;
				if (j != 3) begin
					htrans <= SEQ;
					//haddr <= ((4*i+1)+(j+1))<<2;
				end
				else begin
					htrans <= IDLE;
				end
				@(posedge hclk);

				while (hready == 0) begin
					$display("this is the %d times that hready=0", (wait_i+1));
					wait_i <= wait_i+1;
					@(posedge hclk);
				end
			end
		end
	endtask

	task write_burst_incr8();
		
	endtask

	task write_burst_incr16();
		
	endtask

	task write_burst_wrap4(int ITER);
		for (int i = 0; i < ITER; i++) begin
			//the first control+addr
			hwrite <= 1;
			htrans <= NONSEQ;
			hburst <= WRAP4;
			haddr  <= (4*i+2+i)<<2;
			@(posedge hclk);

			//the current data & the next control+addr
			for (int j = 0; j < 4; j++) begin
				hwdata <= (4*i+1)+j;
				if (j != 3) begin
					htrans <= SEQ;
					//haddr <= ((4*i+1)+(j+1))<<2;
				end
				else begin
					htrans <= IDLE;
				end
				@(posedge hclk);

				while (hready == 0) begin
					$display("this is the %d times that hready=0", (wait_i+1));
					wait_i <= wait_i+1;
					@(posedge hclk);
				end
			end
		end
	endtask

	task read_single(int ITER);

		//the first control+addr
		hwrite <= 0;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		//the current data & the next control+addr
		for (int i = 1; i <= ITER; i++) begin
			if (i==ITER) begin
				htrans <= IDLE;
			end
			haddr <= (i+1)<<2;
			@(posedge hclk);
			while (hready == 0) begin
				$display("this is the %d times that hready=0", (wait_i+1));
				wait_i <= wait_i+1;
				@(posedge hclk);
			end
		end

	endtask

	task read_burst_incr4(int ITER);
		for (int i = 0; i < ITER; i++) begin
			//the first control+addr
			hwrite <= 0;
			htrans <= NONSEQ;
			hburst <= INCR4;
			haddr  <= (4*i+1)<<2;
			@(posedge hclk);

			//the current data & the next control+addr
			for (int j = 0; j < 4; j++) begin
				if (j != 3) begin
					htrans <= SEQ;
					//haddr <= ((4*i+1)+(j+1))<<2;
				end
				else begin
					htrans <= IDLE;
				end
				@(posedge hclk);

				while (hready == 0) begin
					$display("this is the %d times that hready=0", (wait_i+1));
					wait_i <= wait_i+1;
					@(posedge hclk);
				end
			end
		end
	endtask

	task read_burst_incr8();
		
	endtask

	task read_burst_incr16();
		
	endtask

	task read_burst_wrap4(int ITER);
		for (int i = 0; i < ITER; i++) begin
			//the first control+addr
			hwrite <= 0;
			htrans <= NONSEQ;
			hburst <= WRAP4;
			haddr  <= (4*i+2+i)<<2;
			@(posedge hclk);

			//the current data & the next control+addr
			for (int j = 0; j < 4; j++) begin
				if (j != 3) begin
					htrans <= SEQ;
					//haddr <= ((4*i+1)+(j+1))<<2;
				end
				else begin
					htrans <= IDLE;
				end
				@(posedge hclk);

				while (hready == 0) begin
					$display("this is the %d times that hready=0", (wait_i+1));
					wait_i <= wait_i+1;
					@(posedge hclk);
				end
			end
		end
	endtask

	task wr2rd();
		//the first ctrl+addr
		hwrite <= 1;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);	

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the first data & the second ctrl+addr
		hwdata <= 1;
		hwrite <= 1;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 2<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the second data & third ctrl+addr
		hwdata <= 2;
		hwrite <= 0;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the third data & fourth ctrl+addr
		hwrite <= 0;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 2<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the fourth data & fifth ctrl+addr
		hwrite <= 0;
		htrans <= IDLE;
		hburst <= SINGLE;
		@(posedge hclk);

	endtask

	task rd2wr();
		//the first ctrl+addr
		hwrite <= 0;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);	

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the first data & the second ctrl+addr
		hwrite <= 0;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 2<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the second data & third ctrl+addr
		hwrite <= 1;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the third data & fourth ctrl+addr
		hwdata <= 3;
		hwrite <= 1;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 2<<2;
		@(posedge hclk);

		while (hready == 0) begin
			$display("this is the %d times that hready=0", (wait_i+1));
			wait_i = wait_i+1;
			@(posedge hclk);
		end

		//the fourth data & fifth ctrl+addr
		hwdata <= 4;
		htrans <= IDLE;
		hburst <= SINGLE;
		@(posedge hclk);

	endtask

	task error_state_related();
		hwdata <= 3;
		hwrite <= 1;
		htrans <= BUSY;
		hburst <= SINGLE;
		haddr  <= 2<<2;
		@(posedge hclk);

		if (hresp==ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		htrans <= SEQ;
		@(posedge hclk);

		if (hresp==ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

	endtask

	task error_size_check();
		hwrite <= 1;
		hsize <= SIZE_HW;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		hwrite <= 1;
		hsize <= SIZE_W_2;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		hwrite <= 1;
		hsize <= SIZE_W;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 1<<2;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		hwdata <= 1;
		htrans <= IDLE;
		@(posedge hclk);

	endtask

	task error_aliagned_check();
		hwrite <= 1;
		hsize <= SIZE_W;
		htrans <= NONSEQ;
		hburst <= SINGLE;
		haddr  <= 2'b01;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		htrans <= NONSEQ;
		haddr <= 2'b10;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end

		htrans <= NONSEQ;
		haddr <= 2'b11;
		@(posedge hclk);

		if (hresp == ERROR) begin
			htrans <= IDLE;
			@(posedge hclk);
		end
	endtask

	task error_addr_boundary_check();
		hwrite <= 1;
		hsize <= SIZE_W;
		htrans <= NONSEQ;
		hburst <= INCR8;
		haddr  <= 32'h0000_3ff0;
		@(posedge hclk);
	endtask

	always_ff @(posedge hclk) begin : proc_htrans
		if (hresp==ERROR) begin
			htrans <= IDLE;
		end	
	end

endmodule
