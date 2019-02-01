module ADDmod #(parameter N=32)(input logic  [N-1:0] A,B,P,
                                output logic [N-1:0] R);

logic [N:0]C,D; 

always_comb
  begin
    C=A+B;
    D=C-P;

    if (C<P)
      R=C;
    else if(D<P)
      R=D;
    else
      R='b0;
  end
endmodule