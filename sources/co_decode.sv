module co_decode(input logic clk, 
                 input logic [63:0]Proc_in, 
                 output logic rst_add1,rst_add2,rst_mul,
                              //SEL1,SEL2,
                 output logic Read_result,write, 
                 output logic [5 :0]   prime_adr,
                 output logic [4 :0]   AdR1 [3],
	               output logic [4 :0]   AdR2 [3],
	               output logic [4 :0]   AdW  [3],
	               output logic [14:0]   mem_adr);
	                      
always@(negedge clk)
	begin 
    AdR1[0]       =  Proc_in[13:9];
    AdR1[1]       =  Proc_in[18:14];
    AdR1[2]       =  Proc_in[23:19];
    
	  AdR2[0]       =  Proc_in[28:24];
	  AdR2[1]       =  Proc_in[33:29];
	  AdR2[2]       =  Proc_in[38:34];

	  AdW[0]        =  Proc_in[43:39]; 
	  AdW[1]        =  Proc_in[48:44];
	  AdW[2]        =  Proc_in[53:49];
	               
    Read_result   =  Proc_in[54];
    write         =  Proc_in[55];
    mem_adr       =  Proc_in[63:56];  //5 bits of memory adress 
  end
  
  
always@(negedge clk)
    case (Proc_in[2:0])

      3'b000:begin
                 rst_add1= 1;
                 rst_add2= 1;
                 rst_mul= 1;
                 //SEL1= 0;
                 //SEL2= 0;
                 prime_adr= 'b0;
               end

      3'b001:begin
                 rst_add1= 0;
                 rst_add2= 1;
                 rst_mul= 1;
                 //SEL1= 0;
                 //SEL2= 0;
                 prime_adr= Proc_in[8:3];
               end

      3'b010:begin
                 rst_add1= 1;
                 rst_add2= 0;
                 rst_mul= 1;
                 //SEL1= 1;
                 //SEL2= 0;
                 prime_adr= Proc_in[8:3];
               end

      3'b011:begin
                 rst_add1= 0;
                 rst_add2= 0;
                 rst_mul= 1;
                 //SEL1= 0;
                 //SEL2= 0;
                 prime_adr= Proc_in[8:3];
               end

      3'b100:begin
                 rst_add1= 0;
                 rst_add2= 0;
                 rst_mul= 1;
                 //SEL1= 1;
                 //SEL2= 0;
                 prime_adr= Proc_in[8:3];
               end

      3'b101:begin
                 rst_add1= 0;
                 rst_add2= 1;
                 rst_mul= 0;
                 //SEL1= 0;
                 //SEL2= 1;
                 prime_adr= Proc_in[8:3];
               end

      3'b110:begin
                 rst_add1= 1;
                 rst_add2= 0;
                 rst_mul= 0;
                 //SEL1= 1;
                 //SEL2= 1;
                 prime_adr= Proc_in[8:3];
               end

      3'b111:begin
                 rst_add1= 0;
                 rst_add2= 0;
                 rst_mul= 0;
                 //SEL1= 0;
                 //SEL2= 0;
                 prime_adr= Proc_in[8:3];
               end

      default :begin
                 rst_add1= 1;
                 rst_add2= 1;
                 rst_mul= 1;
                 //SEL1= 0;
                 //SEL2= 0;
                 prime_adr= 'b0;             
               end
    endcase
  
endmodule