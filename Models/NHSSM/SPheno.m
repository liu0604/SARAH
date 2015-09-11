(* ::Package:: *)

(* CMSSM input parameters *)

MINPAR={{1,m0},
             {2,m12},
             {3,TanBeta},
             {5,Azero},
             {6,MuInput},
             {7,BMuInput},
             {8,MupInput}};
             



RealParameters = {TanBeta, m0};
ParametersToSolveTadpoles = {mHd2, mHu2};




RenormalizationScaleFirstGuess = m0^2 + 4 m12^2;
RenormalizationScale = Sqrt[(mq2[3, 3] + (vu^2*conj[Yu[3, 3]]*Yu[3, 3])/2)*(mu2[3, 3] + (vu^2*conj[Yu[3, 3]]*Yu[3, 3])/2)-((vd*\[Mu]*conj[Yu[3, 3]] - vu*conj[T[Yu][3, 3]])*(vd*conj[\[Mu]]*Yu[3, 3] - vu*T[Yu][3, 3]))/2];

ConditionGUTscale = g1 == g2;

(* GUT conditions CMSSM *)

BoundaryHighScale={
{T[Ye], Azero*Ye},
{T[Yd], Azero*Yd},
{T[Yu], Azero*Yu},
{mq2, DIAGONAL m0^2},
{ml2, DIAGONAL m0^2},
{md2, DIAGONAL m0^2},
{mu2, DIAGONAL m0^2},
{me2, DIAGONAL m0^2},
{MassB, m12},
{MassWB,m12},
{MassG,m12}
};

BoundarySUSYScale={
{Tep,LHInput[Tep]},
{Tdp,LHInput[Tdp]},
{Tup,LHInput[Tup]},
{\[Mu],MuInput},
{B[\[Mu]], BMuInput},
{Mup, MupInput}
};





UseHiggs2LoopMSSM = True;
(* UseHiggs2LoopMSSM = False; *)

QuadruplePrecision = {};

ListDecayParticles = Automatic;
ListDecayParticles3B = Automatic;

