Off[General::spell]

Model`Name = "MSSMLV";
Model`NameLaTeX ="MSSM with lepton number violation";
Model`Authors = "F.Staub";
Model`Date = "2012-09-01";

(* 2013-09-01: changing to new conventions for Superfields, Superpotential and global symmetries *)



(*-------------------------------------------*)
(*   Particle Content*)
(*-------------------------------------------*)

(* Global symmetries *)

Global[[1]] = {Z[3],BTriality};

(* Vector Superfields *)

Gauge[[1]]={B,   U[1], hypercharge, g1,False, 1};
Gauge[[2]]={WB, SU[2], left,        g2,True,  1};
Gauge[[3]]={G,  SU[3], color,       g3,False, 1};


(* Chiral Superfields *)

SuperFields[[1]] = {q,  3, {uL,  dL},    1/6, 2, 3,                          1};  
SuperFields[[2]] = {l,  3, {vL,  eL},   -1/2, 2, 1, Exp[-2*Pi*\[ImaginaryI]/3]};
SuperFields[[3]] = {Hd, 1, {Hd0, Hdm},  -1/2, 2, 1, Exp[-2*Pi*\[ImaginaryI]/3]};
SuperFields[[4]] = {Hu, 1, {Hup, Hu0},   1/2, 2, 1, Exp[ 2*Pi*\[ImaginaryI]/3]};

SuperFields[[5]] = {d, 3, conj[dR],      1/3, 1, -3, Exp[ 2*Pi*\[ImaginaryI]/3]};
SuperFields[[6]] = {u, 3, conj[uR],     -2/3, 1, -3, Exp[-2*Pi*\[ImaginaryI]/3]};
SuperFields[[7]] = {e, 3, conj[eR],        1, 1,  1, Exp[ 4*Pi*\[ImaginaryI]/3]};


(*------------------------------------------------------*)
(* Superpotential *)
(*------------------------------------------------------*)

SuperPotential = Yu u.q.Hu - Yd d.q.Hd - Ye e.l.Hd + \[Mu] Hu.Hd + \[Epsilon] l.Hu + L1/2 l.l.e + L2 l.q.d;



(*----------------------------------------------*)
(*   DEFINITION                                  *)
(*----------------------------------------------*)

NameOfStates={GaugeES,EWSB};


DEFINITION[GaugeES][DiracSpinors]={
  Bino ->{fB, conj[fB]},
  Wino -> {fWB, conj[fWB]},
  Glu -> {fG, conj[fG]},
  H0 -> {FHd0, conj[FHu0]},
  HC -> {FHdm, conj[FHup]},
  Fd1 -> {FdL, 0},
  Fd2 -> {0, FdR},
  Fu1 -> {FuL, 0},
  Fu2 -> {0, FuR},
  Fe1 -> {FeL, 0},
  Fe2 -> {0, FeR},
  Fv -> {FvL, 0}
};


(* Gauge Sector *)

DEFINITION[EWSB][GaugeSector] =
{ 
  {{VB,VWB[3]},{VP,VZ},ZZ},
  {{VWB[1],VWB[2]},{VWm,conj[VWm]},ZW},
  {{fWB[1],fWB[2],fWB[3]},{fWm,fWp,fW0},ZfW}
};   
        
        
          	

(* ----- VEVs ---- *)

DEFINITION[EWSB][VEVs]= 
{    {SHd0, {vd, 1/Sqrt[2]}, {sigmad, \[ImaginaryI]/Sqrt[2]},{phid, 1/Sqrt[2]}},
     {SHu0, {vu, 1/Sqrt[2]}, {sigmau, \[ImaginaryI]/Sqrt[2]},{phiu, 1/Sqrt[2]}},
     {SvL, {vL, 1/Sqrt[2]}, {sigmaL, \[ImaginaryI]/Sqrt[2]},{phiL, 1/Sqrt[2]}}     };


DEFINITION[EWSB][Phases]= 
{    {fG, PhaseGlu}
    }; 

 
DEFINITION[EWSB][MatterSector]= 
{    {{SdL, SdR}, {Sd, ZD}},
     {{SuL, SuR}, {Su, ZU}},
     {{phid, phiu,phiL}, {hh, ZH}},
     {{sigmad, sigmau,sigmaL}, {Ah, ZA}},
     {{SHdm,conj[SHup],SeL,SeR},{Hpm,ZP}},
     {{FvL,fB, fW0, FHd0, FHu0}, {L0, ZN}}, 
     {{{FeL,fWm, FHdm}, {conj[FeR],fWp, FHup}},  {{Lm,UM}, {Lp,UP}}},
     {{{FdL},{conj[FdR]}},{{FDL,ZDL},{FDR,ZDR}}},
     {{{FuL},{conj[FuR]}},{{FUL,ZUL},{FUR,ZUR}}}
       }; 


DEFINITION[EWSB][DiracSpinors]={
 Fd ->{  FDL, conj[FDR]},
 Fu ->{  FUL, conj[FUR]},
 Chi ->{ L0, conj[L0]},
 Cha ->{ Lm, conj[Lp]},
 Glu ->{ fG, conj[fG]}
};	

(*
(*------------------------------------------------------*)
(* Dirac-Spinors *)
(*------------------------------------------------------*)

dirac[[1]] = {Fd,  FDL, conj[FDR]};
dirac[[2]] = {Fu,  FUL, conj[FUR]};
dirac[[3]] = {Chi, L0, conj[L0]}; 
dirac[[4]] = {Cha, Lm, conj[Lp]};
dirac[[5]] = {Glu, fG, conj[fG]}; 

(* Unbroken EW *)

dirac[[6]] = {Bino, fB, conj[fB]};
dirac[[7]] = {Wino, fWB, conj[fWB]};
dirac[[8]] = {H0, FHd0, conj[FHu0]};
dirac[[9]] = {HC, FHdm, conj[FHup]};
dirac[[10]] = {Fd1, FdL, 0};
dirac[[11]] = {Fd2, 0, FdR};
dirac[[12]] = {Fu1, FuL, 0};
dirac[[13]] = {Fu2, 0, FuR};
dirac[[14]] = {Fe1, FeL, 0};
dirac[[15]] = {Fe2, 0, FeR};
dirac[[16]] = {Fv, FvL, 0};
*)

(*------------------------------------------------------*)
(* Automatized Output        *)
(*------------------------------------------------------*)

(* 
makeOutput = {
                   {EWSB, {TeX, FeynArts}}
             };   
            *)
            
SpectrumFile= None;		

	


