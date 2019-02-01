`timescale 1ns/100ps
module test_modMULT(); 

logic clk;
logic [31:0] a,b,p,c;
logic [32:0] t;

MULTmod MULT(.clk(clk), .A(a), .B(b), .P(p), .T(t), .C(c));

always #0.5 clk = ~clk;

initial
begin
  clk='b0;
  
  a='b10100110111111100010110111101111;
  b='b11111111001011110111111011011101;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #1
  a='b11101001101100101110111110100111;
  b='b11100001001011011001100001110101;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #1
  a='b11000101001001110110100001001001;
  b='b11010100101110110110100110011101;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #1
  a='b11011101001011011011011011100111;
  b='b10101100000000110101111100000001;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #1
  a='b11011000011111101011100101001011;
  b='b11000011111110010000010111111001;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #1
  a='b11111111000000001110010110111101;
  b='b10100101110011000011111111010111;
  p='b11110101110011010011100001001011;
  t='b100001010100111110001101000010110;
  #7
  $finish;
end

always@(posedge clk)
begin
  #4.5;
  if (c==32'b10110011110111110101001000110110)
    begin
    $display ("-------Testbench Result-------");
    $display ("----------pass first----------");
    $display ("  expected   = 10111111001111111000010011011100");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed first---------");
    $display ("  expected   = 10111111001111111000010011011100");
    $display ("  Test   = %b", c);
    end
  #1;
  if (c==32'b10110101101110110000111001101001)
    begin
    $display ("----------pass second----------");
    $display ("  expected   = 00000000000000000000000011000001");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed second---------");
    $display ("  expected   = 00000000000000000000000011000001");
    $display ("  Test   = %b", c);
    end
  #1;
  if (c==32'b1100000111000110001111111011)
    begin
    $display ("----------pass third----------");
    $display ("  expected   = 10110001101100001111011110111010");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed third---------");
    $display ("  expected   = 10110001101100001111011110111010");
    $display ("  Test   = %b", c);
    end
  #1;
  if (c==32'b10111110011111001010001110101100)
    begin
    $display ("----------pass fourth----------");
    $display ("  expected   = 11100011100001101100001000010000");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed fourth---------");
    $display ("  expected   = 11100011100001101100001000010000");
    $display ("  Test   = %b", c);
    end
  #1;
  if (c==32'b11000010000110010100010000010000)
    begin
    $display ("----------pass fifth----------");
    $display ("  expected   = 11000101110111101101010000111110");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed fifth---------");
    $display ("  expected   = 11000101110111101101010000111110");
    $display ("  Test   = %b", c);
    end
  #1;
  if (c==32'b10000010000101100000110001101110)
    begin
    $display ("----------pass sixth----------");
    $display ("  expected   = 11000101110111101101010000111110");
    $display ("  Test   = %b", c);
    end
  else
    begin
    $display ("---------failed sixth---------");
    $display ("  expected   = 11000101110111101101010000111110");
    $display ("  Test   = %b", c);
    end
  #0.5;
end
endmodule

