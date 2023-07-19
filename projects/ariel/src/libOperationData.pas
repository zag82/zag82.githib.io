unit libOperationData;

interface

Const
  AR_OK: integer = 0;
  AR_SettingsNotLoaded = 1;
  AR_ConnectionError = 2;
  AR_WRONG_CHANNEL = 3;
  AR_WRONG_DATA_BUFFER = 4;

  AR_NotSuppportedOperation = $80;

  AR_STATE_NotInited = 0;
  AR_STATE_Connected = 1;
  AR_STATE_Disconnected = 2;
  AR_STATE_DataAquire = 3;

  AR_CLASS_None = 0;
  AR_CLASS_Proper = 1;
  AR_CLASS_Recontrol = 2;
  AR_CLASS_Waste = 3;

implementation

end.
