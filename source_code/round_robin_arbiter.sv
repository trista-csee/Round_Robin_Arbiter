/*
 In this design of the round-robin arbiter, 
 two fixed priority arbiters are utilized to manage requests for a shared resource. 
 The first arbiter, the unmasked arbiter, processes the original request. 
 The second arbiter, the masked arbiter, processes the request ANDed with a mask. 
 The masked arbiter takes priority over the unmasked one. 
 If there is no masked request, the unmasked arbiter's result is used. 
 However, if there is a masked request, the masked arbiter's result takes precedence. 
 The mask determines which request has priority.
*/
module round_robin_arbiter #(parameter NumRequests = 8) (
    input logic clk,
    input logic rstN,
    input logic [NumRequests-1:0] request,
    output logic [NumRequests-1:0] grant
);

    logic [NumRequests-1:0] mask, maskNext;
    logic [NumRequests-1:0] maskedRequest;
    logic [NumRequests-1:0] unmaskedGrant;
    logic [NumRequests-1:0] maskedGrant;
    
    /*
    The maskedRequest expression is a bitwise AND between the original request and the mask. 
    This variable ensures that only requests with priority (i.e., those with a set mask bit) are processed by the masked arbiter. 
    */
    assign maskedRequest = request & mask;
    
    // The first arbiter, the unmasked arbiter, processes the original request.
    fixed_priority_arbiter #(.NumRequests(NumRequests)) arbiter (
        .request(request),
        .grant(unmaskedGrant));
    
    // The second arbiter, the masked arbiter, processes the request ANDed with a mask.
    fixed_priority_arbiter #(.NumRequests(NumRequests)) maskedArbiter (
        .request(maskedRequest),
        .grant(maskedGrant));
        
    /*
    The grant output is determined by the ternary operator, which checks whether the maskedRequest expression is 0. 
    If it is, the unmasked arbiter's result is used. 
    If it is not, the masked arbiter's result is used.
    */
    assign grant = (maskedRequest == '0) ? unmaskedGrant : maskedGrant;
    
    /*
    The mask update logic is a crucial element of the design, 
    which ensures that requests are processed in a circular fashion, 
    promoting statistical fairness and preventing starvation.

    When the N-th bit is granted, the subsequent bits above N must have priority in the next cycle. 
    To accomplish this, the MSB:N+1 bits are set to 1, while the remaining bits are set to 0. 
    
    For example, if the grant vector is 00001000, the mask will be 11110000 in the next cycle. 
    Requests in the MSB 4 bits are granted access, but if there are no requests in these bits, the unmasked arbiter's result is used. 
    If no grant occurs during the cycle, the mask remains unchanged.
    */
    
    // The maskNext variable is updated in the combinational block. 
    always_comb begin
        if (grant == '0)
            maskNext = mask;
        // When a request is granted, the bits above the granted bit are given priority in the next cycle. 
        else begin
            maskNext = '1;
            
            //The for loop in the combinational block iterates through the granted bits to determine which bit has the highest priority. 
            for (int i = 0; i < NumRequests; i++) begin
                maskNext[i] = 1'b0;
                if (grant[i]) 
                    break;
            end
        end
    end

    /*
    The mask variable is updated in the synchronous block using a flip-flop, 
    which is triggered by a positive edge clock or negative edge reset signal.
    */
    always_ff @(posedge clk or negedge rstN) begin
        if (!rstN) 
            mask <= '1;
        else 
            mask <= maskNext;
    end

endmodule