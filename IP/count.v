`timescale 1ns / 1ps
(*use_dsp48="yes"*)
module count  (
    input clk,rst,
    input [127:0]weight,// the rightest is msb, so as activation
    input [127:0]activation,
    output[15:0] sum
);

    reg [31:0]flag;
    reg [1:0]counter;
    reg signed [15:0]result;
    reg signed [15:0]result1;
    wire [15:0] h_sum_1;
    wire [31:0]s_a;//sign of a
    
    // counter == 0  is msb
    assign s_a={
        activation[127],activation[123],activation[119],activation[115],activation[111],activation[107],activation[103],activation[99],
        activation[95],activation[91],activation[87],activation[83],activation[79],activation[75],activation[71],activation[67],
        activation[63],activation[59],activation[55],activation[51],activation[47],activation[43],activation[39],activation[35],
        activation[31],activation[27],activation[23],activation[19],activation[15],activation[11],activation[7],activation[3]
                };
   
   always@(*) begin
        case(counter)
            2'b00:flag={
                    activation[126],activation[122],activation[118],activation[114],activation[110],activation[106],activation[102],activation[98],
                    activation[94],activation[90],activation[86],activation[82],activation[78],activation[74],activation[70],activation[66],
                    activation[62],activation[58],activation[54],activation[50],activation[46],activation[42],activation[38],activation[34],
                    activation[30],activation[26],activation[22],activation[18],activation[14],activation[10],activation[6],activation[2]
                     };

            2'b01:flag={
                    activation[125],activation[121],activation[117],activation[113],activation[109],activation[105],activation[101],activation[97],
                    activation[93],activation[89],activation[85],activation[81],activation[77],activation[73],activation[69],activation[65],
                    activation[61],activation[57],activation[53],activation[49],activation[45],activation[41],activation[37],activation[33],
                    activation[29],activation[25],activation[21],activation[17],activation[13],activation[9],activation[5],activation[1]
                     };

            2'b10:flag={  
                    activation[124],activation[120],activation[116],activation[112],activation[108],activation[104],activation[100],activation[96],
                    activation[92],activation[88],activation[84],activation[80],activation[76],activation[72],activation[68],activation[64],
                    activation[60],activation[56],activation[52],activation[48],activation[44],activation[40],activation[36],activation[32],
                    activation[28],activation[24],activation[20],activation[16],activation[12],activation[8],activation[4],activation[0]
                    };
            default:flag=32'b0;
        endcase
    end

    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            counter<=2;
            result<=0; 
        end
        else if (counter==2) begin
            counter<=0;
            result<=($signed(result)<<1)+$signed(h_sum_1);
            
        end
        else if (counter==1) begin
            counter<=2;
            result<=($signed(result)<<1)+$signed(h_sum_1);
           
        end
        else if (counter==0) begin
            counter<=1;
            result<=$signed(h_sum_1);
        end
    end
    
    always@(posedge clk)
    if(counter==0)begin
        result1<=result;
    end 
    
    assign sum = result1;
 
    top_count_32 my_top_count_32_1(
        s_a[0],s_a[1],s_a[2],s_a[3],s_a[4],s_a[5],s_a[6],s_a[7],s_a[8],s_a[9],s_a[10],s_a[11],s_a[12],s_a[13],s_a[14],s_a[15],
        s_a[16],s_a[17],s_a[18],s_a[19],s_a[20],s_a[21],s_a[22],s_a[23],s_a[24],s_a[25],s_a[26],s_a[27],s_a[28],s_a[29],s_a[30],s_a[31],
        flag[0],flag[1],flag[2],flag[3],flag[4],flag[5],flag[6],flag[7],flag[8],flag[9],flag[10],flag[11],flag[12],flag[13],flag[14],flag[15],
        flag[16],flag[17],flag[18],flag[19],flag[20],flag[21],flag[22],flag[23],flag[24],flag[25],flag[26],flag[27],flag[28],flag[29],flag[30],flag[31],
        weight[127:124],weight[123:120],weight[119:116],weight[115:112],weight[111:108],weight[107:104],weight[103:100],weight[99:96],
        weight[95:92],weight[91:88],weight[87:84],weight[83:80],weight[79:76],weight[75:72],weight[71:68],weight[67:64],
        weight[63:60],weight[59:56],weight[55:52],weight[51:48],weight[47:44],weight[43:40],weight[39:36],weight[35:32],
        weight[31:28],weight[27:24],weight[23:20],weight[19:16],weight[15:12],weight[11:8],weight[7:4],weight[3:0],
        h_sum_1);

endmodule
