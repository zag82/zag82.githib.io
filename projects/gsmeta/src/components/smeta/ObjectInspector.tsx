import React, { useContext } from 'react';
import { SmetaContext } from '../../context/smetaContext';

interface Props {}

const ObjectInspector = (props: Props) => {
  const { curRec } = useContext(SmetaContext);

  const fillFields = () => {
    const fields: JSX.Element[] = [];
    if (curRec) {
      fields.push(
        <tr key={curRec.id}>
          <td>ID</td>
          <td>{curRec.id}</td>
        </tr>
      );
      curRec.fields.forEach((value, name) => {
        fields.push(
          <tr key={name}>
            <td>{name}</td>
            <td>{value}</td>
          </tr>
        );
      });
    }
    return fields;
  };

  return (
    <div className='card bg-secondary text-white mt-1'>
      <div className='card-header bg-dark'>Свойства</div>
      {!curRec && (
        <div className='card-body'>
          <p className='text-center'>
            Нет данных <br /> Выберите строку в гриде
          </p>
        </div>
      )}
      {curRec && (
        <div className='card-body'>
          <table className='table table-light table-striped table-hover table-bordered'>
            <tbody>{fillFields()}</tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default ObjectInspector;
