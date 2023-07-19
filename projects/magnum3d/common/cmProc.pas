unit cmProc;

interface

uses cm_ini, cmVars, cmData, ComPlx, Gauges, StdCtrls, comvars;

type
  TExpansionClass=class
  public
    gg:TGauge;
    lb:TLabel;
    ggb:TGroupBox;
    /////////////
    nds:boolean;
    procedure SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
    procedure ExpandSolutionEL;
    procedure ExpandSolutionRE;
    procedure ExpandSolutionEC;
    constructor Create;
  end;

var
  expa:TExpansionClass;

procedure GetPostParameters_re;


function GetSignal_Axial(imat:int;rr:float):TComplex;
function GetSignal_Axial_1(imat:int):TComplex;
function GetSignal_Axial_2(imat:int;rr:float):TComplex;

function GetSignal_3D(imat:int;rr:float):TComplex;
function GetSignal_3D_1(imat:int;rr:float):TComplex;
function GetSignal_3D_2(imat:int;var secs:array of int; num:int):TComplex;

implementation

uses common_main2d, ec_main2d, ss_main2d;

////////////////////////////////////////////////////////////////////////////////
//                     Post processor functions                               //
////////////////////////////////////////////////////////////////////////////////
procedure GetPostParameters_re;
var i,j,k:int;
    x1,z1,x2,z2:float;
    a,b,c:mxtyp2;
    rav,ar:float;
    vx1,vx2,vz1,vz2:float;
begin
  k:=tt.NTriangles div 2;
  SetLength(FluxDensity2,k+1);
  for i:=1 to k do
  begin
    tt.GetCenter(2*i-1,x1,z1);
    tt.ElementMatrix(2*i-1,ar,rav,a,b,c);
    vx1:=0;
    vz1:=0;
    for j:=1 to 3 do
    begin
      vx1:=vx1-c[j]*TFlatSSTask(tt).vMatr[tt.Topology[2*i-1,j]];
      vz1:=vz1+b[j]*TFlatSSTask(tt).vMatr[tt.Topology[2*i-1,j]];
    end;
    vx1:=vx1/ar/2.0;
    vz1:=vz1/ar/2.0;
    ////////////////
    tt.GetCenter(2*i,x2,z2);
    tt.ElementMatrix(2*i,ar,rav,a,b,c);
    vx2:=0;
    vz2:=0;
    for j:=1 to 3 do
    begin
      vx2:=vx2-c[j]*TFlatSSTask(tt).vMatr[tt.Topology[2*i,j]];
      vz2:=vz2+b[j]*TFlatSSTask(tt).vMatr[tt.Topology[2*i,j]];
    end;
    vx2:=vx2/ar/2.0;
    vz2:=vz2/ar/2.0;
    ////////////////
    FluxDensity2[i,1]:=(x1+x2)/2;   // x-coordinate
    FluxDensity2[i,2]:=(z1+z2)/2;   // z-coordinate
    FluxDensity2[i,3]:=(vx1+vx2)/2;   // Flux X value
    FluxDensity2[i,4]:=(vz1+vz2)/2;   // Flux Z value
  end;
end;

////////////////////////////////////////////////////////////////////////////////
function GetSignal_Axial(imat:int;rr:float):TComplex;
var
  res:TComplex;
  i,j,k:int;
  vv,gg:TComplex;
  aWeight:array of float;
  sum,avX:float;
  aPot:array of TComplex;
begin  // weight sceme
  res:=CNull;
  vv:=CNull;
  aWeight:=nil;
  aPot:=nil;
  j:=0;
  for i:=1 to tt.NTriangles do
  begin
    if tt.Topology[i][0]<>imat then continue;
    inc(j);
    gg:=CNull;
    avX:=0;
    for k:=1 to 3 do
    begin
      avX:=avX+tt.Nodes[tt.Topology[i][k]][1];
      gg:=CAdd(gg,TFlatECTask(tt).Vmatr[tt.Topology[i][k]]);
    end;
    avX:=avX/3;
    gg:=CDiv(gg,CConv(3));
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-rr);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CMul(aPot[i],CConv(aWeight[i]/sum)));
  res:=CMul(res,CConv(rr));
  aPot:=nil;
  aWeight:=nil;
  if (res.re<>0)or(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*mt.Frequency));
  end
  else
    Result:=CNull;
end;

function GetSignal_3D(imat:int;rr:float):TComplex;
var
  res,gg:TComplex;
  i,j,k:int;
  pp:float;
  iNode:int;
  ppc,pps:Float;
  aPot:array of TComplex;
  aWeight:array of float;
  sum,avX:float;
begin   // weight sceme
  res:=CNull;
  j:=0;
  for i:=1 to NElements do
  begin
    if ATopology[i][0]<>imat then continue;
    inc(j);
    gg:=CNull;
    avX:=0;
    for k:=1 to 4 do
    begin
      iNode:=ATopology[i][k];
      pp:=sqrt(sqr(Crd_X[iNode])+sqr(Crd_Y[iNode]));
      ppc:=Crd_X[iNode]/pp;
      pps:=Crd_Y[iNode]/pp;
      gg.re:=gg.re-Result_Xc[iNode].Re*pps+Result_Yc[iNode].Re*ppc;
      gg.im:=gg.im-Result_Xc[iNode].im*pps+Result_Yc[iNode].im*ppc;
      avX:=avX+pp;
    end;
    gg:=CDiv(gg,CConv(4));
    avX:=avX/4;
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-rr);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CMul(aPot[i],CConv(aWeight[i]/sum)));
  res:=CMul(res,CConv(rr));
  if (res.re<>0)or(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*mt.Frequency));
  end
  else
    Result:=CNull;
end;

{================================== Expansion =================================}
procedure TExpansionClass.SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
begin
  gg:=Gag;
  lb:=lab;
  ggb:=Grop;
end;

procedure TExpansionClass.ExpandSolutionEL;
var
  Res:array of float;// векторные потенциалы в пространстве
  i:int;// текущие номера узла (в глобальной дискретизации) и квадрата (в локальной) соответственно
  xp,zp:float;// проекция на плоскость
  A,B:float;
begin
  Res:=nil;
  // выделение памяти под массивы с решением
  SetLength(Res,NPoints+1);
  if nds then
  begin
    lb.Caption:='Expanding solution to 3D area ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  for i:=1 to NPoints do // движемся по узлам 3-хмерной сети
  begin
    zp:=Crd_Z[i];                         // пребразуем координаты в
    if tt.sort_ex=1 then xp:=sqrt(sqr(Crd_X[i])+sqr(Crd_Y[i])) else xp:=Crd_X[i];
    if tt.FindApproximate(xp,zp,A,B) then
      if xp<>0 then Res[i]:=A;
    if (i mod 1000=0) and nds then gg.Progress:=i;
  end;
  // сохранение результатов решения
  a_SaveDataFile('sresult.dat',Res[0],(NPoints+1)*SizeOf(Res[0]));
  Res:=nil;
  if nds then
  begin
    lb.Caption:='Done ...';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TExpansionClass.ExpandSolutionRE;
var
  ResX,ResY,ResZ:array of float;// векторные потенциалы в пространстве
  i:int;// текущие номера узла (в глобальной дискретизации) и квадрата (в локальной) соответственно
  xp,zp:float;// проекция на плоскость
  A,B:float;// потенциалы на границах локального отрезка и их интерполяция
begin
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  // выделение памяти под массивы с решением
  SetLength(ResX,NPoints+1);
  SetLength(ResY,NPoints+1);
  SetLength(ResZ,NPoints+1);
  if nds then
  begin
    lb.Caption:='Expanding solution to 3D area ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  for i:=1 to NPoints do // движемся по узлам 3-хмерной сети
  begin
    zp:=Crd_Z[i];                         // пребразуем координаты в
    if tt.sort_ex=1 then xp:=sqrt(sqr(Crd_X[i])+sqr(Crd_Y[i])) else xp:=Crd_X[i];
    if tt.FindApproximate(xp,zp,A,B) then
      if xp<>0 then
      begin
        if tt.sort_ex=1 then
        begin
          ResX[i]:=-A*Crd_Y[i]/xp;
          ResY[i]:=A*Crd_X[i]/xp;
        end
        else
        begin
          ResX[i]:=0;
          ResY[i]:=A;
        end;
      end;
    if (i mod 1000=0) and nds then gg.Progress:=i;
  end;
  // сохранение результатов решения
  a_SaveDataFile('resultx.dat',ResX[0],(NPoints+1)*SizeOf(ResX[0]));
  a_SaveDataFile('resulty.dat',ResY[0],(NPoints+1)*SizeOf(ResY[0]));
  a_SaveDataFile('resultz.dat',ResZ[0],(NPoints+1)*SizeOf(ResZ[0]));
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  if nds then
  begin
    lb.Caption:='Done ...';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TExpansionClass.ExpandSolutionEC;
var
  ResX,ResY,ResZ:array of TComplex;// векторные потенциалы в пространстве
  i:int;// текущий номер узла (в глобальной дискретизации)
  xp,zp:float;// проекция на плоскость
  B,C:float;
  A:TComplex;// потенциалы на границах локального отрезка и их интерполяция
begin
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  // выделение памяти под массивы с решением
  SetLength(ResX,NPoints+1);
  SetLength(ResY,NPoints+1);
  SetLength(ResZ,NPoints+1);
  if nds then
  begin
    lb.Caption:='Expanding solution to 3D area ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  for i:=1 to NPoints do // движемся по узлам 3-хмерной сети
  begin
    zp:=Crd_Z[i];                         // пребразуем координаты в
    if tt.sort_ex=1 then xp:=sqrt(sqr(Crd_X[i])+sqr(Crd_Y[i])) else xp:=Crd_X[i];
    if tt.FindApproximate(xp,zp,B,C) then
      if xp<>0 then // то линейно  интерполируем потенциал
      begin
        A:=CDConv(B,C);
        if tt.sort_ex=1 then
        begin
          ResX[i]:=CNeg(CMul(A,CConv(Crd_Y[i]/xp)));
          ResY[i]:=CMul(A,CConv(Crd_X[i]/xp));
        end
        else
        begin
          ResX[i]:=CNull;
          ResY[i]:=A;
        end;
      end;
    if (i mod 1000=0)and nds then gg.Progress:=i;
  end;
  // сохранение результатов решения
  a_SaveDataFile('cresultx.dat',ResX[0],(NPoints+1)*SizeOf(ResX[0]));
  a_SaveDataFile('cresulty.dat',ResY[0],(NPoints+1)*SizeOf(ResY[0]));
  a_SaveDataFile('cresultz.dat',ResZ[0],(NPoints+1)*SizeOf(ResZ[0]));
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  if nds then
  begin
    lb.Caption:='Done ...';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;


{==============================================================================}
function GetSignal_Axial_1(imat:int):TComplex;
var
  res:TComplex;
  i,j,k:int;
  xx,zz:float;
  vv:TComplex;
begin        // standard
  res:=CNull;
  j:=0;
  for i:=1 to tt.NTriangles do
  begin
    if tt.Topology[i][0]<>imat then continue;
    inc(j);
    xx:=0;
    zz:=0;
    for k:=1 to 3 do
    begin
      xx:=xx+tt.Nodes[tt.Topology[i][k]][1];
      zz:=zz+tt.Nodes[tt.Topology[i][k]][1];
    end;
    xx:=xx/3;
//    zz:=zz/3;
    vv:=CNull;
    for k:=1 to 3 do vv:=CAdd(vv,TFlatECTask(tt).Vmatr[tt.Topology[i][k]]);
    vv:=CDiv(vv,CConv(3));
    res:=CAdd(res,CMul(vv,CConv(xx)));
  end;
  res:=CDiv(res,CConv(j));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*mt.Frequency));
  end
  else
    Result:=CNull;
end;

function GetSignal_Axial_2(imat:int;rr:float):TComplex;
var
  res:TComplex;
  i,j,k:int;
  vv:TComplex;
  xx,zz:float;
begin  // average sceme
  res:=CNull;
  j:=0;
  for i:=1 to tt.NTriangles do
  begin
    if tt.Topology[i][0]<>imat then continue;
    inc(j);
    vv:=CNull;
    for k:=1 to 3 do vv:=CAdd(vv,TFlatECTask(tt).Vmatr[tt.Topology[i][k]]);
    vv:=CDiv(vv,CConv(3));
    tt.GetCenter(i,xx,zz);
    if xx<0 then vv:=CNeg(vv);
    res:=CAdd(res,vv);
//    res:=CSub(res,vv);
  end;
  res:=CDiv(res,CConv(j));
  res:=CMul(res,CConv(rr));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*mt.Frequency));
  end
  else
    Result:=CNull;
end;

function GetSignal_3D_1(imat:int;rr:float):TComplex;
var
  res,gg:TComplex;
  i,j,k:int;
  pp:float;
  iNode:int;
  ppc,pps:float;
begin  // average sceme
  res:=CNull;
  j:=0;
  for i:=1 to NElements do
  begin
    if ATopology[i][0]<>imat then continue;
    inc(j);
    gg:=CNull;
    for k:=1 to 4 do
    begin
      iNode:=ATopology[i][k];
      pp:=sqrt(sqr(Crd_X[iNode])+sqr(Crd_Y[iNode]));
      ppc:=Crd_X[iNode]/pp;
      pps:=Crd_Y[iNode]/pp;
      gg.re:=gg.re-(Result_Xc[iNode].re*pps-Result_Yc[iNode].re*ppc);
      gg.im:=gg.im-(Result_Xc[iNode].im*pps-Result_Yc[iNode].im*ppc);
    end;
    gg:=CDiv(gg,CConv(4));
    res:=CAdd(res,gg);
  end;
  res:=CDiv(res,CConv(j));
  res:=CMul(res,CConv(rr));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*mt.Frequency));
  end
  else
    Result:=CNull;
end;

function GetSignal_3D_2(imat:int;var secs:array of int; num:int):TComplex;
Type
  Vect3=record
          x,y,z:TComplex;
        end;
var
  res:TComplex;
  iElement,i,j,k:int;
  x,y,z,r,p:float;
  vv:Vect3;
  N:int;
  a,b,c,d:mxtyp3;
  volume:float;

  function Det(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
  begin
    Result:=a1*(b2*c3-c2*b3)-b1*(a2*c3-c2*a3)+c1*(a2*b3-b2*a3)
  end;

  procedure ElementMatrix(iElement:Int);
  var
    x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4:float;
  begin
    {Вызов координат вершин тетраэдра с номером iElement}
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
    {Определение коэффициентов матрицы конечного элемента}
    a[1]:= Det(x2,y2,z2,x3,y3,z3,x4,y4,z4);
    b[1]:=-Det(1,y2,z2,1,y3,z3,1,y4,z4);
    c[1]:= Det(1,x2,z2,1,x3,z3,1,x4,z4);
    d[1]:=-Det(1,x2,y2,1,x3,y3,1,x4,y4);

    a[2]:=-Det(x1,y1,z1,x3,y3,z3,x4,y4,z4);
    b[2]:= Det(1,y1,z1,1,y3,z3,1,y4,z4);
    c[2]:=-Det(1,x1,z1,1,x3,z3,1,x4,z4);
    d[2]:= Det(1,x1,y1,1,x3,y3,1,x4,y4);

    a[3]:= Det(x1,y1,z1,x2,y2,z2,x4,y4,z4);
    b[3]:=-Det(1,y1,z1,1,y2,z2,1,y4,z4);
    c[3]:= Det(1,x1,z1,1,x2,z2,1,x4,z4);
    d[3]:=-Det(1,x1,y1,1,x2,y2,1,x4,y4);

    a[4]:=-Det(x1,y1,z1,x2,y2,z2,x3,y3,z3);
    b[4]:= Det(1,y1,z1,1,y2,z2,1,y3,z3);
    c[4]:=-Det(1,x1,z1,1,x2,z2,1,x3,z3);
    d[4]:= Det(1,x1,y1,1,x2,y2,1,x3,y3);
    {Расчет объема тетраэдра}
    Volume:=(a[1]+a[2]+a[3]+a[4])/6.0;
  end; { ElementMatrix  }


  function GetWhere(i:int;x,y,z:float):int;
  var x1,x2,y1,y2,z1,z2:float;
  begin
    x1:=Crd_X[ATopology[6*i-5][1]];
    y1:=Crd_Y[ATopology[6*i-5][1]];
    z1:=Crd_Z[ATopology[6*i-5][1]];
    x2:=Crd_X[ATopology[6*i][4]];
    y2:=Crd_Y[ATopology[6*i][4]];
    z2:=Crd_Z[ATopology[6*i][4]];
    if (x-x1)*(y2-y1)>(y-y1)*(x2-x1) then {1,3,5}
    begin
      if (y-y1)*(z1-z2)>(z-z2)*(y2-y1) then {5}
        Result:=5
      else
      begin
        if (x-x1)*(z1-z2)<(z-z2)*(x2-x1) then {1}
          Result:=1
        else {3}
          Result:=3;
      end
    end
    else {2,4,6}
    begin
      if (y-y1)*(z1-z2)<(z-z2)*(y2-y1) then {2}
        Result:=2
      else
      begin
        if (x-x1)*(z1-z2)>(z-z2)*(x2-x1) then {6}
          Result:=6
        else {4}
          Result:=4;
      end
    end;
  end;

  function GetTetrahedral(x,y,z:float; mm:int):int;
  var cx,cy,cz,k,iCube:int;
  begin
    cx:=axa.coord2NQuad(x-axa.ax,axa.disc_1,axa.nd1);
    cy:=axa.coord2NQuad(y-axa.ay,axa.disc_2,axa.nd2);
    cz:=axa.coord2NQuad(z-axa.az,axa.disc_3,axa.nd3);
    iCube:=axa.Num2Cube(cx,cy,cz);
    k:=GetWhere(iCube,x,y,z);
    Result:=(iCube-1)*6+k;
  end;

  function ApproximA(i:integer;x,y,z:float):Vect3;
  var k:int;
      aa,bb,cc:TComplex;
  begin
    aa:=CNull;
    bb:=CNull;
    cc:=CNull;
    for k:=1 to 4 do
    begin
      aa:=CAdd(aa,CMul(Result_Xc[ATopology[i][k]],CConv((a[k]+b[k]*x+c[k]*y+d[k]*z)/(6*Volume))));
      bb:=CAdd(bb,CMul(Result_Yc[ATopology[i][k]],CConv((a[k]+b[k]*x+c[k]*y+d[k]*z)/(6*Volume))));
      cc:=CAdd(cc,CMul(Result_Zc[ATopology[i][k]],CConv((a[k]+b[k]*x+c[k]*y+d[k]*z)/(6*Volume))));
    end;
    Result.x:=aa;
    Result.y:=bb;
    Result.z:=cc;
  end;

begin
  res:=CNull;
  for N:=1 to Num do
    for i:=1 to 10 do
      for j:=1 to 10 do
      begin
        with TSector(ob.Items[secs[N]]) do
        begin
          z:=zz+h/(20)+(j-1)*h/10;
          r:=r1+(r2-r1)/20+(i-1)*(r2-r1)/10;
        end;
        for k:=1 to 10 do
        begin
          p:=4.5+(k-1)*9;
          x:=r*cos(pi*p/180);
          y:=r*sin(pi*p/180);
          iElement:=GetTetrahedral(x,y,z,imat);
          if iElement=-1 then exit;
          ElementMatrix(iElement);
          vv:=ApproximA(iElement,x,y,z);
          res.re:=res.re-vv.x.re*sin(pi*p/180)+vv.y.re*cos(pi*p/180);
          res.im:=res.im-vv.x.im*sin(pi*p/180)+vv.y.im*cos(pi*p/180);
        end;
        res:=CMul(res,CConv(2*pi*r));
      end;
  res:=CDiv(res,CConv(100));
  if (res.re<>0)or(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,2*pi*mt.Frequency));
  end
  else
    Result:=CNull;
end;


constructor TExpansionClass.Create;
begin
  Inherited create;
  nds:=true;
end;

end.


(*
function TFlatSSTask.GetSignal_Axial3(imat:int; nnr,nnz:int):TComplex;
var
  res:TComplex;
  i,j,k:int;
  xx,zz:float;
  vv,gg:float;
  aWeight:array of float;
  sum:float;
  aPot:array of float;
  avX:float;
begin
  res:=CNull;
  with SectorJ[imat,1] do xx:=r_min+(r_max-r_min)/2;
  vv:=0;
  aWeight:=nil;
  aPot:=nil;
  j:=0;
  for i:=1 to NTriangles do
  begin
    if TopoMater[i]<>imat then continue;
    inc(j);
    gg:=0;
    avX:=0;
    for k:=1 to 3 do
    begin
      avX:=avX+Nodes[Topology[i][k]].x;
      gg:=gg+Vmatr[Topology[i][k]];
    end;
    avX:=avX/3;
    gg:=gg/3;
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-xx);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CConv(aPot[i]*aWeight[i]/sum));

  res:=CMul(res,CConv(xx));
  aPot:=nil;
  aWeight:=nil;
  res:=CMul(res,CConv(1e10));
  if (res.re<>0)or(res.im<>0) then
  begin
    Result:=res;//,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;


{==============================================================================}
{===============================  External  ===================================}
{==============================================================================}
function TFlatECTask.GetSignal_Axial(imat:integer; nnr,nnz:integer):TComplex;
var
  res:TComplex;
  i,j:integer;
  xx,zz:MyRealType;
  vv:TComplex;
begin
  res:=CNull;
  for i:=1 to NTriangles do
  begin
    if TopoMater[i]<>imat then continue;
    GetCenter(i,xx,zz);
    vv:=CNull;
    for j:=1 to 3 do vv:=CAdd(vv,Vmatr[Topology[i][j]]);
    vv:=CDiv(vv,CConv(3));
    res:=CAdd(res,CMul(vv,CConv(xx)));
  end;
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;

function TFlatECTask.GetSignal_Axial2(imat:integer; nnr,nnz:integer):TComplex;
var
  res:TComplex;
  i,j,k:integer;
  xx,zz:MyRealType;
  vv:TComplex;
begin
  res:=CNull;
  with SectorJ[imat,1] do xx:=r_min+(r_max-r_min)/2;
  j:=0;
  for i:=1 to NTriangles do
  begin
    if TopoMater[i]<>imat then continue;
    inc(j);
    vv:=CNull;
    for k:=1 to 3 do vv:=CAdd(vv,Vmatr[Topology[i][k]]);
    vv:=CDiv(vv,CConv(3));
    res:=CAdd(res,vv);
  end;
  res:=CMul(res,CConv(xx));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;

function TFlatECTask.GetSignal_Axial3(imat:integer; nnr,nnz:integer):TComplex;
var
  res:TComplex;
  i,j,k:integer;
  xx,zz:MyRealType;
  vv,gg:TComplex;
  aWeight:array of MyRealType;
  sum:MyrealType;
  aPot:array of TComplex;
  avX:MyrealType;
begin
  res:=CNull;
  with SectorJ[imat,1] do xx:=r_min+(r_max-r_min)/2;
  vv:=CNull;
  aWeight:=nil;
  aPot:=nil;
  j:=0;
  for i:=1 to NTriangles do
  begin
    if TopoMater[i]<>imat then continue;
    inc(j);
    gg:=CNull;
    avX:=0;
    for k:=1 to 3 do
    begin
      avX:=avX+Nodes[Topology[i][k]].x;
      gg:=CAdd(gg,Vmatr[Topology[i][k]]);
    end;
    avX:=avX/3;
    gg:=CDiv(gg,CConv(3));
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-xx);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CMul(aPot[i],CConv(aWeight[i]/sum)));

  res:=CMul(res,CConv(xx));
  aPot:=nil;
  aWeight:=nil;
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;

function TFlatECTask.GetSignal_Axial4(imat:integer; nnr,nnz:integer):TComplex;
var
  res:TComplex;
  i,j,N,Num,iTriangle:integer;
  xx,zz:MyRealType;
  vv:TComplex;
  a,b,c:mxtyp2;
  RAverage,area:MyRealType;

  function GetWhere(sq:integer;x,z:MyRealType):integer;
  var x1,x2:MyRealType;
      z1,z2:MyRealType;
  begin
    x1:=Nodes[Topology[2*sq-1][3]].x;
    x2:=Nodes[Topology[2*sq-1][2]].x;
    z1:=Nodes[Topology[2*sq-1][3]].z;
    z2:=Nodes[Topology[2*sq-1][2]].z;
    if (x-x2)<((x1-x2)/(z1-z2)*(z-z2)) then
      Result:=1
    else
      Result:=2;
  end;

  function GetTriangle(x,z:myRealType;mm:integer):integer;
  var qx,qz,j,k:integer;
  begin
    qx:=Trunc(x/Plane.hx)+1;
    qz:=Trunc((z-Plane.z0)/Plane.hz)+1;
    j:=Num2Quad(qx,qz);
    if (0<j)and(j<=(NTriangles div 2)) then
    begin
      k:=GetWhere(j,x,z);
      if k=1 then Result:=2*j-1 else Result:=2*j;
    end;
  end;

  function ApproximA(i:integer; x,z:MyRealType):TComplex;
  var l:integer;
      t:TComplex;
  begin
    t:=CNull;
    for l:=1 to 3 do
    begin
      t:=CAdd(t,CMul(Vmatr[Topology[i][l]],CConv((a[l]+b[l]*x+c[l]*z)/(2*area))))
    end;
    Result:=t;
  end;

begin
  res:=CNull;
  Num:=NSectorsJ[imat];

  for N:=1 to Num do
    for i:=1 to nnr do
      for j:=1 to nnz do
      begin
        with SectorJ[imat,N] do
        begin
          zz:=z+h/(2*nnz)+(j-1)*h/nnz;
          xx:=r_min+(r_max-r_min)/(2*nnr)+(i-1)*(r_max-r_min)/nnr;
        end;
        iTriangle:=GetTriangle(xx,zz,imat);
        ElementMatrix(iTriangle,area,rAverage,a,b,c);
        vv:=ApproximA(iTriangle,xx,zz);

        res:=CAdd(res,CMul(vv,CConv(2*pi*xx)));
      end;

  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,2*pi*Frequency));
  end
  else
    Result:=CNull;
end;


  *)

(*
function TFlatECTask.GetSignal_Axial3(imat:integer; nnr,nnz:integer):TComplex;
var
  p1,p2,p3:TComplex;
  x1,y1,x2,y2:MyRealType;
  al,bt,gm:TComplex;
  bb,kk:MyRealType;

  a,b,c:mxtyp2;
  RAverage,area:MyRealType;
  iNode:Integer;

  res:TComplex;
  i,j,k:integer;
  xx,zz:MyRealType;
  vv,gg:TComplex;
  aWeight:array of MyRealType;
  sum:MyrealType;
  aPot:array of TComplex;
  avX:MyrealType;
begin
  res:=CNull;
  with SectorJ[imat,1] do xx:=r_min+(r_max-r_min)/2;
  vv:=CNull;
  aWeight:=nil;
  aPot:=nil;
  j:=0;


  for i:=1 to NTriangles do
  begin
    if Topology[i].mater<>imat then continue;

    ElementMatrix(i,area,raverage,a,b,c);

    al:=CNull;
    bt:=CNull;
    gm:=CNull;
    for k:=1 to 3 do
    begin
      iNode:=Topology[i].nodes[k];
      al:=CAdd(al,CMul(Vmatr[iNode],CConv(a[k])));
      bt:=CAdd(bt,CMul(Vmatr[iNode],CConv(b[k])));
      gm:=CAdd(gm,CMul(Vmatr[iNode],CConv(c[k])));
    end;



  end;



  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CMul(aPot[i],CConv(aWeight[i]/sum)));

  res:=CMul(res,CConv(xx));
  aPot:=nil;
  aWeight:=nil;
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;



function TfmControlCenter.GetSignal_3D_a(imat:integer):TComplex;
var
  res,gg:TComplex;
  i,j,k:integer;
  rr,pp:MyRealType;
  iNode:integer;
  ppc,pps:MyRealType;
  aPot:array of TComplex;
  aWeight:array of MyRealType;
  sum,avX:MyRealType;
begin
  res:=CNull;
  with SectorJ[imat,1] do rr:=r_min+(r_max-r_min)/2;
  j:=0;
  for i:=1 to NElements do
  begin
    if ATopology[i].material<>imat then continue;
    inc(j);
    gg:=CNull;
    avX:=0;
    for k:=1 to 4 do
    begin
      iNode:=ATopology[i].nodes[k];
      pp:=sqrt(sqr(Crd_X[iNode])+sqr(Crd_Y[iNode]));
      ppc:=Crd_X[iNode]/pp;
      pps:=Crd_Y[iNode]/pp;
      gg.re:=gg.re-Result_Xc[iNode].re*pps+Result_Yc[iNode].re*ppc;
      gg.im:=gg.im-Result_Xc[iNode].im*pps+Result_Yc[iNode].im*ppc;
      avX:=avX+pp;
    end;
    gg:=CDiv(gg,CConv(4));
    avX:=avX/4;
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-rr);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CMul(aPot[i],CConv(aWeight[i]/sum)));
  res:=CMul(res,CConv(rr));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;

function TfmControlCenter.GetSignal_3D_b(imat:integer):TComplex;
Type
  Vect3=record
          x,y,z:TComplex;
        end;
var
  res:TComplex;
  iElement,i,j,k:integer;
  xx,yy,zz,rr,pp:MyRealType;
  dl:MyRealType;
  vv:Vect3;
  N,Num:integer;

  function GetWhere(i:integer;x,y,z:MyRealType):integer;
  var x1,x2,y1,y2,z1,z2:MyRealType;
  begin
    x1:=Crd_X[ATopology[6*i-5].nodes[1]];
    y1:=Crd_Y[ATopology[6*i-5].nodes[1]];
    z1:=Crd_Z[ATopology[6*i-5].nodes[1]];
    x2:=Crd_X[ATopology[6*i].nodes[4]];
    y2:=Crd_Y[ATopology[6*i].nodes[4]];
    z2:=Crd_Z[ATopology[6*i].nodes[4]];
    if (x-x1)*(y2-y1)>(y-y1)*(x2-x1) then {1,3,5}
    begin
      if (y-y1)*(z1-z2)>(z-z2)*(y2-y1) then {5}
        Result:=5
      else
      begin
        if (x-x1)*(z1-z2)<(z-z2)*(x2-x1) then {1}
          Result:=1
        else {3}
          Result:=3;
      end
    end
    else {2,4,6}
    begin
      if (y-y1)*(z1-z2)<(z-z2)*(y2-y1) then {2}
        Result:=2
      else
      begin
        if (x-x1)*(z1-z2)>(z-z2)*(x2-x1) then {6}
          Result:=6
        else {4}
          Result:=4;
      end
    end;
  end;

  function GetTetrahedral(x,y,z:MyRealType; mm:integer):integer;
  var cx,cy,cz,k,iCube:integer;
  begin
    cx:=CoordXToStepXNumber(x);
    cy:=CoordYToStepYNumber(y);
    cz:=CoordZToStepZNumber(z);
    iCube:=cx+(cy-1)*(nx-1)+(cz-1)*(nx-1)*(ny-1);
    k:=GetWhere(iCube,x,y,z);
    Result:=(iCube-1)*6+k;
  end;

  function ApproximA(i:integer;x,y,z:MyRealType):Vect3;
  var l:integer;
      aa,bb,cc:TComplex;
  begin
    aa:=CNull;
    bb:=CNull;
    cc:=CNull;
    for l:=1 to 4 do
    begin
      aa:=CAdd(aa,CMul(Result_Xc[ATopology[i].nodes[l]],CConv((a[1]+b[1]*x+c[1]*y+d[1]*z)/(6*Volume))));
      bb:=CAdd(bb,CMul(Result_Yc[ATopology[i].nodes[l]],CConv((a[l]+b[l]*x+c[l]*y+d[l]*z)/(6*Volume))));
      cc:=CAdd(cc,CMul(Result_Zc[ATopology[i].nodes[l]],CConv((a[l]+b[l]*x+c[l]*y+d[l]*z)/(6*Volume))));
    end;
    Result.x:=aa;
    Result.y:=bb;
    Result.z:=cc;
  end;

begin
  res:=CNull;
  Num:=NSectorsJ[imat];

  for N:=1 to Num do
    for i:=1 to num_r do
      for j:=1 to num_z do
        for k:=1 to num_fi do
        begin
          with SectorJ[imat,N] do
          begin
            zz:=z+h/(2*num_z)+(j-1)*h/num_z;
            rr:=r_min+(r_max-r_min)/(2*num_r)+(i-1)*(r_max-r_min)/num_r;
            pp:=90/(2*num_fi)+(k-1)*90/num_fi;
          end;
          xx:=rr*cos(pi*pp/180);
          yy:=rr*sin(pi*pp/180);
          iElement:=GetTetrahedral(xx,yy,zz,imat);
          if iElement=-1 then exit;
          ElementMatrix(iElement);
          vv:=ApproximA(iElement,xx,yy,zz);
          dl:=pi*rr/(2*num_fi);
          res.re:=res.re+dl*(-vv.x.re*sin(pi*pp/180)+vv.y.re*cos(pi*pp/180));
          res.im:=res.im+dl*(-vv.x.im*sin(pi*pp/180)+vv.y.im*cos(pi*pp/180));
        end;
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,2*pi*Frequency*4{90--360}));
  end
  else
    Result:=CNull;
end;

function TfmControlCenter.GetSignal_3D_c(imat:integer):TComplex;
var
  res,gg:TComplex;
  i,j,k:integer;
  rr,pp:MyRealType;
  iNode:integer;
  ppc,pps:MyRealType;
begin
  res:=CNull;
  with SectorJ[imat,1] do rr:=r_min+(r_max-r_min)/2;
  j:=0;
  for i:=1 to NElements do
  begin
    if ATopology[i].material<>imat then continue;
    inc(j);
    gg:=CNull;
    for k:=1 to 4 do
    begin
      iNode:=ATopology[i].nodes[k];
      pp:=sqrt(sqr(Crd_X[iNode])+sqr(Crd_Y[iNode]));
      ppc:=Crd_X[iNode]/pp;
      pps:=Crd_Y[iNode]/pp;
      gg.re:=gg.re-Result_Xc[iNode].re*pps+Result_Yc[iNode].re*ppc;
      gg.im:=gg.im-Result_Xc[iNode].im*pps+Result_Yc[iNode].im*ppc;
    end;
    gg:=CDiv(gg,CConv(4));
    res:=CAdd(res,gg);
  end;
  res:=CDiv(res,CConv(j));
  res:=CMul(res,CConv(rr));
  if (res.re<>0)and(res.im<>0) then
  begin
    Result:=CMul(res,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;

function TfmControlCenter.GetSignal_3D_ss(imat:integer):TComplex;
var
  res:TComplex;
  i,j,k:integer;
  rr,pp,gg:MyRealType;
  iNode:integer;
  ppc,pps:MyRealType;
  aPot:array of MyRealType;
  aWeight:array of MyRealType;
  sum,avX:MyRealType;
begin
  res:=CNull;
  with SectorJ[imat,1] do rr:=r_min+(r_max-r_min)/2;
  j:=0;
  for i:=1 to NElements do
  begin
    if ATopology[i].material<>imat then continue;
    inc(j);
    gg:=0;
    avX:=0;
    for k:=1 to 4 do
    begin
      iNode:=ATopology[i].nodes[k];
      pp:=sqrt(sqr(Crd_X[iNode])+sqr(Crd_Y[iNode]));
      ppc:=Crd_X[iNode]/pp;
      pps:=Crd_Y[iNode]/pp;
      gg:=gg-Result_X[iNode]*pps+Result_Y[iNode]*ppc;
      avX:=avX+pp;
    end;
    gg:=gg/4;
    avX:=avX/4;
    SetLength(aWeight,j+1);
    SetLength(aPot,j+1);
    aWeight[j]:=abs(avX-rr);
    aPot[j]:=gg;
  end;
  sum:=0;
  for i:=1 to j do sum:=sum+aWeight[j];
  for i:=1 to j do res:=CAdd(res,CConv(aPot[i]*aWeight[i]/sum));
  res:=CMul(res,CConv(rr));
  aWeight:=nil;
  aPot:=nil;
  res:=CMul(res,CConv(1e10));
  if (res.re<>0)or(res.im<>0) then
  begin
    Result:=res;//,CDConv(0,4*sqr(pi)*Frequency));
  end
  else
    Result:=CNull;
end;
 *)
