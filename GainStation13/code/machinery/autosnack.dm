/**
 * 	Contains:
 *  Autosnack 9000 
 *  Donut Production machine
 * 	Old Donut Production machine (for the donut factory POI)
 */

/obj/machinery/autosnack //Base type. Mostly here as a base for anything else that might want to use something like this, opposed to only donut machines existing.
	name = "autosnack 9000"
	desc = "an amazing machine that seems to be able to produce any meal using nothing but electricity!"

	circuit = /obj/item/circuitboard/machine/autosnack

	var/active = FALSE
	/// This is the item we're producting. It's supposed to be a food item, but it doesnt nessesarily have to be.
	var/production_item = /obj/item/reagent_containers/food/snacks/burger/plain
	/// This is the delay between production
	var/production_time = 100
	/// This is the world.time when we last produced something
	var/last_production = 0
	/// How many items we produce per batch.
	var/batch_size = 1

/obj/machinery/autosnack/Initialize()
	. = ..()
	
/obj/machinery/autosnack/RefreshParts()
	var/p_time = 100
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		p_time -= 10 * M.rating
	production_time = p_time 

/obj/machinery/autosnack/process()
	if(stat & (BROKEN))
		return
	if(!active)
		return
	if(check_delay())
		produce(TRUE)

/obj/machinery/autosnack/proc/check_delay()
	if((src.last_production + src.production_time) <= world.time)
		return TRUE
	return FALSE

/obj/machinery/autosnack/proc/produce(loud = FALSE)
	if(!istype(production_item))
		return
	last_production = world.time
	var/foodthing = new production_item(src)
	if(loud)
		playsound(src, 'sound/machines/microwave/microwave_end.ogg', 25)

/obj/machinery/autosnack/donut
	name = "donut production machine"
	desc = "A machine that seems to be able to bake donuts using nothing but electrical power"

	circuit = /obj/item/circuitboard/machine/autosnack/donut

	production_item = /obj/item/reagent_containers/food/snacks/donut

	var/special_chance = 0

/obj/machinery/autosnack/donut/RefreshParts()
	. = ..()
	var/lucky_drop = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		lucky_drop += 5 * (M.rating - 1)
	special_chance = lucky_drop
	

/obj/machinery/autosnack/donut/produce(silent = TRUE)
	if(!istype(production_item, /obj/item/reagent_containers/food/snacks/donut)) //Donut machine only makes donuts
		return
	last_production = world.time
	var/foodthing
	if(prob(special_chance))
		foodthing = pick(list(
			/obj/item/reagent_containers/food/snacks/donut/
		))
	else 
		foodthing = new production_item(src)

	if(!silent)
		playsound(src, 'sound/machines/microwave/microwave_end.ogg', 25)


/obj/machinery/autosnack/donut_poi
	name = "old industrial machine"
	desc = "An old rusty machine that looks like it's supposed to produce something... It might even still work!"

	circuit = /obj/item/circuitboard

	production_item = /obj/item/reagent_containers/food/snacks/donut
