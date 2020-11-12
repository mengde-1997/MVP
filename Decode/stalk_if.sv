module stalk_if #(
    parameter SIF_AW = 22,
    parameter MEM_AW = 18
)(
    input  logic    clk,
    input  logic    rstn,

    input  logic [SIF_AW-1:0] sif_addr,
    input  logic            sif_wen,
    input  logic [31:0]     sif_wdata,
    input  logic            sif_ren,
    output logic [31:0]     sif_rdata,

    output logic            buf_a_wen,
    output logic [MEM_AW-1:0] buf_a_addr,
    output logic [31:0]     buf_a_wdata,
    input  logic [31:0]     buf_a_rdata,

    output logic            buf_b_wen,
    output logic [MEM_AW-1:0] buf_b_addr,
    output logic [31:0]     buf_b_wdata,
    input  logic [31:0]     buf_b_rdata,

    output logic            buf_c_wen,
    output logic [MEM_AW-1:0] buf_c_addr,
    output logic [31:0]     buf_c_wdata,
    input  logic [31:0]     buf_c_rdata,

    output logic            buf_d_wen,
    output logic [MEM_AW-1:0] buf_d_addr,
    output logic [31:0]     buf_d_wdata,
    input  logic [31:0]     buf_d_rdata,
    
    output logic              reg_wen,
    output logic [MEM_AW-1:0] reg_addr,
    output logic [31:0]       reg_w_data,
    input  logic [31:0]       reg_r_data
);
    
    logic [31:0] reg_data_out;
    logic [3:0] sif_rdata_mux;
    always_ff @(posedge clk or negedge rstn) begin
        if (~ rstn)       sif_rdata_mux <= '0;
        else if (sif_ren) sif_rdata_mux <= sif_addr[SIF_AW-1-:4];
    end

    always_comb begin
        case(sif_rdata_mux)
            4'b0001: sif_rdata =  buf_d_rdata;
            4'b0010: sif_rdata =  buf_a_rdata;
            4'b0011: sif_rdata =  buf_b_rdata;
            4'b0100: sif_rdata =  buf_c_rdata;
            4'b0101: sif_rdata =  reg_r_data;
            default: sif_rdata = '0;
        endcase
    end
    

   
    assign buf_a_addr  = sif_addr[MEM_AW-1:0];
    assign buf_a_wen   = sif_wen && sif_addr[SIF_AW-1-:4] == 4'b0010;
    assign buf_a_wdata = sif_wdata[31:0];

    assign buf_b_addr  = sif_addr[MEM_AW-1:0];
    assign buf_b_wen   = sif_wen && sif_addr[SIF_AW-1-:4] == 4'b0011;
    assign buf_b_wdata = sif_wdata[31:0];

    assign buf_c_addr  = sif_addr[MEM_AW-1:0];
    assign buf_c_wen   = sif_wen && sif_addr[SIF_AW-1-:4] == 4'b0100;
    assign buf_c_wdata = sif_wdata[31:0];
    
    assign buf_d_addr  = sif_addr[MEM_AW-1:0];
    assign buf_d_wen   = sif_wen && sif_addr[SIF_AW-1-:4] == 4'b0001;
    assign buf_d_wdata = sif_wdata[31:0];
    
    assign reg_addr = sif_addr[MEM_AW-1:0];
    assign reg_wen   = sif_wen && sif_addr[SIF_AW-1-:4] == 4'b0101;
    assign reg_w_data = sif_wdata[31:0];
    
endmodule
