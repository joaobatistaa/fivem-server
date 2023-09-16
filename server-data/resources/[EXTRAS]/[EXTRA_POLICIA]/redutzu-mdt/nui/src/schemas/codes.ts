import * as yup from 'yup';
import CONFIG from '../config';

const schema = yup.object().shape({
    name: yup.string().required('errors.codes.name.required'),
    code: yup.string().required('errors.codes.code.required').matches(CONFIG.CONSTANTS.CODE_FORMAT.REGEX, 'errors.codes.code.format')
});

export default schema;