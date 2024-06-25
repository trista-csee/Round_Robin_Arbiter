/*
use fixed priority and always_comb statement to implement an arbiter 
that selects one of the requesters based on priority.

A fixed priority arbiter selects one of the requesters based on a predefined priority scheme. 
In a fixed priority arbiter, the highest priority request is granted access first. 
If multiple requests have the same priority, the arbiter selects one of the requests in a round-robin fashion.
*/
module fixed_priority_arbiter #(parameter NumRequests = 4) (
    /*
    the input signal request is a NumRequests-bit vector that indicates which requesters are requesting access. 
    The output signal grant is also a NumRequests-bit vector that indicates which requester is granted access.
    */
    input logic [NumRequests-1:0] request,
    output logic [NumRequests-1:0] grant
);  
    
    /*
    The always_comb block uses a for loop to iterate through all of the requests and select the highest priority requester. 
    If multiple requests have the same priority, the arbiter selects one of the requests in a round-robin fashion.
    */
    always_comb begin
        grant = '0;
        
        for (int i = 0; i < NumRequests; i++) begin
            if (request[i]) begin
                grant[i] = 1;
                break;
            end
        end
    end

endmodule