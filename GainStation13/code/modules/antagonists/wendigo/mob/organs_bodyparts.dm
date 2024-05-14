/obj/item/organ/liver/wendigo
	name = "rotten liver"
	desc = "A liver from a wendigo. It looks like a spoiled tomato."
	decay_factor = 0

/obj/item/organ/liver/wendigo/on_life()
	var/mob/living/carbon/C = owner
	if(istype(C))
		damage = initial(maxHealth)

		if(filterToxins && !HAS_TRAIT(owner, TRAIT_TOXINLOVER))
			//handle liver toxin filtration
			for(var/datum/reagent/toxin/T in C.reagents.reagent_list)
				var/thisamount = C.reagents.get_reagent_amount(T.type)
				if (thisamount && thisamount <= toxTolerance)
					C.reagents.remove_reagent(T.type, 1)
		
		C.reagents.metabolize(C, can_overdose=FALSE)
		if(istype(C, /mob/living/carbon/wendigo))
			var/mob/living/carbon/wendigo/A = C
			A.metabolize_hunger()

/obj/item/organ/eyes/night_vision/wendigo
	name = "unnatural eyes"
	sight_flags = SEE_MOBS
	icon_state = "burning_eyes"

/obj/item/organ/stomach/wendigo
	name = "wendigo stomach"
	icon = 'GainStation13/icons/obj/wendigostomach.dmi'
	icon_state = "stomach-wendigo-soul"
	desc = "a thick, menacing chamber with whispy, etherial energies churning about within."
	decay_factor = 0

	actions_types = list(/datum/action/item_action/organ_action/wendigo_stomach)

	var/souls = 0

/datum/action/item_action/organ_action/wendigo_stomach
	name = "Consume Soul"
	desc = "Sate your unnatural hunger with the life essence of the living."
	var/devouring = 0

/datum/action/item_action/organ_action/wendigo_stomach/Trigger()
	. = ..()
	if(target != /obj/item/organ/stomach/wendigo)
	if(!. || devouring)
		return
	if(!user.pulling || !ismob(user.pulling))
		to_chat(user, "<span class='warning'>You must be grabbing a creature to consume it's soul.</span>")
		return
	if(user.grab_state <= GRAB_NECK)
		to_chat(user, "<span class='warning'>You must have a tighter grip to devour the creature's soul!</span>")
		return
	var/mob/living/soulfood = user.pulling //Nourishing!
	var/devourtime = 50
	devouring = 1
	if(ishuman(soulfood))
		devourtime += 50
	if(soulfood.client || soulfood.key)
		devourtime += 50

	if(!do_mob(owner, soulfood, devourtime))
		to_chat(user, "<span class = 'danger'>You must stay still to consume \the [soulfood]'s soul!</span>")
		target

/datum/mood_event/ate_soul
	description = "Eating souls feels nourishing on so many unexpected levels!"
	mood_change = 6

/datum/mood_event/ate_soul/add_effects(param)
	. = ..()
	if(iswendigo(owner))	//Wendigos are used to eating souls
		switch(param)
			if(1)
				description = ""
	else					//It's probably rather alien to others, though
		switch(param)
			if(1)

/obj/item/bodypart/head/wendigo
	dismemberable = FALSE
	animal_origin = WENDIGO_BODYPART

/obj/item/bodypart/chest/wendigo
	dismemberable = FALSE
	animal_origin = WENDIGO_BODYPART

/obj/item/bodypart/l_arm/wendigo
	dismemberable = FALSE
	attack_verb = list("slashed", "clawed", "mauled")
	animal_origin = WENDIGO_BODYPART

/obj/item/bodypart/r_arm/wendigo
	dismemberable = FALSE
	attack_verb = list("slashed", "clawed", "mauled")
	animal_origin = WENDIGO_BODYPART

/obj/item/bodypart/l_leg/wendigo
	dismemberable = FALSE
	attack_verb = list("pounded", "stomped", "stamped", "kicked")
	animal_origin = WENDIGO_BODYPART

/obj/item/bodypart/r_leg/wendigo
	dismemberable = FALSE
	attack_verb = list("pounded", "stomped", "stamped", "kicked")
	animal_origin = WENDIGO_BODYPART
