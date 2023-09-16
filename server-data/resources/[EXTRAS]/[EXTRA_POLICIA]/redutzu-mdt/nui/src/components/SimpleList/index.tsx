import React, { useCallback } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { template } from '../../utils/misc';
import './styles.scss';

interface Props {
    label: string;
    results: any[];
    icon: string;
    main_template: string;
    secondary_template?: string;
    redirect?: string;
    onRightClick?: (...args: any[]) => void;
}

const SimpleList: React.FC<Props> = ({ label, results, icon, main_template, secondary_template, redirect, onRightClick }) => {
    const { t } = useTranslation('translation');
    const navigate = useNavigate();

    const handleClick = useCallback((result: any) => {
        if (!redirect) return;
        let url: string = template(redirect, result);
        return navigate(url);
    }, [redirect]);

    return results.length ? (
        <div className='simple-list'>
            <div className='header'>
                <h1>{label}</h1>
            </div>
            <div className='results'>
                {
                    results.map((result, index) => 
                        <div 
                            className='result' 
                            onClick={() => handleClick(result)}
                            onContextMenu={() => onRightClick && onRightClick(result)}
                            key={index}
                        >
                            <div className='icon'>
                                <i className={icon}></i>
                                <h1>
                                    <Trans t={t}>
                                        {template(main_template, result)}
                                    </Trans>
                                </h1>
                            </div>
                            { secondary_template && <p>{template(secondary_template, result)}</p> }
                        </div>
                    )
                }
            </div>
        </div>
    ) : null;
}
  
export default SimpleList;
  