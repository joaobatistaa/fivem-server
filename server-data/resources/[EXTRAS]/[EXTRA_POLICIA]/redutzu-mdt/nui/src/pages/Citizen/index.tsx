import React, { useContext } from 'react';
import { useQuery } from 'react-query';
import { useNavigate, useParams } from 'react-router-dom';
import { Trans, useTranslation } from 'react-i18next';
import { showNotification } from '@mantine/notifications';
import { fetchNui } from '../../utils/misc';
import { checkPermission } from '../../utils/permissions';
import moment from 'moment';

// Form
import { useFormik } from 'formik';
import schema from '../../schemas/citizen';

// Contexts
import Modals from '../../contexts/Modal';

// Components
import Page from '../../components/Page';
import Tooltip from '../../components/Tooltip';
import Input from '../../components/Input';
import FormattedInput from '../../components/FormattedInput';
import SimpleList from '../../components/SimpleList';
import Image from './Image';

// Assets
import './styles.scss';

const Citizen: React.FC = () => {
    const { createModal } = useContext(Modals);
    const { t } = useTranslation('translation');

    const parameters = useParams();
    const navigate = useNavigate();

    const { isLoading, data } = useQuery(['citizen', parameters.identifier], () =>
        fetchNui('search', {
            type: 'citizen',
            query: parameters.identifier,
            single: true
        })
        .then(async data => {
            let response = await fetchNui('GetCitizenData', { identifier: parameters.identifier });

            return {
                ...data,
                ...response,
                incidents: response.list[0],
                evidences: response.list[1],
                warrants: response.list[2],
                vehicles: response.list[3],
                properties: response.list[4]
            }
        })
    )

    const firstname = !isLoading ? data.firstname : 'Loading...';
    const lastname = !isLoading ? data.lastname : 'Loading...';
    const phone_number = !isLoading ? data.phone_number : 'Loading...';
    const dateofbirth = !isLoading ? data.dateofbirth : 'Loading...';
    const sex = !isLoading ? data.sex : 'Loading...';
    const mdt_height = !isLoading ? data.mdt_height : 'Loading...';
    const mdt_description = !isLoading ? data.mdt_description : 'Loading...';
    const mdt_image = !isLoading ? data.mdt_image : 'Loading...';
    const wanted = !isLoading ? data.wanted : false;
    const licenses = !isLoading ? data.licenses : [];
    const incidents = !isLoading ? data.incidents : [];
    const evidences = !isLoading ? data.evidences : [];
    const warrants = !isLoading ? data.warrants : [];
    const vehicles = !isLoading ? data.vehicles : [];
    const properties = !isLoading ? data.properties : [];
    const job = !isLoading ? data.job : { label: 'Loading...', grade: 'Loading...' };

    const { values, handleBlur, handleChange, submitForm } = useFormik({
        initialValues: {
            notes: mdt_description || '',
            height: mdt_height || '',
            image: mdt_image || ''
        },
        validationSchema: schema,
        enableReinitialize: true,
        onSubmit: async (values) => {
            let permission = await checkPermission('citizens.edit', t);
            if (!permission) return;

            let request = fetchNui('update', {
                type: 'citizen',
                identifierType: 'identifier',
                identifier: parameters.identifier,
                values: {
                    mdt_description: values.notes,
                    mdt_height: values.height
                }
            });

            request.then(response => {
                if (!response.status) return;
                
                showNotification({
                    title: t('citizens.notification.update.title') as string,
                    message: t('citizens.notification.update.message') as string,
                    autoClose: 5000
                });
    
                return navigate('/citizens');
            });
        }
    });

    return (
        <Page header={{ title: t('citizens.citizen.title'), subtitle: t('citizens.citizen.subtitle'), backable: true }}>
            <div className='citizen'>
                <div className='citizen-header'>
                    <Image
                        identifier={parameters.identifier}
                        mdt_image={values.image}
                        onChange={handleChange}
                    />
                    { 
                        wanted && (
                            <div className='wanted'>
                                <i className='fa-solid fa-handcuffs'></i>
                                <Trans t={t}>citizens.wanted</Trans>
                                <i className='fa-solid fa-handcuffs'></i>
                            </div>
                        )
                    }
                    <h1>{firstname} {lastname}</h1>
                </div>
                <div className='information'>
                    <div className='title'>
                        <Tooltip text={t('common.tooltip.save')} position='right'>
                            <h1><Trans t={t}>words.information</Trans></h1>
                        </Tooltip>
                        <i className='fa-solid fa-floppy-disk' onClick={submitForm}></i>
                    </div>
                    <div className='content'>
                        <p><b><Trans t={t}>words.firstname</Trans>:</b>{firstname}</p>
                        <p><b><Trans t={t}>words.lastname</Trans>:</b>{lastname}</p>
                        <p><b><Trans t={t}>words.gender</Trans>:</b>{sex.toUpperCase()}</p>
                        <p><b><Trans t={t}>words.birth</Trans>:</b>{dateofbirth} ({moment(dateofbirth, 'MM-DD-YYYY').fromNow(true)})</p>
                        <p><b><Trans t={t}>words.phone</Trans>:</b>{phone_number}</p>
                        <p><b><Trans t={t}>words.job</Trans>:</b>{job.label} ({job.grade})</p>
                        <FormattedInput
                            id='height'
                            placeholder={t('words.height')}
                            value={values.height || ''}
                            change={handleChange}
                            onBlur={handleBlur}
                            format='number'
                            format_options={{
                                liveUpdate: true,
                                max: 230
                            }}
                        />

                        <Input
                            id='notes'
                            placeholder={t('words.notes')}
                            value={values.notes || ''}
                            maxLength={300}
                            onChange={handleChange}
                            onBlur={handleBlur}
                        />
                    </div>
                </div>
                <div className='body'>
                    <SimpleList 
                        label={t('citizens.incidents')}
                        results={incidents}
                        icon='fa-solid fa-shield-halved'
                        main_template='#{id} {name}'
                        secondary_template='~createdAt~'
                        redirect='/incident/{id}'
                    />
                    <SimpleList 
                        label={t('citizens.evidences')}
                        results={evidences}
                        icon='fa-solid fa-file-lines'
                        main_template='#{id} {name}'
                        secondary_template='~createdAt~'
                        redirect='/evidence/{id}'
                    />
                    <SimpleList 
                        label={t('citizens.warrants')}
                        results={warrants}
                        icon='fa-solid fa-folder-minus'
                        main_template='#{id} {reason}'
                        secondary_template='~createdAt~'
                        redirect='/warrant/{id}'
                    />
                    <SimpleList 
                        label={t('citizens.vehicles')}
                        results={vehicles}
                        icon='fa-solid fa-car'
                        main_template='{plate}'
                        redirect='/vehicle/{plate}'
                    />
                    <SimpleList 
                        label={t('citizens.properties')}
                        results={properties}
                        icon='fa-solid fa-house'
                        main_template='#{id} {name}'
                        redirect='/house/{id}'
                    />
                    <SimpleList 
                        label={t('citizens.licenses')}
                        results={licenses || []}
                        icon='fa-solid fa-id-card-clip'
                        main_template='citizens.licenses_list.{type}'
                        onRightClick={(license) => {
                            createModal({
                                title: t('citizens.modal.license_remove.title'),
                                description: t('citizens.modal.license_remove.message'),
                                icon: 'fa-solid fa-id-card-clip',
                                onClick: () => {
                                    let request = fetchNui('RemoveCitizenLicense', {
                                        type: license.type,
                                        identifier: license.owner
                                    });

                                    return request.then(() => {
                                        showNotification({
                                            title: t('citizens.notification.take.title') as string,
                                            message: t('citizens.notification.take.message') as string,
                                            autoClose: 5000
                                        });

                                        return navigate('/citizens');
                                    });
                                }
                            })
                        }}
                    />
                </div>
            </div>
        </Page>  
    );
}

export default Citizen;
