--██████╗░██████╗░░█████╗░░█████╗░███████╗░██████╗░██████╗███████╗░██████╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝
--██████╔╝██████╔╝██║░░██║██║░░╚═╝█████╗░░╚█████╗░╚█████╗░█████╗░░╚█████╗░
--██╔═══╝░██╔══██╗██║░░██║██║░░██╗██╔══╝░░░╚═══██╗░╚═══██╗██╔══╝░░░╚═══██╗
--██║░░░░░██║░░██║╚█████╔╝╚█████╔╝███████╗██████╔╝██████╔╝███████╗██████╔╝
--╚═╝░░░░░╚═╝░░╚═╝░╚════╝░░╚════╝░╚══════╝╚═════╝░╚═════╝░╚══════╝╚═════╝░

Config.ProcessDistance = 1.1 --Distance at which the DrawText3Ds are viewed.
Config.fadeTime = 1500 --Black screen when entering or exiting, use 0 if you want there to be none.

Config.Progress = {
    --Read slowly if you want to modify the processes, it is a somewhat tedious job.
    Meth = {
        inside = {
            coords = vec3(996.81, -3200.64, -36.39)
        },
        outside = {
            coords = vec3(3688.454, 4562.913, 25.183) --  1561.46, -1693.57, 89.21
        },
        ["cook_meth"] = {
            mainText = "~b~E~s~ - Processar Meta",
            progText = "A processar meta...",
            requireRate = 40,
            requireItem = "chemicals",
            notifyname = "Químicos",
            rewardItem = "meth",
            rewardRate = 40,
            locations = {
                [1] = {
                    location = vector3(1005.80, -3200.40, -38.90),
                    offset = vector3(-4.88, -1.95, 0.0),
                    rotation = vector3(0.0, 0.0, 0.0),
                    active = true
                }
            },
            time = 73000,
            act = "Meth",
            scene = 1,
            active = true
        },
        ["package_meth"] = {
            mainText = "~b~E~s~ - Empacotar Meta",
			progText = "A empacotar meta...",
            requireRate = 20,
            requireItem = "meth",
            notifyname = "Meta Processada",
            rewardItem = "meth_packaged",
            rewardRate = 20,
            locations = {
                [1] = {
                    location = vector3(1011.80, -3194.90, -38.99),
                    offset = vector3(4.48, 1.7, 1.0),
                    rotation = vector3(0.0, 0.0, 0.0),
                    active = true
                },
                [2] = {
                    location = vector3(1014.19, -3195.02, -38.99),
                    offset = vector3(4.48, 1.7, 1.0),
                    rotation = vector3(0.0, 0.0, 0.0),
                    active = true
                },
                [3] = {
                    location = vector3(1016.49, -3194.9, -38.99),
                    offset = vector3(4.48, 1.7, 1.0),
                    rotation = vector3(0.0, 0.0, 0.0),
                    active = true
                }
            },
            time = 50000,
            act = "Meth",
            scene = 2,
            active = true
        }
    },
    Cocaine = {
        inside = {
            coords = vec3(1088.66, -3187.55, -38.99)
        },
        outside = {
            coords = vec3(-496.019, -2910.95, 6.0003)
        },
        ["process_cocaine"] = {
			mainText = "~b~E~s~ - Processar Cocaína",
			progText = "A processar cocaína...",
			requireRate = 20, 
			requireItem = "cocaine",
			notifyname = 'Cocaína',
			rewardItem = "cocaine_cut",
			rewardRate = 20,
            locations = {
                [1] = {
                    location = vector3(1099.544, -3194.13, -39.60),
                    rotation = vector3(0.0, 0.0, -90.0),
                    offset = vector3(0.31, -1.71, 0.0),
                    active = true
                },
                [2] = {
                    location = vector3(1095.41, -3196.57, -38.99),
                    rotation = vector3(0.0, 0.0, -180.0),
                    offset = vector3(-1.8, -0.4, 0.6),
                    active = true
                },
                [3] = {
                    location = vector3(1093.03, -3196.59, -38.99),
                    rotation = vector3(0.0, 0.0, -180.0),
                    offset = vector3(-1.8, -0.4, 0.6),
                    active = true
                },
                [4] = {
                    location = vector3(1090.39, -3196.57, -38.99),
                    rotation = vector3(0.0, 0.0, -180.0),
                    offset = vector3(-1.8, -0.4, 0.6),
                    active = true
                },
                [5] = {
                    location = vector3(1101.86, -3193.74, -38.99),
                    rotation = vector3(0.0, 0.0, -180),
                    offset = vector3(-2, -0.4, 0.6),
                    active = true
                }
            },
            time = 25000,
            act = "Cocaine",
            scene = 1,
            active = true
        },
        ["package_cocaine"] = {
            mainText = "~b~E~s~ - Empacotar Cocaína",
			progText = "A empacotar cocaína...",
			requireRate = 40, 
			requireItem = "cocaine_cut",
			notifyname = 'Cocaína Processada',
			rewardItem = "cocaine_packaged",
			rewardRate = 40,
            locations = {
                [1] = {
                    location = vector3(1101.245, -3198.82, -39.60),
                    offset = vector3(7.663, -2.222, 0.395),
                    rotation = vector3(0.0, 0.0, 0.0),
                    active = true
                }
            },
            time = 59000,
            act = "Cocaine",
            scene = 2,
            active = true
        }
    },
    Weed = {
        inside = {
            coords = vec3(1066.4, -3183.41, -39.16)
        },
        outside = {
            coords = vec3(1417.011, 6339.148, 24.398)
        },
        ["trim_plant"] = {
            mainText = "~b~E~s~ - Processar Marijuana",
			progText = "A processar marijuana...",
			requireRate = 40, 
			requireItem = "weed",
			notifyname = 'Marijuana',
			rewardItem = "weed_packaged",
			rewardRate = 20,
            locations = {
                [1] = {
                    location = vector3(1038.14, -3205.45, -38.16),
                    offset = vector3(-0.3, 0.4, 0.96),
                    rotation = vector3(0.0, 0.0, 90.0),
                    active = true
                },
                [2] = {
                    location = vector3(1033.67, -3205.56, -38.16),
                    offset = vector3(-0.3, 0.4, 0.96),
                    rotation = vector3(0.0, 0.0, 90.0),
                    active = true
                }
            },
            time = 30000,
            act = "Weed",
            scene = 2,
            active = true
        }
    },
}