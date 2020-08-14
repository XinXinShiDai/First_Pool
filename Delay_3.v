module Delay_3(
	input  aclk,
	input  aresetn,
	input  iStart,
	output oStart
);

reg [2:0] Start_Delay; // 数据位宽决定了延时长度；

always @(posedge aclk or negedge aresetn) begin
    if(!aresetn) begin
        Start_Delay <= 0;
    end
    else begin
        Start_Delay[0] <= iStart;
        Start_Delay[1] <= Start_Delay[0];
        Start_Delay[2] <= Start_Delay[1];
    end
end

assign oStart = Start_Delay[2];

endmodule