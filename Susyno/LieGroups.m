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



BeginPackage["Susyno`LieGroups`"];
ClearAll["`*"];


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

CartanMatrix[name_String,numberId_Integer]:=Module[{result},
result="Unknown lie algebra. Try U(1),SU(n) [n>1],SO(n) [n=3 or >4],Sp(2n) [n>1] or the exceptionals G(2),F(4),E(6),E(7),E(8).";

(* Classical algebras *)

If[(ToUpperCase[name]=="A"||ToUpperCase[name]=="B"||ToUpperCase[name]=="C")&&numberId==1,
result={{2}};
];
If[ToUpperCase[name]=="A"&&numberId>1,
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{numberId,numberId}]//Normal;
];
If[ToUpperCase[name]=="B"&&numberId>1,
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{numberId,numberId}]//Normal;
result[[numberId-1,numberId]]=-2;
];
If[ToUpperCase[name]=="C"&&numberId>1,
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{numberId,numberId}]//Normal;
result[[numberId,numberId-1]]=-2;
];
If[ToUpperCase[name]=="D"&&numberId>2,
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{numberId,numberId}]//Normal;
result[[numberId,numberId-1]]=0;
result[[numberId-1,numberId]]=0;
result[[numberId,numberId-2]]=-1;
result[[numberId-2,numberId]]=-1;
];

(* Classical algebras, with alternative names *)

If[ToUpperCase[name]=="SU", (*   SU (n+1)=A (n)   *)
result=CartanMatrix["A", numberId-1]];
If[ToUpperCase[name]=="SP"&&EvenQ[numberId], (*   Sp (2n)=C (n)   *)
result=CartanMatrix["C", numberId/2]];
If[ToUpperCase[name]=="SO"&&!EvenQ[numberId], (*   SO (2n+1)=B (n)   *)
result=CartanMatrix["B", (numberId-1)/2]];
If[ToUpperCase[name]=="SO"&&EvenQ[numberId], (*   SO (2n)=D (n)   *)
result=CartanMatrix["D", numberId/2]];


(* Exceptional algebras *)

If[ToUpperCase[name]=="G"&&numberId==2,
result={{2,-3},{-1,2}};
];

If[ToUpperCase[name]=="F"&&numberId==4,
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{4,4}]//Normal;
result[[2,3]]=-2;
];

If[ToUpperCase[name]=="E"&&(numberId==6||numberId==7||numberId==8),
result=SparseArray[{Band[{1,1}]->2,Band[{2,1}]->-1,Band[{1,2}]->-1},{numberId,numberId}]//Normal;
result[[numberId-1,numberId]]=0;result[[numberId,numberId-1]]=0;result[[3,numberId]]=-1;result[[numberId,3]]=-1;
];

Return[result];
]

(*Assign to some variables the groups' Cartan matrix*)
Do[
Evaluate[ToExpression["SU"<>ToString[i]]]=Evaluate[ToExpression["Su"<>ToString[i]]]=Evaluate[ToExpression["su"<>ToString[i]]]=CartanMatrix["SU",i];
,{i,2,32}]
Do[
Evaluate[ToExpression["SO"<>ToString[i]]]=Evaluate[ToExpression["So"<>ToString[i]]]=Evaluate[ToExpression["so"<>ToString[i]]]=CartanMatrix["SO",i];
,{i,5,32}]
Do[
Evaluate[ToExpression["SP"<>ToString[i]]]=Evaluate[ToExpression["Sp"<>ToString[i]]]=Evaluate[ToExpression["sp"<>ToString[i]]]=CartanMatrix["SP",i];
,{i,2,32,2}]
E6=e6=CartanMatrix["E",6];
E7=e7=CartanMatrix["E",7];
E8=e8=CartanMatrix["E",8];
G2=g2=CartanMatrix["G",2];
F4=f4=CartanMatrix["F",4];
SO3=So3=so3=CartanMatrix["SO",3];
U1=u1=CartanMatrix["U",1]=CartanMatrix["u",1]={};


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

(* DESCRIPTION: Returns the list of positive roots of a group *)
PositiveRoots[cm_]:=PositiveRoots[cm]=Module[{n,weights,aux1,aux2,aux3,cont},
n=Length[cm]; (* =number of simple roots *)
weights=cm;
aux1=Table[KroneckerDelta[i,j],{i,n},{j,n}];
cont=0;

While[cont<Length[weights],
cont++;
aux2=aux1[[cont]];

Do[
aux3=aux2;
aux3[[i]]++;
If[FindM[aux1,aux2,i]-weights[[cont,i]]>0 && Count[aux1,aux3]==0,
weights=Append[weights,weights[[cont]]+cm[[i]]];
aux1=Append[aux1,aux3];
,Null];

,{i,n}];
];

Return[weights];]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

SpecialMatrixD[cm_]:=SpecialMatrixD[cm]=Module[{n,result,k},
n=Length[cm];
result=Table[0,{i,n},{j,4}];

Do[
k=1;
Do[
If[cm[[i,j]]==-1,
result[[i,k]]=j;k++;
];
If[cm[[i,j]]==-2,
result[[i,k]]=j;result[[i,k+1]]=j;k=k+2;
];
If[cm[[i,j]]==-3,
result[[i,k]]=j;result[[i,k+1]]=j;result[[i,k+2]]=j;k=k+3;
];
,{j,n}],{i,n}];

Return[result];
]

ReflectWeight[cm_,weight_,i_]:=Module[{mD,result},
result= weight;
result[[i]]=-weight[[i]];
mD=SpecialMatrixD[cm];
Do[
If[mD[[i,j]]!=0,result[[mD[[i,j]]]]+=weight[[i]]];
,{j,4}];

Return[result];
]

DominantConjugate[cm_,weight_]:=Module[{index,dWeight,i,mD},
If[cm=={{2}},Return[If[weight[[1]]<0,{-weight,1},{weight,0}]]];(*for SU2 the code below would not work*)
index=0;
dWeight=weight;
i=1;
mD=SpecialMatrixD[cm];

While[i<=Length[cm],
If[dWeight[[i]]<0,
index++;
dWeight=ReflectWeight[cm,dWeight,i];
i=mD[[i,1]];
,i++];
];
Return[{dWeight,index}];
]

WeylOrbit[cm_,weight_]:=Module[{wL,counter,n,result,aux},
n=Length[cm];
counter=0;
wL[counter]={weight};
result={weight};

While[Length[wL[counter]]!=0,

counter++;
wL[counter]={};

Do[

If[wL[counter-1][[j,i]]>0 ,
aux=ReflectWeight[cm,wL[counter-1][[j]],i][[i+1;;n]];
If[aux==Abs[aux],
wL[counter]=Append[wL[counter],ReflectWeight[cm,wL[counter-1][[j]],i]];
]];
,{j,Length[wL[counter-1]]},{i,n}];
result=Join[result,wL[counter]];
];

Return[result];
]

DominantWeights[cm_,w_]:=DominantWeights[cm,w]=Module[{proots,listw,aux,functionAux,result,aux1,aux2,n,k,cmInv,matD,cmID,deltaTimes2},
cmInv=Inverse[cm];

(* ------------------------ Generate the dominant weights without dimentionality information ------------------------*)

proots=PositiveRoots[cm];
listw={w};
counter=1;
While[counter<=Length[listw],
aux=Table[listw[[counter]]-proots[[i]],{i,Length[proots]}];
listw=DeleteDuplicates[Join[listw,DeleteCases[aux,x_/;x!=Abs[x]]]];
counter++;
];
listw=Sort[listw,OrderedQ[{-{#1-#2}.cmInv,0{#1}}]&]; 

(* ------------------------ Get dimentionality information ------------------------*)

result={{listw[[1]],1}};
functionAux[x__]=0;
functionAux[listw[[1]]]=1;

(* Invert cm and get the diagonal matrix with entries <root i, root i> *)
n=Length[cm];
matD=MatrixD[cm];
cmID=cmInv.matD;
deltaTimes2=Sum[proots[[i]],{i,Length[proots]}];

Do[

Do[
k=1;

While[(aux1=functionAux[DominantConjugate[cm,k proots[[i]]+listw[[j]]][[1]]])!=0,
aux2=k proots[[i]]+listw[[j]];
functionAux[listw[[j]]]+=2 aux1 SimpleProduct[aux2,proots[[i]],cmID];
k++;

];

,{i,Length[proots]}];

functionAux[listw[[j]]]=functionAux[listw[[j]]]/SimpleProduct[listw[[1]]+listw[[j]]+deltaTimes2,listw[[1]]-listw[[j]],cmID];


result=Append[result,{listw[[j]],functionAux[listw[[j]]]}];
,{j,2,Length[listw]}];

Return[result];
]


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

Adjoint[input__]:=If[Depth[{input}]==4,Return[AdjointBaseMethod[input]],Return[AdjointBaseMethod@@@Transpose[{input}]]];

(* DESCRIPTION: Max weight of the adjoint representation is just the largest  positive root of the algebra [NOTE: this is correct only if the given group is simple. Otherwise the adjoint representation is not even irreducible] *)
AdjointBaseMethod[cm_]:=PositiveRoots[cm][[-1]] 

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

SimpleProduct[v1_,v2_,cmID_]:=1/2 ({v1}.cmID.Transpose[{v2}])[[1,1]];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

(*DESCRIPTION: This method returns a diagonal matrix with the values <root i, root i> *)
MatrixD[cm_]:=MatrixD[cm]=Module[ {positions,result,coord1,coord2},
positions=Position[cm,-1|-2|-3,-1];
positions=Sort[Select[positions,#[[1]]<#[[2]]&]];

(*Assume for now that all roots are the same size*)
result=Table[1,{i,Length[cm]}];
Do[
coord1=positions[[j,1]];
coord2=positions[[j,2]];
(*Give the correct value to <\alpha,\alpha>*)
result[[coord2]]=cm[[coord2,coord1]]/cm[[coord1,coord2]] result[[coord1]];
,{j,Length[positions]}];

result=DiagonalMatrix[result];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

(* DESCRIPTION: Returns the weights of a representation (with dimentionalities) *)
Unprotect[Weights];
Weights[cm_,w_]:=Weights[cm,w]=Module[{dW,wOrbit,result,invCM},
invCM=Inverse[cm];
dW=DominantWeights[cm,w];
result=Table[{#,dW[[i,2]]}&/@WeylOrbit[cm,dW[[i,1]]],{i,Length[dW]}];
result=Apply[Join,result];
 result=Sort[result,OrderedQ[{-{#1[[1]]-#2[[1]]}.invCM,0{#1[[1]]}}]&]; 

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Auxiliar method *)
FindM[ex_,el_,indice_]:=Module[{auxMax,aux1,aux2},
aux1=el[[indice]];
aux2=el;
aux2[[indice]]=0;
auxMax=0;
Do[

If[Count[ex,aux2]==1,auxMax=aux1-i+1;Goto[end];
,Null];
aux2[[indice]]=aux2[[indice]]+1;

,{i,aux1+1}];
Label[end];
Return[auxMax];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Reduces a direct product representation in its irreducible parts *)
ReduceRepProduct[cm_,listReps__]:=Module[{n,orderedList,result},
orderedList=Sort[{listReps},DimR[cm,#1]<DimR[cm,#2]&];
n=Length[orderedList];
result=ReduceRepProductBase2[cm,orderedList[[n-1]],orderedList[[n]]];
Do[
result=ReduceRepProductBase1[cm,orderedList[[n-i]],result];
,{i,2,n-1}];
Return[result];
]

ReduceRepProductBase1[cm_,rep1_,listReps_]:=Module[{result},
result=Table[({#[[1]],listReps[[i,2]]#[[2]]})&/@ReduceRepProductBase2[cm,rep1,listReps[[i,1]]],{i,Length[listReps]}];
result=Join@@result;
result=GatherBy[result,#[[1]]&];
result=Table[{result[[i,1,1]],Sum[result[[i,j,2]],{j,Length[result[[i]]]}]},{i,Length[result]}];
Return[result];
]

ReduceRepProductBase2[cm_,w1_,w2_]:=Module[{l1,wOrbit,delta,n,aux,dim,allIrrep,result},
n=Length[cm];
delta=Table[1,{i,n}];

l1=DominantWeights[cm,w1];
dim[x_]=0;
allIrrep={};
Do[
wOrbit=WeylOrbit[cm,l1[[i,1]]];
Do[
aux=DominantConjugate[cm,wOrbit[[j]]+w2+delta];

If[aux[[1]]-1==Abs[aux[[1]]-1], (*regular*)
dim[aux[[1]]-delta]+=(-1)^aux[[2]] l1[[i,2]];
allIrrep=DeleteDuplicates[Append[allIrrep,aux[[1]]-delta]];
];
,{j,Length[wOrbit]}];

,{i,Length[l1]}];

result=Table[{allIrrep[[i]],dim[allIrrep[[i]]]},{i,Length[allIrrep]}];
result=DeleteCases[result,x_/;x[[2]]==0];
Return[result];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Calculates the dimention of a irrep *)
DimR[input__]:=DimR[input]=If[Depth[{input}]==4,Return[DimRBaseMethod[input]],Return[DimRBaseMethod@@@Transpose[{input}]]];

DimRBaseMethod[cm_,w_]:=Module[{n,proots,cmInv,matD,cmID,delta,result},
n=Length[cm];
proots=PositiveRoots[cm];

(* Invert cm and get the diagonal matrix with entries <root i, root i> *)
cmInv=Inverse[cm];
matD=MatrixD[cm];
cmID=cmInv.matD;
delta=1/2 Sum[proots[[i]],{i,Length[proots]}];
result=Product[SimpleProduct[proots[[i]],w+delta,cmID]/SimpleProduct[proots[[i]],delta,cmID]  ,{i,Length[proots]}];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

NullMatrix[n_,m_]:=Array[0&,{n,m}];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Auxiliar method needed to construct the representation matrices *)
CholeskyTypeDecomposition[matrix_]:=Module[{n,nullRow,matD,matL,result},
n=Length[matrix];
matD=Array[0&,{n,n}];
matL=IdentityMatrix[n];

Do[
Do[
If[matD[[j,j]]!=0,
matL[[i,j]]=Simplify[1/matD[[j,j]](matrix[[i,j]]-Sum[matL[[i,k]]Conjugate[matL[[j,k]]]matD[[k,k]],{k,j-1}])];
,matL[[i,j]]=0];
,{j,i-1}];

matD[[i,i]]=Simplify[matrix[[i,i]]-Sum[matL[[i,k]]Conjugate[matL[[i,k]]]matD[[k,k]],{k,i-1}]];

,{i,Length[matrix]}];

(*Make the resulting matrix as small as possible by eliminating null columns*)
result=Transpose[matL.Sqrt[matD]];
nullRow=Array[0&,n];
result=Transpose[DeleteCases[result,nullRow]];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Calculates the generators of a irrep based on the Chevalley-Serre relations *)
RepMinimalMatrices[cm_,maxW_]:=RepMinimalMatrices[cm,maxW]=Module[{aux1,aux2,aux3,aux4,aux5,aux6,aux7,aux8,n,listw,listAux,listAux2,up,down,dim,dim1,dim2,dim3,col,matrixT,matrix,index,posBegin,posEnd,begin,end,b1,e1,b2,e2,matrixE,matrixF,matrixH},
n=Length[cm];
listw=Weights[cm,maxW];

dim[x__]:=0;
up[x__]=Table[{},{i,n}];
down[x__]=Table[{},{i,n}];
Do[
dim[listw[[i,1]]]=listw[[i,2]];
,{i,Length[listw]}];
up[listw[[1,1]]]=Table[{{0}},{i,n}];

Do[
matrixT={};
Do[
col={};
Do[
dim1=dim[listw[[element,1]]+cm[[i]]];
dim2=dim[listw[[element,1]]+cm[[i]]+cm[[j]]];
dim3=dim[listw[[element,1]]+cm[[j]]];

If[dim1!=0&&dim3!=0,
If[dim2!=0,
aux1=up[listw[[element,1]]+cm[[i]]][[j]];
aux2=down[listw[[element,1]]+cm[[i]]+cm[[j]]][[i]];

If[i!=j,col=Join[col,aux1.aux2], col=Join[col,aux1.aux2+(listw[[element,1,i]] +cm[[i,i]])IdentityMatrix[dim1]]];
,
If[i!=j,col=Join[col,NullMatrix[dim1,dim3]], col=Join[col,(listw[[element,1,i]] +cm[[i,i]])IdentityMatrix[dim1]]];
];

];

,{i,n}];

If[col!={},
matrixT=Join[matrixT,Transpose[col]];
];

,{j,n}];

(* Separate the two matrices in the product (w+\[Alpha]i)i * wj *)
matrix=Transpose[matrixT];

aux1=Sum[dim[listw[[element,1]]+cm[[i]]],{i,n}];
aux2=dim[listw[[element,1]]];

aux3=PadRight[CholeskyTypeDecomposition[matrix],{aux1,aux2}];
aux4=Transpose[aux3];
If[aux3.aux4!= matrix,Print["Error!", aux3//MatrixForm,aux4//MatrixForm,matrix//MatrixForm];];


(* Obtain the blocks in  (w+\[Alpha]i)i and wj. Use it to feed the recursive algorith so that we can calculate the next w's *)

aux1={{0,0}}; (* format (+-): (valid cm raise index i - 1, start position of weight w+cm[[i-1]]-1) *)
Do[
If[dim[listw[[element,1]]+cm[[i]]]!=0,
aux1=Append[aux1,{i,aux1[[-1,2]]+dim[listw[[element,1]]+cm[[i]]]}];];
,{i,n}];

Do[
index=aux1[[i+1,1]];
posBegin=aux1[[i,2]]+1;
posEnd=aux1[[i+1,2]];


aux2=down[listw[[element,1]]+cm[[index]]];
aux2[[index]]=aux3[[posBegin;;posEnd]];
down[listw[[element,1]]+cm[[index]]]=aux2;

aux2=up[listw[[element,1]]];
aux2[[index]]=Transpose[Transpose[aux4][[posBegin;;posEnd]]];
up[listw[[element,1]]]=aux2;
,{i,Length[aux1]-1}];

,{element,2,Length[listw]}];

(* Put the collected pieces together and build the 3n matrices: hi,ei,fi *)

begin[listw[[1,1]]]=1;
end[listw[[1,1]]]=listw[[1,2]];

Do[
begin[listw[[element,1]]]=begin[listw[[element-1,1]]]+listw[[element-1,2]];
end[listw[[element,1]]]=end[listw[[element-1,1]]]+listw[[element,2]];
,{element,2,Length[listw]}];

aux1=Table[{1+Sum[listw[[j,2]],{j,i-1}],Sum[listw[[j,2]],{j,i}]},{i,Length[listw]}];
aux2=Sum[listw[[i,2]],{i,Length[listw]}];
aux3=SparseArray[PadRight[{{}},{aux2,aux2}]];

Do[
aux6=aux3; (* e[i] *)
aux7=aux3; (* f[i] *)
aux8=aux3; (* h[i] *)
Do[ 

If[dim[listw[[element,1]]+cm[[i]]]!=0,
b1=begin[listw[[element,1]]+cm[[i]]];
e1=end[listw[[element,1]]+cm[[i]]];
b2=begin[listw[[element,1]]];
e2=end[listw[[element,1]]];
aux6[[b1;;e1,b2;;e2]]=Transpose[up[listw[[element,1]]][[i]]];
];

If[dim[listw[[element,1]]-cm[[i]]]!=0,
b1=begin[listw[[element,1]]-cm[[i]]];
e1=end[listw[[element,1]]-cm[[i]]];
b2=begin[listw[[element,1]]];
e2=end[listw[[element,1]]];
aux7[[b1;;e1,b2;;e2]]=Transpose[down[listw[[element,1]]][[i]]];
];

b1=begin[listw[[element,1]]];
e1=end[listw[[element,1]]];
aux8[[b1;;e1,b1;;e1]]=listw[[element,1,i]] IdentityMatrix[listw[[element,2]]];

,{element,Length[listw]}];
matrixE[i]=SparseArray[aux6];
matrixF[i]=SparseArray[aux7];
matrixH[i]=SparseArray[aux8];

,{i,n}];

aux1=Table[{matrixE[i],matrixF[i],matrixH[i]},{i,n}];

Return[aux1]; (*  result is a list with entries {e[i],f[i],h[i]} *)
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Calculates the Casimir invariant of an irrep *)
Casimir[input__]:=Casimir[input]=If[Depth[{input}]==4,Return[CasimirBaseMethod[input]],Return[CasimirBaseMethod@@@Transpose[{input}]]];

(* Uses formula XI .23 of "Semi-Simple Lie Algebras and Their Representations", page 89 *)

CasimirBaseMethod[cm_,w_]:=Module[{n,cmInv,matD,cmID,proots,deltaTimes2,result},
n=Length[cm];
proots=PositiveRoots[cm];

cmInv=Inverse[cm];
matD=MatrixD[cm];
cmID=cmInv.matD;
deltaTimes2=Sum[proots[[i]],{i,Length[proots]}];
result=SimpleProduct[w,w+deltaTimes2,cmID];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Auxiliar method (used for building invariants) *)
BlockW[w1_,w2_,listW_,repMat_]:=Module[{dim,b,e,aux1},

dim[0]=0;
Do[dim[i]=dim[i-1]+listW[[i,2]],{i,Length[listW]}];

Do[b[listW[[i,1]]]=dim[i-1]+1;
e[listW[[i,1]]]=dim[i];
,{i,Length[listW]}];

aux1=repMat[[b[w1];;e[w1],b[w2];;e[w2]]];

Return[aux1];

]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* Auxiliar method (used for building the representation matrices) *)
NullSpace2[matrix_,dt_]:=Module[{aux1,aux2,aux3,res,n,n2,v},
Off[Power::"indet"];
n=Length[matrix];
n2=Length[matrix[[1]]];

aux1=Table[v[i],{i,n2}];

Do[

aux2=Solve[matrix[[i;;Min[i+dt-1,n]]].aux1==0][[1]];
aux1=Expand[aux1 /.aux2];

,{i,1,n,dt}];

aux3=DeleteDuplicates[Cases[aux1,v[i_]:>i,Infinity]];
res={};
Do[
res=Append[res,aux1/. v[x_]:>If[x!=aux3[[i]],0,1]];
,{i,Length[aux3]}];
Return[res];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* This method returns the complete set of matrices that make up a representation, with the correct casimir and trace normalizations *)

RepMatrices[input__]:=RepMatrices[input]=If[Depth[{input}]==4,Return[RepMatricesBaseMethod[input]],Return[RepMatricesBaseMethod@@@Transpose[{input}]]];

RepMatricesBaseMethod[cm_,maxW_]:=Module[{listE,listF,listH,listTotal,n,pRoots,sR,cR,dimG,dimR,rep,matrixCholesky,aux,j},
n=Length[cm];
pRoots=PositiveRoots[cm];
rep=RepMinimalMatrices[cm,maxW];
listE=Table[SparseArray[rep[[i,1]]],{i,n}];
listF=Table[SparseArray[rep[[i,2]]],{i,n}];
listH=Table[SparseArray[rep[[i,3]]],{i,n}];

dimG=2Length[pRoots]+Length[cm];
dimR=DimR[cm,maxW];
sR=Casimir[cm,maxW] dimR/dimG;

If[dimR==1, (*trivial rep, therefore all matrices are null*)
listTotal=Table[listE[[1]],{i,dimG}];
Goto[end];
];

(* If it's not the trivial rep, generate the matrices of the remaining algebra elements. The positive roots of the algebra serve as a guide in this process of doing comutators  *)
Do[
j=1;While[(aux=Position[pRoots[[1;;i]],pRoots[[i]]-pRoots[[j]]])=={},j++];

listE=Append[listE,listE[[aux[[1,1]]]].listE[[j]]-listE[[j]].listE[[aux[[1,1]]]]];
listF=Append[listF,listF[[aux[[1,1]]]].listF[[j]]-listF[[j]].listF[[aux[[1,1]]]]];

,{i,n+1,Length[pRoots]}];


Do[
(* Change from the operadores T+, T- to Tx,Ty *)
aux=listE[[i]];
listE[[i]]=listE[[i]]+ listF[[i]];
listF[[i]]=aux-listF[[i]];

(* Control the normalizayion of the Tx,Ty matrices with the trace condition *)
 listE[[i]]=SparseArray[Simplify[Sqrt[sR]/Sqrt[ Tr[listE[[i]].listE[[i]]]]]listE[[i]]]; 
listF[[i]]=SparseArray[Simplify[Sqrt[sR]/Sqrt[ Tr[listF[[i]].listF[[i]]]]]listF[[i]]];
,{i,Length[listE]}];

matrixCholesky=Inverse[cm].MatrixD[cm]; (* See the casimir expression in a book on lie algebras *)
aux=Simplify[CholeskyDecomposition[matrixCholesky]];
listH=Table[SparseArray[Sum[aux[[i,j]]listH[[j]],{j,n}]],{i,n}];

(* Up to multiplicative factors, Tz are now correct. We fix again the normalization with the trace condition *)
listH=Table[SparseArray[Simplify[Sqrt[sR]/Sqrt[ Tr[listH[[i]].listH[[i]]]]]listH[[i]]],{i,n}];

listTotal=Join[listE,listF,listH];

(* Make sure the final matrices are simplified *)
listTotal=Table[SparseArray[Simplify[listTotal[[i]]//ArrayRules],{dimR,dimR}],{i,Length[listTotal]}];

Label[end];

Return[listTotal];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* This method checks if an invariant is symmetric (output=1), skew-symmetric (output=2) ou none (output=0) given the fields names (e.g. {a,b,c}) *)
IsSymmetric[invariant_,vars_]:=Module[{aux1,result},
result=0;
aux1=invariant/.{vars[[1]]->vars[[2]],vars[[2]]->vars[[1]]};
If[Expand[invariant-aux1]==0,result=1]; (* symmetric *)
If[Expand[invariant+aux1]==0,result=2]; (* skew-symmetric *)
Return[result];
];


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

Invariants[arguments__]:=Invariants[arguments]=Module[{result,cm,argumentsList,nArgs,conjugate,aux,aux2,aux3,numberGroups},

argumentsList=Drop[{arguments},-1];
conjugate={arguments}[[-1]];
(* The conjugation argument is optional (default value=False) *)
If[!(TrueQ[conjugate]||TrueQ[!conjugate]),argumentsList={arguments};conjugate=False];
nArgs=Length[argumentsList];
numberGroups=Length[argumentsList[[1]]];



(* If the first argument is just one matrix (simple group) simply use the methods InvariantsBaseMethod *)
If[Depth[argumentsList[[1]]]==3,result=InvariantsBaseMethod[arguments],

(* ... ff not (semi-simple group), some work must be done before using InvariantsBaseMethod *)

Do[
aux[i]=InvariantsBaseMethod[(#[[i]]&/@argumentsList )/.{x__}:>x,conjugate];
,{i,numberGroups}];

result=aux[1];
Do[
aux2={};
Do[
If[nArgs==4,
aux2=Join[aux2,aux[i] /.a[x1_]b[x2_]c[x3_ ]:>(result[[j]]/.{a[y1__]:>a[y1,x1],b[y1__]:>b[y1,x2],c[y1__]:>c[y1,x3]})]];
If[nArgs==3,
aux2=Join[aux2,aux[i] /.a[x1_]b[x2_]:>(result[[j]]/.{a[y1__]:>a[y1,x1],b[y1__]:>b[y1,x2]})]];
If[nArgs==2,
aux2=Join[aux2,aux[i] /.a[x1_]:>(result[[j]]/.{a[y1__]:>a[y1,x1]})]];

,{j,Length[result]}]; (* maybe there is more than one invariant in aux[i]; that's why this extra loop is needed *)
result=aux2;
,{i,2,numberGroups}];

];

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

InvariantsBaseMethod[cm_,rep1_,conj_Symbol:False]:=Module[{result},

result=If[rep1==Table[0,{i,Length[cm]}],{a[1]},{}];
Return[result];
];

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

InvariantsBaseMethod[cm_,rep1_,rep2_,conj_Symbol:False]:=Module[{n,array1,array2,aux1,aux2,aux3,aux4,r1,r2,w1,w2,dim1,dim2,b1,b2,e1,e2,matrixE,bigMatrix,expr,cont,coefs,result},

Off[Solve::"svars"];
n=Length[cm];
w1=Weights[cm,rep1];
w2=Weights[cm,rep2];
r1=RepMinimalMatrices[cm,rep1];
r2=RepMinimalMatrices[cm,rep2];

If[conj,
Do[
w2[[i,1]]=-w2[[i,1]];

,{i,Length[w2]}];
Do[
r2[[i,j]]=-Transpose[r2[[i,j]]];
,{i,n},{j,3}];];

(*---------------------*)
array1[x__]:=0;
array2[x__]:=0;
Do[array1[w1[[i,1]]]=w1[[i,2]],{i,Length[w1]}];
Do[array2[w2[[i,1]]]=w2[[i,2]],{i,Length[w2]}];
(*---------------------*)
aux1={};
Do[
If[array2[-w1[[i,1]]]!=0,aux1=Append[aux1,{w1[[i,1]],-w1[[i,1]]}]];
,{i,Length[w1]}];
(*---------------------*)
dim1[0]=0;
Do[dim1[i]=dim1[i-1]+array1[aux1[[i,1]]]array2[aux1[[i,2]]],{i,Length[aux1]}];

Do[b1[aux1[[i]]]=dim1[i-1]+1;
e1[aux1[[i]]]=dim1[i];
,{i,Length[aux1]}];
(*---------------------*)


bigMatrix={};
Do[

(*--------------------- Code for the e's --------------------- *)

aux2={};
Do[
If[array1[aux1[[j,1]]+cm[[i]]]!=0,
aux2=Append[aux2,{aux1[[j,1]]+cm[[i]],aux1[[j,2]]}]];
If[array2[aux1[[j,2]]+cm[[i]]]!=0,
aux2=Append[aux2,{aux1[[j,1]],aux1[[j,2]]+cm[[i]]}]];
,{j,Length[aux1]}];

aux2=DeleteDuplicates[aux2];

If[Length[w1]==1 && Length[w2]==1,aux2=aux1];  (* Special care is needed if both reps are singlets *)


(*---------------------*)
dim2[0]=0;
Do[dim2[i]=dim2[i-1]+array1[aux2[[i,1]]]array2[aux2[[i,2]]],{i,Length[aux2]}];

Do[b2[aux2[[i]]]=dim2[i-1]+1;
e2[aux2[[i]]]=dim2[i];
,{i,Length[aux2]}];
(*---------------------*)

If[dim2[Length[aux2]]!=0&&dim1[Length[aux1]]!=0,
matrixE=SparseArray[{},{dim2[Length[aux2]],dim1[Length[aux1]]}],matrixE={}];

Do[

If[array1[aux1[[j,1]]+cm[[i]]]!=0,
aux3=aux1[[j]];
aux4={aux1[[j,1]]+cm[[i]],aux1[[j,2]]};

matrixE[[b2[aux4];;e2[aux4],b1[aux3];;e1[aux3]]]=KroneckerProduct[BlockW[aux1[[j,1]]+cm[[i]],aux1[[j,1]],w1,r1[[i,1]]],IdentityMatrix[array2[aux1[[j,2]]]]];

];

If[array2[aux1[[j,2]]+cm[[i]]]!=0,
aux3=aux1[[j]];
aux4={aux1[[j,1]],aux1[[j,2]]+cm[[i]]};

matrixE[[b2[aux4];;e2[aux4],b1[aux3];;e1[aux3]]]=KroneckerProduct[IdentityMatrix[array1[aux1[[j,1]]]],BlockW[aux1[[j,2]]+cm[[i]],aux1[[j,2]],w2,r2[[i,1]]]];

];
,{j,Length[aux1]}];


If[bigMatrix!={},bigMatrix=SparseArray[bigMatrix]];
bigMatrix=Join[bigMatrix ,matrixE];
,{i,n}];

(*---------------------*)

dim1[0]=0;
Do[dim1[i]=dim1[i-1]+w1[[i,2]],{i,Length[w1]}];

dim2[0]=0;
Do[dim2[i]=dim2[i-1]+w2[[i,2]],{i,Length[w2]}];

Do[b1[w1[[i,1]]]=dim1[i-1];
,{i,Length[w1]}];

Do[b2[w2[[i,1]]]=dim2[i-1];
,{i,Length[w2]}];


If[Length[bigMatrix]!=0,
aux4=NullSpace2[bigMatrix,100];

Do[
expr[i0]=0;
cont=0;
Do[
Do[
cont++;
expr[i0]+=aux4[[1,cont]]a[b1[aux1[[i,1]]]+j1] b[b2[aux1[[i,2]]]+j2];
,{j1,array1[aux1[[i,1]]]},{j2,array2[aux1[[i,2]]]}];
,{i,Length[aux1]}];
,{i0,Length[aux4]}];

result=Table[expr[i0],{i0,Length[aux4]}];

(* Normalize the invariants *)
coefs=result /. {Plus ->List,a[__]->1,b[__]->1,c[__]->1};
Do[
If[Length[coefs[[i]]]==0,coefs[[i]]={coefs[[i]]}];
result[[i]]=Expand[Sqrt[Sqrt[DimR[cm,rep1] DimR[cm,rep2]]/coefs[[i]].Conjugate[coefs[[i]]]] result[[i]]];
,{i,Length[coefs]}];
(* /Normalize the invariants *)

,result={}];

(* Special treatment - This code ensures that well known cases come out in the expected form *)

 (* Two SU (2) doublets and no conjugation ... fix the sign *)
If[cm==SU2&&rep1==rep2=={1}&&!conj, result=-result];

(* /Special treatment *)

Return[result];
]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

InvariantsBaseMethod[cm_,rep1_,rep2_,rep3_,conj_Symbol:False]:=Module[{n,array1,array2,array3,aux1,aux2,aux3,aux4,r1,r2,r3,w1,w2,w3,dim1,dim2,dim3,b1,b2,b3,e1,e2,matrixE,bigMatrix,expr,cont,coefs,result},

Off[Solve::"svars"];
n=Length[cm];

w1=Weights[cm,rep1];
w2=Weights[cm,rep2];
w3=Weights[cm,rep3];
r1=RepMinimalMatrices[cm,rep1];
r2=RepMinimalMatrices[cm,rep2];
r3=RepMinimalMatrices[cm,rep3];

If[conj,
Do[
w3[[i,1]]=-w3[[i,1]];

,{i,Length[w3]}];
Do[
r3[[i,j]]=-Transpose[r3[[i,j]]];
,{i,n},{j,3}];];

(*---------------------*)
array1[x__]:=0;
array2[x__]:=0;
array3[x__]:=0;
Do[array1[w1[[i,1]]]=w1[[i,2]],{i,Length[w1]}];
Do[array2[w2[[i,1]]]=w2[[i,2]],{i,Length[w2]}];
Do[array3[w3[[i,1]]]=w3[[i,2]],{i,Length[w3]}];
(*---------------------*)
aux1={};
Do[
If[array3[-w1[[i,1]]-w2[[j,1]]]!=0,aux1=Append[aux1,{w1[[i,1]],w2[[j,1]],-w1[[i,1]]-w2[[j,1]]}]];
,{i,Length[w1]},{j,Length[w2]}];
(*---------------------*)
dim1[0]=0;
Do[dim1[i]=dim1[i-1]+array1[aux1[[i,1]]]array2[aux1[[i,2]]]array3[aux1[[i,3]]],{i,Length[aux1]}];

Do[b1[aux1[[i]]]=dim1[i-1]+1;
e1[aux1[[i]]]=dim1[i];
,{i,Length[aux1]}];
(*---------------------*)


bigMatrix={};
Do[

(*--------------------- Code for the e's --------------------- *)

aux2={};
Do[
If[array1[aux1[[j,1]]+cm[[i]]]!=0,
aux2=Append[aux2,{aux1[[j,1]]+cm[[i]],aux1[[j,2]],aux1[[j,3]]}]];
If[array2[aux1[[j,2]]+cm[[i]]]!=0,
aux2=Append[aux2,{aux1[[j,1]],aux1[[j,2]]+cm[[i]],aux1[[j,3]]}]];
If[array3[aux1[[j,3]]+cm[[i]]]!=0,
aux2=Append[aux2,{aux1[[j,1]],aux1[[j,2]],aux1[[j,3]]+cm[[i]]}]];
,{j,Length[aux1]}];
aux2=DeleteDuplicates[aux2];
If[Length[w1]==1 && Length[w2]==1&& Length[w3]==1,aux2=aux1];   (* Special care is needed if all 3 reps are singlets *)
(*---------------------*)
dim2[0]=0;
Do[dim2[i]=dim2[i-1]+array1[aux2[[i,1]]]array2[aux2[[i,2]]]array3[aux2[[i,3]]],{i,Length[aux2]}];

Do[b2[aux2[[i]]]=dim2[i-1]+1;
e2[aux2[[i]]]=dim2[i];
,{i,Length[aux2]}];
(*---------------------*)


If[dim2[Length[aux2]]!=0&&dim1[Length[aux1]]!=0,
matrixE=SparseArray[{},{dim2[Length[aux2]],dim1[Length[aux1]]}],matrixE={}];

Do[

If[array1[aux1[[j,1]]+cm[[i]]]!=0,
aux3=aux1[[j]];
aux4={aux1[[j,1]]+cm[[i]],aux1[[j,2]],aux1[[j,3]]};

matrixE[[b2[aux4];;e2[aux4],b1[aux3];;e1[aux3]]]=KroneckerProduct[BlockW[aux1[[j,1]]+cm[[i]],aux1[[j,1]],w1,r1[[i,1]]],IdentityMatrix[array2[aux1[[j,2]]]],IdentityMatrix[array3[aux1[[j,3]]]]];
];

If[array2[aux1[[j,2]]+cm[[i]]]!=0,
aux3=aux1[[j]];
aux4={aux1[[j,1]],aux1[[j,2]]+cm[[i]],aux1[[j,3]]};

matrixE[[b2[aux4];;e2[aux4],b1[aux3];;e1[aux3]]]=KroneckerProduct[IdentityMatrix[array1[aux1[[j,1]]]],BlockW[aux1[[j,2]]+cm[[i]],aux1[[j,2]],w2,r2[[i,1]]],IdentityMatrix[array3[aux1[[j,3]]]]];
];

If[array3[aux1[[j,3]]+cm[[i]]]!=0,
aux3=aux1[[j]];
aux4={aux1[[j,1]],aux1[[j,2]],aux1[[j,3]]+cm[[i]]};

matrixE[[b2[aux4];;e2[aux4],b1[aux3];;e1[aux3]]]=KroneckerProduct[IdentityMatrix[array1[aux1[[j,1]]]],IdentityMatrix[array2[aux1[[j,2]]]],BlockW[aux1[[j,3]]+cm[[i]],aux1[[j,3]],w3,r3[[i,1]]]];
];


,{j,Length[aux1]}];

If[bigMatrix!={},bigMatrix=SparseArray[bigMatrix]];
bigMatrix=Join[bigMatrix ,matrixE];

,{i,n}];

(*---------------------*)

dim1[0]=0;
Do[dim1[i]=dim1[i-1]+w1[[i,2]],{i,Length[w1]}];

dim2[0]=0;
Do[dim2[i]=dim2[i-1]+w2[[i,2]],{i,Length[w2]}];

dim3[0]=0;
Do[dim3[i]=dim3[i-1]+w3[[i,2]],{i,Length[w3]}];

Do[b1[w1[[i,1]]]=dim1[i-1];
,{i,Length[w1]}];

Do[b2[w2[[i,1]]]=dim2[i-1];
,{i,Length[w2]}];

Do[b3[w3[[i,1]]]=dim3[i-1];
,{i,Length[w3]}];

If[Length[bigMatrix]!=0,


aux4=NullSpace2[bigMatrix,100];


Do[
expr[i0]=0;
cont=0;
Do[
Do[
aux2=0;
Do[
cont++;
aux2+=aux4[[i0,cont]]a[b1[aux1[[i,1]]]+j1] b[b2[aux1[[i,2]]]+j2] c[b3[aux1[[i,3]]]+j3];
,{j2,array2[aux1[[i,2]]]},{j3,array3[aux1[[i,3]]]}];
expr[i0]+=aux2;
,{j1,array1[aux1[[i,1]]]}]

,{i,Length[aux1]}];
,{i0,Length[aux4]}];

result=Table[expr[i0],{i0,Length[aux4]}];

(*With more that one invariant and repeated fields, make sure each invariant has some symmetry *)
If[Length[result]>1,
If[rep1==rep2==rep3,result=SymmetrizeInvariants[result,a,b,c];];
If[rep1==rep2!=rep3,result=SymmetrizeInvariants[result,a,b];];
If[rep1==rep3!=rep2,result=SymmetrizeInvariants[result,a,c];];
If[rep3==rep2!=rep1,result=SymmetrizeInvariants[result,c,b];];
];

(* Normalize the invariants *)
coefs=result /. {Plus ->List,a[__]->1,b[__]->1,c[__]->1};
Do[
If[Length[coefs[[i]]]==0,coefs[[i]]={coefs[[i]]}];
result[[i]]=Expand[Sqrt[Sqrt[DimR[cm,rep1] DimR[cm,rep2]DimR[cm,rep3]] /coefs[[i]].Conjugate[coefs[[i]]]] result[[i]]];
,{i,Length[coefs]}];
(* /Normalize the invariants *)

,result={}];


(* Special treatment - This code ensures that well known cases come out in the expected form *)


(* Two SU (2) doublets and a singlet no conjugation on the doublets ... fix the sign *)
If[cm==SU2&&Sort[{rep1,rep2,rep3}]=={{0},{1},{1}}&&(!conj||rep3=={0}), result=-result]; 

(* /Special treatment *)

Return[result];
]

(* SymmetrizeAux and SymmetrizeInvariants are auxiliar methods to InvariantsBaseMethod[cm,rep1,rep2,rep3]; They are used to make sure the result is (anti)symmetric *)
SymmetrizeAux[expression_,v1_,v2_]:=Module[{res1,res2},
res1=res2=0;
res1=expression+(expression /.{v1->v2,v2->v1});
res2=expression-(expression /.{v1->v2,v2->v1});
Return[Expand[{res1,res2}]];
]

SymmetrizeAux[expression_,v1_,v2_,v3_]:=Module[{res1,res2},
res1=res2=0;
res1=expression+(expression /.{v1->v2,v2->v1})+(expression /.{v1->v3,v3->v1})+(expression /.{v2->v3,v3->v2})+(expression /.{v1->v2,v2->v3,v3->v1})+(expression /.{v1->v3,v3->v2,v2->v1});
res2=expression-(expression /.{v1->v2,v2->v1})-(expression /.{v1->v3,v3->v1})-(expression /.{v2->v3,v3->v2})+(expression /.{v1->v2,v2->v3,v3->v1})+(expression /.{v1->v3,v3->v2,v2->v1});
Return[Expand[{res1,res2}]];
]

SymmetrizeInvariants[invariants_,var1_,var2_]:=Module[{i,j,aux,coefs},
aux=DeleteCases[Flatten[SymmetrizeAux[#,var1,var2]& /@invariants],0];

coefs=Table[aux[[i,1]] /.{a[__]->1,b[__]->1,c[__]->1},{i,Length[aux]}];
 aux=Expand[ aux/coefs];

i=1;
While[i<Length[aux],
	j=i+1;
	While[j<=Length[aux],
	If[aux[[i]]==aux[[j]],aux=Delete[aux,j];coefs=Delete[coefs,j]];
	j++;];
i++;];
aux=Expand[aux coefs] ;
Return[aux];
]

SymmetrizeInvariants[invariants_,var1_,var2_,var3_]:=Module[{i,j,aux,coefs},
aux=Flatten[SymmetrizeAux[#,var1,var2,var3]& /@invariants];
coefs=Table[aux[[i,1]] /.{a[__]->1,b[__]->1,c[__]->1},{i,Length[aux]}];
 aux=Expand[ aux/coefs];
i=1;
While[i<Length[aux],
	j=i+1;
	While[j<=Length[aux],
	If[aux[[i]]==aux[[j]],aux=Delete[aux,j];coefs=Delete[coefs,j]];
	j++;];
i++;];
aux=Expand[aux coefs] ;
Return[aux];
]


EndPackage[];