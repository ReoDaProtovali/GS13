/datum/objective/devour_souls
	target_amount = 3

/datum/objective/devour_souls/New()
	..()
	target_amount = rand(2,5)

/datum/objective/devour_souls/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Devour atleast [target_amount] souls, and then keep them inside of you or deposit them at the link."
	else
		explanation_text = "Free Objective"

/datum/objective/devour_target_soul
	var/target_role_type = 0

/datum/objective/devour_target_soul/find_target_by_role(role, role_type=0, invert=0)
	if(!invert)
		target_role_type = role_type
	..()
	return target

/datum/objective/devour_target_soul/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Devour the soul of [target.name], the [!target_role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Free Objective"

/datum/objective/devour_target_soul/check_completion()
	if(!target)//If it's a free objective.
		return TRUE
	
