 module mvp_32(

    input clk,
    input rst,

    input [17:0] a_addr,
    input [17:0] b_addr,
    input [17:0] c_addr,
    input [17:0] d_addr,
    input [17:0] reg_addr,
    
    input [31:0]a_wdata,
    input [31:0]b_wdata,
    input [31:0]c_wdata,
    input [31:0]d_wdata,
    input [31:0]reg_wdata,
    
    input a_wea,
    input b_wea,
    input c_wea,
    input d_wea,
    input reg_wea,
    
    output [31:0]a_rdata,
    output [31:0]b_rdata,
    output [31:0]c_rdata,
    output [31:0]d_rdata,
    output reg [31:0]reg_rdata
    );


wire [127:0] activation;
wire [127:0] weight;
wire [31:0] weight0;
wire [31:0] weight1;
wire [31:0] weight2;
wire [31:0] weight3;
wire [31:0]  column_0_out;
reg  [31:0]  address;

assign activation = 128'h1111_1111_1111_1111_1111_1111_1111_1111;
assign weight = {weight0,weight1,weight2,weight3};    

always @(*)
	begin
	      case (reg_addr[3:0])
	        4'b0000   : reg_rdata <= 1'b0;	                 
	        4'b0001   : address <= reg_wdata;	 
	        4'b0010   : reg_rdata <= column_0_out;   
	        4'b0011   : reg_rdata <= address;       
	        4'b0100   : reg_rdata <= weight0;      
	        4'b0101   : reg_rdata <= weight1;
	        4'b0110   : reg_rdata <= weight2;
	        4'b0111   : reg_rdata <= weight3;	        
	        default : reg_rdata <= 0;
	      endcase
	end

blk_mem_gen_0 bel_mem_gen0(.addra(a_addr),.clka(clk),.dina(a_wdata),.douta(a_rdata),.wea(a_wea),
                           .addrb(address),.clkb(clk),.doutb(weight0),.web(1'b0)); 
                           
blk_mem_gen_1 bel_mem_gen1(.addra(b_addr),.clka(clk),.dina(b_wdata),.douta(b_rdata),.wea(b_wea),
                           .addrb(address),.clkb(clk),.doutb(weight1),.web(1'b0));
                           
blk_mem_gen_2 bel_mem_gen2(.addra(c_addr),.clka(clk),.dina(c_wdata),.douta(c_rdata),.wea(c_wea),
                           .addrb(address),.clkb(clk),.doutb(weight2),.web(1'b0));
                           
blk_mem_gen_3 bel_mem_gen3(.addra(d_addr),.clka(clk),.dina(d_wdata),.douta(d_rdata),.wea(d_wea),
                           .addrb(address),.clkb(clk),.doutb(weight3),.web(1'b0));

count count0(.clk(clk),.rst(rst),.weight(weight),.activation(activation),.sum(column_0_out));

endmodule
