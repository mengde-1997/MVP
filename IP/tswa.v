// a module caculate the number of +hit and -hit  
module tswa(
	input t,s,w,a,
	output hit_plus,hit_minus
	);

    assign hit_plus  = (t == s) & w & a;
	assign hit_minus = (t != s) & w & a;

endmodule