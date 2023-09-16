import React from 'react';
import { useTranslation, Trans } from 'react-i18next';
import { MapContainer, TileLayer, Marker, MarkerProps, Popup } from 'react-leaflet';
import Leaflet, { extend, Projection, Transformation } from 'leaflet';

import CONFIG from '../../config';

// Components
import Button from '../Button';

// Assets

import './styles.scss';
import 'leaflet/dist/leaflet.css';

const MarkerIcon = Leaflet.icon({
    iconUrl: require('../../assets/marker.png'),
    iconSize: [20, 30]
});

// Constants

const CENTER_X = 117.3;
const CENTER_Y = 172.8;
const SCALE_X = 0.02072;
const SCALE_Y = 0.0205;
const MAX_BOUNDS: [[number, number], [number, number]] = [[8000.0, -4000.0], [-4000.0, 4000.0]];

// Typings

interface MarkerExtendedProps extends MarkerProps {
    label: string;
    data?: any;
}

interface Props {
    markers?: MarkerExtendedProps[];
    onClick: (...args: any[]) => void;
}

const Map: React.FC<Props> = ({ markers, onClick }) => {
    const { t } = useTranslation('translation');

    const CRS = extend({}, Leaflet.CRS.Simple, {
        projection: Projection.LonLat,
        scale: (zoom: number) => Math.pow(2, zoom),
        zoom: (sc: number) => Math.log(sc) / 0.6931471805599453,
        distance: (postion: any, target: any) => {
            let x_difference: number = target.lng - postion.lng;
            let y_difference: number = target.lat - postion.lat;
            return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
        },
        transformation: new Transformation(SCALE_X, CENTER_X, -SCALE_Y, CENTER_Y),
        infinite: true
    });

    return (
        <MapContainer
            className='game-map'
            crs={CRS}
            minZoom={3}
            maxZoom={5}
            preferCanvas={true}
            center={[0, 0]}
            zoom={4}
            zoomControl={false}
            maxBounds={MAX_BOUNDS}
        >
            <TileLayer noWrap url={CONFIG.CONSTANTS.MAP_API} />
            { 
                (markers || []).map((marker: MarkerExtendedProps, index: number) => (
                    <Marker {...marker} icon={MarkerIcon} key={index}>
                        <Popup>
                            <h1><Trans>alerts.notification.take.message</Trans></h1>

                            <p>{marker.label}</p>

                            <Button 
                                label={t('words.yes')}
                                style={{ width: '100%' }}
                                onClick={() => onClick(marker.data)}
                            />
                        </Popup>
                    </Marker>
                ))
            }
        </MapContainer>
    );
}

export default Map;