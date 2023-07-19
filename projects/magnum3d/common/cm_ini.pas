unit cm_ini;

{$I CompileConditions}

interface

type
  float = double;
  int = integer;

  TComplex = record
               re:float;
               im:float;
             end;

{------------------------------------------------------------------------------}
{---------------------  Common Constant definition  ---------------------------}
{------------------------------------------------------------------------------}
Type
  TTet5=array [1..2, // discretization number
               1..5, // tetrahedron number
               1..4, // point number in tetrahedron
               1..3] of int;

const
  Mu0=4*Pi*1e-7;
  Eps0 = 8.85*1e-12;
  verID:byte=11;

    Tet5:TTet5=((((0,0,0),(1,0,0),(0,1,0),(0,0,1)),  // 1
                 ((1,0,0),(1,1,0),(0,1,0),(1,1,1)),
                 ((1,0,0),(0,1,0),(0,0,1),(1,1,1)),
                 ((0,0,1),(1,0,0),(1,1,1),(1,0,1)),
                 ((0,0,1),(0,1,0),(0,1,1),(1,1,1))),
                (((0,0,0),(1,1,0),(1,0,1),(1,0,0)),  // 2
                 ((0,0,0),(1,1,0),(0,1,0),(0,1,1)),
                 ((0,0,0),(1,1,0),(0,1,1),(1,0,1)),
                 ((0,0,0),(0,1,1),(0,0,1),(1,0,1)),
                 ((0,1,1),(1,0,1),(1,1,0),(1,1,1))));

{------------------------------------------------------------------------------}
{------------------------  Common types definition  ---------------------------}
{------------------------------------------------------------------------------}
Type
  st1=string[1];
  st8=string[8];
  st80=string[80];
  // 2d task foundation types
  mxtyp2 = array[1..3] of float;
  mxtyp3 = array[1..4] of float;

  TFlatPoint=array[1..2]of float;
  TTriangle=array[0..3]of int;

  TStep=record num:int; val:float; end;

  TFlatSource=record
    num:int;
    val_J:float;
    val_Bx:float;
    val_Bz:float;
    val_Ro:float;
    val_Jim:float;
  end;

  TFlatBound_Re=record
    num:int;
    val:float;
  end;

  TFlatBound_Cx=record
    num:int;
    val:TComplex;
  end;

  TFlatPointList=array of TFlatPoint;
  TTriangleList=array of TTriangle;
  TFlatSourceList=array of TFlatSource;
  TFlatBound_reList=array of TFlatBound_Re;
  TFlatBound_cxList=array of TFlatBound_Cx;

  TBound2=record
    nm:st80;
    x1,x2,z1,z2:int;
    val:float;
    vl_im:float;
  end;

  TBound3=record
    nm:st80;
    x1,x2,y1,y2,z1,z2:int;
    dir:byte;
    val:float;
    vl_im:float;
  end;

  TBounds2_data=array of TBound2;
  TBounds3_data=array of TBound3;

  TPWD_data=record
    usr:int;
    password:array [1..4] of string;
  end;

Var
  bnd2:TBounds2_data;
  Nbnd2:int;
  bnd3:TBounds3_data;
  Nbnd3:int;

  pw:TPWD_data;

implementation

end.
