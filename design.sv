// Code your design here
module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

always @(A,B,Op_code)
begin
case(Op_code)
3'd0 : Y = A;
3'd1 : Y = A+B;
3'd2 : Y = A-B;
3'd3 : Y = A & B;
3'd4 : Y = A | B;
3'd5 : Y = A + 1;
3'd6 : Y = A - 1;
3'd7 : Y = B;
endcase
end
endmodule

