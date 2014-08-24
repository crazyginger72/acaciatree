function default.grow_acaciatree(data, a, pos, seed) --watershed_acaciatree(x, y, z, area, data)
local c_actree = minetest.get_content_id("moretrees:acaciatree_gen") --trunk
local c_actree2 = minetest.get_content_id("moretrees:acaciatree_t") --limbs
local c_acleaf = minetest.get_content_id("moretrees:acacialeaves") --leaves
local xa = pos.x
local ya = pos.y
local za = pos.z
for j = -3, 9 do --j is the y axis level of the tree
    local pr = PseudoRandom(seed)
    local th = pr:next(0, 2) --adds 0-2 to the hight of the tree
    if j > 7 + th then return end --if y is not in the trees range
        if j == 7 + th then --the top layer of leaves
            for i = -3, 3 do --sets size of the layer
            for k = -3, 3 do --sets size of the layer
                if math.abs(i) + math.abs(k) ~= 6 then --makes the corners rounded off
                    if math.random(15) ~= 11 then --adds leaves at random
                        local vil = a:index(xa + i, ya + j + th, za + k) --set area for leaves
                        if data[vil] == c_air or data[vil] == c_ignore then --set only if air or ignore
                            data[vil] = c_acleaf --add leaves now
                        end
                    end
                end
            end
            end
        elseif j == 6 + th then --second layer of leaves
            for i = -5, 5 do --sets size of the layer
            for k = -5, 5 do --sets size of the layer
                if math.abs(i) + math.abs(k) ~= 10 and math.abs(i) + math.abs(k) ~= 9 then --makes the corners rounded off
                    if math.random(15) ~= 2 then --adds leaves at random
                        local vil1 = a:index(xa + i, ya + j +th, za + k) --set area for leaves
                        if data[vil1] == c_air or data[vil1] == c_ignore then --set only if air or ignore
                            data[vil1] = c_acleaf --add leaves now
                        end
                    end
                end
            end
            end
        elseif j == 5 +th then --first layer of wood third of leaves
            for i = -6, 6 do --sets size of the layer
            for k = -6, 6 do --sets size of the layer
            for i2 = -2, 2, 4 do --sets size of the layer-wood
            for k2 = -2, 2, 4 do --sets size of the layer-wood
            for i3 = -3, 3, 6 do --sets size of the layer-wood
            for k3 = -3, 3, 6 do --sets size of the layer-wood
                if math.abs(i) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11 --makes the outer rim of leaves
                or math.abs(k) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11 --makes the outer rim of leaves
                or math.abs(i) == 5 and math.abs(k) == 5 --makes the outer rim of leaves
                or math.abs(i) == 5 and math.abs(k) == 4 --makes the outer rim of leaves
                or math.abs(i) == 4 and math.abs(k) == 5 then --makes the outer rim of leaves
                    local vil2 = a:index(xa + i, ya + j +th, za + k) --set area for leaves
                    if data[vil2] == c_air or data[vil2] == c_ignore then --set only if air or ignore
                        data[vil2] = c_acleaf --add leaves now
                    end
                end
                local vit = a:index(xa + i2, ya + j + th, za + k2) --sets area for wood
                if data[vit] == c_air or data[vit] == c_ignore or data[vit] == c_acleaf then --set only if air, leaves or ignore
                    data[vit] = c_actree2 --add wood now
                end
                local vit2 = a:index(xa + i3, ya + j + th, za + k3) --sets area for wood
                if data[vit2] == c_air or data[vit2] == c_ignore or data[vit2] == c_acleaf then --set only if air, leaves or ignore
                    data[vit2] = c_actree2 --add wood now
                end
            end
            end
            end
            end
            end
            end
        elseif j == 4 + th then --second layer of wood
            for i = -1, 1 do --sets size of the layer
            for k = -1, 1 do --sets size of the layer
                if math.abs(i) + math.abs(k) == 2 then --makes the patern of wood
                    local vit3 = a:index(xa + i, ya + j + th, za + k) --set area for wood
                    if data[vit3] == c_air or data[vit3] == c_ignore or data[vit3] == c_acleaf or data[vit3] then --set only if air, leaves or ignore
                        data[vit3] = c_actree2 --add wood now
                    end
                end
            end
            end
        elseif j <= -1 then --layer for roots
            local vit4 = a:index(xa, ya + j , za) --set area for wood
            if data[vit4] ~= c_air then --sets if not air
                data[vit4] = c_actree2 --add wood now
            end
        else
            for t = 0, th do --layer for main trunk
                local vit5 = a:index(xa, ya + j + t , za) --set area for wood
                if data[vit5] == c_air or data[vit5] == c_ignore or data[vit5] == c_acleaf then --set only if air, leaves or ignore
                    data[vit5] = c_actree --add wood now
                end
            end
        end
    end
end


--=====================================================
--                     nodes
--=====================================================

minetest.register_node("moretrees:acaciatree", {
    description = "Acacia Tree",
    tiles = {"default_acaciatree_top.png", "default_acaciatree_top.png", "default_acaciatree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree=1,trunk=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
    sounds = default.node_sound_wood_defaults(),
    on_place = minetest.rotate_node,
    paramtype = "light",
    drawtype = "nodebox",       
    selection_box = {
        type = "fixed",
        fixed = cylbox,
    },
    node_box = {
        type = "fixed",
        fixed = cylbox,
    },
})

minetest.register_node("moretrees:acaciatree_t", {
    tiles = {"default_acaciatree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,treedecay=3},
    sounds = default.node_sound_wood_defaults(),
    on_place = minetest.rotate_node,
    paramtype = "light",
    drop = 'moretrees:acaciatree',
})

minetest.register_node("moretrees:acaciawood", {
    description = "Acaciawood Planks",
    tiles = {"default_acaciawood.png"},
    groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moretrees:acacialeaves", {
    description = "Acacia Leaves",
    drawtype = "allfaces_optional",
    visual_scale = 1.3,
    tiles = {"default_acacialeaves.png"},
    paramtype = "light",
    waving = 1,
    is_ground_content = false,
    groups = {snappy=3, leafdecay=4, flammable=2, leaves=1},
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get sapling with 1/20 chance
                items = {'moretrees:acaciasapling'},
                rarity = 65,
            },
            {
                -- player will get leaves only if he get no saplings,
                -- this is because max_items is 1
                items = {'moretrees:acacialeaves'},
            }
        }
    },
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moretrees:acaciasapling", {
    description = "Acacia Sapling",
    drawtype = "plantlike",
    use_texture_alpha = true,
    visual_scale = 1.0,
    tiles = {"default_acaciasapling.png"},
    inventory_image = "default_acaciasapling.png",
    wield_image = "default_acaciasapling.png",
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
    },
    groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
    sounds = default.node_sound_leaves_defaults(),
})

--=====================================================
--                      ABMs
--=====================================================

minetest.register_abm({
    nodenames = {"moretrees:acaciasapling"},
    interval = 10,
    chance = 35,
    action = function(pos, node)
        local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
        local is_sand = minetest.get_item_group(nu, "sand")
        if is_sand == 0 then
            return
        end
        minetest.remove_node(pos)
        minetest.log("action", "A acacia sapling grows into a tree at "..minetest.pos_to_string(pos))
        local vm = minetest.get_voxel_manip()
        local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
        local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
        local data = vm:get_data()
        default.grow_acaciatree(data, a, pos, math.random(1,100000))
        vm:set_data(data)
        vm:write_to_map(data)
        vm:update_map()
    end
})