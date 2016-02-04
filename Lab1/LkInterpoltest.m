%% LkInterpol test
clear;
A3 = [1 , 3 , 5 ; 3 , 5 , 7 ; 5 , 7 , 9 ]

A4 = [1,3,5,7;3,5,7,9;5,7,9,11;7,9,11,13]
%%
B4 = LkInterpol(A4,2,'upsample','bicubic')       

%%

B3 = LkInterpol(A3,0.2,'move','bicubic')

