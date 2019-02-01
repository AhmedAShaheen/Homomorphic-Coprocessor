module MULTmod(
      input logic clk,
			input logic  [31:0]A,B,
			input logic  [31:0]P,
      input logic  [32:0]T,
      output logic signed[31:0]C);

	  logic [63:0]X;
	  logic [65:0]R;
		logic [63:0]Y;
    logic [32:0]W,u1,u2,k,l,m;
		
  always_ff@(posedge clk) 
  begin
    X <= A * B;  
  end    
  
  always_ff@(posedge clk) 
  begin
    R <= T * X[63:31];  
	end 
	
	always_ff@(posedge clk) 
  begin
    Y <= R[65:33] * P;        
  end
  
  always_ff@(posedge clk) 
  begin
    W <= u2 - Y[32:0];
  end
  
  always_ff@(posedge clk) 
  begin  
    l = (W - P)-P;
    k = W - P;
    m = W;
    if (m>2*P) C<=l;
    else if (m>P) C<=k;
    else C<= m;
  end

  always_ff@(posedge clk)
  begin
    u1 <= X[32:0];
    u2 <= u1;
  end   
		
endmodule