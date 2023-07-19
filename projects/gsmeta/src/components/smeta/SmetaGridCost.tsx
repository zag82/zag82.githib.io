import React, { useContext } from 'react';
import { GRecord } from '../../context/gss.types';
import { SmetaContext } from '../../context/smetaContext';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPlusSquare,
  faMinusSquare,
} from '@fortawesome/free-regular-svg-icons';
import { SmetaGridRes } from './SmetaGridRes';
import { SmetaGridCostDetails } from './SmetaGridCostDetails';

interface Props {
  cost: GRecord;
}

export const SmetaGridCost = ({ cost }: Props) => {
  const {
    getRecordStatus,
    curRecID,
    selectRec,
    toggleRecordStatus,
  } = useContext(SmetaContext);
  const status = getRecordStatus(cost.id);

  const coefs = cost.extensions?.get('Коэффициент');
  const indexes = cost.extensions?.get('Индекс');

  function getNumberInfo(): string {
    let txt = '';
    function listItems(rec: GRecord, ix: number) {
      let values = '';
      function getV(name: string): string {
        const fld = rec.fields.get(name);
        if (fld && fld !== '1') return `${name}=${fld}`;
        return '';
      }
      function addV(name: string) {
        const v = getV(name);
        if (v) {
          if (values) values += ', ';
          values += v;
        }
      }
      addV('ПЗ');
      addV('ОТ');
      addV('ЭМ');
      addV('ОТМ');
      addV('МР');
      addV('ОБ');
      txt += `${ix + 1}. (${rec.fields.get('Шифр')}) ${rec.fields.get(
        'Наименование'
      )} (${values})\n`;
    }

    if (coefs) {
      txt += 'КОЭФФИЦИЕНТЫ:\n';
      coefs.forEach(listItems);
    }
    if (indexes) {
      txt += 'ИНДЕКСЫ:\n';
      indexes.forEach(listItems);
    }

    return txt;
  }

  return (
    <>
      <div
        className={
          'row grid-cost-header' + (cost.id === curRecID ? ' selected' : '')
        }
        onClick={() => selectRec(cost.id)}
      >
        <div className='col-1' title={getNumberInfo()}>
          <div className='cost-fld-number'>
            <div className='cost-fld-number-first'>
              <a
                role='button'
                href='#!'
                onClick={(e: React.MouseEvent) => {
                  e.preventDefault();
                  toggleRecordStatus(2);
                }}
                className='black-plus'
              >
                <FontAwesomeIcon
                  icon={(status & 2) !== 2 ? faPlusSquare : faMinusSquare}
                />
              </a>
              {cost.children.length !== 0 && (
                <a
                  role='button'
                  href='#!'
                  onClick={(e: React.MouseEvent) => {
                    e.preventDefault();
                    toggleRecordStatus(1);
                  }}
                  className='blue-plus'
                >
                  <FontAwesomeIcon
                    icon={(status & 1) !== 1 ? faPlusSquare : faMinusSquare}
                  />
                </a>
              )}
            </div>
            <div className='cost-fld-number-last'>
              <div className='text-right font-weight-bold'>
                {cost.fields.get('Номер')}
              </div>
              {coefs && (
                <div className='font-italic smaller text-secondary'>
                  Коэф: {coefs?.length}
                </div>
              )}
              {indexes && (
                <div className='font-italic smaller text-secondary'>
                  Инд: {indexes?.length}
                </div>
              )}
            </div>
          </div>
        </div>
        <div className='col-1 font-weight-bold'>{cost.fields.get('Шифр')}</div>
        <div className='col-7'>{cost.fields.get('Наименование')}</div>
        <div className='col-1 text-center'>{cost.fields.get('ЕдИзм')}</div>
        <div className='col-1 text-right font-weight-bold'>
          {cost.fields.get('Количество')}
        </div>
        <div className='col-1 text-right font-weight-bold'>
          {cost.fields.get('Итого')}
        </div>
      </div>
      {(status & 2) === 2 && <SmetaGridCostDetails cost={cost} />}
      {(status & 1) === 1 &&
        cost.children.map((res) => <SmetaGridRes res={res} key={res.id} />)}
    </>
  );
};
