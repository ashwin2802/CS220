module priority_encoder(a,b);
    input[7:0] a;
    output wire [2:0] b;

    // Combinational Logic using SOP and reduction
    assign b[0] = (a[1]&~a[0]) | (a[3]& ~(a[2]|a[1]|a[0])) | (a[5]& ~(a[4]|a[3]|a[2]|a[1]|a[0])) | (a[7]& ~(a[6]|a[5]|a[4]|a[3]|a[2]|a[1]|a[0]));
    assign b[1] = (~(a[1]|a[0]) & (a[2]|(a[3]&~a[2]))) | (~(a[5]|a[4]|a[3]|a[2]|a[1]|a[0]) & (a[6]|(~a[6]&a[7])));
    assign b[2] = ~(a[3]|a[2]|a[1]|a[0]) & (a[4] | (a[5]&~a[4]) | (a[6]&~(a[5]|a[4])) | (a[7]&~(a[6]|a[5]|a[4])));
    
endmodule