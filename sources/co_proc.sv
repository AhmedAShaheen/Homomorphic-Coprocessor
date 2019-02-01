module co_proc 
#(parameter RDPORTS = 3,
  parameter WRPORTS = 3,
  parameter n=32, 
  parameter N=32*n
 )
(
	input  logic clk,Read_result,write,
	input 	logic [31:0] 	P,
	input 	logic [32:0]	 REC,
	input  logic [4:0]   AdR1 [3],
	input  logic [4:0]   AdR2 [3],
	input  logic [4:0]   AdW  [3],
  input	 logic [N-1:0]	W_in [3],
	output	logic [N-1:0]	R_out[3],
	input  logic rst_add1,rst_add2,rst_mul
 );
	
	logic  [N-1:0] IN1[3];
	logic  [N-1:0] INr1[3];
	logic  [N-1:0] IN2[3];
	logic  [N-1:0] INr2[3];
	logic  [N-1:0] OUT1,OUT2,OUT3;
	logic  [N-1:0] WR[3];
					
genvar i;
genvar j;
genvar k;
//first adder unit
generate
for(i=0;i<n;++i)
	begin
		ADDmod ADD1 (.A(IN1[0][N-(i*32)-1:N-((i+1)*32)]),
				         .B(IN2[0][N-(i*32)-1:N-((i+1)*32)]),
				         .P(P[31:0]), 
				         .R(OUT1[N-(i*32)-1:N-((i+1)*32)]));	  
	end
endgenerate

//multiplier unit
generate	
for(j=0;j<n;++j)
	begin
		MULTmod MUL(	.clk(clk),
		             .A(IN1[1][N-(j*32)-1:N-((j+1)*32)]),
				         .B(IN2[1][N-(j*32)-1:N-((j+1)*32)]), 
					       .P(P[31:0]), 
					       .T(REC[32:0]),  
					       .C(OUT2[N-(j*32)-1:N-((j+1)*32)]));
	end
endgenerate

//second adder unit
generate
for(k=0;k<n;++k)
	begin
		ADDmod ADD2 (.A(IN1[2][N-(k*32)-1:N-((k+1)*32)]),
				         .B(IN2[2][N-(k*32)-1:N-((k+1)*32)]),
				         .P(P[31:0]),
				         .R(OUT3[N-(k*32)-1:N-((k+1)*32)]));	  
	end
endgenerate

//Register File
    RF#(N,RDPORTS,WRPORTS,5)
    R1(.clk(clk), .rf_src1(AdR1), .rf_src2(AdR2),
     .rf_srcv1(INr1), .rf_srcv2(INr2), .rf_dst(AdW), .rf_dstv(WR));

//Choose output     
always@(posedge clk,rst_add1)
  if (rst_add1)
    begin
      IN1[0]<='b0;
      IN2[0]<='b0;
    end
  else
    begin
      IN1[0]<=INr1[0];
      IN2[0]<=INr2[0];
    end
    
always@(posedge clk,rst_mul)
  if (rst_mul)
    begin
      IN1[1]<='b0;
      IN2[1]<='b0;
    end
  else
    begin
      IN1[1]<=INr1[1];
      IN2[1]<=INr2[1];
    end
    
always@(posedge clk,rst_add2)
  if (rst_add2)
    begin
      IN1[2]<='b0;
      IN2[2]<='b0; 
    end
  else
    begin
      IN1[2]<=INr1[2];
      IN2[2]<=INr2[2];
    end
    
always@(posedge clk)    
  if (Read_result)
    begin
      R_out[0]<=OUT1;
      R_out[1]<=OUT2;
      R_out[2]<=OUT3;
    end
  else
    begin
      WR[0]<=OUT1;
      WR[1]<=OUT2;
      WR[2]<=OUT3;
    end
    
always@(posedge clk)
  if (write)
    begin
      WR[0]<=W_in[0];
      WR[1]<=W_in[1];
      WR[2]<=W_in[2];
    end
  else
    begin
      WR[0]<=OUT1;
      WR[1]<=OUT2;
      WR[2]<=OUT3;
    end
endmodule