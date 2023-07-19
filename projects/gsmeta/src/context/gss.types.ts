export interface Smeta {
  total: number;
  positions: number;
  maxID: number;
  additions: Addition[];
  references: GRef[];
  data: GRecord[];
}

export type GRecordType =
  | 'Раздел'
  | 'Расценка'
  | 'Ресурс'
  | 'Коэффициент'
  | 'Индекс'
  | 'Начисление';
export interface GRecord {
  id: number;
  type: GRecordType; // RecordType.Name
  fields: Map<string, string>; // name and value
  children: GRecord[];
  extensions: Map<GRecordType, GRecord[]> | null;
}

// начисления
export enum AdditionKind {
  Standard,
  Sprav,
  Empty,
  Subtotal,
}
export interface Addition {
  id: number;
  name: string;
  kind: AdditionKind;
  level: number;
  code: string;
  total: number;
  totalBase: number;
}

// привязки
export interface GRef {
  id: number;
  name: string;
  index: string;
  method: string;
}
