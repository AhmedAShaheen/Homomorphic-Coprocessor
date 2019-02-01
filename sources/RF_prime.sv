module RF_prime #(
  parameter XLEN    = 33,
  parameter AR_BITS=6
)
(
  input  logic              clk,
  //Register File read
  input  logic[AR_BITS-1:0] rf_adr,
  output logic[XLEN   -1:0] rf_src[2],
  //Register File write
  input  logic[AR_BITS-1:0] rf_dst,
  input  logic[XLEN   -1:0] rf_dstw
);

//Actual register file
logic [XLEN-1:0] rf [128];

//Reads are asynchronous
     //per Altera's recommendations. Prevents bypass logic
     always @(posedge clk) rf_src[0] <= rf[ rf_adr   ];
     always @(posedge clk) rf_src[1] <= rf[ rf_adr+1 ];

	 
//Writes are synchronous
     always @(posedge clk) rf[ rf_dst] <= rf_dstw;

endmodule


