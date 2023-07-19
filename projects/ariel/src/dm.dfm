object dataMod: TdataMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 105
  Width = 262
  object tcpPL: TTcpClient
    RemoteHost = '10.8.2.218'
    RemotePort = '5001'
    OnConnect = tcpPLConnect
    OnDisconnect = tcpPLDisconnect
    OnReceive = tcpPLReceive
    OnSend = tcpPLSend
    OnError = tcpPLError
    Left = 72
    Top = 24
  end
  object tcpPL_Aqc: TTcpClient
    RemoteHost = '10.8.2.218'
    RemotePort = '5003'
    OnConnect = tcpPL_AqcConnect
    OnDisconnect = tcpPL_AqcDisconnect
    OnReceive = tcpPL_AqcReceive
    OnSend = tcpPL_AqcSend
    OnError = tcpPL_AqcError
    Left = 160
    Top = 24
  end
end
