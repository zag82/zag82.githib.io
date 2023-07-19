unit comp_vec;

interface

uses cm_ini, ComPlx, cmVars, cmData;

var
  M_X:float;
  M_Z:float;
  FD_X:float;
  FD_Z:float;
  HIn_X:float;
  HIn_Z:float;
  avRes:float;
  mu_rel:float;

  cFD_X:TComplex;
  cFD_Z:TComplex;
  cHIn_X:TComplex;
  cHIn_Z:TComplex;
  cavRes:TComplex;

procedure ComputeVec_sc(iElement:int);
procedure ComputeVec_re(iElement:int);
procedure ComputeVec_ec(iElement:int);

implementation

uses common_main2d, el_main2d, ss_main2d, ec_main2d;

var
  a,b,c:mxtyp2;
  rav,ar:float;

procedure ComputeVec_sc(iElement:int);
var i:int;
    im:int;
    tmp:float;
begin
  FD_X:=0;
  FD_Z:=0;
  HIn_X:=0;
  HIn_Z:=0;
  avRes:=0;
  mu_rel:=0;
  im:=tt.Topology[iElement][0];
  tt.ElementMatrix(iElement,ar,rav,a,b,c);
  for i:=1 to 3 do
  begin
    tmp:=TFlatELTask(tt).vMatr[tt.Topology[iElement][i]];
    avRes:=avRes+tmp;
    HIn_X:=HIn_X-b[i]*tmp;
    HIn_Z:=HIn_Z-c[i]*tmp;
  end;
  avRes:=avRes/3;
  tmp:=mt.Prop(iElement,im);
  mu_rel:=tmp/mu0;
  HIn_X:=HIn_X/2/ar;
  HIn_Z:=HIn_Z/2/ar;
  FD_X:=HIn_X*tmp/mt.Anisotropy_X[im];
  FD_Z:=HIn_Z*tmp/mt.Anisotropy_Z[im];
  
end;

procedure ComputeVec_re(iElement:int);
var i:int;
    im:int;
    tmp:float;
begin
  FD_X:=0;
  FD_Z:=0;
  HIn_X:=0;
  HIn_Z:=0;
  avRes:=0;
  mu_rel:=0;
  im:=tt.Topology[iElement][0];
  tt.ElementMatrix(iElement,ar,rav,a,b,c);
  for i:=1 to 3 do
  begin
    tmp:=TFlatSSTask(tt).vMatr[tt.Topology[iElement][i]];
    avRes:=avRes+tmp;
    FD_X:=FD_X-c[i]*tmp;
    FD_Z:=FD_Z+b[i]*tmp;
  end;
  avRes:=avRes/3;
  /////
  tmp:=mt.Prop(iElement,im);
  mu_rel:=1/(mu0*tmp);
  /////
  FD_X:=FD_X/2/ar;
  FD_Z:=FD_Z/2/ar;
  HIn_X:=FD_X*tmp/mt.Anisotropy_X[im];
  HIn_Z:=FD_Z*tmp/mt.Anisotropy_Z[im];

end;

procedure ComputeVec_ec(iElement:int);
var i:int;
    im:int;
    tp:float;
    tmp:TComplex;
begin
  cFD_X:=CNull;
  cFD_Z:=CNull;
  cHIn_X:=CNull;
  cHIn_Z:=CNull;
  cavRes:=CNull;
  ////
  im:=tt.Topology[iElement][0];
  tt.ElementMatrix(iElement,ar,rav,a,b,c);
  for i:=1 to 3 do
  begin
    tmp:=TFlatECTask(tt).vMatr[tt.Topology[iElement][i]];
    cavRes:=CAdd(cavRes,tmp);
    cFD_X:=CSub(cFD_X,CMul(CConv(c[i]),tmp));
    cFD_Z:=CAdd(cFD_Z,CMul(CConv(b[i]),tmp));
  end;
  cavRes:=CDiv(cavRes,CConv(3));
  /////
  tp:=mt.Prop(iElement,im);
  /////
  cFD_X:=CDiv(cFD_X,CConv(2*ar));
  cFD_Z:=CDiv(cFD_Z,CConv(2*ar));
  cHIn_X:=CMul(cFD_X,CConv(tp/mt.Anisotropy_X[im]));
  cHIn_Z:=CMul(cFD_Z,CConv(tp/mt.Anisotropy_Z[im]));
end;

end.
