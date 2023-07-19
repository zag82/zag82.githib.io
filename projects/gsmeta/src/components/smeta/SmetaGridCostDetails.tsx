import React from 'react';
import { GRecord } from '../../context/gss.types';

interface Props {
  cost: GRecord;
}

export const SmetaGridCostDetails = ({ cost }: Props) => {
  return (
    <>
      <div className='grid-cost-details row'>
        <div className='col-4'></div>
        <div className='col-1 font-weight-bold text-center'>ПЗ</div>
        <div className='col-1 font-weight-bold text-center'>ОТ</div>
        <div className='col-1 font-weight-bold text-center'>ЭМ</div>
        <div className='col-1 font-weight-bold text-center'>ОТМ</div>
        <div className='col-1 font-weight-bold text-center'>МР</div>
        <div className='col-1 font-weight-bold text-center'>ОБ</div>
        <div className='col-2'></div>
      </div>
      <div className='grid-cost-details row'>
        <div className='col-4 text-right'>Итоговая стоимость</div>
        <div className='col-1 text-right'>{cost.fields.get('сПЗ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('сОТ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('сЭМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('сОТМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('сМР')}</div>
        <div className='col-1 text-right'>{cost.fields.get('сОБ')}</div>
        <div className='col-2'></div>
      </div>
      <div className='grid-cost-details row'>
        <div className='col-4 text-right'>
          Показатель стоимости на единицу измерения расценки
        </div>
        <div className='col-1 text-right'>{cost.fields.get('ПЗ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('ОТ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('ЭМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('ОТМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('МР')}</div>
        <div className='col-1 text-right'>{cost.fields.get('ОБ')}</div>
        <div className='col-2'></div>
      </div>
      <div className='grid-cost-details row'>
        <div className='col-4 text-right text-primary'>
          Коэффициенты на условия работ
        </div>
        <div className='col-1 text-right'>{cost.fields.get('кПЗ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('кОТ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('кЭМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('кОТМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('кМР')}</div>
        <div className='col-1 text-right'>{cost.fields.get('кОБ')}</div>
        <div className='col-2'></div>
      </div>
      <div className='grid-cost-details row'>
        <div className='col-4 text-right text-primary'>Индексы</div>
        <div className='col-1 text-right'>{cost.fields.get('иПЗ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('иОТ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('иЭМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('иОТМ')}</div>
        <div className='col-1 text-right'>{cost.fields.get('иМР')}</div>
        <div className='col-1 text-right'>{cost.fields.get('иОБ')}</div>
        <div className='col-2'></div>
      </div>
    </>
  );
};
