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




BeginPackage["Susyno`LieGroups`"]
{name,result,i,E6,g2,f4,n,j,k,weight,index,w,x,Adjoint,input,w,x,x$,ex,el,DimR,delta,dim,m,matrix,up,down,dim1,dim2,col,begin,b1,b2,b3,Casimir,b,e,b$,res,n2,v,RepMatrices,rep,Invariants,a,x1,x2,c,x3,y1,x1$,x2$,y1$,conj,expr,j1,j2,j3,res1,res2,var1,var2,var3,weights,l1,end,groups,group,max,adjoint,cas,ConjugateIrrep,DynkinIndex,repsWithSizeN,CongruencyClass, sR,TriangularAnomalyValue,InvariantsBaseMethod,reps,vector,i1,pos,dims,r, v1, v2,Conjugations,r1,r2,SU3, dt};
EndPackage[]
BeginPackage["Susyno`SusyRGEs`"]
EndPackage[]

BeginPackage["SARAH`",{"Global`","Susyno`LieGroups`","Susyno`SusyRGEs`"}]

If[SA`Parallelize==True,
LaunchKernels[4];
];



StartingDirectory= Directory[]

$sarahDir=SetDirectory[DirectoryName[System`Private`FindFile[$Input]]]

 ResetDirectory[]

$sarahPackageDir=ToFileName[{$sarahDir,"Package"}]
$sarahSPhenoPackageDir=ToFileName[{$sarahPackageDir,"SPheno"}]
$sarahModelDir=ToFileName[{$sarahDir,"Models"}]
$sarahFeynDir=ToFileName[{$sarahDir,"FeynArts"}]
$sarahRGEsDir=ToFileName[{$sarahDir,"RGEs"}]
(* $sarahOutputDir=ToFileName[{$sarahDir,"Output"}] *)
$sarahInputDir=ToFileName[{$sarahDir,"Input"}]
$sarahSusynoDir=ToFileName[{$sarahDir,"Susyno"}]

SA`Version = "4.5.7";



Off[CreateDirectory::ioerr];
If[NumericQ[ToExpression[SA`Version]],
Print[StyleForm["SARAH ","Section",FontSize->14],StyleForm[SA`Version ,"Section",FontSize->14] ],
Print[StyleForm["SARAH ","Section",FontSize->14],StyleForm["(Private Version)","Section",FontSize->14] ]
]
Print["by Florian Staub, 2015"]
Print[StyleForm["contributions by M. D. Goodsell, K. Nickel",FontSize->10] ];
Print[""];
Print[StyleForm["References:","Section",FontSize->10]]
Print["  Comput.Phys.Commun.181 (2010) 1077-1086. (arXiv:0909.2863[hep-ph])"]
Print["  Comput.Phys.Commun.182 (2011) 808-833. (arXiv:1002.0840[hep-ph])"]
Print["  Comput.Phys.Commun.184 (2013) 1792-1809. (arXiv:1207.0906[hep-ph])"]
Print["  Comput.Phys.Commun.185 (2014) 1773-1790. (arXiv:1309.7223[hep-ph])"]
Print[StyleForm["Download and Documentation:","Section",FontSize->10]]
Print["  http://sarah.hepforge.org"]
Print[""]
Print["Start evaluation of a model with:"];
Print[StyleForm["   Start[\"Name of Model\"]","Section",FontSize->12]];
Print["e.g. Start[\"MSSM\"] or Start[\"NMSSM\",\"CKM\"]"];
Print["To get a list with all installed models, use ",StyleForm["ShowModels","Section",FontSize->12]];


Block[{$Path={$sarahPackageDir}},
<<variables`;
<<dependences`;
<<mathFunctions`;
<<mathSumMatrizes`;
<<mathParticleProp`;
<<init`;
<<error`; 

<<vertex`;
<<numerik`;
<<more`;
<<deriveModel`;

<<loopCorrections`; 

<<TwoLoopEffPot`;

<<wilson`;
Get[ToFileName[$sarahSPhenoPackageDir,"SPheno.m"]];
<<processes`;
<<checkModel`; 

<< TwoLoopPole`;

];

Block[{$Path=ToFileName[{$sarahPackageDir,"Outputs"}]},
<<madgraph`;
<<lhpc`;
<<whizard`;
<<feynarts`;
<<calchep`;
<<calchepSPheno`;
<<output`;
<<tex`;
<<Vevacious`;
];

Block[{$Path=ToFileName[{$sarahPackageDir,"Lagrangian"}]},
<<lagrange`; 
<<inputLag`; 
<<mixings`; 
<<ghosts`; 
<<tadpoles`;
];


Block[{$Path=ToFileName[{$sarahPackageDir,"RGEs"}]},
<<mathRGEs`;
<<nonSUSYrges`; 
<<genericRGEs`;
<<OutputRGEs`;
];

Block[{$Path=ToFileName[{$sarahPackageDir,"GroupTheory"}]},
<<linkSusyno`; 
<<grouptheory`;
<<young`;

 ];

Block[{$Path={$sarahDir}},
<<SARAH.config;
]

Start[model_,sub___]:=Block[{i,startedtime},
startedtime=TimeUsed[];
InitArrays;
ModelLoaded=False;
i=1;

If[Head[model]=!=String,
Print[""];
Print["Name of Model must be a String!"];
Print["Evaluation aborted"];
AbortStart=False;
ModelLoaded=True;
];

$sarahOutputDir=SARAH[OutputDirectory];


While[ModelLoaded ===False && i<=Length[SARAH[InputDirectories]],

If[SARAH`Private===True,
 $sarahModelDirInput=ToFileName[{$sarahDir,"Private-Models"}];,
(* $sarahModelDirInput=ToFileName[{$sarahDir,"Models"}] *)
$sarahModelDirInput=SARAH[InputDirectories][[i]];
];

Print[" ... checking Directory: ",$sarahModelDirInput];

Modelname = model;

If[StringFreeQ[model,"/"]==False,
splitted=StringSplit[model,"/"];
modelDir=splitted[[1]]; submodeldir=splitted[[2]];,
modelDir = model;
If[ValueQ[sub]=!=ValueQ[],
submodeldir=sub;,
submodeldir=False;
];
];

$sarahModelNameMain=modelDir;

If[submodeldir=!=False,
$sarahCurrentModelDir=ToFileName[ToFileName[{$sarahModelDirInput,modelDir}],submodeldir];
$sarahCurrentOutputMainDir=ToFileName[{$sarahOutputDir,modelDir<>"-"<>submodeldir}];
ModelFile=ToFileName[{$sarahCurrentModelDir},modelDir<>"-"<>submodeldir<>".m"];
modDir = modelDir <>"/" <> submodeldir;,
$sarahCurrentModelDir=ToFileName[{$sarahModelDirInput,modelDir}];
$sarahCurrentOutputMainDir=ToFileName[{$sarahOutputDir,modelDir}];
ModelFile=ToFileName[{$sarahCurrentModelDir},modelDir<>".m"];
modDir = modelDir;
];

$sarahCurrentModelMainDir=ToFileName[{$sarahModelDirInput,modelDir}];

ParameterFile=ToFileName[{$sarahCurrentModelDir},"parameters.m"];
ParticleFile=ToFileName[{$sarahCurrentModelDir},"particles.m"];

AbortStart=False;

(* Print[""]; *)
Off[FileByteCount::nffil];

If[FileByteCount[ModelFile]===$Failed,
(* Message[ModelFile::MissingModel]; *)
AbortStart=True;,
Get[ModelFile];
ModelLoaded=True;
AbortStart=False;
];

If[ModelLoaded==True,
If[FileByteCount[ParameterFile]===$Failed,
Message[ModelFile::MissingParticle];
AbortStart=True;,
Get[ParameterFile];
AbortStart=False;
];

If[FileByteCount[ParticleFile]===$Failed,
Message[ModelFile::MissingParameter];
AbortStart=True;,
Get[ParticleFile];
AbortStart=False;
];
];

Get[ToFileName[{$sarahModelDir},"parameters.m"]];
Get[ToFileName[{$sarahModelDir},"particles.m"]];

i++;
];

If[AbortStart===True,
 Message[ModelFile::MissingModel];
];


If[AbortStart==False,

If[Head[Model`Name]=!=String && Head[ModelName]===String,Model`Name=ModelName;];
If[Head[Model`NameLaTeX]=!=String && Head[ModelNameLaTeX]===String,Model`NameLaTeX=ModelNameLaTeX;];
If[Head[Model`Authors]=!=String,Model`Authors="undefined";];
If[Head[Model`Date]=!=String,Model`Date="undefined";];

(* because of historic reasons (I have to change the variable names sometimes inside the code) *)
ModelName = Model`Name;
ModelNameLaTeX = Model`NameLaTeX;

SetOptions[MakeVevacious,OutputFile->ModelName<>".vin"];

(*Print["*****************************"];*)
Print[StyleForm["Model files loaded   ","Section",FontSize->12]];
Print["  Model    : ",StyleForm[Model`Name,"Section",FontSize->10] ];
Print["  Author(s): ",StyleForm[Model`Authors,"Section",FontSize->10]];
Print["  Date     : ",StyleForm[Model`Date,"Section",FontSize->10]];
(* Print["  Superpotential     : ",StyleForm[SuperPotential,"Section",FontSize\[Rule]10]]; *)
(*Print["*****************************"];*)


If[FileExistsQ[$sarahOutputDir]=!=True,CreateDirectory[$sarahOutputDir];];
If[FileExistsQ[$sarahCurrentOutputMainDir]=!=True,CreateDirectory[$sarahCurrentOutputMainDir];];

SetOptions[MakeSPheno,Eigenstates->Last[NameOfStates]];

InitSusyno; 

InitFields;
InitParameters;
If[Length[NonSUNindices]==0,
CheckAnomalies;
];


PrintAll[StyleForm["Derive Lagrangian","Section",FontSize->12]];
If[SupersymmetricModel=!=False,
GetSuperpotential;
CalcSuperpotential;
CalcFTerms;
CalcMatter;
CalcSoftBreaking;
];

CalcKinetic;
If[SupersymmetricModel=!=False,
CalcDTerms;
CalcGaugino;
];
If[AddGravitino===True && SupersymmetricModel=!=False,CalcGravitino;];

CalcVectorBoson;
(* GenerateSusyNoInvariants; *)
CalcGaugeTransformations;
CalcLagrangian;
If[AddDiracGauginos===True,CheckAdjoints;];
CalcMixedLagrangian; 
parameters = DeleteCases[parameters,x_? ((FreeQ[RemoveParameters,#[[1]]]==False)&)];
CheckHiggsStates;
CleanUpGaugeConstants;

SetOptions[MakeSPheno,Eigenstates ->Last[NameOfStates]];

Print[""];
Print["All Done. ",model," is ready!"];
Print["(Model initialized in ",TimeUsed[]-startedtime,"s)"];

Print[""];
Print[""];
Print["Are you unfamiliar with SARAH? Use ",StyleForm["SARAH`FirstSteps","Section",FontSize->12]];,
Print[""];
Message[ModelFile::Aborted];

];

];

ShowModels=Return[DeleteCases[StringReplace[FileNames["particles.m",$sarahModelDir,4],{$sarahModelDir->"","/particles.m"->""}],"particles.m"] //TableForm];



EndPackage[]
