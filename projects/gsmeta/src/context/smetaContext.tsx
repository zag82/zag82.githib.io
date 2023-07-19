import React, { createContext, useState } from 'react';
import { Smeta, GRecord, Addition, GRef, GRecordType } from './gss.types';
import { gssTestSmeta } from './gss.smeta';
import { idHolder } from './idHolder';

// consts and types
interface SmetaContextProvider {
  currentFile: string;
  smeta: Smeta;
  // view state
  showAddi: boolean;
  showRefs: boolean;
  curRecID: number | null;
  curRec: GRecord | null;
  // common actions
  openFile: (file: string) => void;
  // view actions
  toggleShowAddi: () => void;
  toggleShowRefs: () => void;
  toggleRecordStatus: (param: number) => void;
  getRecordStatus: (recID: number) => number;
  selectRec: (recID: number) => void;
  // gss Actions
  gssChangeQuantity: () => void;
  gssCopyItem: () => void;
}

const initialFile = 'small';
const initialSmeta: Smeta = gssTestSmeta();
const initialShowAddi = false;
const initialShowRefs = false;
const initialRecID = null;
const initialCurRec = null;
const defaultContext: SmetaContextProvider = {
  currentFile: initialFile,
  smeta: initialSmeta,
  // view state
  showAddi: initialShowAddi,
  showRefs: initialShowRefs,
  curRecID: initialRecID,
  curRec: initialCurRec,
  // common actions
  openFile: (file: string) => {},
  // view actions
  toggleShowAddi: () => {},
  toggleShowRefs: () => {},
  toggleRecordStatus: (param: number) => {},
  getRecordStatus: (recID: number): number => {
    return 0;
  },
  selectRec: (recID: number) => {},
  // gss Actions
  gssChangeQuantity: () => {},
  gssCopyItem: () => {},
};

// context
export const SmetaContext = createContext<SmetaContextProvider>(defaultContext);

interface Props {
  children: React.ReactNode;
}
export const SmetaProvider = (props: Props) => {
  // state
  const [currentFile, setFile] = useState<string>(initialFile);
  const [smeta, setSmeta] = useState<Smeta>(initialSmeta);
  const [showAddi, setShowAddi] = useState<boolean>(initialShowAddi);
  const [showRefs, setShowRefs] = useState<boolean>(initialShowRefs);
  const [collapses, setCollapses] = useState(new Map<number, number>());
  const [curRecID, setCurRecID] = useState<number | null>(initialRecID);
  const [curRec, setCurRec] = useState<GRecord | null>(initialCurRec);

  // common actions
  const openFile = (file: string) => {
    // do file opening operations
    setCurRecID(initialRecID);
    setCurRec(initialCurRec);
    setCollapses(new Map<number, number>());
    setShowRefs(initialShowRefs);
    setShowAddi(initialShowAddi);
    gssRecalc(gssTestSmeta());
    // store file
    setFile(file);
  };

  // view actions
  const toggleShowAddi = () => {
    setShowAddi(!showAddi);
  };
  const toggleShowRefs = () => {
    setShowRefs(!showRefs);
  };
  const getRecordStatus = (recID: number): number => {
    const status = collapses.get(recID);
    return status || 0;
  };
  const toggleRecordStatus = (param: number) => {
    // do toggle state of param of record in smeta
    if (curRecID) {
      const newCollapses = new Map<number, number>(collapses);
      let status = getRecordStatus(curRecID);
      if ((status & param) === param) {
        status -= param;
      } else {
        status += param;
      }
      newCollapses.set(curRecID, status);
      setCollapses(newCollapses);
    }
  };
  const selectRec = (recID: number) => {
    // set current selected record
    setCurRecID(recID);
    setCurRec(gssFindRec(smeta, recID));
  };

  // gss actions
  function gssCopyRecord(rec: GRecord, useGlobalID: boolean): GRecord {
    let newChilds: GRecord[] = [];
    rec.children.forEach((r) => {
      newChilds.push(gssCopyRecord(r, useGlobalID));
    });

    let newExts: Map<GRecordType, GRecord[]> | null = null;
    if (rec.extensions) {
      newExts = new Map<GRecordType, GRecord[]>();
      rec.extensions?.forEach((ex, typ) => {
        let newEx: GRecord[] = [];
        ex.forEach((itm) => {
          newEx.push(gssCopyRecord(itm, useGlobalID));
        });
        newExts?.set(typ, newEx);
      });
    }
    return {
      id: useGlobalID ? idHolder.newID() : rec.id,
      type: rec.type,
      fields: new Map<string, string>(rec.fields),
      children: newChilds,
      extensions: newExts,
    };
  }
  function gssCopySmeta(src: Smeta): Smeta {
    let newAdditions: Addition[] = [];
    src.additions.forEach((addi) => {
      newAdditions.push({
        ...addi,
      });
    });
    let newRefs: GRef[] = [];
    src.references.forEach((ref) => {
      newRefs.push({
        ...ref,
      });
    });
    let newData: GRecord[] = [];
    src.data.forEach((itm) => {
      newData.push(gssCopyRecord(itm, false));
    });

    return {
      total: src.total,
      positions: src.positions,
      maxID: src.maxID,
      additions: newAdditions,
      references: newRefs,
      data: newData,
    };
  }

  function gssSearch(rec: GRecord, action: (r: GRecord) => void) {
    action(rec);
    rec.children.forEach((itm) => gssSearch(itm, action));
    rec.extensions?.forEach((ex, _typ) => {
      ex.forEach((itm) => gssSearch(itm, action));
    });
  }
  const gssRecalc = (sm: Smeta, needMakeCopy: boolean = false) => {
    let total = 0;
    let pos = 0;
    let maxid = 0;
    const newSmeta = needMakeCopy ? gssCopySmeta(sm) : sm;
    newSmeta.data.forEach((part) => {
      gssSearch(part, (r) => {
        if (r.id > maxid) maxid = r.id;
      });
      let totalPart = 0;
      part.children.forEach((cost) => {
        const value = parseFloat(cost.fields.get('Итого') as string);
        total += value;
        totalPart += value;
        pos += 1;
        cost.fields.set('Номер', String(pos));
      });
      part.fields.set('Итого', String(Math.round(totalPart * 100) / 100));
    });
    newSmeta.total = Math.round(total * 100) / 100;
    newSmeta.positions = pos;
    newSmeta.maxID = maxid;
    setSmeta(newSmeta);
  };

  const gssFindRec = (sm: Smeta, recID: number): GRecord | null => {
    let rec = null;
    sm.data.forEach((part) => {
      gssSearch(part, (r) => {
        if (r.id === recID) {
          rec = r;
        }
      });
    });
    return rec;
  };

  const gssChangeQuantity = () => {
    // change quantity
    if (curRecID) {
      let newSmeta = gssCopySmeta(smeta);
      const rec = gssFindRec(newSmeta, curRecID);
      let fld = rec?.fields.get('Количество');
      if (fld) rec?.fields.set('Количество', '' + parseFloat(fld) * 2);
      fld = rec?.fields.get('Итого');
      if (fld) rec?.fields.set('Итого', '' + parseFloat(fld) * 2);
      gssRecalc(newSmeta);
    }
  };

  const gssCopyItem = () => {
    // copy item
    if (curRecID) {
      let newSmeta = gssCopySmeta(smeta);
      let processed = false;
      idHolder.assign(newSmeta.maxID);
      for (let i = 0; i < newSmeta.data.length; i++) {
        // go through parts
        const part = newSmeta.data[i];
        if (part.id === curRecID) {
          const newPart: GRecord = gssCopyRecord(part, true);
          newSmeta.data = [
            ...newSmeta.data.slice(0, i + 1),
            newPart,
            ...newSmeta.data.slice(i + 1),
          ];
          processed = true;
        }
        if (processed === true) break;

        for (let j = 0; j < part.children.length; j++) {
          // go through costs
          const cost = part.children[j];
          if (cost.id === curRecID) {
            const newCost: GRecord = gssCopyRecord(cost, true);
            part.children = [
              ...part.children.slice(0, j + 1),
              newCost,
              ...part.children.slice(j + 1),
            ];
            processed = true;
          }
          if (processed === true) break;

          for (let k = 0; k < cost.children.length; k++) {
            // go through resources
            const resource = cost.children[k];
            if (resource.id === curRecID) {
              const newResource: GRecord = gssCopyRecord(resource, true);
              cost.children = [
                ...cost.children.slice(0, k + 1),
                newResource,
                ...cost.children.slice(k + 1),
              ];
              processed = true;
            }
            if (processed === true) break;
          }
          if (processed === true) break;
        }
        if (processed === true) break;
      }
      gssRecalc(newSmeta);
    }
  };

  return (
    <SmetaContext.Provider
      value={{
        currentFile,
        smeta,
        showAddi,
        showRefs,
        curRecID,
        curRec,
        // common actions
        openFile,
        // view actions
        toggleShowAddi,
        toggleShowRefs,
        toggleRecordStatus,
        getRecordStatus,
        selectRec,
        gssChangeQuantity,
        gssCopyItem,
      }}
    >
      {props.children}
    </SmetaContext.Provider>
  );
};
