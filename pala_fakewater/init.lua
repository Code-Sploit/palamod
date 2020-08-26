if minetest.get_modpath("mcl_bucket") then

	minetest.register_node("pala_fakewater:fakewater_source", {
		description = S("Water Source"),
		drawtype = "liquid",
		waving = 3,
		tiles = {
			{
				name = "default_water_source_animated.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
			{
				name = "default_water_source_animated.png",
				backface_culling = true,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
		},
		alpha = 191,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "source",
		liquid_alternative_flowing = "pala_fakewater:fakewater_flowing",
		liquid_alternative_source = "pala_fakewater:fakewater_source",
		liquid_viscosity = 1,
		post_effect_color = {a = 103, r = 30, g = 60, b = 90},
		damage_per_second = 4,
		groups = {water = 3, liquid = 3, cools_lava = 1},
		sounds = default.node_sound_water_defaults(),
	})

minetest.register_node("pala_fakewater:fakewater_flowing", {
	description = S("Flowing Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"default_water.png"},
	special_tiles = {
		{
			name = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	alpha = 191,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "pala_fakewater:fakewater_flowing",
	liquid_alternative_source = "pala_fakewater:fakewater_source",
	liquid_viscosity = 1,
	damage_per_second = 4,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})


	mcl_buckets.register_liquid(
		"pala_fakewater:fakewater_source",
		{"pala_fakewater:fakewater_source"},
		"mcl_buckets:bucket_fakewater",
		"bucket_water.png^pala_fakewater_overlay",
		S("Sulfuric Water Bucket"),
		S("A bucket can be used to collect and release liquids. This one is filled with water."),
		S("Place it to empty the bucket and create a fakewater source."),
		S("Places a fakewater source"),
		function(pos, placer)
			-- Check protection
			local placer_name = ""
			if placer ~= nil then
				placer_name = placer:get_player_name()
			end
			if placer and minetest.is_protected(pos, placer_name) then
				minetest.record_protection_violation(pos, placer_name)
				return false
			end
			local nn = minetest.get_node(pos).name
			-- Evaporate water if used in Nether (except on cauldron)
			if
				local dim = mcl_worlds.pos_to_dimension(pos)
				if dim == "nether" then
					minetest.sound_play("fire_extinguish_flame", {pos = pos, gain = 0.25, max_hear_distance = 16}, true)
					return false
				end
			end
		end,
		{ fakewater_bucket = 1 }
	)