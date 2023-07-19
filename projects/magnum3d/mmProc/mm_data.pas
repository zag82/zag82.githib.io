unit mm_data;

interface

uses cm_ini, cmdata, cmvars;

type
  TOutStruct=record
    dr:boolean;
    name:st80;
    val:int;
  end;

  TPack=record
    obj:int;
    sort:int;
    prop:int;
    nVars:int;
    vars:array of float;
  end;

  TMultiPack=class
  private
    { ============ }
  public
    num:int;
    nMulti:array of int;
    vMulti:array of array of TPack;
    numGage:int;
    vGage:array of int;
    bTopology:boolean;
    solMet:int;
    outPath:st80;
    outStyle:int;
    outName:array of TOutStruct;
    ////////////////////
    constructor Create;
    procedure Delete;
    ////////////////////
    procedure ChangeNum;
    procedure AddPack(iChange,iSort,iObj,iProp:int);
    function GetValue(iSort,iObj,iProp:int):float;
    procedure SetValue(n1,n2,k:int);
    function GetValS(n1,n2,k,vl:int):string;
  end;

Var
  mp:TMultiPack;

procedure MultiSave(fName:string);
procedure MultiLoad(fName:string);

implementation

uses sysutils;

constructor TMultiPack.Create;
begin
  inherited create;
  bTopology:=false;
  solMet:=1;
  outPath:='';
  outStyle:=1;
  ///////
  num:=1;
  SetLength(nMulti,num+1);
  SetLength(vMulti,num+1);
  SetLength(outName,num);
  nmulti[1]:=0;
  SetLength(vMulti[1],nMulti[1]+1);
  numGage:=0;
  SetLength(vGage,1);
end;

procedure TMultiPack.Delete;
begin
  nMulti:=nil;
  vMulti:=nil;
  vGage:=nil;
  outName:=nil;
end;

procedure TMultiPack.ChangeNum;
var i:int;
begin
  SetLength(outName,num);
  SetLength(nMulti,num+1);
  SetLength(vMulti,num+1);
  for i:=1 to num do if nMulti[i]=0 then SetLength(vMulti[i],1);
end;

procedure TMultiPack.AddPack(iChange,iSort,iObj,iProp:int);
var k:int;
begin
  nMulti[iChange]:=nMulti[iChange]+1;
  SetLength(vMulti[iChange],nMulti[iChange]+1);
  vMulti[iChange][nMulti[iChange]].sort:=iSort;
  vMulti[iChange][nMulti[iChange]].obj:=iObj;
  vMulti[iChange][nMulti[iChange]].prop:=iProp;
  with vMulti[iChange][nMulti[iChange]] do
  Case iSort of
    1:begin
        if nMulti[iChange]>1 then nvars:=vMulti[iChange][1].nVars
        else nVars:=1;
        SetLength(Vars,nVars+1);
        if TMGObject(ob.Items[iObj]) is TBlock then
          Case iProp of
            1:vars[nvars]:=TBlock(ob.Items[iObj]).x_1;
            2:vars[nvars]:=TBlock(ob.Items[iObj]).y_1;
            3:vars[nvars]:=TBlock(ob.Items[iObj]).z_1;
            4:vars[nvars]:=TBlock(ob.Items[iObj]).x_2;
            5:vars[nvars]:=TBlock(ob.Items[iObj]).y_2;
            6:vars[nvars]:=TBlock(ob.Items[iObj]).z_2;
          end
        else
          case iProp of
            1:vars[nvars]:=TSector(ob.Items[iObj]).xx;
            2:vars[nvars]:=TSector(ob.Items[iObj]).yy;
            3:vars[nvars]:=TSector(ob.Items[iObj]).zz;
            4:vars[nvars]:=TSector(ob.Items[iObj]).r1;
            5:vars[nvars]:=TSector(ob.Items[iObj]).r2;
            6:vars[nvars]:=TSector(ob.Items[iObj]).al;
            7:vars[nvars]:=TSector(ob.Items[iObj]).bt;
            8:vars[nvars]:=TSector(ob.Items[iObj]).h;
          end;
      end;
    2:begin
        if nMulti[iChange]>1 then nvars:=vMulti[iChange][1].nVars
        else nVars:=1;
        SetLength(Vars,nVars+1);
        Case iProp of
          1:vars[nvars]:=mt.Epsilon[iObj];
          2:vars[nvars]:=mt.MuProperty[iObj];
          3:vars[nvars]:=mt.Sigma[iObj];
        end;
      end;
    3:begin
        if nMulti[iChange]>1 then nvars:=vMulti[iChange][1].nVars
        else nVars:=1;
        SetLength(Vars,nVars+1);
        vars[nvars]:=mt.Frequency;
      end;
  end;
end;

function TMultiPack.GetValue(iSort,iObj,iProp:int):float;
var k:int;
begin
  Result:=0;
  Case iSort of
    1:begin
        if TMGObject(ob.Items[iObj]) is TBlock then
          Case iProp of
            1:Result:=TBlock(ob.Items[iObj]).x_1;
            2:Result:=TBlock(ob.Items[iObj]).y_1;
            3:Result:=TBlock(ob.Items[iObj]).z_1;
            4:Result:=TBlock(ob.Items[iObj]).x_2;
            5:Result:=TBlock(ob.Items[iObj]).y_2;
            6:Result:=TBlock(ob.Items[iObj]).z_2;
          end
        else
          case iProp of
            1:Result:=TSector(ob.Items[iObj]).xx;
            2:Result:=TSector(ob.Items[iObj]).yy;
            3:Result:=TSector(ob.Items[iObj]).zz;
            4:Result:=TSector(ob.Items[iObj]).r1;
            5:Result:=TSector(ob.Items[iObj]).r2;
            6:Result:=TSector(ob.Items[iObj]).al;
            7:Result:=TSector(ob.Items[iObj]).bt;
            8:Result:=TSector(ob.Items[iObj]).h;
            9:Result:=0;
          end;
      end;
    2:begin
        Case iProp of
          1:Result:=mt.Epsilon[iObj];
          2:Result:=mt.MuProperty[iObj];
          3:Result:=mt.Sigma[iObj];
        end;
      end;
    3:begin
        Result:=mt.Frequency;
      end;
  end;
end;

procedure TMultiPack.SetValue(n1,n2,k:int);
var iSort,iProp,iObj:int;
begin
  iSort:=vMulti[n1,n2].sort;
  iProp:=vMulti[n1,n2].prop;
  iObj:=vMulti[n1,n2].obj;
  with vMulti[n1,n2] do
  Case iSort of
    1:begin
        if TMGObject(ob.Items[iObj]) is TBlock then
          Case iProp of
            1:TBlock(ob.Items[iObj]).x_1:=vars[k];
            2:TBlock(ob.Items[iObj]).y_1:=vars[k];
            3:TBlock(ob.Items[iObj]).z_1:=vars[k];
            4:TBlock(ob.Items[iObj]).x_2:=vars[k];
            5:TBlock(ob.Items[iObj]).y_2:=vars[k];
            6:TBlock(ob.Items[iObj]).z_2:=vars[k];
          end
        else
          case iProp of
            1:TSector(ob.Items[iObj]).xx:=vars[k];
            2:TSector(ob.Items[iObj]).yy:=vars[k];
            3:TSector(ob.Items[iObj]).zz:=vars[k];
            4:TSector(ob.Items[iObj]).r1:=vars[k];
            5:TSector(ob.Items[iObj]).r2:=vars[k];
            6:TSector(ob.Items[iObj]).al:=vars[k];
            7:TSector(ob.Items[iObj]).bt:=vars[k];
            8:TSector(ob.Items[iObj]).h:=vars[k];
            9:TSector(ob.Items[iObj]).zz:=TSector(ob.Items[iObj]).zz+vars[k];
          end;
      end;
    2:begin
        Case iProp of
          1:mt.Epsilon[iObj]:=vars[k];
          2:mt.MuProperty[iObj]:=vars[k];
          3:mt.Sigma[iObj]:=vars[k];
        end;
      end;
    3:begin
        mt.Frequency:=vars[k];
      end;
  end;
end;

function TMultiPack.GetValS(n1,n2,k,vl:int):string;
var iSort,iProp,iObj:int;
    vv:float;
    s:string;
    f:boolean;
begin
  iSort:=vMulti[n1,n2].sort;
  iProp:=vMulti[n1,n2].prop;
  iObj:=vMulti[n1,n2].obj;
  if vl=6 then
  begin
    s:='';
  end
  else
  with vMulti[n1,n2] do
  Case iSort of
    1:begin
        f:=false;
        if TMGObject(ob.Items[iObj]) is TBlock then
          Case vl of
            0:vv:=vars[k];
            1:begin vv:=TBlock(ob.Items[iObj]).x_2-TBlock(ob.Items[iObj]).x_1; s:=IntToStr(Round(vv*1e4)); f:=true; end;
            2:begin vv:=TBlock(ob.Items[iObj]).y_2-TBlock(ob.Items[iObj]).y_1; s:=IntToStr(Round(vv*1e4)); f:=true; end;
            3:begin vv:=TBlock(ob.Items[iObj]).z_2-TBlock(ob.Items[iObj]).z_1; s:=IntToStr(Round(vv*1e4)); f:=true; end;
            4:vv:=vars[k];
            5:vv:=vars[k];
          end
        else
          Case vl of
            0:vv:=vars[k];
            1:vv:=vars[k];
            2:vv:=vars[k];
            3:vv:=vars[k];
            4:vv:=TSector(ob.Items[iObj]).r2-TSector(ob.Items[iObj]).r1;
            5:vv:=TSector(ob.Items[iObj]).bt-TSector(ob.Items[iObj]).al;
          end;
        if not f then
        if TMGObject(ob.Items[iObj]) is TBlock then
          s:=IntToStr(Round(vv*1e4))
        else
          case iProp of
            1..5,8,9:s:=IntToStr(Round(vv*1e4));
            6,7:s:=IntToStr(Round(vv));
          end;
      end;
    2:begin
        vv:=vars[k];
        Case iProp of
          1:s:=IntToStr(Round(vv*100));
          2:s:=IntToStr(Round(vv*100));
          3:s:=IntToStr(Round(vv/1e6*100));
        end;
      end;
    3:begin
        vv:=vars[k];
        s:=IntToStr(Round(vv));
      end;
  end;
  Result:=s;
end;

procedure MultiSave(fName:string);
var f:File;
    i,j,k:int;
    sf,si,sb:int;
begin
  sf:=SizeOf(float);
  si:=SizeOf(int);
  sb:=SizeOf(boolean);
  // saving information
  AssignFile(f,fName);
  Rewrite(f,1);
  BlockWrite(f,mp.num,si);
  BlockWrite(f,mp.bTopology,sb);
  BlockWrite(f,mp.solMet,si);
  BlockWrite(f,mp.outStyle,si);
  BlockWrite(f,mp.outPath,80);
  ///////////////////////////
  BlockWrite(f,mp.numGage,si);
  for i:=1 to mp.numgage do BlockWrite(f,mp.vGage[i],si);
  ////////////////////////////
  for i:=1 to mp.num do BlockWrite(f,mp.nMulti[i],si);
  for i:=1 to mp.num do
    for j:=1 to mp.nMulti[i] do
    begin
      BlockWrite(f,mp.vMulti[i,j].obj,si);
      BlockWrite(f,mp.vMulti[i,j].sort,si);
      BlockWrite(f,mp.vMulti[i,j].prop,si);
      BlockWrite(f,mp.vMulti[i,j].nVars,si);
      for k:=1 to mp.vMulti[i,j].nVars do
        BlockWrite(f,mp.vMulti[i,j].Vars[k],sf);
    end;
  /////////////////////////////
  for i:=1 to mp.num-1 do
  begin
    BlockWrite(f,mp.outName[i].dr,sb);
    BlockWrite(f,mp.outName[i].name,80);
    BlockWrite(f,mp.outName[i].val,si);
  end;
  CloseFile(f);
end;

procedure MultiLoad(fName:string);
var f:File;
    i,j,k:int;
    sf,si,sb:int;
    ii:int;
    ff:float;
    bb:boolean;
    nn:int;
    s80:st80;
begin
  if mp<>nil then begin mp.Delete; mp.Free; mp:=nil; end;
  mp:=TMultiPack.Create();
  ///////////////////////
  sf:=SizeOf(float);
  si:=SizeOf(int);
  sb:=SizeOf(boolean);
  // saving information
  AssignFile(f,fName);
  Reset(f,1);

  BlockRead(f,ii,si); mp.num:=ii;
  mp.ChangeNum;
  BlockRead(f,bb,sb); mp.bTopology:=bb;
  BlockRead(f,ii,si); mp.solMet:=ii;
  BlockRead(f,ii,si); mp.outStyle:=ii;
  BlockRead(f,s80,80);mp.outPath:=s80;
  ///////////////////////////
  Blockread(f,ii,si); mp.numGage:=ii;
  SetLength(mp.vGage,mp.numGage+1);
  for i:=1 to mp.numgage do begin BlockRead(f,ii,si); mp.vGage[i]:=ii; end;
  ////////////////////////////
  for i:=1 to mp.num do begin BlockRead(f,ii,si); mp.nMulti[i]:=ii; end;
  for i:=1 to mp.num do
  begin
    SetLength(mp.vMulti[i],mp.nMulti[i]+1);
    for j:=1 to mp.nMulti[i] do
    begin
      BlockRead(f,ii,si); mp.vMulti[i,j].obj:=ii;
      BlockRead(f,ii,si); mp.vMulti[i,j].sort:=ii;
      BlockRead(f,ii,si); mp.vMulti[i,j].prop:=ii;
      BlockRead(f,ii,si); mp.vMulti[i,j].nVars:=ii;
      nn:=ii;
      with mp.vMulti[i,j] do
      begin
        SetLength(vars,nn+1);
        for k:=1 to nn do begin BlockRead(f,ff,sf); Vars[k]:=ff; end;
      end;
    end;
  end;
  /////////////////////////////
  for i:=1 to mp.num-1 do
  begin
    BlockRead(f,bb,sb); mp.outName[i].dr:=bb;
    BlockRead(f,s80,80);mp.outName[i].name:=s80;
    BlockRead(f,ii,si); mp.outName[i].val:=ii;
  end;
  CloseFile(f);
end;

end.
