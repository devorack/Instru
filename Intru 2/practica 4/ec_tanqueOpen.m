function dy_dt = ec_tanqueOpen(t,Y)
    global n a qi A 
    dy_dt = ((qi)/A-(a*Y^n));

end