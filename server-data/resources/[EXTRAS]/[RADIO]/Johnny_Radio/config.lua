Config = {}

--Config.Locale = 'br'

Config.RestrictedChannels = 10 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = true --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'Não estás em nenhuma frequência!',
  ['on_radio'] = 'Estás na frequência: <b>',
  ['joined_to_radio'] = 'Entraste na frequência: <b>',
  ['restricted_channel_error'] = 'Não tens acesso a esta frequência!',
  ['you_on_radio'] = 'Já estás nesta frequência: <b>',
  ['you_leave'] = 'Saiste da frequência: <b>',
  ['freq_invalid'] = 'Frequência Inválida!'

}
