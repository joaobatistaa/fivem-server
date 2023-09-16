import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import LOCALES from './locales.json';
import CONFIG from '../config';

i18n.use(initReactI18next)
    .init({
        returnNull: false,
        resources: LOCALES,
        lng: CONFIG.DEFAULT_LOCALE,
        fallbackLng: CONFIG.DEFAULT_LOCALE,
        interpolation: {
            escapeValue: false
        }
    });

export default i18n;