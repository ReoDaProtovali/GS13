/// Kinda stolen from xenomorphs, since they seem to be structured kinda similarly
/// Except they eat souls.

/datum/antagonist/wendigo
	name = "Wendigo"
	job_rank = 0 //Put something here...
	show_in_antagpanel = FALSE
	var/datum/team/wendigo_team
	antag_moodlet = null //Put something custom here

	var/devoured_souls = 0 //Total souls eaten and deposited.
	var/deposited_souls = 0 //Just the amount deposited.

/datum/antagonist/wendigo/greet()
	to_chat(owner.current, "<span class='boldannounce'>You are a Wendigo! Placeholder text that Reo should definitely fluff later.</span>")
	to_chat(owner.current, "<b>You must complete the following tasks:</b>")

	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/bloodcult.ogg', 100, FALSE, pressure_affected = FALSE)

	owner.announce_objectives()

/datum/team/wendigo
	name = "Wendigos"

/datum/team/wendigo/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>The [pick("lurking", "sly", "stalking")] [name] were:</span>"
	parts += printplayerlist(members)
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/antagonist/wendigo/create_team(datum/team/wendigo/new_team)
	if(!new_team)
		for(var/datum/antagonist/wendigo/W in GLOB.antagonists)
			if(!X.owner || !X.wendigo_team)
				continue
			wendigo_team = X.wendigo_team
			return
		wendigo_team = new
	else
		if(!istype(new_team))
			CRASH("Wrong wendigo team type provided to create_team")
		wendigo_team = new_team

/mob/living/carbon/wendigo/mind_initialize()
	..()
	if(!mind.has_antag_datum(/datum/antagonist/wendigo))
		mind.add_antag_datum(/datum/antagonist/wendigo)
