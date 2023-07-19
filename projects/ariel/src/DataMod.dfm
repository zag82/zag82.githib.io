object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 259
  Width = 315
  object mdFilterType: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D4500010000000001070000004C6F77506173730101000000010800
      000042616E6450617373}
    SortOptions = []
    Left = 24
    Top = 8
    object mdFilterTypeID: TIntegerField
      FieldName = 'ID'
    end
    object mdFilterTypeNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsFilterType: TDataSource
    DataSet = mdFilterType
    Left = 24
    Top = 56
  end
end
