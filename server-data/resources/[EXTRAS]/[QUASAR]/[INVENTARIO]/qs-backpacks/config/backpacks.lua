Config = Config or {}
-- (important) do not use both prop and cloth at same time just one.
-- (IMPORTANT INTEGRATION WITH QS-SHOPS)
-- If you want to add the backpack to a qs-shop, you must add an ID to the item. this is the example :

--[[ 

     qs-shops/config/config.lua
     
     [1] = {
          name = "backpack",
          label = 'Backpack',
          price = 250,
          amount = 100,
          info = { bagid = 'ID-'..math.random(111111,999999) },
          type = "item",
          slot = 1,
     }, 
     [2] = {
          name = "my_custom_backpack",
          label = 'UwU Backpack',
          price = 250,
          amount = 100,
          info = { bagid = 'UwU ID-'..math.random(111111,999999) },
          type = "item",
          slot = 2,
     }, 
 ]]

 Config.items = {
    ['backpack'] = { --- Item name
         slots = 5, -- Slots in inventory
         weight = 10000, -- Max Weight
         locked = false, -- or 'password' to add password
         prop = {
              model = 'vw_prop_vw_backpack_01a',
              animation = {
                   dict = 'amb@world_human_hiker_standing@female@base',
                   anim = 'base',
                   bone = 'Back', -- LeftHand | RightHand
                   attaching_position = {
                        x = -0.10, -- Up - Down
                        y = -0.05, -- Forward Backward
                        z = 0.0, -- Left - Right
                        x_rotation = 10.0,
                        y_rotation = 90.0,
                        z_rotation = 175.0,
                   }
              },
         },
    },
    ['backpack2'] = {
         slots = 6,
         weight = 10000,
         cloth = {
         -- qb-clothing 
         ["bag"] = { item = 45, texture = 0 }

         --[[ esx-skin
              male = { ['bags_1'] = 29},
              female = { ['bags_1'] = 93 },
         ]]

          }
    },
    ['briefcase'] = {
         slots = 3,
         weight = 5000,
         locked = 'password', -- Add password
         prop = {
              model = 'prop_ld_suitcase_01',
              animation = {
                   dict = 'missheistdocksprep1hold_cellphone',
                   anim = 'static',
                   bone = 'RightHand',
                   attaching_position = {
                        x = 0.10,
                        y = 0.0,
                        z = 0.0,
                        x_rotation = 0.0,
                        y_rotation = 280.0,
                        z_rotation = 53.0,
                   }
              },
         },
    },
    ['paramedicbag'] = {
         slots = 10,
         weight = 10000,
         prop = {
              model = 'xm_prop_smug_crate_s_medical',
              animation = {
                   dict = 'missheistdocksprep1hold_cellphone',
                   anim = 'static',
                   bone = 'RightHand',
                   attaching_position = {
                        x = 0.29,
                        y = -0.05,
                        z = 0.0,
                        x_rotation = -25.0,
                        y_rotation = 280.0,
                        z_rotation = 75.0,
                   }
              },
         }
    },
}
