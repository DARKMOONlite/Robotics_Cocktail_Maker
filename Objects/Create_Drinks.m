function [Objects] = Create_Drinks()
    %%Creates drink and dispenser objects in the environment
    
    Objects(1) = R_Object("Objects/Parts/GingerBeer",0.035,0.296,transl(0.6,0.6,0.4),"Large");
    Objects(2) = R_Object("Objects/Parts/Rum",0.035,0.296,transl(0.4,0.6,0.4),"Large");
    Objects(3) = R_Object("Objects/Parts/Tonic_Water",0.04,0.3,transl(0.2,0.6,0.4),"Large");
    Objects(4) = R_Object("Objects/Parts/Gin",0.043,0.221,transl(-0.4,0.6,0.4),"Large");


    Objects(5) = R_Object("Objects/Parts/Shaker_Top",0.0415,0.075,transl(0.0,0.6,0.4),"Large");
    Objects(6) = R_Object("Objects/Parts/Shaker_Bottom",0.0415,0.151,transl(-0.2,0.6,0.4),"Large");

    Objects(7) = R_Object("Objects/Parts/Glass",0.03,0.168,transl(0,-0.95,0.0),"Large");

    Objects(8) = R_Object("Objects/Parts/Sugar_Dispenser",0.1,0.4,transl(-1,-0.5,0.02)*trotz(90,"deg"),"Large");
    Objects(9) = R_Object("Objects/Parts/Lime_Dispenser",0.1,0.4,transl(-1,-0.1,0.02)*trotz(90,"deg"),"Large");
    Objects(10) = R_Object("Objects/Parts/ICE_Dispenser",0.1,0.4,transl(-1,0.3,0.02)*trotz(90,"deg"),"Large");
    
end

