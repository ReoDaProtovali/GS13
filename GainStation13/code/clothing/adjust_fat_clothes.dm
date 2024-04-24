/*
//	Fat clothes adjustment code!!!
//	Code for clothes adjusting based on mob weight goes here. 
//	And possibly any other clothes changes for body changes for in the future.
//	Contact Reo if any of this breaks and you cant figure out what's glogged.
//	-Reo
*/

//Fat value flags!

#define DM_FAT_LEVEL_1			0x1
#define DM_FAT_LEVEL_2			0x2
#define DM_FAT_LEVEL_3			0x4
#define DM_FAT_LEVEL_4			0x8
#define DM_FAT_LEVEL_5			0x10
#define DM_FAT_LEVEL_6			0x20
#define DM_FAT_LEVEL_7			0x30
#define DM_FAT_LEVEL_8			0x40
#define DM_FAT_LEVEL_9			0x80

/obj/item/clothing
	var/fatsprites = 0 //Var for determining what fat icons exist, and then applying them

/obj/item/clothing/proc/adjust_clothing_size()
	

/obj/item/clothing/equipped(mob/user)
	. = ..()

	adjust_clothing_size()
