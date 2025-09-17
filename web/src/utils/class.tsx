import type { User } from "./types";
import { fetchNui } from './fetchNui';

export class RegisterUser implements User {
  name: string;
  surname: string;
  dob: string;
  sex: number;

  constructor(nume: string, prenume: string, dob: string, sex: number) {
    this.name = nume;
    this.surname = prenume;
    this.dob = dob;
    this.sex = sex;
  }

  isValidDate(str: string) {
    const match = str.match(
      /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(\d{4})$/
    );
    if (!match) return false;
    const day = parseInt(match[1], 10);
    const month = parseInt(match[2], 10);
    const year = parseInt(match[3], 10);
    if (month < 1 || month > 12) return false;
    if (day < 1) return false;
    const daysInMonth = [31,(year % 4 === 0 && year % 100 !== 0) || year % 400 === 0 ? 29 : 28,31,30,31,30,31,31,30,31,30,31];
    if (day > daysInMonth[month - 1]) return false;
    return true;
  }

  isAgeOk(): boolean {
    if (!this.isValidDate(this.dob)) return false;
    const [dayStr, monthStr, yearStr] = this.dob.split("/");
    const day = parseInt(dayStr, 10);
    const month = parseInt(monthStr, 10);
    const year = parseInt(yearStr, 10);
    const birthDate = new Date(year, month - 1, day);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age >= 18 && age <= 60;
  }

  register() {
    fetchNui('REGISTER_IDENTITY', { firstname: this.name, lastname: this.surname, birthdate: this.dob, gender: this.sex });
  }
}
