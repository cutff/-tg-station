
/mob
	var/bloody_hands = 0
	var/mob/living/carbon/human/bloody_hands_mob

/obj/item/clothing/gloves
	var/transfer_blood = 0
	var/mob/living/carbon/human/bloody_hands_mob


/obj/item/weapon/reagent_containers/glass/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = 1
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 5
	can_be_placed_into = null

/obj/item/weapon/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/user as mob,proximity)
	if(!proximity)
		return
	if(ismob(A) && A.reagents && reagents.total_volume)
		if(user.a_intent == "harm")
			src.reagents.reaction(A, TOUCH)
			src.reagents.clear_reagents()
		else
			reagents.trans_to(A, reagents.total_volume)
		user.visible_message("<span class='danger'>[user] has smothered \the [A] with \the [src]!</span>", "<span class='danger'>You smother \the [A] with \the [src]!</span>", "<span class='italics'>You hear some struggling and muffled cries of surprise.</span>")
	else if(istype(A) && src in user)
		user.visible_message("[user] starts to wipe down [A] with [src]!", "<span class='notice'>You start to wipe down [A] with [src]...</span>")
		if(do_after(user,30))
			user.visible_message("[user] finishes wiping off the [A]!", "<span class='notice'>You finish wiping off the [A].</span>")
			A.clean_blood()
	return
