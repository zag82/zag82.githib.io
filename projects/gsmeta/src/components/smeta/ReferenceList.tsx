import React, { useContext } from 'react';
import { SmetaContext } from '../../context/smetaContext';
import { GRef } from '../../context/gss.types';

interface Props {}

const ReferenceList = (props: Props) => {
  const { smeta, showRefs, toggleShowRefs } = useContext(SmetaContext);

  return (
    <div className='card bg-secondary text-white mt-3'>
      <div
        className='card-header bg-dark clickable-header'
        onClick={toggleShowRefs}
      >
        Привязки
      </div>
      {showRefs && (
        <div className='card-body'>
          <div className='row'>
            {smeta.references.map((ref: GRef) => (
              <div className='col-6 mt-3' key={ref.id}>
                <div className='font-weight-bold'>{ref.name}</div>
                <div className='pl-5 smaller'>
                  {ref.index && `Индексы: ${ref.index}`}
                </div>
                <div className='pl-5 smaller'>
                  {ref.method && `Метод расчета: ${ref.method}`}
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default ReferenceList;
