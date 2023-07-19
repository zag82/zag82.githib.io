import React, { useContext } from 'react';
import { SmetaContext } from '../../context/smetaContext';
import { Addition, AdditionKind } from '../../context/gss.types';

interface Props {}

const AdditionsList = (props: Props) => {
  const { smeta, showAddi, toggleShowAddi } = useContext(SmetaContext);

  return (
    <div className='card bg-secondary text-white mt-3'>
      <div
        className='card-header bg-dark clickable-header'
        onClick={toggleShowAddi}
      >
        Начисления
      </div>
      {showAddi && (
        <div className='card-body'>
          <table className='table'>
            <thead className='thead-dark'>
              <tr>
                <th>Шифр</th>
                <th>Наименование</th>
                <th>Итого (руб)</th>
                <th>Итого баз (руб)</th>
              </tr>
            </thead>
            <tbody>
              {smeta.additions.map((addi: Addition) => (
                <tr key={addi.id} className={`addi-line-${addi.kind}`}>
                  {addi.kind === AdditionKind.Empty && (
                    <td colSpan={4} className={`addi-level-${addi.level}`}>
                      {addi.name}
                    </td>
                  )}
                  {addi.kind !== AdditionKind.Empty && (
                    <>
                      <td className={`addi-level-${addi.level}`}>
                        {addi.code}
                      </td>
                      <td>{addi.name}</td>
                      <td className='text-right'>{addi.total}</td>
                      <td className='text-right'>{addi.totalBase}</td>
                    </>
                  )}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default AdditionsList;
