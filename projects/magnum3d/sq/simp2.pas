unit simp2;

interface

uses god2;

type
  TSimplex=class
  private
    done:boolean;      // окончание итераций
    h:vic;             // худшая точка
    l:vic;             // лучшая точка
    maxiter:integer;   // максимум итераций
    next:vector;       // следующая точка
    center:vector;     // центр симплекса
    maxerr:vector;     // предел допустимой погрешности для каждой точки симплекса
    step:vector;       // шаг по каждому из измерений
    simp:array[1..n]of vector;  // собственно симплекс
    procedure GetF(var x:vector);
    procedure new_vertex;
    procedure order;
  public
    mmax:double;
    niter:integer;     // текущее количество итераций
    mean:vector;       // результат вычислений
    error:vector;      // погрешность для каждой вершины
    constructor Create(mi:integer;crd,stp,err:vector); // конструктор
    procedure Optimize;                                // запуск симплексного алгоритма
    procedure CalcRes;                                 // генерация результата
  end;

var
  sx:TSimplex;

implementation

uses sysutils, optim;

procedure TSimplex.GetF(var x:vector);
var vv:double;
    i:integer;
begin
  // проверка границ
  for i:=1 to m do
  begin
    if x[i]<0 then x[i]:=step[i];
    if x[i]>mmax then x[i]:=mmax;
  end;
  // изменение профиля
  opt.profile:=x;
  opt.ApplyToObject;
  opt.RunSolver;
  opt.LoadFiles;
  vv:=opt.GetError;
  x[n]:=vv;
end;

procedure TSimplex.CalcRes;
var i,j:integer;
begin
  for i:=1 to n do
  begin
    mean[i]:=0.0;
    for j:=1 to n do
      mean[i]:=mean[i]+simp[j,i];
    mean[i]:=mean[i]/n;
  end;
//  for i:=1 to n do mean[i]:=simp[l[n],i]
end;

constructor TSimplex.Create(mi:integer;crd,stp,err:vector);
var i:integer;
begin
  maxiter:=mi;
  for i:=1 to m do simp[1,i]:=crd[i];
  for i:=1 to m do step[i]:=stp[i];
  for i:=1 to n do maxerr[i]:=err[i];
  Inherited create;
end;

procedure TSimplex.new_vertex;
var i:integer;
begin
  for i:=1 to n do
    simp[h[n],i]:=next[i];
end;

procedure TSimplex.order;
var i,j:integer;
begin
  for i:=1 to n do
    for j:=1 to n do
    begin
      if simp[i,j]<simp[l[j],j] then l[j]:=i;
      if simp[i,j]>simp[h[j],j] then h[j]:=i;
    end;
end;

procedure TSimplex.Optimize;
var i,j:integer;
    p,q:vector;
    f:TextFile;
    t1:TDateTime;
begin
  t1:=Time;
  AssignFile(f,'calc.log');
  Rewrite(f);
  Writeln(f,'Calculations time');
  writeln(f);
  CloseFile(f);
  //////////////
  GetF(simp[1]);
  for i:=1 to m do
  begin
    p[i]:=step[i]*(sqrt(n)+m-1)/(m*sqrt(2));
    q[i]:=step[i]*(sqrt(n)-1)/(m*sqrt(2));
  end;
  for i:=2 to n do
  begin
    for j:=1 to m do simp[i,j]:=simp[1,j]+q[j];
    simp[i,i-1]:=simp[i,i-1]+{step[i-1]}p[i-1];
    GetF(simp[i]);
  end;
  for i:=1 to n do
  begin
    l[i]:=1;
    h[i]:=1;
  end;
  order;
  niter:=0;
  CalcRes;
  ////////
{  with fmOp2d do
  begin
    Series1.Clear;
    for i:=1 to m do
      Series1.AddXY(i,mean[i]*1e3);
    Chart1.Refresh;
    Label13.Caption:=IntToStr(niter);
    Label14.Caption:=FloatToStrF(mean[n],ffGeneral,7,7);
    Label15.Caption:=FloatToStrF(error[n],ffGeneral,7,7);
    gbb.Refresh;
  end;    }
  ////////
  repeat
    done:=true;
    niter:=niter+1;
    for i:=1 to n do center[i]:=0.0;
    for i:=1 to n do
      if i<>h[n] then
        for j:=1 to m do
          center[j]:=center[j]+simp[i,j];
    for i:=1 to n do
    begin
      center[i]:=center[i]/m;
      next[i]:=(1.0+alfa)*center[i]-alfa*simp[h[n],i];
    end;
    GetF(next);
    if next[n]<=simp[l[n],n] then
    begin
      new_vertex;
      for i:=1 to m do
        next[i]:=gamma*simp[h[n],i]+(1.0-gamma)*center[i];
      GetF(next);
      if next[n]<=simp[l[n],n] then new_vertex;
    end
    else
    begin
      if next[n]<=simp[h[n],n] then
        new_vertex
      else
      begin
        for i:=1 to m do
          next[i]:=beta*simp[h[n],i]+(1.0-beta)*center[i];
        GetF(next);
        if next[n]<=simp[h[n],n] then
          new_vertex
        else
        begin
          for i:=1 to n do
          begin
            for j:=1 to m do
              simp[i,j]:=(simp[i,j]+simp[l[n],j])*beta;
            GetF(simp[i]);
          end;
        end;
      end
    end;
    order;
    for j:=1 to n do
    begin
      error[j]:=(simp[h[j],j]-simp[l[j],j]){/simp[h[j],j]};
      if done then
        if error[j]>maxerr[j] then done:=false;
    end;
    CalcRes;
    ////////
{    with fmOp2d do
    begin
      Series1.Clear;
      for i:=1 to m do
        Series1.AddXY(i,mean[i]*1e3);
      Chart1.Refresh;
      Label13.Caption:=IntToStr(niter);
      Label14.Caption:=FloatToStrF(mean[n],ffGeneral,7,7);
      Label15.Caption:=FloatToStrF(error[n],ffGeneral,7,7);
      gbb.Refresh;
    end;       }
    ////////
    Append(f);
    write(f,niter:5,'. ',TimeToStr(t1-Time));
    for i:=1 to m do
      write(f,' ',1e3*mean[i]:5:3);
    write(f,#09,mean[n]:14);
    writeln(f);
    closeFile(f);
  until (done or (niter>=maxiter));
end;

end.
