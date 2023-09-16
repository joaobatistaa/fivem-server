import React from 'react';
import { useQuery, useQueryClient, useMutation } from 'react-query';
import { useTranslation } from 'react-i18next';
import { fetchNui } from '../../utils/misc';
import { useEvent } from '../../hooks/useEvent';
import { checkPermission } from '../../utils/permissions';

// Types
import Alert from '../../types/alert';

// Components
import Page from '../../components/Page';
import Map from '../../components/Map';
import Form from './Form';

import './styles.scss';

const Alerts: React.FC = () => {
    const { t } = useTranslation('translation');

    const queryCache = useQueryClient();
    
    const { data, refetch } = useQuery('alerts', () =>
        fetchNui('GetAlerts')
            .then(data => data)
    )

    const markers = (data || []).map((alert: Alert) => {
        const coords = JSON.parse(alert.coords);

        return {
            position: [coords.y, coords.x],
            label: `#${alert.id} ${alert.label} | ${alert.description} | ${alert.address}`,
            data: alert
        }
    });

    const { mutate } = useMutation({
        mutationFn: async (alert: Alert) => {
            let permission = await checkPermission('alerts.take', t);
            if (!permission) return;

            return fetchNui('TakeAlert', { id: alert.id })
                .then(data => data)
        },
        onSuccess: () => queryCache.invalidateQueries('alerts')
    });

    useEvent('SetAlerts', refetch);

    return (
        <Page header={{ title: t('alerts.title'), subtitle: t('alerts.subtitle') }}>
            <div className='half-grid'>
                <Form />

                <Map 
                    markers={markers}
                    onClick={mutate}
                />
            </div>
        </Page>
    );
}

export default Alerts;
