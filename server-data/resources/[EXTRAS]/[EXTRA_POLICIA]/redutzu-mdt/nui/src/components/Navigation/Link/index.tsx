import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { Trans, useTranslation } from 'react-i18next';
import { hasPermission } from '../../../utils/permissions';

// Assets
import Permission from '../../../types/permission';

interface Link {
    id: string;
    label: string;
    icon: string;
}

const NavLink: React.FC<Link> = ({ id, label, icon }) => {
    const [visible, setVisible] = useState<boolean>(true);
    const { t } = useTranslation('translation');

    const location = useLocation();
    const navigate = useNavigate();

    const active = location.pathname === id ? 'active' : '';

    const handleClick = () => {
        if (location.pathname === id) return;
        return navigate(id);
    }

    useEffect(() => {
        const permission = hasPermission(`${label}.view` as Permission);
        
        permission.then(response => {
            if (!response)
                return setVisible(false);
        });
    }, []);

    if (!visible) return null;

    return (
        <li className={`link ${active}`} onClick={handleClick}>
            <div className='icon'>
                <i className={icon}></i>
            </div>
            <small><Trans t={t}>pages.{label}</Trans></small>
        </li>
    )
}
  
export default NavLink;
  