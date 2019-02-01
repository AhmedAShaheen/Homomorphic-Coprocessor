module RF #(
  parameter XLEN    = 1024,
  parameter RDPORTS = 3,
  parameter WRPORTS = 3,
  parameter AR_BITS=5
)
(
  input  logic              clk,
  //Register File read
  input  logic[AR_BITS-1:0] rf_src1  [RDPORTS],
  input  logic[AR_BITS-1:0] rf_src2  [RDPORTS],
  output logic[XLEN   -1:0] rf_srcv1 [RDPORTS],
  output logic[XLEN   -1:0] rf_srcv2 [RDPORTS],
  //Register File write
  input  logic[AR_BITS-1:0] rf_dst   [WRPORTS],
  input  logic[XLEN   -1:0] rf_dstv  [WRPORTS]
);

//Actual register file
logic [XLEN-1:0] rf [32];
//read data from register file
logic            src1_is_x0 [RDPORTS],
                 src2_is_x0 [RDPORTS],
				         src1_is_x1 [RDPORTS],
                 src2_is_x1 [RDPORTS];
logic [XLEN-1:0] dout1 [RDPORTS],
                 dout2 [RDPORTS];
//variable for generates
genvar i;

//Reads are asynchronous
generate
  for(i=0; i<RDPORTS; i=i+1)
  begin: xreg_rd
     //per Altera's recommendations. Prevents bypass logic
     always @(posedge clk) dout1[i] <= rf[ rf_src1[i] ];
     always @(posedge clk) dout2[i] <= rf[ rf_src2[i] ];

     //got data from RAM, now handle X0
     always @(posedge clk) src1_is_x0[i] <= ~|rf_src1[i];
     always @(posedge clk) src2_is_x0[i] <= ~|rf_src2[i];
	   always @(posedge clk) src1_is_x1[i] <= (~|rf_src1[i])|(rf_src1[1][i]);
     always @(posedge clk) src2_is_x1[i] <= (~|rf_src2[i])|(rf_src1[1][i]);
     assign rf_srcv1[i] = src1_is_x0[i] ? {XLEN{1'b0}} : (src1_is_x1[i] ? {XLEN{1'b1}} :dout1[i]);
     assign rf_srcv2[i] = src2_is_x0[i] ? {XLEN{1'b0}} : (src1_is_x1[i] ? {XLEN{1'b1}} :dout2[i]);

  end
endgenerate

//Writes are synchronous
generate
  for(i=0; i<WRPORTS; i=i+1)
  begin: xreg_wr
      always @(posedge clk)
        rf[ rf_dst[i]] <= rf_dstv[i];
  end
endgenerate

endmodule
