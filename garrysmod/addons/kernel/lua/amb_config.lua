AMB.Config = AMB.Config or {}

-- github: https://github.com/Titanovsky/architecture-of-ambition
AMB.Config.dev          = true
AMB.Config.logs         = true
AMB.Config.gamemode     = 'gamemode'
AMB.Config.server_dir   = 'my_server'
AMB.Config.prefix       = 'mysvr'
AMB.Config.language     = 'ru' -- ru, en

AMB.Loader.ConnectMicroKernel()
-- AMB.Loader.ConnectResourceWorkshopFromAddons() -- check wiki

-- Example:
-- AMB.Loader.ConnectModule( 'anymodule', 'The good module, really good :)' )