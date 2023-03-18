module multiplex2to1(
    input select,
    input En,
    input a,
    input b,
    output y
);
    assign y = En?((select)?a:b):0;;
endmodule