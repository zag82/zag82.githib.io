import React, { useContext } from 'react';
import { GRecord } from '../../context/gss.types';
import { SmetaContext } from '../../context/smetaContext';
import { SmetaGridCost } from './SmetaGridCost';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPlusSquare,
  faMinusSquare,
} from '@fortawesome/free-regular-svg-icons';

interface Props {
  part: GRecord;
}
export const SmetaGridPart = ({ part }: Props) => {
  const {
    getRecordStatus,
    curRecID,
    selectRec,
    toggleRecordStatus,
  } = useContext(SmetaContext);
  const status = getRecordStatus(part.id);

  return (
    <>
      <div
        className={
          'row grid-part-header' + (part.id === curRecID ? ' selected' : '')
        }
        onClick={() => selectRec(part.id)}
      >
        <div className='col-11'>
          <a
            role='button'
            href='#!'
            onClick={(e: React.MouseEvent) => {
              e.preventDefault();
              toggleRecordStatus(1);
            }}
            className='black-plus'
          >
            <FontAwesomeIcon
              icon={status === 1 ? faPlusSquare : faMinusSquare}
            />
          </a>
          {part.fields.get('Наименование')}
        </div>
        <div className='col-1 text-right'>{part.fields.get('Итого')}</div>
      </div>
      {status === 0 &&
        part.children.map((cost) => (
          <SmetaGridCost cost={cost} key={cost.id} />
        ))}
    </>
  );
};
