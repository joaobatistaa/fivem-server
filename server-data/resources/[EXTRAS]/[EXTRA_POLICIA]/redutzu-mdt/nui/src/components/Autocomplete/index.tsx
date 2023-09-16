import React, { useState } from 'react';
import { useQuery } from 'react-query';
import { DebounceInputProps } from 'react-debounce-input';
import { fetchNui, template } from '../../utils/misc';

import CONFIG from '../../config';

// Components
import Input from '../Input';

// Assets
import './styles.scss';

interface Result {
    template: string;
}

interface Item {
    icon: string | null;
    template: string;
}

interface Props {
    table: string;
    max_selected?: number;
    max_results?: number;
    input: DebounceInputProps<HTMLInputElement, any> & { error?: string };
    result: Result;
    item: Item;
    identifier: string;
    selected?: any[];
    onSelect: (value: any) => void;
}

const Autocomplete: React.FC<Props> = settings => {
    const [query, setQuery] = useState<string>('');
    const [selected, setSelected] = useState<any[]>(settings.selected || []);

    const { data } = useQuery(['autocomplete', query], () =>
        fetchNui('search', {
            type: settings.table,
            query: `%${query}%`,
            limit: settings.max_results || CONFIG.SETTINGS.MAX_RESULTS
        }).then(data => {
            data = data.filter((item: any) => !selected.find(selected => selected[settings.identifier] === item[settings.identifier]))
                    .slice(0, CONFIG.SETTINGS.MAX_FORM_RESULTS);

            return data; 
        }),
    { enabled: Boolean(query) });

    const selectResult = (result: any) => {
        if (selected.find(item => item[settings.identifier] === result[settings.identifier])) return;
        
        setQuery('');
        setSelected(results => [...results, result]);

        settings.onSelect({
            target: {
                id: settings.input.id,
                value: [...selected, result]
            }
        });
    }

    const removeSelected = (index: number) => {
        let condition = (item: any, i: number) => i !== index;
        setSelected(results => results.filter(condition));

        settings.onSelect({
            target: {
                id: settings.input.id,
                value: selected.filter(condition)
            },
        });
    }

    return (
        <div className='autocomplete'>
            {selected.length ? (
                <div className='selected-items'>
                    {selected.map((item, index) => (
                        <div className='selected-item' key={index}>
                            <div className='text'>
                                {settings.item.icon ? <i className={settings.item.icon}></i> : null}
                                <h1>{template(settings.item.template, item)}</h1>
                            </div>
                            <div className='delete'>
                                <i 
                                    className='fas fa-times'
                                    onClick={() => removeSelected(index)} 
                                />
                            </div>
                        </div>
                    ))}
                </div>
            ) : null}
            
            <Input 
                {...settings.input}
                value={query}
                disabled={selected.length >= (settings.max_selected || CONFIG.SETTINGS.MAX_SELECTED)}
                onChange={event => setQuery(event.target.value)}
            />

            { (data || []).length ? (
                <div className='results'>
                    { 
                        (data || []).map((result: any, index: number) => (
                            <div className='result' key={index} onClick={() => selectResult(result)}>
                                <div className='text'>
                                    <h1>{template(settings.result.template, result)}</h1>
                                </div>
                            </div>
                        ))
                    }
                </div>
            ) : null}
        </div>
    );
}
  
export default Autocomplete;
  