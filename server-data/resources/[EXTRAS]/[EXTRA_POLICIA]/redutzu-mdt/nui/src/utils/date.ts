import moment from 'moment';
import i18n from '../locales/index';

export const fromNow = (timestamp: number | null) => {
    if (!timestamp) return;

    let locale = i18n.language.slice(0, 2);
    moment.locale(locale);

    let data = moment(timestamp).format('DDMMYYYYkkmmss');
    let format = moment(data, 'DDMMYYYYkkmmss').fromNow();
    
    return format;
};

export const sortDate = (first: any, second: any) => {
    let a: Date = new Date(first.createdAt);
    let b: Date = new Date(second.createdAt);
    
    return b.getTime() - a.getTime();
};
