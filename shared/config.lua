Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


-- Thank you for downloading this script!

-- Below you can change multiple options to suit your server needs.


Config.CoreSettings = {
    Debug = {
        Prints = true, -- sends debug prints to f8 console and txadmin server console
    },
    Target = {
        Type = 'qb', -- taregt script name support for qb-target and ox_target        
        -- EDIT CLIENT/cl_funcs.lua TO ADD YOUR OWN TARGET SUPPORT
        -- use 'qb' for qb-target
        -- use 'ox' for ox_target
        -- use 'custom' for your own custom target system
    },
    Notify = {
        Type = 'qb', -- notification type, support for qb-core notify, okokNotify, mythic_notify and ox_lib notify
        -- EDIT CLIENT/cl_funcs.lua & SERVER/sv_funcs.lua TO ADD YOUR OWN NOTIFY SUPPORT
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for mythic_notify
        --use 'ox' for ox_lib notify
        --use 'custom' for your own custom notifications system
    },
    Inventory = { -- support for qb-inventory and ox_inventory
    -- EDIT SERVER/sv_funcs.lua TO ADD YOUR OWN INVENTORY SUPPORT
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
        --use 'custom' for your own custom inventory system
    },
    Security = {
        MaxDistance = 4.0, -- max permitted distance for security checks - do not set this too high and also bare in mind the target distance too
        DropPlayer = true, -- kicks the player from the server if the fail any of the security checks
        BanPlayer = false, -- bans the player from the server if the fail any of the security checks
    },
}



Config.Shops = {
    ['Supermarket'] = { -- the key is the shop name
        info = {
            shopLabel = 'Supermarket', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Supermarket" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Supermarket', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_shopkeep_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(24.47, -1346.62, 29.5, 271.66),
            vector4(-3039.54, 584.38, 7.91, 17.27),
            vector4(-3242.97, 1000.01, 12.83, 357.57),
            vector4(1728.07, 6415.63, 35.04, 242.95),
            vector4(1959.82, 3740.48, 32.34, 301.57),
            vector4(549.13, 2670.85, 42.16, 99.39),
            vector4(2677.47, 3279.76, 55.24, 335.08),
            vector4(2556.66, 380.84, 108.62, 356.67),
            vector4(372.66, 326.98, 103.57, 253.73),
        },
        inventory = { 
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'tosti',         price = 2,   amount = 50 },
            { name = 'water_bottle',  price = 2,   amount = 50 },
            { name = 'kurkakola',     price = 2,   amount = 50 },
            { name = 'twerks_candy',  price = 2,   amount = 50 },
            { name = 'snikkel_candy', price = 2,   amount = 50 },
            { name = 'sandwich',      price = 2,   amount = 50 },
            { name = 'lighter',       price = 2,   amount = 50 },
        },
    },
    ['Liqour Store'] = { -- the key is the shop name
        info = {
            shopLabel = 'Liqour Store', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Liqour Store" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Liqour Store', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_shopkeep_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(-1221.58, -908.15, 12.33, 35.49),
            vector4(-1486.59, -377.68, 40.16, 139.51),
            vector4(-2966.39, 391.42, 15.04, 87.48),
            vector4(1165.17, 2710.88, 38.16, 179.43),
            vector4(1134.2, -982.91, 46.42, 277.24),
        },
        inventory = { 
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'beer',          price = 5,   amount = 50 },
            { name = 'whiskey',       price = 10,  amount = 50 },
            { name = 'vodka',         price = 20,  amount = 50 },
        },
    },
    ['LTD Gasoline'] = { -- the key is the shop name
        info = {
            shopLabel = 'LTD Gasoline', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "LTD Gasoline" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'LTD Gasoline', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_shopkeep_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(-47.02, -1758.23, 29.42, 45.05),
            vector4(-706.06, -913.97, 19.22, 88.04),
            vector4(-1820.02, 794.03, 138.09, 135.45),
            vector4(1164.71, -322.94, 69.21, 101.72),
            vector4(1697.87, 4922.96, 42.06, 324.71),
        },
        inventory = { 
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'beer',          price = 5,   amount = 50 },
            { name = 'whiskey',       price = 10,  amount = 50 },
            { name = 'vodka',         price = 20,  amount = 50 },
            { name = 'tosti',         price = 2,   amount = 50 },
            { name = 'water_bottle',  price = 2,   amount = 50 },
            { name = 'kurkakola',     price = 2,   amount = 50 },
            { name = 'twerks_candy',  price = 2,   amount = 50 },
            { name = 'snikkel_candy', price = 2,   amount = 50 },
            { name = 'sandwich',      price = 2,   amount = 50 },
            { name = 'lighter',       price = 2,   amount = 50 },
        },
    },
    ['Hardware Store'] = { -- the key is the shop name
        info = {
            shopLabel = 'Hardware Store', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Hardware Store" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Hardware Store', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_waremech_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(45.68, -1749.04, 29.61, 53.13),
            vector4(2747.71, 3472.85, 55.67, 255.08),
            vector4(-421.83, 6136.13, 31.88, 228.2),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            --as GUNS are unique items it is wise to only stock 1 of that particular item this prevents issues with stacking serial numbers if purchasing multiple of that item. This logic does not apply to knives or ammunition
            { name = 'lockpick',          price = 200, amount = 50 },
            { name = 'repairkit',         price = 250, amount = 50, requiresJob = { 'mechanic', 'police' }, },
            { name = 'screwdriverset',    price = 350, amount = 50 },
            { name = 'phone',             price = 850, amount = 50 },
            { name = 'radio',             price = 250, amount = 50 },
            { name = 'cleaningkit',       price = 150, amount = 150 },
            { name = 'advancedrepairkit', price = 500, amount = 50, requiresJob = 'mechanic' },
        },
    },
    ['Smoke On The Water'] = { -- the key is the shop name
        info = {
            shopLabel = 'Smoke On The Water', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_SMOKING_POT', -- define a scenario used for the ped
            args = { shopType = "Smoke On The Water" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Smoke On The Water', -- blip title
        },
        models = { -- define random ped models below
            'a_m_y_hippy_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(-1168.26, -1573.2, 4.66, 105.24),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'joint',          price = 10,  amount = 50 },
            { name = 'weed_nutrition', price = 20,  amount = 50 },
            { name = 'lighter',        price = 2,   amount = 50 },
            { name = 'empty_weed_bag', price = 2,   amount = 50 },
            { name = 'rolling_paper',  price = 2,   amount = 50 },
        },
    },
    ['Ammunation'] = { -- the key is the shop name
        info = {
            shopLabel = 'Ammunation', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Ammunation" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Ammunation', -- blip title
        },
        models = { -- define random ped models below
            's_m_y_ammucity_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(809.68, -2159.13, 29.62, 1.43),
            vector4(1692.67, 3761.38, 34.71, 227.65),
            vector4(-331.23, 6085.37, 31.45, 228.02),
            vector4(253.63, -51.02, 69.94, 72.91),
            vector4(23.0, -1105.67, 29.8, 162.91),
            vector4(2567.48, 292.59, 108.73, 349.68),
            vector4(-1118.59, 2700.05, 18.55, 221.89),
            vector4(841.92, -1035.32, 28.19, 1.56),
            vector4(-1304.19, -395.12, 36.7, 75.03),
            vector4(-3173.31, 1088.85, 20.84, 244.18),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            --as GUNS are unique items it is wise to only stock 1 of that particular item this prevents issues with stacking serial numbers if purchasing multiple of that item. This logic does not apply to knives or ammunition
            { name = 'weapon_knife',         price = 250,  amount = 250 },
            { name = 'weapon_bat',           price = 250,  amount = 250 },
            { name = 'weapon_hatchet',       price = 250,  amount = 250 },
            { name = 'pistol_ammo',          price = 250,  amount = 250, },
            { name = 'weapon_pistol',        price = 2500, amount = 1, requiresLicense = 'weapon' },
            { name = 'weapon_snspistol',     price = 1500, amount = 1, requiresLicense = 'weapon' },
            { name = 'weapon_vintagepistol', price = 4000, amount = 1, requiresLicense = 'weapon' },
        },
    },
    ['Black Market'] = { -- the key is the shop name
        info = {
            shopLabel = 'Black Market', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Black Market" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Black Market', -- blip title
        },
        models = { -- define random ped models below
            'g_m_y_lost_02',
            'g_m_y_ballasout_01',
            'g_m_y_famdnf_01',
            'g_m_m_chigoon_01',
            'g_f_y_lost_01',
            'g_f_importexport_01',
            'g_f_y_vagos_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(1364.38, 6549.21, 14.61, 344.92),
            vector4(2872.72, 4458.63, 48.51, 290.45),
            vector4(2461.2, 1576.13, 33.11, 276.14),
            vector4(972.59, -94.51, 74.84, 50.55),
            vector4(-546.73, -1605.85, 18.87, 279.88),
            vector4(-1998.81, 540.9, 109.55, 218.27),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'security_card_01',  price = 5000, amount = 50 },
            { name = 'security_card_02',  price = 5000, amount = 50 },
            { name = 'advancedlockpick',  price = 5000, amount = 50 },
            { name = 'electronickit',     price = 5000, amount = 50 },
            { name = 'gatecrack',         price = 5000, amount = 50 },
            { name = 'thermite',          price = 5000, amount = 50 },
            { name = 'trojan_usb',        price = 5000, amount = 50 },
            { name = 'drill',             price = 5000, amount = 50 },
            { name = 'radioscanner',      price = 5000, amount = 50 },
            { name = 'cryptostick',       price = 5000, amount = 50 },
            { name = 'joint',             price = 5000, amount = 50 },
            { name = 'cokebaggy',         price = 5000, amount = 50 },
            { name = 'crack_baggy',       price = 5000, amount = 50 },
            { name = 'xtcbaggy',          price = 5000, amount = 50 },
            { name = 'coke_brick',        price = 5000, amount = 50 },
            { name = 'weed_brick',        price = 5000, amount = 50 },
            { name = 'coke_small_brick',  price = 5000, amount = 50 },
            { name = 'oxy',               price = 5000, amount = 50 },
            { name = 'meth',              price = 5000, amount = 50 },
            { name = 'weed_whitewidow',   price = 5000, amount = 50 },
            { name = 'weed_skunk',        price = 5000, amount = 50 },
            { name = 'weed_purplehaze',   price = 5000, amount = 50 },
            { name = 'weed_ogkush',       price = 5000, amount = 50 },
            { name = 'weed_amnesia',      price = 5000, amount = 50 },
            { name = 'weed_ak47',         price = 5000, amount = 50 },
        },
    },
    ['Prison Canteen'] = { -- the key is the shop name
        info = {
            shopLabel = 'Prison Canteen', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Prison Canteen" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Prison Canteen', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_securoguard_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(1777.59, 2560.52, 45.62, 187.83),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'sandwich',     price = 4, amount = 50 },
            { name = 'water_bottle', price = 4, amount = 50 },
        },
    },
    ['Leisure Shop'] = { -- the key is the shop name
        info = {
            shopLabel = 'Leisure Shop', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Leisure Shop" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Leisure Shop', -- blip title
        },
        models = { -- define random ped models below
            'a_m_y_beach_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(-1505.91, 1511.95, 115.29, 257.13),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'parachute',   price = 2500, amount = 10 },
            { name = 'binoculars',  price = 50,   amount = 50 },
            { name = 'diving_gear', price = 2500, amount = 10 },
            { name = 'diving_fill', price = 500,  amount = 10 },
        },
    },
    ['Police Armoury'] = { -- the key is the shop name
        info = {
            shopLabel = 'Police Armoury', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Police Armoury" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Police Armoury', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_securoguard_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(454.05, -980.27, 30.69, 89.95),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'weapon_nightstick',   price = 0, amount = 1,  requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'weapon_flashlight',   price = 0, amount = 1,  requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'handcuffs',           price = 0, amount = 50, requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'empty_evidence_bag',  price = 0, amount = 50, requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'police_stormram',     price = 0, amount = 50, requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'radio',               price = 0, amount = 50, requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'heavyarmor',          price = 0, amount = 50, requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'weapon_stungun',      price = 0, amount = 1,  requiresJob = {'police', 'bsco', 'leo',}, },
            { name = 'pistol_ammo',         price = 0, amount = 50, requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 1, },
            { name = 'smg_ammo',            price = 0, amount = 50, requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 2, },
            { name = 'shotgun_ammo',        price = 0, amount = 50, requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 3, },
            { name = 'rifle_ammo',          price = 0, amount = 50, requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 3, },
            { name = 'weapon_pistol',       price = 0, amount = 1,  requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 1, },
            { name = 'weapon_smg',          price = 0, amount = 1,  requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 2,},
            { name = 'weapon_pumpshotgun',  price = 0, amount = 1,  requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 3,},
            { name = 'weapon_carbinerifle', price = 0, amount = 1,  requiresLicense = 'weapon', requiresJob = {'police', 'bsco', 'leo',}, requiresRank = 3,},
        },
    },
    ['EMS Supplies'] = { -- the key is the shop name
        info = {
            shopLabel = 'EMS Supplies', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "EMS Supplies" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'EMS Supplies', -- blip title
        },
        models = { -- define random ped models below
            's_m_m_doctor_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(311.03, -598.99, 43.29, 71.63),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'radio',           price = 0, amount = 50, requiresJob = {'ambulance','ems', }, },
            { name = 'bandage',         price = 0, amount = 50, requiresJob = {'ambulance','ems', }, },
            { name = 'painkillers',     price = 0, amount = 50, requiresJob = {'ambulance','ems', }, },
            { name = 'firstaid',        price = 0, amount = 50, requiresJob = {'ambulance','ems', }, },
        },
    },
    ['Mechanic Supplies'] = { -- the key is the shop name
        info = {
            shopLabel = 'Mechanic Supplies', -- label used as the shop header when opening the inventory shop
            targetIcon = 'fa-solid fa-hand-point-up', -- icon used for target interaction
            targetLabel = 'Open Shop', -- label used for target interaction
            distance = 2.0, -- max distance for target interaction
            scenario = 'WORLD_HUMAN_CLIPBOARD', -- define a scenario used for the ped
            args = { shopType = "Mechanic Supplies" }, -- args sends the shopType data to the event to determine which inventory shop to open and displays the relevant products available - this must be the same as the key name
        },
        blips = { -- blip settings for shop
            enabled = true, -- blip enabled
            id = 52, -- blip id
            colour = 2, -- blip colour
            scale = 0.6, -- bliip scale
            title = 'Mechanic Supplies', -- blip title
        },
        models = { -- define random ped models below
            'mp_m_waremech_01',
        },
        locations = { -- define spawn locations for the vendor must be vector4
            vector4(-227.74, -1327.81, 30.89, 274.6),
        },
        inventory = {
            -- define items and their prices below that can be purchased at this particular vendor - ensure these are in your items.lua!
            { name = 'veh_toolbox',       price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_armor',         price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_brakes',        price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_engine',        price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_suspension',    price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_transmission',  price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_turbo',         price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_interior',      price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_exterior',      price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_wheels',        price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_neons',         price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_xenons',        price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_tint',          price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'veh_plates',        price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'nitrous',           price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'tunerlaptop',       price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'repairkit',         price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'advancedrepairkit', price = 0, amount = 50, requiresJob = {'mechanic', }, },
            { name = 'tirerepairkit',     price = 0, amount = 50, requiresJob = {'mechanic', }, },
        },
    },
}

--translation settings
Config.Language = {
    Notifications = {
        Busy = 'You are already doing something!',
        Cancelled = 'Transaction cancelled!',
        CantCarry = 'You dont have enough space for that!',
        NoCash = 'You dont have enough cash on you!',
        NoBank = 'You dont have enough money in the bank!',
        Failed = 'Transaction failed!',
        Success = 'Purchase Successful!',
    },
}