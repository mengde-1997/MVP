module count_32(
    input t0,s0,a0,w0,
    input t1,s1,a1,w1,
    input t2,s2,a2,w2,
    input t3,s3,a3,w3,
    input t4,s4,a4,w4,
    input t5,s5,a5,w5,
    input t6,s6,a6,w6,
    input t7,s7,a7,w7,
    input t8,s8,a8,w8,
    input t9,s9,a9,w9,
    input t10,s10,a10,w10,
    input t11,s11,a11,w11,
    input t12,s12,a12,w12,
    input t13,s13,a13,w13,
    input t14,s14,a14,w14,
    input t15,s15,a15,w15,
    input t16,s16,a16,w16,
    input t17,s17,a17,w17,
    input t18,s18,a18,w18,
    input t19,s19,a19,w19,
    input t20,s20,a20,w20,
    input t21,s21,a21,w21,
    input t22,s22,a22,w22,
    input t23,s23,a23,w23,
    input t24,s24,a24,w24,
    input t25,s25,a25,w25,
    input t26,s26,a26,w26,
    input t27,s27,a27,w27,
    input t28,s28,a28,w28,
    input t29,s29,a29,w29,
    input t30,s30,a30,w30,
    input t31,s31,a31,w31,
    output [6:0]h_plus_32,h_minus_32
    );
  
    assign h_plus_32 = h_plus0+h_plus1+h_plus2+h_plus3+h_plus4+h_plus5+h_plus6+h_plus7+h_plus8+h_plus9+h_plus10+h_plus11+h_plus12+h_plus13+h_plus14+h_plus15+
            h_plus16+h_plus17+h_plus18+h_plus19+h_plus20+h_plus21+h_plus22+h_plus23+h_plus24+h_plus25+h_plus26+h_plus27+h_plus28+h_plus29+h_plus30+h_plus31;
    assign h_minus_32 = h_minus0+h_minus1+h_minus2+h_minus3+h_minus4+h_minus5+h_minus6+h_minus7+h_minus8+h_minus9+h_minus10+h_minus11+h_minus12+h_minus13+h_minus14+h_minus15+
            h_minus16+h_minus17+h_minus18+h_minus19+h_minus20+h_minus21+h_minus22+h_minus23+h_minus24+h_minus25+h_minus26+h_minus27+h_minus28+h_minus29+h_minus30+h_minus31;
    
    wire h_plus0,h_plus1,h_plus2,h_plus3,h_plus4,h_plus5,h_plus6,h_plus7;
    wire h_plus8,h_plus9,h_plus10,h_plus11,h_plus12,h_plus13,h_plus14,h_plus15;
    wire h_plus16,h_plus17,h_plus18,h_plus19,h_plus20,h_plus21,h_plus22,h_plus23;
    wire h_plus24,h_plus25,h_plus26,h_plus27,h_plus28,h_plus29,h_plus30,h_plus31;
    
    wire h_minus0,h_minus1,h_minus2,h_minus3,h_minus4,h_minus5,h_minus6,h_minus7;
    wire h_minus8,h_minus9,h_minus10,h_minus11,h_minus12,h_minus13,h_minus14,h_minus15;
    wire h_minus16,h_minus17,h_minus18,h_minus19,h_minus20,h_minus21,h_minus22,h_minus23;
    wire h_minus24,h_minus25,h_minus26,h_minus27,h_minus28,h_minus29,h_minus30,h_minus31;
    
    tswa tswa0(t0,s0,w0,a0,h_plus0,h_minus0);
    tswa tswa1(t1,s1,w1,a1,h_plus1,h_minus1);
    tswa tswa2(t2,s2,w2,a2,h_plus2,h_minus2);
    tswa tswa3(t3,s3,w3,a3,h_plus3,h_minus3);
    tswa tswa4(t4,s4,w4,a4,h_plus4,h_minus4);
    tswa tswa5(t5,s5,w5,a5,h_plus5,h_minus5);
    tswa tswa6(t6,s6,w6,a6,h_plus6,h_minus6);
    tswa tswa7(t7,s7,w7,a7,h_plus7,h_minus7);
    tswa tswa8(t8,s8,w8,a8,h_plus8,h_minus8);
    tswa tswa9(t9,s9,w9,a9,h_plus9,h_minus9);
    tswa tswa10(t10,s10,w10,a10,h_plus10,h_minus10);
    tswa tswa11(t11,s11,w11,a11,h_plus11,h_minus11);
    tswa tswa12(t12,s12,w12,a12,h_plus12,h_minus12);
    tswa tswa13(t13,s13,w13,a13,h_plus13,h_minus13);
    tswa tswa14(t14,s14,w14,a14,h_plus14,h_minus14);
    tswa tswa15(t15,s15,w15,a15,h_plus15,h_minus15);
    tswa tswa16(t16,s16,w16,a16,h_plus16,h_minus16);
    tswa tswa17(t17,s17,w17,a17,h_plus17,h_minus17);
    tswa tswa18(t18,s18,w18,a18,h_plus18,h_minus18);
    tswa tswa19(t19,s19,w19,a19,h_plus19,h_minus19);
    tswa tswa20(t20,s20,w20,a20,h_plus20,h_minus20);
    tswa tswa21(t21,s21,w21,a21,h_plus21,h_minus21);
    tswa tswa22(t22,s22,w22,a22,h_plus22,h_minus22);
    tswa tswa23(t23,s23,w23,a23,h_plus23,h_minus23);
    tswa tswa24(t24,s24,w24,a24,h_plus24,h_minus24);
    tswa tswa25(t25,s25,w25,a25,h_plus25,h_minus25);
    tswa tswa26(t26,s26,w26,a26,h_plus26,h_minus26);
    tswa tswa27(t27,s27,w27,a27,h_plus27,h_minus27);
    tswa tswa28(t28,s28,w28,a28,h_plus28,h_minus28);
    tswa tswa29(t29,s29,w29,a29,h_plus29,h_minus29);
    tswa tswa30(t30,s30,w30,a30,h_plus30,h_minus30);
    tswa tswa31(t31,s31,w31,a31,h_plus31,h_minus31);
    
endmodule
