local Lololo=(getfenv and getfenv(1)) or _ENV or _G
local lO0ojjj11il,L1oLiI1Ljol=string.byte,string.char
local function Lil0Oj1OLjll(i1ojiLijO01O0j,lLiLoOILjlj)
local Lj0Oojil=""
local LL1LOO0j0Lio=#lLiLoOILjlj
for loijji0il1iOL=1,#i1ojiLijO01O0j do Lj0Oojil=Lj0Oojil..L1oLiI1Ljol((lO0ojjj11il(i1ojiLijO01O0j,loijji0il1iOL)-lO0ojjj11il(lLiLoOILjlj,(loijji0il1iOL-1)%LL1LOO0j0Lio+1))%256) end
return Lj0Oojil
end
local IIoj1jl0IjiO=Lololo[Lil0Oj1OLjll("\022<\002\150T\023","\163\215\1501\241")]
local ioijllLIjLi=Lololo[Lil0Oj1OLjll("4W\148\175/J","\193\227\"F")][Lil0Oj1OLjll("\211\250s","`\133\017\134\n%\198")]
local L1IlliOOIo=Lololo[Lil0Oj1OLjll("\178\131\162\023\163",">\"@\171")][Lil0Oj1OLjll("\212\224rs/~","qq\004\016\206\n")]
local llj0IOOj1Oj0j=Lololo[Lil0Oj1OLjll("/-7\253","\194\204\195\149")][Lil0Oj1OLjll(" \216\017\225\224","\186l\162rn")]
local IlL0lL0Ill=Lololo[Lil0Oj1OLjll("\210\183{\211\181o\195\186","^H\r")]
local lIooij01jl0l=Lololo[Lil0Oj1OLjll("\136\129P\023p","#\015\222\168\2549")]
local iiol0IIiljl1O0=(L1oLiI1Ljol(69,73)=="EI" and 2765 or 40)+IlL0lL0Ill("1301")*5+IIoj1jl0IjiO("#",0,0,0,0,0,0)*22+lO0ojjj11il("b")
local iIl1O1Lijl00=Lololo[Lil0Oj1OLjll("R\2295\235F","\222\132\211\127\225O\245")][Lil0Oj1OLjll("Npb%","\222\015\255\186\178V")] or function(...) return {n=IIoj1jl0IjiO("#",...),...} end
local ilijiO1I1jO1=Lololo[Lil0Oj1OLjll("\223SvC\012","k\242\020\215\167-")][Lil0Oj1OLjll("\012z\248\141@v","\151\012\136,\221\011\202")] or Lololo[Lil0Oj1OLjll("\139O\191\150\171\170","\022\225O5H?e")]
local ljoIILoO1illj="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function LLlIO1j1I1o(j1Li1OIij)
local IIloljjIIoj1Io={}
for iI0ooj00oI0ojI=1,64 do IIloljjIIoj1Io[lO0ojjj11il(ljoIILoO1illj,iI0ooj00oI0ojI)]=iI0ooj00oI0ojI-1 end
local j0loiOoILIj,IlI1ILlj1O1oj,IoLjIiL0l10l,iLolLolI0={},0,0,0
for iI0ooj00oI0ojI=1,#j1Li1OIij do
local IiiliiLo1=IIloljjIIoj1Io[lO0ojjj11il(j1Li1OIij,iI0ooj00oI0ojI)]
if IiiliiLo1 then
IlI1ILlj1O1oj=IlI1ILlj1O1oj*64+IiiliiLo1
IoLjIiL0l10l=IoLjIiL0l10l+6
if IoLjIiL0l10l>=8 then IoLjIiL0l10l=IoLjIiL0l10l-8 iLolLolI0=iLolLolI0+1 j0loiOoILIj[iLolLolI0]=L1oLiI1Ljol(llj0IOOj1Oj0j(IlI1ILlj1O1oj/(2^IoLjIiL0l10l))%256) IlI1ILlj1O1oj=IlI1ILlj1O1oj%(2^IoLjIiL0l10l) end
end
end
return L1IlliOOIo(j0loiOoILIj)
end
local IOILIooljLjI="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"
local function IiOIo1Iij(jLLiLjijOjOoL)
local LLliil0L10ilLi=(2155151023)+iiol0IIiljl1O0
local Iij10o=47
local j1Oj0j={}
for iIljIoOoL=1,#jLLiLjijOjOoL do
LLliil0L10ilLi=(LLliil0L10ilLi*35315+2357354687)%4294967296
local i1Ljliij0O=lO0ojjj11il(jLLiLjijOjOoL,iIljIoOoL)
local lolLO1=(llj0IOOj1Oj0j(LLliil0L10ilLi/65536)+Iij10o+(iIljIoOoL-1)*182)%256
j1Oj0j[iIljIoOoL]=L1oLiI1Ljol((i1Ljliij0O-lolLO1)%256)
Iij10o=(Iij10o*37+i1Ljliij0O+1)%251
end
return L1IlliOOIo(j1Oj0j)
end
local j0lIOlij0Loj0=IiOIo1Iij(LLlIO1j1I1o(IOILIooljLjI))
local i1Ljliij0O=1
local function jl0IlL()
local iIljIoOoL=lO0ojjj11il(j0lIOlij0Loj0,i1Ljliij0O)
i1Ljliij0O=i1Ljliij0O+1
return iIljIoOoL
end
local function jLl0IOjiLoIoi()
local iIljIoOoL,LoojIi=lO0ojjj11il(j0lIOlij0Loj0,i1Ljliij0O,i1Ljliij0O+1)
i1Ljliij0O=i1Ljliij0O+2
return iIljIoOoL+LoojIi*256
end
local function LjIoo0Il0()
local iIljIoOoL,LoojIi,jLLiLjijOjOoL,j1Oj0j=lO0ojjj11il(j0lIOlij0Loj0,i1Ljliij0O,i1Ljliij0O+3)
i1Ljliij0O=i1Ljliij0O+4
return iIljIoOoL+LoojIi*256+jLLiLjijOjOoL*65536+j1Oj0j*16777216
end
local function j1LiIIi()
local iIljIoOoL=LjIoo0Il0()
local LoojIi=ioijllLIjLi(j0lIOlij0Loj0,i1Ljliij0O,i1Ljliij0O+iIljIoOoL-1)
i1Ljliij0O=i1Ljliij0O+iIljIoOoL
return LoojIi
end
local function lillIL1OlOO()
local iIljIoOoL=jl0IlL()
local LoojIi=j1LiIIi()
if iIljIoOoL==0 then return IlL0lL0Ill(LoojIi)
elseif iIljIoOoL==1 then return LoojIi
elseif iIljIoOoL==2 then return 1/0
elseif iIljIoOoL==3 then return -1/0
else return 0/0 end
end
local function jLo0i1jjo()
local l01ILiL0=jl0IlL()
local iIljIoOoL=jl0IlL()
local LoojIi=jLl0IOjiLoIoi()
local ILill1L={}
for jLLiLjijOjOoL=1,LoojIi do local ijIOOI0oLj=jLl0IOjiLoIoi() ILill1L[jLLiLjijOjOoL]={ijIOOI0oLj,j1LiIIi()} end
local j1Oj0j=LjIoo0Il0()
local l1LLjI1io0l101={}
for jLLiLjijOjOoL=1,j1Oj0j do
l1LLjI1io0l101[jLLiLjijOjOoL]={jLl0IOjiLoIoi(),jLl0IOjiLoIoi(),LjIoo0Il0(),LjIoo0Il0()}
end
local i1Ljliij0O=jLl0IOjiLoIoi()
local iLILL1lLj0Iil={}
for jLLiLjijOjOoL=1,i1Ljliij0O do iLILL1lLj0Iil[jLLiLjijOjOoL]=jLo0i1jjo() end
local IjIllLl=jLl0IOjiLoIoi()
local l1LojLOlI={}
for jLLiLjijOjOoL=1,IjIllLl do l1LojLOlI[jLLiLjijOjOoL]={jl0IlL(),jLl0IOjiLoIoi()} end
return {l01ILiL0,iIljIoOoL,l1LLjI1io0l101,ILill1L,iLILL1lLj0Iil,l1LojLOlI,{}}
end
local function l1ljoloO(jj001oL1i0L1,joOL0iOLol,ijIOOI0oLj)
if joOL0iOLol[ijIOOI0oLj]~=nil then return joOL0iOLol[ijIOOI0oLj] end
local j1Li1OIij=jj001oL1i0L1[ijIOOI0oLj]
local IIloljjIIoj1Io=j1Li1OIij[1]
local iI0ooj00oI0ojI=j1Li1OIij[2]
local j0loiOoILIj=(24795+IIloljjIIoj1Io*251+1)%65536
local IlI1ILlj1O1oj={}
for IoLjIiL0l10l=1,#iI0ooj00oI0ojI do
j0loiOoILIj=(j0loiOoILIj*40503+12345)%65536
IlI1ILlj1O1oj[IoLjIiL0l10l]=L1oLiI1Ljol((lO0ojjj11il(iI0ooj00oI0ojI,IoLjIiL0l10l)-llj0IOOj1Oj0j(j0loiOoILIj/256)%256-IoLjIiL0l10l*(24795%256))%256)
end
local iLolLolI0=L1IlliOOIo(IlI1ILlj1O1oj)
local IiiliiLo1=lO0ojjj11il(iLolLolI0,1)
local iiIjI1o1o=lO0ojjj11il(iLolLolI0,2)+lO0ojjj11il(iLolLolI0,3)*256+lO0ojjj11il(iLolLolI0,4)*65536+lO0ojjj11il(iLolLolI0,5)*16777216
local ljlIo0ooO1oL=ioijllLIjLi(iLolLolI0,6,5+iiIjI1o1o)
local lLLIioI00jlllj
if IiiliiLo1==0 then lLLIioI00jlllj=IlL0lL0Ill(ljlIo0ooO1oL) elseif IiiliiLo1==1 then lLLIioI00jlllj=ljlIo0ooO1oL elseif IiiliiLo1==2 then lLLIioI00jlllj=1/0 elseif IiiliiLo1==3 then lLLIioI00jlllj=-1/0 else lLLIioI00jlllj=0/0 end
joOL0iOLol[ijIOOI0oLj]=lLLIioI00jlllj
return lLLIioI00jlllj
end
local iijoiOoj10={}
local iIoo1O=jLl0IOjiLoIoi()
for i1LOj1iIl=1,iIoo1O do local iIljIoOoL=jLl0IOjiLoIoi() local LoojIi=jLl0IOjiLoIoi() iijoiOoj10[iIljIoOoL]=LoojIi end
local j0o0OoLi=jLo0i1jjo()
local l0OOIiiojo10O
local function j0ll11(j0o0OoLi,l1LojLOlI)
return function(...) return l0OOIiiojo10O(j0o0OoLi,l1LojLOlI,iIl1O1Lijl00(...)) end
end
l0OOIiiojo10O=function(j0o0OoLi,l1LojLOlI,ilIooL)
local L0OiIoi1j1oIL={}
local iIO10liL=0
local l01ILiL0=j0o0OoLi[1]
local I0liOOi00IOIOI=ilIooL.n
for iIljIoOoL=1,l01ILiL0 do L0OiIoi1j1oIL[iIljIoOoL-1]=ilIooL[iIljIoOoL] end
local jIloOLl1j,jo00011LloLi0={},0
if j0o0OoLi[2]==1 then jo00011LloLi0=I0liOOi00IOIOI-l01ILiL0; if jo00011LloLi0<0 then jo00011LloLi0=0 end; for iIljIoOoL=1,jo00011LloLi0 do jIloOLl1j[iIljIoOoL]=ilIooL[l01ILiL0+iIljIoOoL] end end
local l1LLjI1io0l101,ILill1L,iLILL1lLj0Iil=j0o0OoLi[3],j0o0OoLi[4],j0o0OoLi[5]
local I01iIjlI=j0o0OoLi[7]
local Li0Li00i000O=1
local IjIllLl=0
while true do
local iiiolo00l1l0=l1LLjI1io0l101[Li0Li00i000O]
Li0Li00i000O=Li0Li00i000O+1
local LOOOOIijoljIL,iIljIoOoL,LoojIi,jLLiLjijOjOoL=iiiolo00l1l0[1],iiiolo00l1l0[2],iiiolo00l1l0[3],iiiolo00l1l0[4]
local j1Oj0j=iijoiOoj10[LOOOOIijoljIL]
if (Li0Li00i000O*Li0Li00i000O+Li0Li00i000O)%2~=0 then iIO10liL=iIO10liL+5 end
if j1Oj0j==43 then
L0OiIoi1j1oIL[iIljIoOoL]=Lololo[l1ljoloO(ILill1L,I01iIjlI,LoojIi+1)]
elseif j1Oj0j==31 then
local iI0ooj00oI0ojI
if LoojIi==0 then iI0ooj00oI0ojI=IjIllLl-iIljIoOoL-1 else iI0ooj00oI0ojI=LoojIi end
local IIloljjIIoj1Io=L0OiIoi1j1oIL[iIljIoOoL]
for j1Li1OIij=1,iI0ooj00oI0ojI do IIloljjIIoj1Io[jLLiLjijOjOoL+j1Li1OIij]=L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij] end
elseif j1Oj0j==42 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]<=L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==30 then
L0OiIoi1j1oIL[iIljIoOoL]={}
elseif j1Oj0j==7 then
Lololo[l1ljoloO(ILill1L,I01iIjlI,LoojIi+1)]=L0OiIoi1j1oIL[iIljIoOoL]
elseif j1Oj0j==36 then
l1LojLOlI[LoojIi+1][1]=L0OiIoi1j1oIL[iIljIoOoL]
elseif j1Oj0j==22 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]>=L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==19 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]+L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==12 then
if (not not L0OiIoi1j1oIL[iIljIoOoL])==(LoojIi~=0) then Li0Li00i000O=jLLiLjijOjOoL+1 end
elseif j1Oj0j==4 then
for j1Li1OIij=iIljIoOoL,iIljIoOoL+LoojIi do L0OiIoi1j1oIL[j1Li1OIij]=nil end
elseif j1Oj0j==38 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]%L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==17 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]<L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==9 then
L0OiIoi1j1oIL[iIljIoOoL][L0OiIoi1j1oIL[LoojIi]]=L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==20 then
local IIloljjIIoj1Io=L0OiIoi1j1oIL[iIljIoOoL]
local iLolLolI0=L0OiIoi1j1oIL[iIljIoOoL+1]
local IiiliiLo1=L0OiIoi1j1oIL[iIljIoOoL+2]
local IlI1ILlj1O1oj=iIl1O1Lijl00(IIloljjIIoj1Io(iLolLolI0,IiiliiLo1))
local IoLjIiL0l10l=IlI1ILlj1O1oj[1]
if IoLjIiL0l10l~=nil then
L0OiIoi1j1oIL[iIljIoOoL+2]=IoLjIiL0l10l
for j1Li1OIij=1,LoojIi do L0OiIoi1j1oIL[iIljIoOoL+3+j1Li1OIij-1]=IlI1ILlj1O1oj[j1Li1OIij] end
Li0Li00i000O=jLLiLjijOjOoL+1
end
elseif j1Oj0j==18 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[iIljIoOoL]-L0OiIoi1j1oIL[iIljIoOoL+2]; Li0Li00i000O=LoojIi+1
elseif j1Oj0j==5 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]~=L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==41 then
L0OiIoi1j1oIL[LoojIi][1]=L0OiIoi1j1oIL[iIljIoOoL]
elseif j1Oj0j==25 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]-L0OiIoi1j1oIL[LoojIi]%L0OiIoi1j1oIL[jLLiLjijOjOoL])/L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==6 then
L0OiIoi1j1oIL[iIljIoOoL]=(LoojIi~=0)
elseif j1Oj0j==2 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi][L0OiIoi1j1oIL[jLLiLjijOjOoL]]
elseif j1Oj0j==29 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]>L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==10 then
if LoojIi==0 then
for j1Li1OIij=1,jo00011LloLi0 do L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij-1]=jIloOLl1j[j1Li1OIij] end
IjIllLl=iIljIoOoL+jo00011LloLi0
else
for j1Li1OIij=1,LoojIi-1 do L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij-1]=jIloOLl1j[j1Li1OIij] end
end
elseif j1Oj0j==24 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi][1]
elseif j1Oj0j==3 then
L0OiIoi1j1oIL[iIljIoOoL]=not L0OiIoi1j1oIL[LoojIi]
elseif j1Oj0j==33 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]-L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==1 then
Li0Li00i000O=LoojIi+1
elseif j1Oj0j==37 then
L0OiIoi1j1oIL[iIljIoOoL+1]=L0OiIoi1j1oIL[LoojIi]; L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi][L0OiIoi1j1oIL[jLLiLjijOjOoL]]
elseif j1Oj0j==8 then
L0OiIoi1j1oIL[iIljIoOoL]={L0OiIoi1j1oIL[LoojIi]}
elseif j1Oj0j==32 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]..L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==28 then
L0OiIoi1j1oIL[iIljIoOoL]=(L0OiIoi1j1oIL[LoojIi]==L0OiIoi1j1oIL[jLLiLjijOjOoL])
elseif j1Oj0j==26 then
local IIloljjIIoj1Io=L0OiIoi1j1oIL[iIljIoOoL]
local iI0ooj00oI0ojI
if LoojIi==0 then iI0ooj00oI0ojI=IjIllLl-iIljIoOoL-1 else iI0ooj00oI0ojI=LoojIi-1 end
local j0loiOoILIj={}
for j1Li1OIij=1,iI0ooj00oI0ojI do j0loiOoILIj[j1Li1OIij]=L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij] end
local IlI1ILlj1O1oj=iIl1O1Lijl00(IIloljjIIoj1Io(ilijiO1I1jO1(j0loiOoILIj,1,iI0ooj00oI0ojI)))
if jLLiLjijOjOoL==0 then
local IoLjIiL0l10l=IlI1ILlj1O1oj.n
for j1Li1OIij=1,IoLjIiL0l10l do L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij-1]=IlI1ILlj1O1oj[j1Li1OIij] end
IjIllLl=iIljIoOoL+IoLjIiL0l10l
else
for j1Li1OIij=1,jLLiLjijOjOoL-1 do L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij-1]=IlI1ILlj1O1oj[j1Li1OIij] end
end
elseif j1Oj0j==34 then
L0OiIoi1j1oIL[iIljIoOoL]=l1LojLOlI[LoojIi+1][1]
elseif j1Oj0j==23 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[iIljIoOoL]+L0OiIoi1j1oIL[iIljIoOoL+2]
local IIloljjIIoj1Io=L0OiIoi1j1oIL[iIljIoOoL+2]
if (IIloljjIIoj1Io>0 and L0OiIoi1j1oIL[iIljIoOoL]<=L0OiIoi1j1oIL[iIljIoOoL+1]) or (IIloljjIIoj1Io<=0 and L0OiIoi1j1oIL[iIljIoOoL]>=L0OiIoi1j1oIL[iIljIoOoL+1]) then L0OiIoi1j1oIL[iIljIoOoL+3]=L0OiIoi1j1oIL[iIljIoOoL]; Li0Li00i000O=LoojIi+1 end
elseif j1Oj0j==11 then
L0OiIoi1j1oIL[iIljIoOoL]=((L0OiIoi1j1oIL[iIljIoOoL] or 0)+LoojIi)%(jLLiLjijOjOoL+1)
elseif j1Oj0j==14 then
local IIloljjIIoj1Io=iLILL1lLj0Iil[LoojIi+1]
local j0loiOoILIj={}
local IlI1ILlj1O1oj=IIloljjIIoj1Io[6]
for j1Li1OIij=1,#IlI1ILlj1O1oj do
local IoLjIiL0l10l=IlI1ILlj1O1oj[j1Li1OIij]
if IoLjIiL0l10l[1]==1 then j0loiOoILIj[j1Li1OIij]=L0OiIoi1j1oIL[IoLjIiL0l10l[2]] else j0loiOoILIj[j1Li1OIij]=l1LojLOlI[IoLjIiL0l10l[2]+1] end
end
L0OiIoi1j1oIL[iIljIoOoL]=j0ll11(IIloljjIIoj1Io,j0loiOoILIj)
elseif j1Oj0j==15 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]^L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==39 then
L0OiIoi1j1oIL[iIljIoOoL]=#L0OiIoi1j1oIL[LoojIi]
elseif j1Oj0j==35 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]/L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==27 then
L0OiIoi1j1oIL[iIljIoOoL]=-L0OiIoi1j1oIL[LoojIi]
elseif j1Oj0j==13 then
L0OiIoi1j1oIL[iIljIoOoL]=l1ljoloO(ILill1L,I01iIjlI,LoojIi+1)
elseif j1Oj0j==21 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]
elseif j1Oj0j==40 then
L0OiIoi1j1oIL[iIljIoOoL]=L0OiIoi1j1oIL[LoojIi]*L0OiIoi1j1oIL[jLLiLjijOjOoL]
elseif j1Oj0j==16 then
local iI0ooj00oI0ojI
if LoojIi==0 then iI0ooj00oI0ojI=IjIllLl-iIljIoOoL else iI0ooj00oI0ojI=LoojIi-1 end
local j0loiOoILIj={}
for j1Li1OIij=1,iI0ooj00oI0ojI do j0loiOoILIj[j1Li1OIij]=L0OiIoi1j1oIL[iIljIoOoL+j1Li1OIij-1] end
return ilijiO1I1jO1(j0loiOoILIj,1,iI0ooj00oI0ojI)
else lIooij01jl0l() end
end
return iIO10liL
end
return l0OOIiiojo10O(j0o0OoLi,{},iIl1O1Lijl00(...))
