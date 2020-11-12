module IF #(parameter SIF_AW = 22,parameter MEM_AW = 18)
(
    input  wire     clk,
    input  wire     rstn,

    input  wire         sif_en,
    input  wire         sif_wen,
    input  wire  [23:0] sif_addr,
    input  wire  [31:0] sif_wdata,
    output wire  [31:0] sif_rdata,
    
    output wire        buf_a_wen,
    output wire [MEM_AW-1:0] buf_a_addr,
    output wire [31:0]     buf_a_wdata,
    input  wire [31:0]     buf_a_rdata,

    output wire            buf_b_wen,
    output wire [MEM_AW-1:0] buf_b_addr,
    output wire [31:0]     buf_b_wdata,
    input  wire [31:0]     buf_b_rdata,

    output wire          buf_c_wen,
    output wire [MEM_AW-1:0] buf_c_addr,
    output wire [31:0]     buf_c_wdata,
    input  wire [31:0]     buf_c_rdata,

    output wire          buf_d_wen,
    output wire [MEM_AW-1:0] buf_d_addr,
    output wire [31:0]     buf_d_wdata,
    input  wire [31:0]     buf_d_rdata,
    
    output wire              reg_wen,
    output wire [MEM_AW-1:0] reg_addr,
    output wire [31:0]       reg_w_data,
    input  wire [31:0]       reg_r_data
);

   stalk_if #(
        .SIF_AW         (SIF_AW),
        .MEM_AW         (MEM_AW)
    ) 
        stalk_if (
        .clk            (clk),
        .rstn           (rstn),

        .sif_addr       (sif_addr[23:2]),
        .sif_wen        (sif_en && sif_wen),
        .sif_wdata      (sif_wdata),
        .sif_ren        (sif_en && ~ sif_wen),
        .sif_rdata      (sif_rdata),

        .buf_a_wen      (buf_a_wen),
        .buf_a_addr     (buf_a_addr),
        .buf_a_wdata    (buf_a_wdata),
        .buf_a_rdata    (buf_a_rdata),

        .buf_b_wen      (buf_b_wen),
        .buf_b_addr     (buf_b_addr),
        .buf_b_wdata    (buf_b_wdata),
        .buf_b_rdata    (buf_b_rdata),

        .buf_c_wen      (buf_c_wen),
        .buf_c_addr     (buf_c_addr),
        .buf_c_wdata    (buf_c_wdata),
        .buf_c_rdata    (buf_c_rdata),

        .buf_d_wen      (buf_d_wen),
        .buf_d_addr     (buf_d_addr),
        .buf_d_wdata    (buf_d_wdata),
        .buf_d_rdata    (buf_d_rdata),
        
        .reg_wen        (reg_wen), 
        .reg_addr       (reg_addr),
        .reg_w_data     (reg_w_data),
        .reg_r_data     (reg_r_data)     
    );
    
endmodule