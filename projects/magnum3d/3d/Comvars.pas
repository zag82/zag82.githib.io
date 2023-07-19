unit ComVars;

interface

uses
  cm_ini;

var
  NBounds:int;
  NBounds_X,NBounds_Y,NBounds_Z:int;
  NSources:int;
  NMagnets:int;
  NCharges:int;
  NPoints:int;
  NElements:int;

  ATopology : array of array[0..4] of int;
  Crd_x,Crd_y,Crd_z : array of float;

  // boundary
  NumberBound : array of int;
  PotentialBound : array of float;
  NumberBound_X,NumberBound_Y,NumberBound_Z : array of int;
  PotentialBound_X,PotentialBound_Y,PotentialBound_Z : array of float;
  PotentialBound_Xc,PotentialBound_Yc,PotentialBound_Zc : array of TComplex;
  // matrixes
  NumberConnect : array of array of int;
  ScalarMatrix : array of array of float;
  ComplexMatrix_X,
  ComplexMatrix_Y,
  ComplexMatrix_Z : array of array of TComplex;
  RealMatrix_X,
  RealMatrix_Y,
  RealMatrix_Z : array of array of float;
  // results
  Result_X,Result_Y,Result_Z,ResultSc:array of float;
  Result_Xc,Result_Yc,Result_Zc : array of TComplex;
  // right sides
  RightSide: array of float;
  RightSide_X,RightSide_Y,RightSide_Z : array of float;
  RightSide_Xc,RightSide_Yc,RightSide_Zc : array of TComplex;
  // sources
  NumberCharge : array of int;
  Charge_Ro : array of float;

  NumberMagnet : array of int;
  Magnet_X,Magnet_Y,Magnet_Z : array of float;

  NumberSource : array of int;
  Source : array of float;
  Source_X,Source_Y,Source_Z : array of float;
  Source_Xc,Source_Yc,Source_Zc : array of TComplex;

  // solution
  Z,zrx,zry,zrz:array of float;
  zcx,zcy,zcz:array of TComplex;
  Residual_X,Residual_Y,Residual_Z,Residual : array of float;
  Residual_Xc,Residual_Yc,Residual_Zc : array of TComplex;
  Direction_X,Direction_Y,Direction_Z,Direction,
  DirectionNew_X,DirectionNew_Y,DirectionNew_Z,DirectionNew : array of float;
  Direction_Xc,Direction_Yc,Direction_Zc,
  DirectionNew_Xc,DirectionNew_Yc,DirectionNew_Zc : array of TComplex;

procedure FreeAll_3d;

implementation

procedure FreeAll_3d;
begin
  NBounds:=0;
  NBounds_X:=0;
  NBounds_Y:=0;
  NBounds_Z:=0;
  NSources:=0;
  NMagnets:=0;
  NCharges:=0;
  NPoints:=0;
  NElements:=0;

  ATopology:=nil;
  Crd_x:=nil;
  Crd_y:=nil;
  Crd_z:=nil;

  // boundary
  NumberBound:=nil;
  PotentialBound:=nil;
  NumberBound_X:=nil;
  NumberBound_Y:=nil;
  NumberBound_Z:=nil;
  PotentialBound_X:=nil;
  PotentialBound_Y:=nil;
  PotentialBound_Z:=nil;
  PotentialBound_Xc:=nil;
  PotentialBound_Yc:=nil;
  PotentialBound_Zc:=nil;
  // matrixes
  NumberConnect:=nil;
  ScalarMatrix:=nil;
  ComplexMatrix_X:=nil;
  ComplexMatrix_Y:=nil;
  ComplexMatrix_Z:=nil;
  RealMatrix_X:=nil;
  RealMatrix_Y:=nil;
  RealMatrix_Z:=nil;
  // results
  Result_X:=nil;
  Result_Y:=nil;
  Result_Z:=nil;
  ResultSc:=nil;
  Result_Xc:=nil;
  Result_Yc:=nil;
  Result_Zc:=nil;
  // right sides
  RightSide:=nil;
  RightSide_X:=nil;
  RightSide_Y:=nil;
  RightSide_Z:=nil;
  RightSide_Xc:=nil;
  RightSide_Yc:=nil;
  RightSide_Zc:=nil;
  // sources
  NumberCharge:=nil;
  Charge_Ro:=nil;

  NumberMagnet:=nil;
  Magnet_X:=nil;
  Magnet_Y:=nil;
  Magnet_Z:=nil;

  NumberSource:=nil;
  Source:=nil;
  Source_X:=nil;
  Source_Y:=nil;
  Source_Z:=nil;
  Source_Xc:=nil;
  Source_Yc:=nil;
  Source_Zc:=nil;
  // solution
  Residual_X:=nil;
  Residual_Y:=nil;
  Residual_Z:=nil;
  Residual:=nil;
  Residual_Xc:=nil;
  Residual_Yc:=nil;
  Residual_Zc:=nil;
  Direction_X:=nil;
  Direction_Y:=nil;
  Direction_Z:=nil;
  Direction:=nil;

  DirectionNew_X:=nil;
  DirectionNew_Y:=nil;
  DirectionNew_Z:=nil;
  DirectionNew:=nil;

  Direction_Xc:=nil;
  Direction_Yc:=nil;
  Direction_Zc:=nil;

  DirectionNew_Xc:=nil;
  DirectionNew_Yc:=nil;
  DirectionNew_Zc:=nil;

  Z:=nil;
  Zrx:=nil;
  Zry:=nil;
  Zrz:=nil;
  Zcx:=nil;
  Zcy:=nil;
  Zcz:=nil;
end;

end.
