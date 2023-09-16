fx_version "adamant"

game "gta5"

data_file 'INTERIOR_PROXY_ORDER_FILE' "interiorproxies.meta"
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
data_file "DLC_ITYP_REQUEST" "stream/assalto_banco_principal/props.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/escudo/shield.ytyp"
data_file 'DLC_ITYP_REQUEST' "stream/smartphone/prop_phonequasar_mega.ytyp"

files {
    "stream/assalto_banco_principal/ch_prop_gold_bar_01a.ydr",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01a.ydr",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01a.ytd",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01b.ydr",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01b.ytd",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01c.ydr",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_01c.ytd",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_empty.ydr",
    "stream/assalto_banco_principal/ch_prop_gold_trolly_empty.ytd",
	"stream/smartphone/prop_phonequasar_mega.ytyp",
    "stream/smartphone/prop_phone_mega_1.ydr",
    "stream/smartphone/prop_phone_mega_2.ydr",
    "stream/smartphone/prop_phone_mega_3.ydr",
    "stream/smartphone/prop_phone_mega_4.ydr",
    "stream/smartphone/prop_phone_mega_5.ydr",
    "stream/smartphone/prop_phone_mega_6.ydr",
    "stream/smartphone/prop_phone_mega_7.ydr",
    "stream/smartphone/prop_phone_mega_8.ydr",
    "stream/smartphone/prop_phone_mega_9.ydr",
    "stream/smartphone/prop_phone_mega_10.ydr",
    "interiorproxies.meta",
    "weapons.meta"
}

dependency '/assetpacks'

client_script 'client.lua'


