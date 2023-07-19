import React, { useContext } from 'react';
import { SmetaContext } from '../../context/smetaContext';

interface Props {}

const Totals = (props: Props) => {
  const { smeta, gssChangeQuantity, gssCopyItem } = useContext(SmetaContext);

  const onChangeQuantity = (e: React.MouseEvent) => {
    e.preventDefault();
    gssChangeQuantity();
  };

  const onCopyItem = (e: React.MouseEvent) => {
    e.preventDefault();
    gssCopyItem();
  };

  return (
    <ul className='nav'>
      <li className='nav-item text-white pt-2 mx-4'>
        <strong>Итого по смете: {smeta.total} руб.</strong>
      </li>
      <li className='nav-item text-white pt-2 mx-4'>
        <strong>Позиций: {smeta.positions}</strong>
      </li>
      <li className='nav-item'>
        <a
          role='button'
          className='nav-link btn btn-outline-warning'
          href='#!'
          onClick={onChangeQuantity}
          title='Увеличивает количество текущей позиции в 2 раза'
        >
          Количество
        </a>
      </li>
      <li className='nav-item mx-2'>
        {' '}
        <a
          role='button'
          className='nav-link btn btn-outline-warning'
          href='#!'
          onClick={onCopyItem}
          title='Копирует текущую позицию и вставляет сразу за ней'
        >
          Копия
        </a>
      </li>
    </ul>
  );
};

export default Totals;
