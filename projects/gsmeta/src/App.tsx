import React from 'react';
import { SmetaProvider } from './context/smetaContext';
import Navbar from './components/layout/Navbar';
import AdditionsList from './components/smeta/AdditionsList';
import ReferenceList from './components/smeta/ReferenceList';
import ObjectInspector from './components/smeta/ObjectInspector';
import SmetaGrid from './components/smeta/SmetaGrid';
import Footer from './components/layout/Footer';

function App() {
  return (
    <SmetaProvider>
      <Navbar />
      <div className='container-fluid skip-navbar'>
        <AdditionsList />
        <ReferenceList />
        <div className='row mt-3' style={{ flexWrap: 'wrap' }}>
          <div className='col-3 equal-height'>
            <ObjectInspector />
          </div>
          <div className='col-9 equal-height'>
            <SmetaGrid />
          </div>
        </div>
      </div>
      <Footer />
    </SmetaProvider>
  );
}

export default App;
