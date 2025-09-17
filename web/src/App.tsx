import './App.css'
import { useState, useMemo } from 'react';
import chars from './assets/characters.png'
import { useNuiEvent } from './utils/useNuiEvent';
import { RegisterUser } from './utils/class';

function App() {
  const [active, setActive] = useState(false);
  const [nume, setNume] = useState('');
  const [prenume, setPrenume] = useState('');
  const [birth, setBirth] = useState('');
  const [sex, setSex] = useState(0);

  useNuiEvent('SHOW_UI', () => {
    setActive(true);
  });

  const regUser = useMemo(() => new RegisterUser(nume.trim(), prenume.trim(), birth.trim(), sex), [nume, prenume, birth, sex]);

  const handleClickBtn = () => {
    regUser.register();
    setActive(false);
  }

  const allFilled =
    regUser.name.length >= 4 && regUser.name.length <= 10 &&
    regUser.surname.length >= 4 && regUser.surname.length <= 10 &&regUser.dob && (regUser.sex === 0 || regUser.sex === 1) && regUser.isValidDate(regUser.dob) && regUser.isAgeOk();

  return active ?  (
    <div className="identity">
      <div className="left">
        <span className="header">Welcome on AllPlay</span>
        <img src={chars} className='chars' />
      </div>
      <div className="right">
        <div className="header">
          <span className="title">Identity</span>
          <span className="desc">Alatura-te pentru o experienta de Roleplay mai bună</span>
        </div>
        <div className="inputs">
          <div className="input">
            <span className="label">Nume</span>
            <input
              type="text"
              className="field"
              placeholder='Moretti'
              autoComplete='off'
              autoCorrect='off'
              maxLength={12}
              value={nume}
              onChange={e => {
                let val = e.target.value.replace(/^\s+|\s+$/g, '');
                if (val.length > 10) val = val.slice(0, 10);
                setNume(val);
              }}
            />
          </div>
          <div className="input">
            <span className="label">Prenume</span>
            <input
              type="text"
              className="field"
              placeholder='Luca'
              autoComplete='off'
              autoCorrect='off'
              maxLength={12}
              value={prenume}
              onChange={e => {
                let val = e.target.value.replace(/^\s+|\s+$/g, '');
                if (val.length > 10) val = val.slice(0, 10);
                setPrenume(val);
              }}
            />
          </div>
          <div className="input">
            <span className="label">Data Nasterii</span>
            <input
              type="text"
              className="field"
              placeholder="dd/mm/yyyy"
              autoComplete="off"
              autoCorrect="off"
              pattern="^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\\d{4}$"
              maxLength={10}
              value={birth}
              onChange={e => {
                let value = e.target.value.replace(/[^0-9]/g, '');
                if (value.length > 8) value = value.slice(0, 8);
                let day = value.slice(0,2);
                let month = value.slice(2,4);
                if (day.length === 2 && (parseInt(day,10) < 1 || parseInt(day,10) > 31)) return;
                if (month.length === 2 && (parseInt(month,10) < 1 || parseInt(month,10) > 12)) return;
                let formatted = value;
                if (value.length > 4) formatted = value.slice(0,2) + '/' + value.slice(2,4) + '/' + value.slice(4);
                else if (value.length > 2) formatted = value.slice(0,2) + '/' + value.slice(2);
                setBirth(formatted);
              }}
            />
          </div>
          <div className="input">
            <span className="label">Sex</span>
            <div className="sex-boxes">
              <input type="radio" id="male" name="sex" className="sex-radio" hidden checked={sex===0} onChange={()=>setSex(0)} />
              <label htmlFor="male" className="sex-box male">Male</label>
              <input type="radio" id="female" name="sex" className="sex-radio" hidden checked={sex===1} onChange={()=>setSex(1)} />
              <label htmlFor="female" className="sex-box female">Female</label>
            </div>
          </div>
        </div>
        <button className='btn-confirm' onClick={handleClickBtn} disabled={!allFilled}>Register</button>
      </div>
    </div>
  ) : null
}
export default App
