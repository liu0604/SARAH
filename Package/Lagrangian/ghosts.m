(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



CalcGaugeTransformations:=Block[{i},

PrintDebug["Calc Gauge Transformations"];
Print["Calculate gauge transformations: ",Dynamic[DynamicGaugeTNr],"/",AnzahlChiral+Length[Gauge]," (",Dynamic[DynamicGaugeTName],")"];

GaugeTransformation={};

For[i=1,i<=Length[Gauge],
DynamicGaugeTNr=i;
DynamicGaugeTName=SGauge[[i]];
PrintDebug["   ",SGauge[[i]]];
ai=ADI[i];
GaugeTransformation=Join[GaugeTransformation,{{(SGauge[[i]]/.subGC[1]),Gauge[[i,4]] getStructureConstant[i,ai /. subGC[1],ai /. subGC[2],ai /. subGC[3]] part[gGauge[[i]],2] part[SGauge[[i]],3]}}];
i++;];

For[i=1,i<=AnzahlChiral,
DynamicGaugeTNr=i+Length[Gauge];
DynamicGaugeTName=SFields[[i]];
PrintDebug["   ",SFields[[i]]];
If[SFields[[i]]=!=0,
temp= - (I KovariantGhost[i,1,2,3])*part[SFields[[i]],2];
If[temp=!=0,
gaugeT=Flatten[SumOverIndizesGhost[SumOverExpandedIndizes[temp,{None,Fields[[i,3]]}],{Fields[[i,3]]}]] /.subFieldsOne;,
gaugeT=0;
];
(* If[Dimensions[SFieldsMultiplets[[i]]]=!={1}, *)
If[Head[SFieldsMultiplets[[i]]]===List,
(* withoutNum=Flatten[DeleteCases[SFieldsMultiplets[[i]],x_?NumberQ,4]]; *)
withoutNum=Flatten[DeleteCases[SFieldsMultiplets[[i]],x_?NumberQ,{3,4}]] /. 0->1; (* CHECK *)
withNum=Flatten[SFieldsMultiplets[[i]]];
NumFac=withNum/withoutNum;
invF=Map[getFull,withoutNum] /. subGC[1];
For[j=1,j<=Length[invF],
If[NumericQ[invF[[j]]]===False,
GaugeTransformation=Join[GaugeTransformation, {{invF[[j]],NumFac[[j]]gaugeT[[j]]}}];
];
j++;];,
GaugeTransformation=Join[GaugeTransformation, {{SFieldsMultiplets[[i]],gaugeT}}];
];
];
i++;];
DynamicGaugeTName="All Done";
GaugeTransformation=DeleteCases[GaugeTransformation,{_,_,0}] /.{GetGen -> getGen,GetGenStart->getGenStart};
];



UpdateGaugeTransformations[sub_,subInv_,nameUGT_]:=Block[{i,temp},

Print["   Update gauge transformations: ",Dynamic[DynamicUGT[nameUGT]],"/",Length[Particles[Current]]," (",Dynamic[DynamicUGTname[nameUGT]],")"];
PrintDebug["   Update gauge transformations"];

If[sub=!={} ,
NewGaugeTransformation={};
For[i=1,i<=Length[Particles[Current]],
DynamicUGTname[nameUGT]=Particles[Current][[i,1]];
DynamicUGT[nameUGT]=i;
PrintDebug[Particles[Current][[i,1]]];
If[Particles[Current][[i,4]]===S || Particles[Current][[i,4]]===V,
temp = DeltaGT[ReplaceAll[replaceGen[ReleaseHold[getFull[Particles[Current][[i,1]]] /.subGC[1] /. subInv /. gen1->pre1],rgNr], gen1->tem1]];
rgNr++;
NewGaugeTransformation=Join[NewGaugeTransformation,{{Particles[Current][[i,1]],(replaceGen[ReleaseHold[temp/. sub],rgNr] /.pre1->gen1 /.tem1->int10  )}}];
];
i++;];
DynamicUGTname[nameUGT]="All Done";
GaugeTransformation=DeleteCases[NewGaugeTransformation,{_,_,0}] /.{GetGen -> getGen,GetGenStart->getGenStart};
];

];

KovariantGhost[fieldNr_,p1_,p2_, LorNr_]:=Block[{i,temp, gauge, gaugeNr,gNr,gNr2},
temp=0;
For[gNr=1,gNr<=AnzahlGauge,
If[FieldDim[fieldNr,gNr]=!=0 || Gauge[[gNr,2]]===U[1] ,
temp += part[gGauge[[gNr]],LorNr] getGenerator[gNr,FieldDim[fieldNr,gNr],LorNr,p1,p2]*
Gauge[[gNr,4]] makeDelta[fieldNr,p1,p2,{Gauge[[gNr,3]]}];
If[Gauge[[gNr,2]]===U[1] && NoU1Mixing=!=True,
For[gNr2=1,gNr2<=AnzahlGauge,
If[Gauge[[gNr2,2]]===U[1] && gNr2!= gNr,
temp +=  part[gGauge[[gNr]],LorNr] getGenerator[gNr2,FieldDim[fieldNr,gNr2],LorNr,p1,p2]*
GaugesU1[gNr2,gNr] makeDelta[fieldNr,p1,p2,{Gauge[[gNr,3]]}];
];
gNr2++;
];
];
];
gNr++;];
Return[temp];
];


SumOverIndizesGhost[term_,partList_]:=Block[{j,i,temp, temp1,pos},
IndexNames={};
For[i=1,i<=Length[partList],
If[partList[[i]]=!=None,
pos=Position[ListFields,partList[[i]]][[1,1]];
For[j=1,j<=Length[ListFields[[pos,2]]],
(* IndexNames = Join[IndexNames,ListFields[[pos,2,2]] /. subGC[i]]; *)
IndexNames = Join[IndexNames,Table[{ListFields[[pos,2,1,j]],ListFields[[pos,2,2,j,2]]},{j,1,Length[ListFields[[pos,2,2]]]}] /. subGC[i]];
j++;];
];
i++;];

temp=term;
For[i=1, i<=Length[IndexNames],
temp1=Hold[Table[temp,iter]]/.{iter-> IndexNames[[Length[IndexNames]-i+1]]};
temp=ReleaseHold[temp1];
i++;];

Return[temp];

];






DeltaGT[x_]:=Block[{},
If[Head[x]==List,erg=List@@x;erg=DeltaGT/@erg;Return[List@@erg];];
If[Head[x]==Times,erg=List@@x;erg=DeltaGT/@erg;Return[Times@@erg];];
If[Head[x]==Plus,erg=List@@x;erg=DeltaGT/@erg;Return[Plus@@erg];];
If[Head[x]==Power,erg=List@@x;erg=DeltaGT/@erg;Return[Power@@erg];];
If[Head[x]==conj,erg=List@@x;erg=DeltaGT/@erg;Return[conj@@erg];];
If[Head[x]==Mom,Return[x];];
If[Head[x]==Der,Return[Der[DeltaGT[x[[1]]],lor3]];];


If[MemberQ[vacuum,x] || MemberQ[vacuum,Head[x]],
If[Length[x]==0,
If[FreeQ[Transpose[GaugeTransformation][[1]],x],Print[x," not found"];];
pos=Position[Transpose[GaugeTransformation][[1]],x][[1,1]];
If[Head[GaugeTransformation[[pos]][[1]]]===conj,
Return[conj[Extract[GaugeTransformation,pos][[2]]]];,
Return[Extract[GaugeTransformation,pos][[2]]];
];,
If[FreeQ[Transpose[GaugeTransformation][[1]],Head[x]],Print[Head[x]," not found"];];
pos=Position[Transpose[GaugeTransformation][[1]],Head[x]][[1,1]];
If[Head[GaugeTransformation[[pos]][[1]]]===conj,
Return[conj[Extract[GaugeTransformation,pos][[2]]/.gen1->x[[1,1]]]];,
Return[Extract[GaugeTransformation,pos][[2]]/.gen1->x[[1,1]]];
];
];,
Return[x];
];
];




CalcGhostLagrangian[GaugeFixing_]:=Block[{i,GaugeFixingTemp},

GaugeFixingTemp = GaugeFixing /. Der[a_]->Der[a,lor2];

subGhostC={};
For[i=1,i<=Length[Particles[Current]],
If[(getType[Particles[Current][[i,1]]]==G) && (MemberQ[realVar,Particles[Current][[i,1]]]==False),
If[StringTake[ToString[Particles[Current][[i,1]]],-1]==="C",
subGhostC=Join[subGhostC,{conj[Particles[Current][[i,1]][{x_}]]->ToExpression[StringDrop[ToString[Particles[Current][[i,1]]],-1]][{x}]}];,
subGhostC=Join[subGhostC,{conj[Particles[Current][[i,1]][{x_}]]->ToExpression[ToString[Particles[Current][[i,1]]]<>"C"][{x}]}];
];
];

i++;]; 

Print["Calc Ghost Interactions"];

LGhost=0;
For[i=1,i<=Length[GaugeFixing],
GaugeFixingFactor[makeGhost[conj[GaugeFixingTemp[[i,1]]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];
GaugeFixingFactor[makeGhost[GaugeFixingTemp[[i,1]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];
GaugeFixingFactor[ExtractGaugeField[GaugeFixingTemp[[i,1]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];

LGhost +=(GaugeFixing[[i,2]] /. RXi[a__]->1)(bar[partBlank[makeGhost[conj[GaugeFixingTemp[[i,1]]]],1]]*(DeltaGT[conj[GaugeFixingTemp[[i,1]]]] /.subGhostC)+bar[partBlank[makeGhost[GaugeFixingTemp[[i,1]]],1]]*(DeltaGT[GaugeFixingTemp[[i,1]]] /.subGhostC));
i++;];

LGhost = - LGhost;


GoldstoneGhost={};

For[i=1,i<=Length[GaugeFixing],
parts=Cases[GaugeFixing[[i,1]] /. conj[y_]->y,x_?ParticleQ,2];
For[j=1,j<=Length[parts],
If[getType[parts[[j]]]===S,
If[FreeQ[GaugeFixing[[i,1]] ,conj[parts[[j]]]],
GoldstoneGhost = Join[GoldstoneGhost,{{ExtractGaugeField[GaugeFixing[[i,1]]] ,parts[[j]]}}];,
GoldstoneGhost = Join[GoldstoneGhost,{{ExtractGaugeField[GaugeFixing[[i,1]]] ,conj[parts[[j]]]}}];
];
];
j++;];
i++;
];



];



makeGhost[x_]:=Block[{temp,ghostp},
If[Head[x]===Plus,
temp=List@@x;,
temp={x};
];
ghostp=Select[temp,(Head[#]==Der)&,2][[1,1]];
Return[getGhost[ghostp]];
];

ExtractGaugeField[x_]:=Block[{temp,ghostp},
If[Head[x]===Plus,
temp=List@@x;,
temp={x};
];
ghostp=Select[temp,(Head[#]==Der)&,2][[1,1]];
Return[ghostp];
];




GenerateGaugeFixing[kinetic_,name_,nr_]:=Block[{scalars,gb,temp={}, res,i,j,nameXi,num},
If[Head[DEFINITION[name][GaugeFixing]]===List,
GaugeFixing::Defined="Since version 3.1.0 SARAH derives the gauge fixing terms by itself. The given input in the model file is longer necessary and it will be ingored.";
Message[GaugeFixing::Defined];
];

gb = SA`NewGaugeBosons;
gb =Select[Particles[Current],(#[[4]]===V)&];
gb=Transpose[gb][[1]];
scalars=Select[Particles[Current],(#[[4]]===S)&];
scalars=Transpose[scalars][[1]];

CalcImp=True;
Update[];

Print["  ... generate gauge fixing terms: ",Dynamic[DynamicGFnr[name]],"/",Length[gb]," (",Dynamic[DynamicGFname[name]],")"];

For[i=1,i<=Length[gb],
DynamicGFnr[name]=i;
DynamicGFname[name]=gb[[i]];
PrintDebug["   ",gb[[i]]];
res=0;
If[conj[gb[[i]]]===gb[[i]],num=2;,num=1;];
nameXi=RXi[ToExpression[StringDrop[ToString[gb[[i]]],1]]];
If[getEntryField[gb[[i]],Mass]=!=0,
For[j=1,j<=Length[scalars],
res+=DPV[DPV[kinetic /. vacuumF /. zero[_][_]->0 /. zero[_]->0,conj[gb[[i]]],1,1]/. vacuumV /. zero[_][_]->0 /. zero[_]->0,scalars[[j]],2,2] /. vacuumS /. zero[_][_]->0 /. zero[_]->0 /. Mom[a_,b_] /;(getType[a]===NoField)->0  /. Mom[a_,b_]->a /. g[a__]->1 /. gen1->gn1 /. gen2->gn2 /.gt1->gen1 /. gt2->gen2 ;
If[conj[scalars[[j]]]=!=scalars[[j]],
res+=DPV[DPV[kinetic /. vacuumF /. zero[_][_]->0 /. zero[_]->0,conj[gb[[i]]],1,1]/. vacuumV /. zero[_][_]->0 /. zero[_]->0,conj[scalars[[j]]],2,2] /. vacuumS /. zero[_][_]->0 /. zero[_]->0 /. Mom[a_,b_] /;(getType[a]===NoField)->0  /. Mom[a_,b_]->a /. g[__]->1 /. gen1->gn1 /. gen2->gn2 /.gt1->gen1 /. gt2->gen2;
];
j++;];
res= CalcDelta[res /. Delta[a__]/;(FreeQ[{a},gen1] ==False || FreeQ[{a},gen2] ==False)->DELTAGEN[a] ] /. DELTAGEN->Delta ;,
res=0;
];
temp=Join[temp,{{Der[gb[[i]]]+res*nameXi,-1/(num nameXi)}}];
SA`GaugeFixingRXi = Join[SA`GaugeFixingRXi,{{nameXi,gb[[i]]}}];
i++;];
DynamicGFname[name]="All Done";
CalcImp=False;
SA`GaugeFixingRXi = Intersection[SA`GaugeFixingRXi];

temp=temp /. subAlways /.gn2->gn1;

DEFINITION[name][GeneratedGaugeFixing]=temp;
Return[temp];
];


CalcGhostLagrangian2[GaugeFixing_]:=Block[{i,Rxi,vb},

GaugeFixingTemp = GaugeFixing /. Der[a_]->Der[a,lor2];

subGhostC={};
For[i=1,i<=Length[Particles[Current]],
If[(getType[Particles[Current][[i,1]]]==G) && (MemberQ[realVar,Particles[Current][[i,1]]]==False),
If[StringTake[ToString[Particles[Current][[i,1]]],-1]==="C",
subGhostC=Join[subGhostC,{conj[Particles[Current][[i,1]][{x_}]]->ToExpression[StringDrop[ToString[Particles[Current][[i,1]]],-1]][{x}]}];,
subGhostC=Join[subGhostC,{conj[Particles[Current][[i,1]][{x_}]]->ToExpression[ToString[Particles[Current][[i,1]]]<>"C"][{x}]}];
];
];

i++;]; 

Print["  ... calculate Ghost interactions"];

LGhosttemp=0;
LGhostSS=0;
For[i=1,i<=Length[GaugeFixing],
Rxi=Cases[GaugeFixing[[i,2]],x_?((Head[#]==RXi)&),6][[1]];
vb=Cases[{GaugeFixing[[i,1]]},x_?((Head[#]==Der)&),6][[1,1]];
GaugeFixingFactor[makeGhost[conj[GaugeFixingTemp[[i,1]]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];
GaugeFixingFactor[makeGhost[GaugeFixingTemp[[i,1]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];
GaugeFixingFactor[ExtractGaugeField[GaugeFixingTemp[[i,1]]]]=Cases[GaugeFixing[[i,2]],RXi[a__],2][[1,1]];
LGhosttemp +=(GaugeFixing[[i,2]] /. RXi[a__]->1)(bar[partBlank[makeGhost[conj[GaugeFixingTemp[[i,1]]]],1]]*(DeltaGT[conj[GaugeFixingTemp[[i,1]]]] /.subGhostC)+bar[partBlank[makeGhost[GaugeFixingTemp[[i,1]]],1]]*(DeltaGT[GaugeFixingTemp[[i,1]]] /.subGhostC));
If[vb===conj[vb],
LGhostSS+=(GaugeFixing[[i,1]] /. Der[a__]->0)*conj[(GaugeFixing[[i,1]] /. Der[a__]->0 /. gen1->gen3 /. gen2->gen4)]/Rxi/2;,
LGhostSS+=(GaugeFixing[[i,1]] /. Der[a__]->0)*conj[(GaugeFixing[[i,1]] /. Der[a__]->0 /. gen1->gen3 /. gen2->gen4)]/Rxi;
];
saveGF=GaugeFixing[[i,1]];
i++;];

(* LGhost = (LGhost /. SA`RemovedGaugeBosons /. SA`RemovedGhosts)- LGhosttemp; *)

LGhost = -LGhosttemp;


];

CheckGoldstoneGhosts[name_]:=Block[{i,GaugeFixing,pos,vb},
GoldstoneGhost={};

vb=Select[Particles[name],(#[[4]]==V)&];

For[i=1,i<=Length[vb],
If[getEntryField[vb[[i,1]],Goldstone]===Goldstone || getEntryField[vb[[i,1]],Goldstone]===None,
 If[getEntryField[vb[[i,1]],Mass]=!=0 && FreeQ[SGauge,vb[[i,1]]],
(* Print["No Goldstone for massive vector boson defined ", vb[[i,1]]]; *)
Message[ModelFile::NoGoldstone,vb[[i,1]]];
];,
GoldstoneGhost=Join[GoldstoneGhost,{{vb[[i,1]],getEntryField[vb[[i,1]],Goldstone]}}];
];
i++;];

];
