unit Compute_VectorsUnit;

interface

uses cm_ini,cmVars,ComPlx;

var
  HIntensity_X:float;
  HIntensity_Y:float;
  HIntensity_Z:float;
  AvResult:float;
  FluxDensity_X:float;
  FluxDensity_Y:float;
  FluxDensity_Z:float;
  AvResult_x:float;
  AvResult_y:float;
  AvResult_z:float;
  RSide_X:float;
  RSide_Y:float;
  RSide_Z:float;
  //
  cAvResult_x:TComplex;
  cAvResult_y:TComplex;
  cAvResult_z:TComplex;
  cFluxDensity_X:TComplex;
  cFluxDensity_Y:TComplex;
  cFluxDensity_Z:TComplex;
  cHIntensity_X:TComplex;
  cHIntensity_Y:TComplex;
  cHIntensity_Z:TComplex;
  cEIntensity_X:TComplex;
  cEIntensity_Y:TComplex;
  cEIntensity_Z:TComplex;
  cPoynting_X:TComplex;
  cPoynting_Y:TComplex;
  cPoynting_Z:TComplex;
  cEddyCurrent_X:TComplex;
  cEddyCurrent_Y:TComplex;
  cEddyCurrent_Z:TComplex;

procedure Compute_Vectors(iElement : Integer);
procedure Compute_RealVectors(iElement : Integer);
procedure Compute_ComplexVectors(iElement : Integer);

implementation

uses
  ComVars,cmData;

var
  a,b,c,d:mxtyp3;
  Volume:float;

function Determinant(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
begin
  Result:=a1*(b2*c3-c2*b3)-b1*(a2*c3-c2*a3)+c1*(a2*b3-b2*a3)
end;

procedure ElementMatrix3(iElement:Int);
var
  x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4:float;
begin
{  Вызов координат вершин тетраэдра с номером iElement }
  x1:=Crd_x[ATopology[iElement][1]];
  x2:=Crd_x[ATopology[iElement][2]];
  x3:=Crd_x[ATopology[iElement][3]];
  x4:=Crd_x[ATopology[iElement][4]];
  y1:=Crd_y[ATopology[iElement][1]];
  y2:=Crd_y[ATopology[iElement][2]];
  y3:=Crd_y[ATopology[iElement][3]];
  y4:=Crd_y[ATopology[iElement][4]];
  z1:=Crd_z[ATopology[iElement][1]];
  z2:=Crd_z[ATopology[iElement][2]];
  z3:=Crd_z[ATopology[iElement][3]];
  z4:=Crd_z[ATopology[iElement][4]];
{  Определение коэффициентов матрицы конечного элемента }
  a[1]:=Determinant(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  b[1]:=-Determinant(1,y2,z2,1,y3,z3,1,y4,z4);
  c[1]:=Determinant(1,x2,z2,1,x3,z3,1,x4,z4);
  d[1]:=-Determinant(1,x2,y2,1,x3,y3,1,x4,y4);

  a[2]:=-Determinant(x1,y1,z1,x3,y3,z3,x4,y4,z4);
  b[2]:=Determinant(1,y1,z1,1,y3,z3,1,y4,z4);
  c[2]:=-Determinant(1,x1,z1,1,x3,z3,1,x4,z4);
  d[2]:=Determinant(1,x1,y1,1,x3,y3,1,x4,y4);

  a[3]:=Determinant(x1,y1,z1,x2,y2,z2,x4,y4,z4);
  b[3]:=-Determinant(1,y1,z1,1,y2,z2,1,y4,z4);
  c[3]:=Determinant(1,x1,z1,1,x2,z2,1,x4,z4);
  d[3]:=-Determinant(1,x1,y1,1,x2,y2,1,x4,y4);

  a[4]:=-Determinant(x1,y1,z1,x2,y2,z2,x3,y3,z3);
  b[4]:=Determinant(1,y1,z1,1,y2,z2,1,y3,z3);
  c[4]:=-Determinant(1,x1,z1,1,x2,z2,1,x3,z3);
  d[4]:=Determinant(1,x1,y1,1,x2,y2,1,x3,y3);
{  Расчет объема тетраэдра  }
  Volume:=(a[1]+a[2]+a[3]+a[4])/6.0;
end; { ElementMatrix3  }

procedure Compute_Vectors(iElement : Integer);
var
  i,im : Integer;
begin
  ElementMatrix3(iElement);
  if Volume<1e-30 then Volume:=1;
  iM:=ATopology[iElement][0];
  HIntensity_X:=0.0;
  HIntensity_Y:=0.0;
  HIntensity_Z:=0.0;
  AvResult:=0;
  for i:=1 to 4 do begin
    HIntensity_X:=HIntensity_X-b[i]*ResultSc[ATopology[iElement][i]];
    HIntensity_Y:=HIntensity_Y-c[i]*ResultSc[ATopology[iElement][i]];
    HIntensity_Z:=HIntensity_Z-d[i]*ResultSc[ATopology[iElement][i]];
    AvResult:=AvResult+ResultSc[ATopology[iElement][i]];
  end;
  if Volume>1e-30 then
  begin
    AvResult:=AvResult/4;
    HIntensity_X:=HIntensity_X/Volume/6.0;
    HIntensity_Y:=HIntensity_Y/Volume/6.0;
    HIntensity_Z:=HIntensity_Z/Volume/6.0;
  end;
  FluxDensity_X:=mt.Prop(iElement,iM)*mt.Anisotropy_X[iM]*HIntensity_X;
  FluxDensity_Y:=mt.Prop(iElement,iM)*mt.Anisotropy_Y[iM]*HIntensity_Y;
  FluxDensity_Z:=mt.Prop(iElement,iM)*mt.Anisotropy_Z[iM]*HIntensity_Z;
end; { Compute_Vectors}

procedure Compute_RealVectors(iElement : Integer);
var
  i,im : Integer;
begin
  ElementMatrix3(iElement);
  iM:=ATopology[iElement][0];
  FluxDensity_X:=0.0;
  FluxDensity_Y:=0.0;
  FluxDensity_Z:=0.0;
  AvResult_x:=0; AvResult_y:=0; AvResult_z:=0;
  RSide_X:=0;
  RSide_Y:=0;
  RSide_Z:=0;
  for i:=1 to 4 do
  begin
    FluxDensity_X:=FluxDensity_X+c[i]*Result_Z[ATopology[iElement][i]]-d[i]*Result_Y[ATopology[iElement][i]];
    FluxDensity_Y:=FluxDensity_Y+d[i]*Result_X[ATopology[iElement][i]]-b[i]*Result_Z[ATopology[iElement][i]];
    FluxDensity_Z:=FluxDensity_Z+b[i]*Result_Y[ATopology[iElement][i]]-c[i]*Result_X[ATopology[iElement][i]];
    //
    AvResult_x:=AvResult_x+Result_X[ATopology[iElement][i]];
    AvResult_y:=AvResult_y+Result_Y[ATopology[iElement][i]];
    AvResult_z:=AvResult_z+Result_Z[ATopology[iElement][i]];
    //
    RSide_X:=RSide_X+RightSide_X[ATopology[iElement][i]];
    RSide_Y:=RSide_Y+RightSide_Y[ATopology[iElement][i]];
    RSide_Z:=RSide_Z+RightSide_Z[ATopology[iElement][i]];
  end;
  if Volume>1e-30 then begin
    AvResult_x:=AvResult_x/4;
    AvResult_y:=AvResult_y/4;
    AvResult_z:=AvResult_z/4;
    FluxDensity_X:=FluxDensity_X/Volume/6.0;
    FluxDensity_Y:=FluxDensity_Y/Volume/6.0;
    FluxDensity_Z:=FluxDensity_Z/Volume/6.0;
    RSide_X:=RSide_X/4;
    RSide_Y:=RSide_Y/4;
    RSide_Z:=RSide_Z/4;
  end;
  HIntensity_X:=mt.Prop(iElement,iM)/mt.Anisotropy_X[iM]*FluxDensity_X;
  HIntensity_Y:=mt.Prop(iElement,iM)/mt.Anisotropy_Y[iM]*FluxDensity_Y;
  HIntensity_Z:=mt.Prop(iElement,iM)/mt.Anisotropy_Z[iM]*FluxDensity_Z;
end;

procedure Compute_ComplexVectors(iElement : Integer);
var
  i,im : Integer;
begin
  ElementMatrix3(iElement);
  iM:=ATopology[iElement][0];
  cFluxDensity_X.re:=0.0; cFluxDensity_Y.re:=0.0; cFluxDensity_Z.re:=0.0;
  cFluxDensity_X.im:=0.0; cFluxDensity_Y.im:=0.0; cFluxDensity_Z.im:=0.0;
  cAvResult_x:=CNull; cAvResult_y:=CNull; cAvResult_z:=CNull;
  for i:=1 to 4 do begin
    cFluxDensity_X:=CSub(CAdd(cFluxDensity_X,CMul(CConv(c[i]),Result_Zc[ATopology[iElement][i]])),CMul(CConv(d[i]),Result_Yc[ATopology[iElement][i]]));
    cFluxDensity_Y:=CSub(CAdd(cFluxDensity_Y,CMul(CConv(d[i]),Result_Xc[ATopology[iElement][i]])),CMul(CConv(b[i]),Result_Zc[ATopology[iElement][i]]));
    cFluxDensity_Z:=CSub(CAdd(cFluxDensity_Z,CMul(CConv(b[i]),Result_Yc[ATopology[iElement][i]])),CMul(CConv(c[i]),Result_Xc[ATopology[iElement][i]]));
    ///////////////////////////
    CAddTo(cAvResult_x,Result_Xc[ATopology[iElement][i]]);
    CAddTo(cAvResult_y,Result_Yc[ATopology[iElement][i]]);
    CAddTo(cAvResult_z,Result_Zc[ATopology[iElement][i]]);
  end;
  cAvResult_x:=cDiv(cAvResult_x,cConv(4));
  cAvResult_y:=cDiv(cAvResult_y,cConv(4));
  cAvResult_z:=cDiv(cAvResult_z,cConv(4));
  cFluxDensity_X:=CDiv(cFluxDensity_X,CConv(Volume*6.0));
  cFluxDensity_Y:=CDiv(cFluxDensity_Y,CConv(Volume*6.0));
  cFluxDensity_Z:=CDiv(cFluxDensity_Z,CConv(Volume*6.0));

  cHIntensity_X:=CMul(CConv(mt.VecProperty[iM]/mt.Anisotropy_X[iM]),cFluxDensity_X);
  cHIntensity_Y:=CMul(CConv(mt.VecProperty[iM]/mt.Anisotropy_Y[iM]),cFluxDensity_Y);
  cHIntensity_Z:=CMul(CConv(mt.VecProperty[iM]/mt.Anisotropy_Z[iM]),cFluxDensity_Z);

  cEIntensity_X:=CMul(CDConv(0,-mt.frequency*2*Pi),cAvResult_X);
  cEIntensity_Y:=CMul(CDConv(0,-mt.frequency*2*Pi),cAvResult_Y);
  cEIntensity_Z:=CMul(CDConv(0,-mt.frequency*2*Pi),cAvResult_Z);

  cPoynting_X:=CSub(CMul(cEIntensity_Y,CInv(cHIntensity_Z)),CMul(cEIntensity_Z,CInv(cHIntensity_Y)));
  cPoynting_Y:=CSub(CMul(cEIntensity_Z,CInv(cHIntensity_X)),CMul(cEIntensity_X,CInv(cHIntensity_Z)));
  cPoynting_Z:=CSub(CMul(cEIntensity_X,CInv(cHIntensity_Y)),CMul(cEIntensity_Y,CInv(cHIntensity_X)));

  cEddyCurrent_X:=CMul(CConv(mt.Sigma[iM]),cEIntensity_X);
  cEddyCurrent_Y:=CMul(CConv(mt.Sigma[iM]),cEIntensity_Y);
  cEddyCurrent_Z:=CMul(CConv(mt.Sigma[iM]),cEIntensity_Z);
end; { Compute_ComplexVectors}

end.
