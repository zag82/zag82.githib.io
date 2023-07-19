import React, { useContext } from 'react';
import { GRecord } from '../../context/gss.types';
import { SmetaContext } from '../../context/smetaContext';

interface Props {
  res: GRecord;
}
export const SmetaGridRes = ({ res }: Props) => {
  const { curRecID, selectRec } = useContext(SmetaContext);
  const typ = res.fields.get('Тип');

  const typColor = () => {
    let colorClass = '';
    switch (typ) {
      case 'Материальные ресурсы':
        colorClass = 'res-material';
        break;
      case 'Оплата труда':
        colorClass = 'res-labor';
        break;
      case 'Машины и механизмы':
        colorClass = 'res-machines';
        break;
      case 'Оборудование':
        colorClass = 'res-equipment';
        break;
      default:
        colorClass = '';
    }
    return colorClass;
  };

  return (
    <div
      className={
        'row grid-resource-header' +
        (res.id === curRecID ? ' selected' : ' ' + typColor())
      }
      onClick={() => selectRec(res.id)}
    >
      <div className='col-1'></div>
      <div className='col-1'>{res.fields.get('Шифр')}</div>
      <div className='col-7'>{res.fields.get('Наименование')}</div>
      <div className='col-1 text-center'>{res.fields.get('ЕдИзм')}</div>
      <div className='col-1 text-center'>
        {res.fields.get('Расход')} =&gt; {res.fields.get('Количество')}
      </div>
      <div className='col-1 text-right'>{res.fields.get('Итого')}</div>
    </div>
  );
};
