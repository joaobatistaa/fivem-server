fx_version 'cerulean'
game 'gta5'

data_file 'DLC_ITYP_REQUEST' 'stream/10cargarage.ytyp' -- 10 car garage shell
data_file 'DLC_ITYP_REQUEST' 'stream/40cargarage.ytyp'

files {
    'stream/10cargarage.ytyp',
    'stream/40cargarage.ytyp'
}

dependency '/server:4960' -- ⚠️PLEASE READ⚠️; Requires at least server build 4960.
dependency '/assetpacks'