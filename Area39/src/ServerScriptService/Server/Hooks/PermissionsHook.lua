return(function(bWare_llIlIllIllllIlllll,bWare_llllIlIlIIIllIIIIlllIlllI,bWare_IIlllIllllIl)local bWare_IIlIIIIIlll=string.char;local bWare_lIlIIlIlll=string.sub;local bWare_lllIIlIlIIIIIIllllI=table.concat;local bWare_IllIllIIlII=math.ldexp;local bWare_IIlIIIlIllIIlllIIlll=getfenv or function()return _ENV end;local bWare_IllIIIlII=select;local bWare_lllIlIlllllIIllIlIlllIlI=unpack or table.unpack;local bWare_IllIIlIlIlIlllIIl=tonumber;local function bWare_IIlIlllllIIlII(bWare_llIlIllIllllIlllll)local bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI,bWare_llIllIIIIll="","",{}local bWare_lllIIlIllll=256;local bWare_IlIIlllllllllIIllIIlIlII={}for bWare_IIlllIllllIl=0,bWare_lllIIlIllll-1 do bWare_IlIIlllllllllIIllIIlIlII[bWare_IIlllIllllIl]=bWare_IIlIIIIIlll(bWare_IIlllIllllIl)end;local bWare_IIlllIllllIl=1;local function bWare_lllIlIlllllIIllIlIlllIlI()local bWare_IlIIllIIIlIIIIlIIl=bWare_IllIIlIlIlIlllIIl(bWare_lIlIIlIlll(bWare_llIlIllIllllIlllll,bWare_IIlllIllllIl,bWare_IIlllIllllIl),36)bWare_IIlllIllllIl=bWare_IIlllIllllIl+1;local bWare_IlllIllIlIIlIIlIIlI=bWare_IllIIlIlIlIlllIIl(bWare_lIlIIlIlll(bWare_llIlIllIllllIlllll,bWare_IIlllIllllIl,bWare_IIlllIllllIl+bWare_IlIIllIIIlIIIIlIIl-1),36)bWare_IIlllIllllIl=bWare_IIlllIllllIl+bWare_IlIIllIIIlIIIIlIIl;return bWare_IlllIllIlIIlIIlIIlI end;bWare_IlIIllIIIlIIIIlIIl=bWare_IIlIIIIIlll(bWare_lllIlIlllllIIllIlIlllIlI())bWare_llIllIIIIll[1]=bWare_IlIIllIIIlIIIIlIIl;while bWare_IIlllIllllIl<#bWare_llIlIllIllllIlllll do local bWare_IIlllIllllIl=bWare_lllIlIlllllIIllIlIlllIlI()if bWare_IlIIlllllllllIIllIIlIlII[bWare_IIlllIllllIl]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlIIlllllllllIIllIIlIlII[bWare_IIlllIllllIl]else bWare_IlllIllIlIIlIIlIIlI=bWare_IlIIllIIIlIIIIlIIl..bWare_lIlIIlIlll(bWare_IlIIllIIIlIIIIlIIl,1,1)end;bWare_IlIIlllllllllIIllIIlIlII[bWare_lllIIlIllll]=bWare_IlIIllIIIlIIIIlIIl..bWare_lIlIIlIlll(bWare_IlllIllIlIIlIIlIIlI,1,1)bWare_llIllIIIIll[#bWare_llIllIIIIll+1],bWare_IlIIllIIIlIIIIlIIl,bWare_lllIIlIllll=bWare_IlllIllIlIIlIIlIIlI,bWare_IlllIllIlIIlIIlIIlI,bWare_lllIIlIllll+1 end;return table.concat(bWare_llIllIIIIll)end;local bWare_IllIIlIlIlIlllIIl=bWare_IIlIlllllIIlII('182742741B2751A1727527B181J27827B1H2751927I27F2741A1427522I23123322P23F23G23123E21S22V22V22R1A1127522223123222V23E23122I23H22U191D275214161827J27427J1Q28F2771A27827A1C27C1828T27J28W27427H28L27K2741O27828F27423G22X22Y22S2311A28T27423222P22U2301A28Q27422F2271A1E27522123022T29H23F27727427021C25E24E2211A1027522523423122Z23H23G28829P27522L23F27W21T29J28I27422723123G22I22X22U22R21T22U22723E22V23H23C29X27422T1W22D2212B127526W21J2B722Z26R22K2B627C23S22V2201A2102752292AY21423022V21422U22V23G21422O22X23I23121423C27W29U23F23F22P22V22U21428723E21423G22O27T21422Z22V22T22T2AR2302121A296182AW2AY23C2CP29R29T29H2B72932201921M2751Q1F28J2D727421429127J28Q1Q27M182B12DA1828Q28Q28T29Q2DJ1828327J28X29L2DP2D81G2DO28K1828N2DG182CQ1829Q28Q27727J2142162E127429Q2E92E12772D6182A527J28P2E41T2D727A2DY1C2DT2EP28V2DT21L2D72EE2DY2ED28I2DR2EI2DZ28O2DU2752EJ2E128Q21A1I2D71M2D7122EU2752FE2E82EA2EZ1828H2D727J2A52E02771327B2F82EL21A1P2D71K2D727O2ER2752G12DS2FI2D72E027J1527B27E2DC28G2FL27528I21A2G6182GH28S2DT2GH2G42742EW2FK2D82E42FN2F12D72FR2F52832F72D72FX2FZ27J1X2D72942GR182H82G72GS2EX2GH2EC2GX2FP2F32FS182FU2H32EK2DO2FB2D72GT182G32EV2G928F2GB2GD2D72DT182902GV27B');local bWare_IIlllIllllIl=(bit or bit32);local bWare_IlIIlllllllllIIllIIlIlII=bWare_IIlllIllllIl and bWare_IIlllIllllIl.bxor or function(bWare_IIlllIllllIl,bWare_IlIIllIIIlIIIIlIIl)local bWare_IlllIllIlIIlIIlIIlI,bWare_IlIIlllllllllIIllIIlIlII,bWare_lIlIIlIlll=1,0,10 while bWare_IIlllIllllIl>0 and bWare_IlIIllIIIlIIIIlIIl>0 do local bWare_lIlIIlIlll,bWare_lllIIlIllll=bWare_IIlllIllllIl%2,bWare_IlIIllIIIlIIIIlIIl%2 if bWare_lIlIIlIlll~=bWare_lllIIlIllll then bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIlllllllllIIllIIlIlII+bWare_IlllIllIlIIlIIlIIlI end bWare_IIlllIllllIl,bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI=(bWare_IIlllIllllIl-bWare_lIlIIlIlll)/2,(bWare_IlIIllIIIlIIIIlIIl-bWare_lllIIlIllll)/2,bWare_IlllIllIlIIlIIlIIlI*2 end if bWare_IIlllIllllIl<bWare_IlIIllIIIlIIIIlIIl then bWare_IIlllIllllIl=bWare_IlIIllIIIlIIIIlIIl end while bWare_IIlllIllllIl>0 do local bWare_IlIIllIIIlIIIIlIIl=bWare_IIlllIllllIl%2 if bWare_IlIIllIIIlIIIIlIIl>0 then bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIlllllllllIIllIIlIlII+bWare_IlllIllIlIIlIIlIIlI end bWare_IIlllIllllIl,bWare_IlllIllIlIIlIIlIIlI=(bWare_IIlllIllllIl-bWare_IlIIllIIIlIIIIlIIl)/2,bWare_IlllIllIlIIlIIlIIlI*2 end return bWare_IlIIlllllllllIIllIIlIlII end local function bWare_IlllIllIlIIlIIlIIlI(bWare_IlIIllIIIlIIIIlIIl,bWare_IIlllIllllIl,bWare_IlllIllIlIIlIIlIIlI)if bWare_IlllIllIlIIlIIlIIlI then local bWare_IIlllIllllIl=(bWare_IlIIllIIIlIIIIlIIl/2^(bWare_IIlllIllllIl-1))%2^((bWare_IlllIllIlIIlIIlIIlI-1)-(bWare_IIlllIllllIl-1)+1);return bWare_IIlllIllllIl-bWare_IIlllIllllIl%1;else local bWare_IIlllIllllIl=2^(bWare_IIlllIllllIl-1);return(bWare_IlIIllIIIlIIIIlIIl%(bWare_IIlllIllllIl+bWare_IIlllIllllIl)>=bWare_IIlllIllllIl)and 1 or 0;end;end;local bWare_IIlllIllllIl=1;local function bWare_IlIIllIIIlIIIIlIIl()local bWare_lIlIIlIlll,bWare_IlllIllIlIIlIIlIIlI,bWare_lllIIlIllll,bWare_IlIIllIIIlIIIIlIIl=bWare_llIlIllIllllIlllll(bWare_IllIIlIlIlIlllIIl,bWare_IIlllIllllIl,bWare_IIlllIllllIl+3);bWare_lIlIIlIlll=bWare_IlIIlllllllllIIllIIlIlII(bWare_lIlIIlIlll,8)bWare_IlllIllIlIIlIIlIIlI=bWare_IlIIlllllllllIIllIIlIlII(bWare_IlllIllIlIIlIIlIIlI,8)bWare_lllIIlIllll=bWare_IlIIlllllllllIIllIIlIlII(bWare_lllIIlIllll,8)bWare_IlIIllIIIlIIIIlIIl=bWare_IlIIlllllllllIIllIIlIlII(bWare_IlIIllIIIlIIIIlIIl,8)bWare_IIlllIllllIl=bWare_IIlllIllllIl+4;return(bWare_IlIIllIIIlIIIIlIIl*16777216)+(bWare_lllIIlIllll*65536)+(bWare_IlllIllIlIIlIIlIIlI*256)+bWare_lIlIIlIlll;end;local function bWare_llIllIIIIll()local bWare_IlIIllIIIlIIIIlIIl=bWare_IlIIlllllllllIIllIIlIlII(bWare_llIlIllIllllIlllll(bWare_IllIIlIlIlIlllIIl,bWare_IIlllIllllIl,bWare_IIlllIllllIl),8);bWare_IIlllIllllIl=bWare_IIlllIllllIl+1;return bWare_IlIIllIIIlIIIIlIIl;end;local function bWare_lllIIlIllll()local bWare_IlllIllIlIIlIIlIIlI,bWare_IlIIllIIIlIIIIlIIl=bWare_llIlIllIllllIlllll(bWare_IllIIlIlIlIlllIIl,bWare_IIlllIllllIl,bWare_IIlllIllllIl+2);bWare_IlllIllIlIIlIIlIIlI=bWare_IlIIlllllllllIIllIIlIlII(bWare_IlllIllIlIIlIIlIIlI,8)bWare_IlIIllIIIlIIIIlIIl=bWare_IlIIlllllllllIIllIIlIlII(bWare_IlIIllIIIlIIIIlIIl,8)bWare_IIlllIllllIl=bWare_IIlllIllllIl+2;return(bWare_IlIIllIIIlIIIIlIIl*256)+bWare_IlllIllIlIIlIIlIIlI;end;local function bWare_lIIIIIIIllIIIlIllIl()local bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIllIIIlIIIIlIIl();local bWare_IIlllIllllIl=bWare_IlIIllIIIlIIIIlIIl();local bWare_lIlIIlIlll=1;local bWare_IlIIlllllllllIIllIIlIlII=(bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,1,20)*(2^32))+bWare_IlIIlllllllllIIllIIlIlII;local bWare_IlIIllIIIlIIIIlIIl=bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,21,31);local bWare_IIlllIllllIl=((-1)^bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,32));if(bWare_IlIIllIIIlIIIIlIIl==0)then if(bWare_IlIIlllllllllIIllIIlIlII==0)then return bWare_IIlllIllllIl*0;else bWare_IlIIllIIIlIIIIlIIl=1;bWare_lIlIIlIlll=0;end;elseif(bWare_IlIIllIIIlIIIIlIIl==2047)then return(bWare_IlIIlllllllllIIllIIlIlII==0)and(bWare_IIlllIllllIl*(1/0))or(bWare_IIlllIllllIl*(0/0));end;return bWare_IllIllIIlII(bWare_IIlllIllllIl,bWare_IlIIllIIIlIIIIlIIl-1023)*(bWare_lIlIIlIlll+(bWare_IlIIlllllllllIIllIIlIlII/(2^52)));end;local bWare_IIlIlllllIIlII=bWare_IlIIllIIIlIIIIlIIl;local function bWare_IllIllIIlII(bWare_IlIIllIIIlIIIIlIIl)local bWare_IlllIllIlIIlIIlIIlI;if(not bWare_IlIIllIIIlIIIIlIIl)then bWare_IlIIllIIIlIIIIlIIl=bWare_IIlIlllllIIlII();if(bWare_IlIIllIIIlIIIIlIIl==0)then return'';end;end;bWare_IlllIllIlIIlIIlIIlI=bWare_lIlIIlIlll(bWare_IllIIlIlIlIlllIIl,bWare_IIlllIllllIl,bWare_IIlllIllllIl+bWare_IlIIllIIIlIIIIlIIl-1);bWare_IIlllIllllIl=bWare_IIlllIllllIl+bWare_IlIIllIIIlIIIIlIIl;local bWare_IlIIllIIIlIIIIlIIl={}for bWare_IIlllIllllIl=1,#bWare_IlllIllIlIIlIIlIIlI do bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl]=bWare_IIlIIIIIlll(bWare_IlIIlllllllllIIllIIlIlII(bWare_llIlIllIllllIlllll(bWare_lIlIIlIlll(bWare_IlllIllIlIIlIIlIIlI,bWare_IIlllIllllIl,bWare_IIlllIllllIl)),8))end return bWare_lllIIlIlIIIIIIllllI(bWare_IlIIllIIIlIIIIlIIl);end;local bWare_IIlllIllllIl=bWare_IlIIllIIIlIIIIlIIl;local function bWare_lllIIlIlIIIIIIllllI(...)return{...},bWare_IllIIIlII('#',...)end local function bWare_IIlIIIIIlll()local bWare_lllIlIlllllIIllIlIlllIlI={};local bWare_IllIIlIlIlIlllIIl={};local bWare_IIlllIllllIl={};local bWare_llIlIllIllllIlllll={[#{"1 + 1 = 111";{968;252;313;55};}]=bWare_IllIIlIlIlIlllIIl,[#{{974;598;126;819};"1 + 1 = 111";"1 + 1 = 111";}]=nil,[#{{330;797;332;903};"1 + 1 = 111";{139;50;226;50};"1 + 1 = 111";}]=bWare_IIlllIllllIl,[#{"1 + 1 = 111";}]=bWare_lllIlIlllllIIllIlIlllIlI,};local bWare_IIlllIllllIl=bWare_IlIIllIIIlIIIIlIIl()local bWare_lIlIIlIlll={}for bWare_IlllIllIlIIlIIlIIlI=1,bWare_IIlllIllllIl do local bWare_IlIIllIIIlIIIIlIIl=bWare_llIllIIIIll();local bWare_IIlllIllllIl;if(bWare_IlIIllIIIlIIIIlIIl==0)then bWare_IIlllIllllIl=(bWare_llIllIIIIll()~=0);elseif(bWare_IlIIllIIIlIIIIlIIl==3)then bWare_IIlllIllllIl=bWare_lIIIIIIIllIIIlIllIl();elseif(bWare_IlIIllIIIlIIIIlIIl==2)then bWare_IIlllIllllIl=bWare_IllIllIIlII();end;bWare_lIlIIlIlll[bWare_IlllIllIlIIlIIlIIlI]=bWare_IIlllIllllIl;end;bWare_llIlIllIllllIlllll[3]=bWare_llIllIIIIll();for bWare_llIlIllIllllIlllll=1,bWare_IlIIllIIIlIIIIlIIl()do local bWare_IIlllIllllIl=bWare_llIllIIIIll();if(bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,1,1)==0)then local bWare_IlIIlllllllllIIllIIlIlII=bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,2,3);local bWare_llIllIIIIll=bWare_IlllIllIlIIlIIlIIlI(bWare_IIlllIllllIl,4,6);local bWare_IIlllIllllIl={bWare_lllIIlIllll(),bWare_lllIIlIllll(),nil,nil};if(bWare_IlIIlllllllllIIllIIlIlII==0)then bWare_IIlllIllllIl[#("0gY")]=bWare_lllIIlIllll();bWare_IIlllIllllIl[#{"1 + 1 = 111";"1 + 1 = 111";{87;980;969;830};"1 + 1 = 111";}]=bWare_lllIIlIllll();elseif(bWare_IlIIlllllllllIIllIIlIlII==1)then bWare_IIlllIllllIl[#("g2R")]=bWare_IlIIllIIIlIIIIlIIl();elseif(bWare_IlIIlllllllllIIllIIlIlII==2)then bWare_IIlllIllllIl[#{"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";}]=bWare_IlIIllIIIlIIIIlIIl()-(2^16)elseif(bWare_IlIIlllllllllIIllIIlIlII==3)then bWare_IIlllIllllIl[#("gEk")]=bWare_IlIIllIIIlIIIIlIIl()-(2^16)bWare_IIlllIllllIl[#("oH4m")]=bWare_lllIIlIllll();end;if(bWare_IlllIllIlIIlIIlIIlI(bWare_llIllIIIIll,1,1)==1)then bWare_IIlllIllllIl[#("KR")]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#("VQ")]]end if(bWare_IlllIllIlIIlIIlIIlI(bWare_llIllIIIIll,2,2)==1)then bWare_IIlllIllllIl[#{{177;228;95;193};"1 + 1 = 111";{522;87;251;852};}]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#{{933;383;99;393};{502;886;442;510};"1 + 1 = 111";}]]end if(bWare_IlllIllIlIIlIIlIIlI(bWare_llIllIIIIll,3,3)==1)then bWare_IIlllIllllIl[#("eoUy")]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#{{419;203;124;675};"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";}]]end bWare_lllIlIlllllIIllIlIlllIlI[bWare_llIlIllIllllIlllll]=bWare_IIlllIllllIl;end end;for bWare_IIlllIllllIl=1,bWare_IlIIllIIIlIIIIlIIl()do bWare_IllIIlIlIlIlllIIl[bWare_IIlllIllllIl-1]=bWare_IIlIIIIIlll();end;return bWare_llIlIllIllllIlllll;end;local function bWare_llIllIIIIll(bWare_IIlllIllllIl,bWare_IlIIllIIIlIIIIlIIl,bWare_lIlIIlIlll)bWare_IIlllIllllIl=(bWare_IIlllIllllIl==true and bWare_IIlIIIIIlll())or bWare_IIlllIllllIl;return(function(...)local bWare_lllIIlIllll=bWare_IIlllIllllIl[1];local bWare_IlIIlllllllllIIllIIlIlII=bWare_IIlllIllllIl[3];local bWare_IIlIIIIIlll=bWare_IIlllIllllIl[2];local bWare_IIlllIllllIl=bWare_lllIIlIlIIIIIIllllI local bWare_IlllIllIlIIlIIlIIlI=1;local bWare_IIlllIllllIl=-1;local bWare_lllIIlIlIIIIIIllllI={};local bWare_IllIIlIlIlIlllIIl={...};local bWare_llIlIllIllllIlllll=bWare_IllIIIlII('#',...)-1;local bWare_IIlllIllllIl={};local bWare_IlIIllIIIlIIIIlIIl={};for bWare_IIlllIllllIl=0,bWare_llIlIllIllllIlllll do if(bWare_IIlllIllllIl>=bWare_IlIIlllllllllIIllIIlIlII)then bWare_lllIIlIlIIIIIIllllI[bWare_IIlllIllllIl-bWare_IlIIlllllllllIIllIIlIlII]=bWare_IllIIlIlIlIlllIIl[bWare_IIlllIllllIl+1];else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl]=bWare_IllIIlIlIlIlllIIl[bWare_IIlllIllllIl+#{"1 + 1 = 111";}];end;end;local bWare_IIlllIllllIl=bWare_llIlIllIllllIlllll-bWare_IlIIlllllllllIIllIIlIlII+1 local bWare_IIlllIllllIl;local bWare_IlIIlllllllllIIllIIlIlII;while true do bWare_IIlllIllllIl=bWare_lllIIlIllll[bWare_IlllIllIlIIlIIlIIlI];bWare_IlIIlllllllllIIllIIlIlII=bWare_IIlllIllllIl[#("K")];if bWare_IlIIlllllllllIIllIIlIlII<=#("8ignJmfFs5I9STLj")then if bWare_IlIIlllllllllIIllIIlIlII<=#("oDQHLE0")then if bWare_IlIIlllllllllIIllIIlIlII<=#("Rl5")then if bWare_IlIIlllllllllIIllIIlIlII<=#("x")then if bWare_IlIIlllllllllIIllIIlIlII>#("")then bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#{"1 + 1 = 111";"1 + 1 = 111";}]]={};else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("qT")]]=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("epy")]][bWare_IIlllIllllIl[#("90Pf")]];end;elseif bWare_IlIIlllllllllIIllIIlIlII>#{"1 + 1 = 111";"1 + 1 = 111";}then bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("f1")]]=bWare_llIllIIIIll(bWare_IIlIIIIIlll[bWare_IIlllIllllIl[#{"1 + 1 = 111";{347;975;184;989};"1 + 1 = 111";}]],nil,bWare_lIlIIlIlll);else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("NK3")];end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#{{663;980;496;491};{128;384;512;219};{530;292;577;217};{273;207;830;6};"1 + 1 = 111";}then if bWare_IlIIlllllllllIIllIIlIlII>#("Pvah")then bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("ZH")]]=bWare_IIlllIllllIl[#("OdY")];else local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#{"1 + 1 = 111";"1 + 1 = 111";}]bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI](bWare_lllIlIlllllIIllIlIlllIlI(bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("Cf3")]))end;elseif bWare_IlIIlllllllllIIllIIlIlII==#("ANm53q")then local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("UR")];local bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI];for bWare_IIlllIllllIl=bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("oT0")]do bWare_llllIlIlIIIllIIIIlllIlllI(bWare_IlIIlllllllllIIllIIlIlII,bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl])end;else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("nA")]]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#("Mbj")]];bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;bWare_IIlllIllllIl=bWare_lllIIlIllll[bWare_IlllIllIlIIlIIlIIlI];bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("3M")]]=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("Bre")]][bWare_IIlllIllllIl[#("SZDo")]];bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;bWare_IIlllIllllIl=bWare_lllIIlIllll[bWare_IlllIllIlIIlIIlIIlI];bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("8s")]]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#("TIT")]];bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;bWare_IIlllIllllIl=bWare_lllIIlIllll[bWare_IlllIllIlIIlIIlIIlI];bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("Er")]]=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("FPH")]][bWare_IIlllIllllIl[#("HN2J")]];bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;bWare_IIlllIllllIl=bWare_lllIIlIllll[bWare_IlllIllIlIIlIIlIIlI];if not bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("X9")]]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("2Ha")];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("2UxOpJ2ajX6")then if bWare_IlIIlllllllllIIllIIlIlII<=#("EvJQ3x5x8")then if bWare_IlIIlllllllllIIllIIlIlII>#("1oETpqIS")then local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("o7")]bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI]=bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI](bWare_lllIlIlllllIIllIlIlllIlI(bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("KAA")]))else local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("XI")]bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI]=bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI](bWare_lllIlIlllllIIllIlIlllIlI(bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("scK")]))end;elseif bWare_IlIIlllllllllIIllIIlIlII>#("ETuWyQdIs8")then if bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("F8")]]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("ada")];end;else if not bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("xX")]]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("zTB")];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("z2AeNd07tJ83U")then if bWare_IlIIlllllllllIIllIIlIlII==#("2hkHsMCCbDmj")then if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("eb")]]<bWare_IIlllIllllIl[#("oDM2")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("Kzp")];else bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;end;else if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("HZ")]]<bWare_IIlllIllllIl[#("uU7W")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("G6a")];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("laZYMyFS9ZzfmA")then local bWare_IlIIlllllllllIIllIIlIlII=bWare_IIlllIllllIl[#{{480;315;943;67};"1 + 1 = 111";}];local bWare_IlllIllIlIIlIIlIIlI=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#{"1 + 1 = 111";{196;477;325;186};"1 + 1 = 111";}]];bWare_IlIIllIIIlIIIIlIIl[bWare_IlIIlllllllllIIllIIlIlII+1]=bWare_IlllIllIlIIlIIlIIlI;bWare_IlIIllIIIlIIIIlIIl[bWare_IlIIlllllllllIIllIIlIlII]=bWare_IlllIllIlIIlIIlIIlI[bWare_IIlllIllllIl[#("tlis")]];elseif bWare_IlIIlllllllllIIllIIlIlII>#("ymF0KbFI2b9xb60")then bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("tA")]]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#("IpC")]];else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("Pr")]]=bWare_llIllIIIIll(bWare_IIlIIIIIlll[bWare_IIlllIllllIl[#("Tue")]],nil,bWare_lIlIIlIlll);end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("2DEP6EUvFpd3sVBgl0dY7vKIQ")then if bWare_IlIIlllllllllIIllIIlIlII<=#("7XNbDVi1HNSVO3Cjvu7M")then if bWare_IlIIlllllllllIIllIIlIlII<=#("gL2lk2caG368EH7SEW")then if bWare_IlIIlllllllllIIllIIlIlII==#("UBoYyAlkxYaoKem0m")then if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("cL")]]<bWare_IIlllIllllIl[#("tKua")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("LkK")];else bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;end;else if not bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("ob")]]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("Rv7")];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII>#("Zr2g1aTWXjvEB1IP1Y2")then do return end;else local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("3c")];local bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("IyC")]];bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI+1]=bWare_IlIIlllllllllIIllIIlIlII;bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI]=bWare_IlIIlllllllllIIllIIlIlII[bWare_IIlllIllllIl[#{"1 + 1 = 111";{814;738;811;271};{165;394;548;57};"1 + 1 = 111";}]];end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("EW9SQmGOv3rRV7OFAOJneM")then if bWare_IlIIlllllllllIIllIIlIlII==#("cY2xiR4ny8AqdsjBPFeB3")then if bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("m6")]]then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("odc")];end;else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("0T")]]=bWare_lIlIIlIlll[bWare_IIlllIllllIl[#("rOa")]];end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("PTEmdpmpOS2j64YZx7BP3Tv")then local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("mH")];local bWare_IlIIlllllllllIIllIIlIlII=bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI];for bWare_IIlllIllllIl=bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("AuO")]do bWare_llllIlIlIIIllIIIIlllIlllI(bWare_IlIIlllllllllIIllIIlIlII,bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl])end;elseif bWare_IlIIlllllllllIIllIIlIlII>#("Llqn3T9lTjii36NPbitSy3vp")then do return end;else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("M4")]]={};end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("Zih9n96yWL289v4SQBXVP6BtVOUzO")then if bWare_IlIIlllllllllIIllIIlIlII<=#("SZbLdL2lFjmVguVRcXA9RDJE73S")then if bWare_IlIIlllllllllIIllIIlIlII>#("oKpIUD3c7yrt0F5NI30fIeM68O")then do return bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("Y7")]]end else if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("U0")]]<bWare_IIlllIllllIl[#("AeQH")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("1Xj")];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII==#("oqHNk3d754PbNBTTOGfjmH55dcMq")then if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("15")]]~=bWare_IIlllIllllIl[#("BxlO")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("MsN")];end;else if(bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("ji")]]~=bWare_IIlllIllllIl[#("HJVd")])then bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;else bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#{"1 + 1 = 111";"1 + 1 = 111";{379;421;366;447};}];end;end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("7sJf2PVBVgBWHaS32mPYv8A3EzRvLJh")then if bWare_IlIIlllllllllIIllIIlIlII>#("XY7Mg5VW7s2APyQHmcl06CY82PLD7A")then local bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("DD")]bWare_IlIIllIIIlIIIIlIIl[bWare_IlllIllIlIIlIIlIIlI](bWare_lllIlIlllllIIllIlIlllIlI(bWare_IlIIllIIIlIIIIlIIl,bWare_IlllIllIlIIlIIlIIlI+1,bWare_IIlllIllllIl[#("Z1O")]))else do return bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("6i")]]end end;elseif bWare_IlIIlllllllllIIllIIlIlII<=#("l8j9TcgW6C30cfangSkiJyruu98TBtrY")then bWare_IlllIllIlIIlIIlIIlI=bWare_IIlllIllllIl[#("9uI")];elseif bWare_IlIIlllllllllIIllIIlIlII==#("DRBGz7EgpozdLV32CFVXqqYRYOTdyvMje")then bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("fk")]]=bWare_IIlllIllllIl[#("GzJ")];else bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("ht")]]=bWare_IlIIllIIIlIIIIlIIl[bWare_IIlllIllllIl[#("m8B")]][bWare_IIlllIllllIl[#{"1 + 1 = 111";{288;950;273;376};{140;301;226;483};{249;261;369;862};}]];end;bWare_IlllIllIlIIlIIlIIlI=bWare_IlllIllIlIIlIIlIIlI+1;end;end);end;return bWare_llIllIIIIll(true,{},bWare_IIlIIIlIllIIlllIIlll())();end)(string.byte,table.insert,setmetatable);