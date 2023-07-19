import React, { useContext } from 'react';
import { SmetaContext } from '../../context/smetaContext';
import { SmetaGridPart } from './SmetaGridPart';

interface Props {}

const SmetaGrid = (props: Props) => {
  const { smeta } = useContext(SmetaContext);

  const noData = <p className='text-center'>Нет данных для отображения</p>;

  return (
    <div className='card bg-secondary text-white mt-1'>
      <div className='card-header bg-dark'>Смета</div>
      <div className='card-body'>
        <div className='row grid-edit-line'>
          <div className='col'>Смета.Раздел1.Расценка2.Итого</div>
          <div className='col'>0.00</div>
        </div>
        <div className='row grid-header'>
          <div className='col-1'>№</div>
          <div className='col-1'>Шифр</div>
          <div className='col-7'>Наименование</div>
          <div className='col-1'>Ед.Изм</div>
          <div className='col-1'>Кол-во</div>
          <div className='col-1'>Итого</div>
        </div>
        {smeta.data.length === 0 && noData}
        {smeta.data.map((part) => (
          <SmetaGridPart part={part} key={part.id} />
        ))}
      </div>
    </div>
  );
};

export default SmetaGrid;
