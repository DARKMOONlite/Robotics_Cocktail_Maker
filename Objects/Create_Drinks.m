function [Objects] = Create_Drinks()
%CREATE_DRINKS Summary of this function goes here
%   Detailed explanation goes here

Objects(1) = R_Object("Vodka",0.035,0.296,transl(0.8,0.7,0.4),"Large")
Objects(2) = R_Object("Rum",0.035,0.296,transl(0.6,0.7,0.4),"Large")

Objects(3) = R_Object("Tonic_Water",0.1,0.3,transl(0.2,0.7,0.4),"Large")

Objects(4) = R_Object("Shaker_Top",0.0415,0.075,transl(-0.2,0.7,0.4),"Large")

Objects(5) = R_Object("Shaker_Bottom",0.0415,0.151,transl(-0.6,0.7,0.4),"Large")

Objects(6) = R_Object("Gin",0.043,0.221,transl(-0.8,0.7,0.4),"Large")


Objects(7) = R_Object("Glass",0.03,0.168,transl(0,-0.95,0.0),"Large")

end

