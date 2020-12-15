AMB = AMB or {}
AMB.Config = AMB.Config or {}

AMB.Config.dev          = true
AMB.Config.debug_flag   = 1
AMB.Config.log_flag     = 2
AMB.Config.gamemode     = 'sandbox'
AMB.Config.server_dir   = 'server_name'

AMB.Loader.ConnectKernel()

AMB.Loader.ConnectModule( 'gamemode', 'The useless description of a main module =) ' )
