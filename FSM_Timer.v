module FSM_Timer(
S_AXIS_ACLK,S_AXIS_ARESETN,Din_Valid,Cal_Valid
    );
    input  S_AXIS_ACLK;
    input  S_AXIS_ARESETN;
    input  Din_Valid;
    output Cal_Valid;
    wire Ti1,Ti2,Ti3,Ti4,Ti5,To1,To2,To3,To4,To5;
    FSM FSM(
    .S_AXIS_ACLK(S_AXIS_ACLK),
    .S_AXIS_ARESETN(S_AXIS_ARESETN),
    .Din_Valid(Din_Valid),
    .Ti1(Ti1),.Ti2(Ti2),.Ti3(Ti3),.Ti4(Ti4),.Ti5(Ti5),
    .To1(To1),.To2(To2),.To3(To3),.To4(To4),.To5(To5),
    .Cal_Valid(Cal_Valid)
    );
    Timer Timer(
    .S_AXIS_ACLK(S_AXIS_ACLK),
    .S_AXIS_ARESETN(S_AXIS_ARESETN),
   .Ti1(To1),.Ti2(To2),.Ti3(To3),.Ti4(To4),.Ti5(To5),
   .To1(Ti1),.To2(Ti2),.To3(Ti3),.To4(Ti4),.To5(Ti5)
   );
endmodule