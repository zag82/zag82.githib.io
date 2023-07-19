import React, { useContext, useEffect } from 'react';
import { SmetaContext } from '../../context/smetaContext';
import Totals from '../smeta/Totals';

interface Props {}

const Navbar = (props: Props) => {
  const { currentFile, openFile } = useContext(SmetaContext);
  const files = [
    {
      name: 'Новый файл',
      description: 'Простой файл на 2 позиции для примера',
    },
  ];

  useEffect(() => {
    openFile(currentFile);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const onSelectFile = (index: number) => {
    openFile(files[index].name);
  };
  return (
    <nav className='navbar navbar-expand-lg navbar-dark bg-dark fixed-top'>
      <div className='container-fluid'>
        <span className='navbar-brand mb-0 h1'>
          <img src='/images/logo.png' alt='логотип' /> Гсс+
        </span>
        <Totals />
        <ul className='navbar-nav'>
          {files.map((file, index) => (
            <li
              key={index}
              className={
                'nav-item' + (currentFile === file.name ? ' active' : '')
              }
            >
              <a
                href='#!'
                className='nav-link'
                onClick={(e: React.MouseEvent) => {
                  e.preventDefault();
                  onSelectFile(index);
                }}
                title={file.description}
              >
                {file.name}
              </a>
            </li>
          ))}
        </ul>
      </div>
    </nav>
  );
};

export default Navbar;
