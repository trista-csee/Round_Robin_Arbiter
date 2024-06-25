module round_robin_arbiter_tb ();
    parameter NumRequests = 4;

    reg clk;
    reg rstN;
    reg [NumRequests-1:0] request;
    wire [NumRequests-1:0] grant;
    
    // Connect the DUT
    round_robin_arbiter #(NumRequests) DUT (
        .clk(clk),
        .rstN(rstN),
        .request(request),
        .grant(grant));

    // Clock generator
    always #1 clk = ~clk; // 2ns = 500MHz
    
    initial begin
        clk = 0;
        rstN = 0;
        request = 0;
        
        #10 
        rstN = 1;
        
        repeat (1) @ (posedge clk);
        request[0] <= 1;
        
        repeat (1) @ (posedge clk);
        request[0] <= 0;
        
        repeat (1) @ (posedge clk);
        request[0] <= 1;
        request[1] <= 1;
        
        repeat (1) @ (posedge clk);
        request[2] <= 1;
        request[1] <= 0;
        
        repeat (1) @ (posedge clk);
        request[3] <= 1;
        request[2] <= 0;
        
        repeat (1) @ (posedge clk);
        request[3] <= 0;
        
        repeat (1) @ (posedge clk);
        request[0] <= 0;
        
        repeat (1) @ (posedge clk);
        
        #10 
        $finish;
    end 

endmodule