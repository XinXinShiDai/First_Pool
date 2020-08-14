module FSM(
S_AXIS_ACLK,S_AXIS_ARESETN,Din_Valid,Ti1,Ti2,Ti3,Ti4,Ti5,To1,To2,To3,To4,To5,Cal_Valid
    );

    input S_AXIS_ACLK;
    input S_AXIS_ARESETN;
    input Din_Valid,Ti1,Ti2,Ti3,Ti4,Ti5; // 输入序列；
    output reg Cal_Valid,To1,To2,To3,To4,To5; // 状态输出；
    
    parameter   S0=3'b000, // Idle and End；
                S1=3'b001, // 首缓存；
                S2=3'b011, // Valid_Calculate_Data； 
                S3=3'b010, // 跳变；
                S4=3'b110; // 换行；
    
    reg [2:0] cs; // 现态；
    reg [2:0] ns; // 次态；
    /*------------------次态到现态的时序逻辑------------------*/  
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cs <= S0;
        else
            cs <= ns;
    end
    /*------------------现态到次态的组合逻辑------------------*/
    always @(cs or Din_Valid or Ti1 or Ti2 or Ti3 or Ti4 or Ti5) begin
        ns = S0;
        case(cs)
            S0: ns = Din_Valid? S1:S0;
            S1: ns = Ti1? S2:S1;
            S2: ns = (!Ti2 && (!Ti5))? S3:(Ti5? S0:S4);
            S3: ns = Ti3? S2:S3;
            S4: ns = Ti4? S2:S4;
       default: ns = S0;
        endcase
     end
     /*------------------现态到输出的组合逻辑------------------*/
     always @(cs) begin
        case(cs)
            S0: begin To1=0;To2=0;To3=0;To4=0;To5=0;Cal_Valid=0; end
            S1: begin To1=1;To2=0;To3=0;To4=0;To5=0;Cal_Valid=0; end
            S2: begin To1=0;To2=1;To3=0;To4=0;To5=1;Cal_Valid=1; end
            S3: begin To1=0;To2=1;To3=0;To4=0;To5=1;Cal_Valid=0; end
            S4: begin To1=0;To2=0;To3=0;To4=1;To5=1;Cal_Valid=0; end
       default: begin To1=0;To2=0;To3=0;To4=0;To5=0;Cal_Valid=0; end
        endcase
     end
   
endmodule