local lILl1jloO0=(getfenv and getfenv(1)) or _ENV or _G
local j0j110OlLii11,jo0oOlLiILI1L=string.byte,string.char
local function L111L1I1II(li0j01ol0oLj,L0OIojjjIoLL)
local L0ijol1IoO1liI=""
local ij111ilj=#L0OIojjjIoLL
for LL01ojOI0=1,#li0j01ol0oLj do L0ijol1IoO1liI=L0ijol1IoO1liI..jo0oOlLiILI1L((j0j110OlLii11(li0j01ol0oLj,LL01ojOI0)-j0j110OlLii11(L0OIojjjIoLL,(LL01ojOI0-1)%ij111ilj+1))%256) end
return L0ijol1IoO1liI
end
local j0i1OiII0ljI=lILl1jloO0[L111L1I1II("8Rb\194\205\\","\197\237\246]j\232")]
local Ii1I0O0I=lILl1jloO0[L111L1I1II("\024b\145w\140\031","\165\238\031\014\030\184\218")][L111L1I1II("\1528w","%\195\021.\205z\n")]
local jjjlliLjL=lILl1jloO0[L111L1I1II("2\022\024E#","\190\181\182\217")][L111L1I1II("\2388N\250\236=","\139\201\224\151")]
local Loo0oilLoOI0Li=lILl1jloO0[L111L1I1II("\n\007r\194","\157\166\254Z\146\164w")][L111L1I1II("\005\003x\155^","\159\151\009,\236\141")]
local ILoILlIo=lILl1jloO0[L111L1I1II("\021\218\185`\213\003\208\189","\161kK\235h")]
local ljliIOO1Ol=lILl1jloO0[L111L1I1II("S\188\156]\188","\238J*")]
local iijjlIiOoIjL=j0j110OlLii11("L")+(jo0oOlLiILI1L(75,65)=="KA" and 3922 or 94)+j0i1OiII0ljI("#",0,0,0,0,0,0)*4+ILoILlIo("7829")*7
local l1iooI0l0Il=lILl1jloO0[L111L1I1II("\175\192\210}\160",";_p\017")][L111L1I1II("L\165j\133","\220D\007\026\193\008")] or function(...) return {n=j0i1OiII0ljI("#",...),...} end
local IOlooLO011lj=lILl1jloO0[L111L1I1II("\1539\004\145=","%\216\162")][L111L1I1II("N1\127\139\247q","\217\195\015*\148\006")] or lILl1jloO0[L111L1I1II("X5\1795\136\189","\227\199C\212%R")]
local IOl0iOIOlojIl="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function IIjj1oLi1O1j10(LiL0jO)
local ijljilL={}
for lOIjj0i=1,64 do ijljilL[j0j110OlLii11(IOl0iOIOlojIl,lOIjj0i)]=lOIjj0i-1 end
local iljO0il0l,LI01ilLjjj0o1o,IOO0Lol0LollI,jILLO0Ooo0i={},0,0,0
for lOIjj0i=1,#LiL0jO do
local LilijlIo0ljiI=ijljilL[j0j110OlLii11(LiL0jO,lOIjj0i)]
if LilijlIo0ljiI then
LI01ilLjjj0o1o=LI01ilLjjj0o1o*64+LilijlIo0ljiI
IOO0Lol0LollI=IOO0Lol0LollI+6
if IOO0Lol0LollI>=8 then IOO0Lol0LollI=IOO0Lol0LollI-8 jILLO0Ooo0i=jILLO0Ooo0i+1 iljO0il0l[jILLO0Ooo0i]=jo0oOlLiILI1L(Loo0oilLoOI0Li(LI01ilLjjj0o1o/(2^IOO0Lol0LollI))%256) LI01ilLjjj0o1o=LI01ilLjjj0o1o%(2^IOO0Lol0LollI) end
end
end
return jjjlliLjL(iljO0il0l)
end
local LL0oLlojo0i="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"
local function LO0llO0L(i10o1jjijjlO)
local i0i1o0llioLLOL=(1432556715)+iijjlIiOoIjL
local LLo0L1=189
local L0Ojl10i={}
for IjOLIijjO=1,#i10o1jjijjlO do
i0i1o0llioLLOL=(i0i1o0llioLLOL*31561+638846615)%4294967296
local iLOjo0ljI0l1=j0j110OlLii11(i10o1jjijjlO,IjOLIijjO)
local liLO11=(Loo0oilLoOI0Li(i0i1o0llioLLOL/65536)+LLo0L1+(IjOLIijjO-1)*38)%256
L0Ojl10i[IjOLIijjO]=jo0oOlLiILI1L((iLOjo0ljI0l1-liLO11)%256)
LLo0L1=(LLo0L1*43+iLOjo0ljI0l1+1)%251
end
return jjjlliLjL(L0Ojl10i)
end
local ljIijo=LO0llO0L(IIjj1oLi1O1j10(LL0oLlojo0i))
local iLOjo0ljI0l1=1
local function i0iiLOj()
local IjOLIijjO=j0j110OlLii11(ljIijo,iLOjo0ljI0l1)
iLOjo0ljI0l1=iLOjo0ljI0l1+1
return IjOLIijjO
end
local function Lo0jijLljj0iL()
local IjOLIijjO,l1i1LIlooo=j0j110OlLii11(ljIijo,iLOjo0ljI0l1,iLOjo0ljI0l1+1)
iLOjo0ljI0l1=iLOjo0ljI0l1+2
return IjOLIijjO+l1i1LIlooo*256
end
local function ILlIiLL()
local IjOLIijjO,l1i1LIlooo,i10o1jjijjlO,L0Ojl10i=j0j110OlLii11(ljIijo,iLOjo0ljI0l1,iLOjo0ljI0l1+3)
iLOjo0ljI0l1=iLOjo0ljI0l1+4
return IjOLIijjO+l1i1LIlooo*256+i10o1jjijjlO*65536+L0Ojl10i*16777216
end
local function l0ilOOILiIo()
local IjOLIijjO=ILlIiLL()
local l1i1LIlooo=Ii1I0O0I(ljIijo,iLOjo0ljI0l1,iLOjo0ljI0l1+IjOLIijjO-1)
iLOjo0ljI0l1=iLOjo0ljI0l1+IjOLIijjO
return l1i1LIlooo
end
local function ILLiIjiLOIj()
local IjOLIijjO=i0iiLOj()
local l1i1LIlooo=l0ilOOILiIo()
if IjOLIijjO==0 then return ILoILlIo(l1i1LIlooo)
elseif IjOLIijjO==1 then return l1i1LIlooo
elseif IjOLIijjO==2 then return 1/0
elseif IjOLIijjO==3 then return -1/0
else return 0/0 end
end
local function III0lLI()
local i1IjL1=i0iiLOj()
local IjOLIijjO=i0iiLOj()
local l1i1LIlooo=Lo0jijLljj0iL()
local IjiOljI101ij={}
for i10o1jjijjlO=1,l1i1LIlooo do local ijoIll1lLIiO1j=Lo0jijLljj0iL() IjiOljI101ij[i10o1jjijjlO]={ijoIll1lLIiO1j,l0ilOOILiIo()} end
local L0Ojl10i=ILlIiLL()
local IL0L1o={}
for i10o1jjijjlO=1,L0Ojl10i do
IL0L1o[i10o1jjijjlO]={Lo0jijLljj0iL(),Lo0jijLljj0iL(),ILlIiLL(),ILlIiLL()}
end
local iLOjo0ljI0l1=Lo0jijLljj0iL()
local loLiio={}
for i10o1jjijjlO=1,iLOjo0ljI0l1 do loLiio[i10o1jjijjlO]=III0lLI() end
local jo1o01oIli=Lo0jijLljj0iL()
local jioiliOI0jj1O0={}
for i10o1jjijjlO=1,jo1o01oIli do jioiliOI0jj1O0[i10o1jjijjlO]={i0iiLOj(),Lo0jijLljj0iL()} end
return {i1IjL1,IjOLIijjO,IL0L1o,IjiOljI101ij,loLiio,jioiliOI0jj1O0,{}}
end
local function liiI1l0(IlLI1IoOIjL,iLOllI,ijoIll1lLIiO1j)
if iLOllI[ijoIll1lLIiO1j]~=nil then return iLOllI[ijoIll1lLIiO1j] end
local LiL0jO=IlLI1IoOIjL[ijoIll1lLIiO1j]
local ijljilL=LiL0jO[1]
local lOIjj0i=LiL0jO[2]
local iljO0il0l=(41724+ijljilL*251+1)%65536
local LI01ilLjjj0o1o={}
for IOO0Lol0LollI=1,#lOIjj0i do
iljO0il0l=(iljO0il0l*40503+12345)%65536
LI01ilLjjj0o1o[IOO0Lol0LollI]=jo0oOlLiILI1L((j0j110OlLii11(lOIjj0i,IOO0Lol0LollI)-Loo0oilLoOI0Li(iljO0il0l/256)%256-IOO0Lol0LollI*(41724%256))%256)
end
local jILLO0Ooo0i=jjjlliLjL(LI01ilLjjj0o1o)
local LilijlIo0ljiI=j0j110OlLii11(jILLO0Ooo0i,1)
local ILiIOi0olL=j0j110OlLii11(jILLO0Ooo0i,2)+j0j110OlLii11(jILLO0Ooo0i,3)*256+j0j110OlLii11(jILLO0Ooo0i,4)*65536+j0j110OlLii11(jILLO0Ooo0i,5)*16777216
local iOILlILiloooii=Ii1I0O0I(jILLO0Ooo0i,6,5+ILiIOi0olL)
local l1L1i01
if LilijlIo0ljiI==0 then l1L1i01=ILoILlIo(iOILlILiloooii) elseif LilijlIo0ljiI==1 then l1L1i01=iOILlILiloooii elseif LilijlIo0ljiI==2 then l1L1i01=1/0 elseif LilijlIo0ljiI==3 then l1L1i01=-1/0 else l1L1i01=0/0 end
iLOllI[ijoIll1lLIiO1j]=l1L1i01
return l1L1i01
end
local lLLjjj1lOio={}
local iIojiojlIiOOji=Lo0jijLljj0iL()
for lOjO0ioolOo0O=1,iIojiojlIiOOji do local IjOLIijjO=Lo0jijLljj0iL() local l1i1LIlooo=Lo0jijLljj0iL() lLLjjj1lOio[IjOLIijjO]=l1i1LIlooo end
local IL01LLoLo1I=III0lLI()
local LoiLiijojIoj
local function jiiIiil0IIO(IL01LLoLo1I,jioiliOI0jj1O0)
return function(...) return LoiLiijojIoj(IL01LLoLo1I,jioiliOI0jj1O0,l1iooI0l0Il(...)) end
end
LoiLiijojIoj=function(IL01LLoLo1I,jioiliOI0jj1O0,LOLlOj1)
local Ll0LolILLiOi0o={}
local jIlO1oii0LLi0=0
local i1IjL1=IL01LLoLo1I[1]
local j0jOjo1ijOOI0=LOLlOj1.n
for IjOLIijjO=1,i1IjL1 do Ll0LolILLiOi0o[IjOLIijjO-1]=LOLlOj1[IjOLIijjO] end
local LL1L0ijoL,iiIIj0i={},0
if IL01LLoLo1I[2]==1 then iiIIj0i=j0jOjo1ijOOI0-i1IjL1; if iiIIj0i<0 then iiIIj0i=0 end; for IjOLIijjO=1,iiIIj0i do LL1L0ijoL[IjOLIijjO]=LOLlOj1[i1IjL1+IjOLIijjO] end end
local IL0L1o,IjiOljI101ij,loLiio=IL01LLoLo1I[3],IL01LLoLo1I[4],IL01LLoLo1I[5]
local Lll1LIiI0l11=IL01LLoLo1I[7]
local jijOOIIllLii=1
local jo1o01oIli=0
while true do
local IOojijiI10jO1=IL0L1o[jijOOIIllLii]
jijOOIIllLii=jijOOIIllLii+1
local lojL1jOIo00IjL,IjOLIijjO,l1i1LIlooo,i10o1jjijjlO=IOojijiI10jO1[1],IOojijiI10jO1[2],IOojijiI10jO1[3],IOojijiI10jO1[4]
local L0Ojl10i=lLLjjj1lOio[lojL1jOIo00IjL]
if (jijOOIIllLii*(jijOOIIllLii+1)*(jijOOIIllLii+2))%3~=0 then jIlO1oii0LLi0=jIlO1oii0LLi0-1 end
if (L0Ojl10i*L0Ojl10i+L0Ojl10i)%2==1 then jIlO1oii0LLi0=jIlO1oii0LLi0-6 end
if L0Ojl10i==25 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]
elseif L0Ojl10i==32 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[IjOLIijjO]-Ll0LolILLiOi0o[IjOLIijjO+2]; jijOOIIllLii=l1i1LIlooo+1
elseif L0Ojl10i==1 then
Ll0LolILLiOi0o[IjOLIijjO]={Ll0LolILLiOi0o[l1i1LIlooo]}
elseif L0Ojl10i==18 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]<Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==23 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[IjOLIijjO]+Ll0LolILLiOi0o[IjOLIijjO+2]
local ijljilL=Ll0LolILLiOi0o[IjOLIijjO+2]
if (ijljilL>0 and Ll0LolILLiOi0o[IjOLIijjO]<=Ll0LolILLiOi0o[IjOLIijjO+1]) or (ijljilL<=0 and Ll0LolILLiOi0o[IjOLIijjO]>=Ll0LolILLiOi0o[IjOLIijjO+1]) then Ll0LolILLiOi0o[IjOLIijjO+3]=Ll0LolILLiOi0o[IjOLIijjO]; jijOOIIllLii=l1i1LIlooo+1 end
elseif L0Ojl10i==41 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]*Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==26 then
jioiliOI0jj1O0[l1i1LIlooo+1][1]=Ll0LolILLiOi0o[IjOLIijjO]
elseif L0Ojl10i==14 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]/Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==28 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]%Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==9 then
Ll0LolILLiOi0o[l1i1LIlooo][1]=Ll0LolILLiOi0o[IjOLIijjO]
elseif L0Ojl10i==16 then
jijOOIIllLii=l1i1LIlooo+1
elseif L0Ojl10i==3 then
Ll0LolILLiOi0o[IjOLIijjO]=#Ll0LolILLiOi0o[l1i1LIlooo]
elseif L0Ojl10i==24 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]-Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==39 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]>=Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==11 then
local ijljilL=Ll0LolILLiOi0o[IjOLIijjO]
local jILLO0Ooo0i=Ll0LolILLiOi0o[IjOLIijjO+1]
local LilijlIo0ljiI=Ll0LolILLiOi0o[IjOLIijjO+2]
local LI01ilLjjj0o1o=l1iooI0l0Il(ijljilL(jILLO0Ooo0i,LilijlIo0ljiI))
local IOO0Lol0LollI=LI01ilLjjj0o1o[1]
if IOO0Lol0LollI~=nil then
Ll0LolILLiOi0o[IjOLIijjO+2]=IOO0Lol0LollI
for LiL0jO=1,l1i1LIlooo do Ll0LolILLiOi0o[IjOLIijjO+3+LiL0jO-1]=LI01ilLjjj0o1o[LiL0jO] end
jijOOIIllLii=i10o1jjijjlO+1
end
elseif L0Ojl10i==8 then
Ll0LolILLiOi0o[IjOLIijjO]=((Ll0LolILLiOi0o[IjOLIijjO] or 0)+l1i1LIlooo)%(i10o1jjijjlO+1)
elseif L0Ojl10i==2 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]==Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==7 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]>Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==19 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]^Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==37 then
local lOIjj0i
if l1i1LIlooo==0 then lOIjj0i=jo1o01oIli-IjOLIijjO else lOIjj0i=l1i1LIlooo-1 end
local iljO0il0l={}
for LiL0jO=1,lOIjj0i do iljO0il0l[LiL0jO]=Ll0LolILLiOi0o[IjOLIijjO+LiL0jO-1] end
return IOlooLO011lj(iljO0il0l,1,lOIjj0i)
elseif L0Ojl10i==34 then
for LiL0jO=IjOLIijjO,IjOLIijjO+l1i1LIlooo do Ll0LolILLiOi0o[LiL0jO]=nil end
elseif L0Ojl10i==31 then
local lOIjj0i
if l1i1LIlooo==0 then lOIjj0i=jo1o01oIli-IjOLIijjO-1 else lOIjj0i=l1i1LIlooo end
local ijljilL=Ll0LolILLiOi0o[IjOLIijjO]
for LiL0jO=1,lOIjj0i do ijljilL[i10o1jjijjlO+LiL0jO]=Ll0LolILLiOi0o[IjOLIijjO+LiL0jO] end
elseif L0Ojl10i==15 then
local ijljilL=loLiio[l1i1LIlooo+1]
local iljO0il0l={}
local LI01ilLjjj0o1o=ijljilL[6]
for LiL0jO=1,#LI01ilLjjj0o1o do
local IOO0Lol0LollI=LI01ilLjjj0o1o[LiL0jO]
if IOO0Lol0LollI[1]==1 then iljO0il0l[LiL0jO]=Ll0LolILLiOi0o[IOO0Lol0LollI[2]] else iljO0il0l[LiL0jO]=jioiliOI0jj1O0[IOO0Lol0LollI[2]+1] end
end
Ll0LolILLiOi0o[IjOLIijjO]=jiiIiil0IIO(ijljilL,iljO0il0l)
elseif L0Ojl10i==30 then
Ll0LolILLiOi0o[IjOLIijjO]=jioiliOI0jj1O0[l1i1LIlooo+1][1]
elseif L0Ojl10i==17 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]~=Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==43 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo][1]
elseif L0Ojl10i==42 then
Ll0LolILLiOi0o[IjOLIijjO]=-Ll0LolILLiOi0o[l1i1LIlooo]
elseif L0Ojl10i==40 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo][Ll0LolILLiOi0o[i10o1jjijjlO]]
elseif L0Ojl10i==35 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]+Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==22 then
Ll0LolILLiOi0o[IjOLIijjO]=(l1i1LIlooo~=0)
elseif L0Ojl10i==20 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]-Ll0LolILLiOi0o[l1i1LIlooo]%Ll0LolILLiOi0o[i10o1jjijjlO])/Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==12 then
Ll0LolILLiOi0o[IjOLIijjO]=not Ll0LolILLiOi0o[l1i1LIlooo]
elseif L0Ojl10i==10 then
local ijljilL=Ll0LolILLiOi0o[IjOLIijjO]
local lOIjj0i
if l1i1LIlooo==0 then lOIjj0i=jo1o01oIli-IjOLIijjO-1 else lOIjj0i=l1i1LIlooo-1 end
local iljO0il0l={}
for LiL0jO=1,lOIjj0i do iljO0il0l[LiL0jO]=Ll0LolILLiOi0o[IjOLIijjO+LiL0jO] end
local LI01ilLjjj0o1o=l1iooI0l0Il(ijljilL(IOlooLO011lj(iljO0il0l,1,lOIjj0i)))
if i10o1jjijjlO==0 then
local IOO0Lol0LollI=LI01ilLjjj0o1o.n
for LiL0jO=1,IOO0Lol0LollI do Ll0LolILLiOi0o[IjOLIijjO+LiL0jO-1]=LI01ilLjjj0o1o[LiL0jO] end
jo1o01oIli=IjOLIijjO+IOO0Lol0LollI
else
for LiL0jO=1,i10o1jjijjlO-1 do Ll0LolILLiOi0o[IjOLIijjO+LiL0jO-1]=LI01ilLjjj0o1o[LiL0jO] end
end
elseif L0Ojl10i==29 then
Ll0LolILLiOi0o[IjOLIijjO]=liiI1l0(IjiOljI101ij,Lll1LIiI0l11,l1i1LIlooo+1)
elseif L0Ojl10i==36 then
Ll0LolILLiOi0o[IjOLIijjO]=lILl1jloO0[liiI1l0(IjiOljI101ij,Lll1LIiI0l11,l1i1LIlooo+1)]
elseif L0Ojl10i==33 then
Ll0LolILLiOi0o[IjOLIijjO]=(Ll0LolILLiOi0o[l1i1LIlooo]<=Ll0LolILLiOi0o[i10o1jjijjlO])
elseif L0Ojl10i==27 then
Ll0LolILLiOi0o[IjOLIijjO]={}
elseif L0Ojl10i==6 then
if l1i1LIlooo==0 then
for LiL0jO=1,iiIIj0i do Ll0LolILLiOi0o[IjOLIijjO+LiL0jO-1]=LL1L0ijoL[LiL0jO] end
jo1o01oIli=IjOLIijjO+iiIIj0i
else
for LiL0jO=1,l1i1LIlooo-1 do Ll0LolILLiOi0o[IjOLIijjO+LiL0jO-1]=LL1L0ijoL[LiL0jO] end
end
elseif L0Ojl10i==13 then
Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo]..Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==5 then
if (not not Ll0LolILLiOi0o[IjOLIijjO])==(l1i1LIlooo~=0) then jijOOIIllLii=i10o1jjijjlO+1 end
elseif L0Ojl10i==38 then
Ll0LolILLiOi0o[IjOLIijjO+1]=Ll0LolILLiOi0o[l1i1LIlooo]; Ll0LolILLiOi0o[IjOLIijjO]=Ll0LolILLiOi0o[l1i1LIlooo][Ll0LolILLiOi0o[i10o1jjijjlO]]
elseif L0Ojl10i==4 then
Ll0LolILLiOi0o[IjOLIijjO][Ll0LolILLiOi0o[l1i1LIlooo]]=Ll0LolILLiOi0o[i10o1jjijjlO]
elseif L0Ojl10i==21 then
lILl1jloO0[liiI1l0(IjiOljI101ij,Lll1LIiI0l11,l1i1LIlooo+1)]=Ll0LolILLiOi0o[IjOLIijjO]
else ljliIOO1Ol() end
end
return jIlO1oii0LLi0
end
return LoiLiijojIoj(IL01LLoLo1I,{},l1iooI0l0Il(...))
