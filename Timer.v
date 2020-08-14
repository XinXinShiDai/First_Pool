module Timer(
S_AXIS_ACLK,S_AXIS_ARESETN,Ti1,Ti2,Ti3,Ti4,Ti5,To1,To2,To3,To4,To5
);
	
    input  S_AXIS_ACLK;
    input  S_AXIS_ARESETN;
    input  Ti1,Ti2,Ti3,Ti4,Ti5;
    output To1,To2,To3,To4,To5;
    
    reg [7:0]  cnt1;
    reg [7:0]  cnt2;
    reg [7:0]  cnt3;
    reg [11:0] cnt4;
    reg [12:0] cnt5;
    
    // 启动计时模块，共 5 个计数器，计数完成发送信号；
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt1 <= 0;
        else begin
            if(Ti1)
                cnt1 <= cnt1 + 1'b1;
            else 
                cnt1 <= 0;
        end
    end
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt2 <= 0;
        else begin
            if(Ti2)
                cnt2 <= cnt2 + 1'b1;
            else 
                cnt2 <= 0;
        end
    end
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt3 <= 0;
        else begin
            if(Ti3)
                cnt3 <= cnt3 + 1'b1;
            else 
                cnt3 <= 0;
        end
    end
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt4 <= 0;
        else begin
            if(Ti4)
                cnt4 <= cnt4 + 1'b1;
            else 
                cnt4 <= 0;
        end
    end
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt5 <= 0;
        else begin
            if(Ti5)
                cnt5 <= cnt5 + 1'b1;
            else 
                cnt5 <= 0;
        end
    end

    assign To1 = (cnt1 < 8'd33)? 0:1;
    assign To2 = (cnt2 < 8'd30)?  0:1;
    assign To3 = 1;
    assign To4 = (cnt4 < 12'd32)?  0:1;
    assign To5 = (cnt5 < 13'd990)? 0:1;
    
endmodule