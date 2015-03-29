#!/bin/bash

# variables/flags (Note: For bool, 1 is true, and 0 is false.)

world=0							# int [0-8]
chipotle=0					#	bool
palestra=0					#	bool
shady_house=0				#	bool
pocket_money=50			#	int [0-50]
jerkey=0						#	int [0-2]
have_ring=0					#	bool
have_card=0					# bool
have_key=0					#	bool
have_butterfly=0		#	bool
garbagebag_poked=0	# bool
can_use_key=0				# bool
can_open_door=0			# bool
plop=0							# int [0-2]
fake_glitch=0				# bool
saw_salmon=0				# bool
poke_sure=0					# bool
saw_door=0					# bool
can_give_hobo=0			# bool
to_hobo=0						# bool
hobo_level=0				#	int [0-3]
can_give_shady=0		# bool
shady_level=0				#	int [0-5]
dark_outside=0			# bool
tried_leaving=0			# bool
light_on=0					#	bool
talked_spencer0=0		#	bool
talked_spencer1=0		# bool
bathroom_joel=0			# bool
to_joel=0						# bool
just_completed=0		# bool
restart_name=0				# bool
# str								# string (empty)
# usrname						#	string (special mode if JJ)
# usrname_fst_three	# string (usrname truncated to substring of first three characters)

# special mode variables/flags

dignity=1						# bool
burrito=1						# bool
manliness=0					# bool
fun_time=0					# bool

# achievement variables/flags

secret_shady=0			# bool					0.						(type "asdfg" then "ThE cAkE iS a LiE" at Shady's House,
secret_asdfg=0			# bool												then look at Cheesecake in Fresh Grocer)
secret_cake=0				# bool
all_girls=0					# bool					1.						(look at girls in all four scenarios)
meet_girls_class2=0	# bool
meet_girls_class3=0	# bool
meet_girls_potnsh=0	# bool
meet_girls_potsh=0	# bool
theres_a_mouse=0		# bool					2.						(look at mouse)
meet_stripper=0			# bool					3.						(look at stripper)
troll_paper=0				# bool					4.						(look at troll paper in chipotle five times)
troll_paper_count=0	# int [0-]
hobo_happy=0				# bool					5.						(give $30 to hobo)
sky_life=0					# bool					6.						(look at sky)
retry_seven=0				# bool					7.						(retry seven times)
num_retry=0					# int [0-]
try_all_names=0			# bool					8.						(try choosing all character names)
type_joel=0					# bool
type_shady=0				# bool
type_spencer=0			# bool
type_narrator=0			# bool
beat_game=0					# bool					9.						(beat the game)
unlock_special=0		# bool					10. (hidden)	(enter special mode)
all_achievements=0	# bool

# functions that serve as part of the game's mechanism

newline () {
	echo "$str"
}

waitenter () {
	while read is_enter
	do
		if [ "$is_enter" = "$str" ]; then
			break
		fi
	done
}

mech_error () {
	if [ $1 -ne $2 ]; then
		n1
		echo "Bug in mechanism!"
		mech_error_choice
	fi
}

mech_error_choice () {
	n 1
	w 1
	mech_error_choice_whatdo () {
		whatdo
		init
		echo "${ctr}. ignore"
		incr
		echo "${ctr}. quit"
		incr
		n 1
	}
	mech_error_choice_whatdo
	while read action
	do
		case $action in
			"ignore")
				break
			;;
			"quit")
				exit 0
			;;
			*)
				invalid
			;;
		esac
		mech_error_choice_whatdo
	done
}

n () {
	mech_error $# 1
	for i in $(seq 1 $1);
	do
		newline
	done
}

w () {
	mech_error $# 1
	for i in $(seq 1 $1);
	do
		waitenter
	done
}

wn () {
	mech_error $# 2
	w $1
	n $2
}

loop_wn () {
	mech_error $# 3
	for i in $(seq 1 $3);
	do
		wn $1 $2
	done
}

# functions for various modes and actions

whatdo () {
	n 1
	echo "What should I do?"
	n 1
}

whatsee () {
	n 1
	echo "What do I see?"
	wn 1 1
}

invalid () {
	n 3
	echo "Invalid action, object, or location!"
	n 7
}

# counter functions

init () {
	ctr=1
}

incr () {
	ctr=$((${ctr} + 1))
}

# item functions

itemshow () {
	n 1
	echo "Items that I have:"
	wn 1 1
	init
	echo "${ctr}. Joel's CIS 320 Notebook  	 [use notebook]"
	incr
	echo "${ctr}. Cash (\$${pocket_money} in my pocket) 	 [use cash]"
	incr
	if [ $jerkey -eq 1 ]; then
		echo "${ctr}. 1 Pack of Beef Jerkey 	 [use jerkey]"
		incr
	elif [ $jerkey -eq 2 ]; then
		echo "${ctr}. 2 Packs of Beef Jerkey  	 [use jerkey]"
		incr
	fi
	if [ $have_ring -eq 1 ]; then
		echo "${ctr}. Spencer's Batman Ring     	 [use ring]"
		incr
	fi
	if [ $have_card -eq 1 ]; then
		echo "${ctr}. PennCard		  	 [use penncard]"
		incr
	fi
	if [ $have_key -eq 1 ]; then
		echo "${ctr}. Key 	 			 [use key]"
		incr
	fi
	if [ $have_butterfly -eq 1 ]; then
		echo "${ctr}. Dead Butterfly 		 [use butterfly]"
		incr
	fi
	wn 1 1
}

# use functions

usenotebook () {
	n 1
	echo "This is Joel's CIS 320 notebook. His hand-writing is flawless. There are pages of descriptions of complex algorithms that I frankly don't completely understand at this point."
	wn 1 1
	w 1
	echo "In the corner of the last page of the notebook, there is a little scribble that is barely legible. It says:"
	wn 1 1
	w 1
	if [ $world -eq 7 ]; then
		echo "How can I beat him?"
	else
		echo "\"How can I get better?"
	fi
	wn 1 3
	wn 1 1
	echo "                  I'm scared.\""
	n 1
	wn 1 1
}

usenotebook_joel () {
	loop_wn 1 1 2
	w 1
	echo "Joel stands still in the corner of the bathroom, having placed his heavy backpack on the floor."
	wn 1 1
	w 1
	echo "${usrname}: Joel."
	w 1
	echo "Joel: Hey! You're here!"
	w 1
	echo "${usrname}: Thanks for sparing your time."
	w 1
	echo "Joel: No worries, man. CIS 320 midterm is a joke, anyways."
	loop_wn 1 1 2
	w 1
	echo "Joel: So..."
	w 1
	echo "Joel: What's up?"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: The reason I wanted to talk with you is because..."
	w 1
	echo "${usrname}: I want to ask you a question."
	w 1
	echo "${usrname}: And... And I really need an honest answer!"
	wn 1 1
	w 1
	echo "Joel: Shoot."
	w 1
	echo "Joel: Only one question, though..."
	w 1
	echo "Joel: ...cuz you said \"ask you a question\"."
	w 1
	echo "Joel: LOL!"
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Okay, if I had to ask you one question, it won't be what's inside your backpack."
	w 1
	echo "${usrname}: I might have an idea as to what it is, anyways."
	w 1
	echo "${usrname}: What I do want to ask you, though, is..."
	w 1
	echo "I take out Joel's CIS 320 notebook."
	w 1
	echo "I open and flip it to the last page..."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	dialogue_post_joel_bathroom
}

usecash () {
	n 1
	if [ $pocket_money -le 0 ]; then
		echo "At the beginning of the game, I was sort of lying when I said that I was broke."
		w 1
		echo "Now, I'm really broke."
		w 1
		echo "I have literally 0 dollar."
		w 1
		echo "You know, 0 is a wonderful number."
		w 1
		echo "It can do a lot of magical things."
		w 1
		echo "Like, being the first index."
		w 1
		echo "Or transforming everything into complete nothingness."
		w 1
		echo "....Or making you realize that you're broke."
	else
		echo "What am I gonna do with this cash? Wipe my a\$\$ with it?"
	fi
	wn 1 1
}

usecash_hobo () {
	n 1
	if [ $pocket_money -lt 10 ]; then
		echo "I would love to give the homeless man some money..."
		w 1
		echo "...but I'm just as well off as him right now."
		w 1
		echo "${usrname}: *sigh*"
		wn 1 3
		w 1
		echo "Life is hard, isn't it?"
	elif [ $hobo_level -eq 0 ]; then
		pocket_money=$((${pocket_money} - 10))
		hobo_level=1
		echo "I decide to give the homeless man \$10."
		w 1
		echo "${usrname}: Here you go, homeless man!"
		w 1
		echo "Homeless Man: Thank you! Thank you so much!"
		w 1
		echo "Homeless Man: May God bless you!"
		wn 1 3
		w 1
		echo "I feel great."
	elif [ $hobo_level -eq 1 ]; then
		pocket_money=$((${pocket_money} - 10))
		hobo_level=2
		echo "Since I felt great giving the homeless man \$10 last time,"
		w 1
		echo "I decide to give him \$10 more."
		w 1
		echo "I mean..."
		w 1
		echo "Why not?"
		w 1
		echo "It's not a big deal, anyways."
		w 1
		echo "${usrname}: Here's an extra 10, Mister!"
		w 1
		echo "Homeless Man: You are truly a noble man, Sir."
		w 1
		echo "Homeless Man: You will most certainly succeed later in life."
		w 1
		echo "${usrname}: Haha, thanks!"
		w 1
		echo "${usrname}: But really, I hope this helps you in any way."
		w 1
		echo "Homeless Man: It definitely will, Sir."
		wn 1 3
	elif [ $hobo_level -eq 2 ]; then
		pocket_money=$((${pocket_money} - 10))
		hobo_level=3
		echo "I take out another 10 dollar bill from my pocket..."
		w 1
		echo "The homeless man stares at me."
		w 1
		echo "He stares at mes for a good minute."
		w 1
		echo "${usrname}: ..."
		w 1
		echo "Homeless Man: ..."
		loop_wn 1 3 3
		w 1
		echo "${usrname}: Uh..."
		loop_wn 1 3 2
		w 1
		echo "His eyes begin to tear up."
		w 1
		echo "Homeless Man: I... I..."
		w 1
		echo "${usrname}: Are you okay? What's wrong?"
		w 1
		echo "Homeless Man: I can't... I can't believe such a kind gentleman exists in our world today!"
		w 1
		echo "Homeless Man: You have no idea how happy I am!"
		w 1
		echo "The homeless man stumbles towards me."
		w 1
		echo "${usrname}: Woah, woah, woah... I..."
		w 1
		echo "He opens his arms,"
		wn 1 3
		w 1
		echo "and he hugs me."
		wn 1 1
		echo "Homeless Man: Thank you."
		w 1
		echo "."
		w 1
		echo "."
		w 1
		echo "."
		wn 1 3
		w 1
		echo "Genius."
		w 1
		echo "Billionaire."
		w 1
		echo "Playboy."
		w 1
		echo "Philanthropist."
		wn 1 1
		w 1
		echo "Now I just need to become two more of those things."
		if [ $hobo_happy -eq 0 ]; then
			hobo_happy=1
			unlocked_hobo
			achievementscheck
		fi
	else
		echo "Homeless Man: No, no, no!"
		w 1
		echo "Homeless Man: Please, you don't have to give me any more money today!"
		w 1
		echo "Homeless Man: Today has already become the best day of my homeless life!"
		w 1
		echo "Homeless Man: Besides, I would not want a hobo be replaced by another hobo!"
		w 1
		echo "."
		w 1
		echo "."
		w 1
		echo "."
		wn 1 1
		w 1
		echo "Another hobo..."
		w 1
		echo "Is he referring to me?"
		w 1
		echo "..."
		w 1
		echo "He's a smart one."
	fi
	wn 1 1
}

usecash_shady () {
	if [ $pocket_money -ge 10 ]; then
		if [ $shady_level -eq 0 ]; then
			shady_level=1
			pocket_money=$((${pocket_money} - 10))
			n 1
			echo "${usrname}: Here."
			w 1
			echo "I take out a 10 dollar bill from my pocket."
			w 1
			echo "${usrname}: I'm sure this is what you want."
			loop_wn 1 1 2
			w 1
			echo "Shady: Oh, you sweet little thing!"
			w 1
			echo "I hand over my 10 dollar bill to her."
			loop_wn 1 1 3
		elif [ $shady_level -eq 1 ]; then
			shady_level=2
			pocket_money=$((${pocket_money} - 10))
			n 1
			echo "${usrname}: Here."
			w 1
			echo "I take out another 10 dollar bill from my pocket."
			w 1
			echo "${usrname}: Clearly you want more."
			loop_wn 1 1 2
			w 1
			echo "Shady: Thinking like a true Penn student!"
			w 1
			echo "I hand over another 10 dollar bill."
			loop_wn 1 1 3
		elif [ $shady_level -eq 2 ]; then
			shady_level=3
			pocket_money=$((${pocket_money} - 10))
			n 1
			echo "Shady: Are you gonna give me more?"
			w 1
			echo "${usrname}: Are you gonna tell me?"
			loop_wn 1 1 2
			w 1
			echo "Shady: Maybe!"
			w 1
			echo "I hesitantly hand over another 10 dollar bill."
			loop_wn 1 1 3
		elif [ $shady_level -eq 3 ]; then
			shady_level=4
			pocket_money=$((${pocket_money} - 10))
			n 1
			echo "..."
			w 1
			echo "${usrname}: Okay, now what?!"
			w 1
			echo "Shady: I know you have more."
			w 1
			echo "${usrname}: What are you trying to make me?! A hobo?!"
			w 1
			echo "Shady: I was thinking of telling you, but I guess..."
			w 1
			echo "${usrname}: Fine, fine, fine! Take this!"
			w 1
			echo "I begrudgingly hand over another 10 dollar bill."
			wn 1 1
			wn 1 2
			loop_wn 1 3 2
			w 1
			echo "${usrname}: So... You're gonna tell me now?"
			loop_wn 1 1 2
			w 1
			echo "Shady: Pffft, of course not!"
			wn 1 1
			w 1
			echo "..."
			w 1
			echo "Dammit."
			loop_wn 1 1 3
		else
			shady_level=5
			can_give_shady=0
			pocket_money=$((${pocket_money} - 10))
			dialogue_post_shadyshouse
		fi
	else
		n 1
		echo "I don't have enough money!"
		loop_wn 1 1 2
		w 1
		echo "Perhaps money is not the way to get her to spit it out."
		w 1
		echo "..."
		wn 1 1 
	fi
}

buyjerkey () {
	n 1
	if [ $pocket_money -ge 20 ]; then
		echo "${usrname}: AHHH, I CAN'T CONTROL MYSELF!!!"
		loop_wn 1 3 3
		w 1
		echo "Cashier: Have a good one!"
		w 1
		echo "${usrname}: You too!"
		w 1
		echo "."
		w 1
		echo "."
		w 1
		echo "."
		wn 1 1
		if [ $jerkey -eq 0 ]; then
			jerkey_count="a"
		else
			jerkey_count="another"
		fi
		echo "Bam! I just bought $jerkey_count pack of beef jerkey."
		w 1
		echo "...And I'm not regretting a single bit!"
		pocket_money=$((${pocket_money} - 20))
		jerkey=$((${jerkey} + 1))
	else
		echo "Ummm... This is awkward."
		w 1
		echo "I don't have enough money to buy a pack of beef jerkey."
		w 1
		echo "..."
		w 1
		echo "Well, better next time!"
	fi
	wn 1 1
}

usejerkey () {
	if [ $jerkey -eq 2 ]; then
		jerkey=1
		n 1
		echo "Mmmm! That was yummy, indeed! What a taste of good ole Western civilization!"
		w 1
		echo "And I still have one more pack of beef jerkey!"
		w 1
		echo "Life is good, isn't it?"
		wn 1 1
	elif [ $jerkey -eq 1 ]; then
		jerkey=0
		n 1
		echo "Yum! That was fulfilling!"
		w 1
		echo "Now off I go!"
		wn 1 1
	else
		invalid
	fi
}

usering () {
	n 1
	echo "This is Spencer's Batman ring found in the Palestra."
	w 1
	echo "I wonder what the story behind this is..."
	w 1
	echo "But I won't be able to figure that out until the next time I get to talk with Spencer."
	w 1
	echo "...If such time ever comes..."
	wn 1 1
	light_on=1
}

usepenncard () {
	n 1
	echo "This is the PennCard I found in the Palestra."
	w 1
	echo "It belongs to a guy named Jae Joon Lee."
	w 1
	if [ "$usrname" = "Jae Joon" -o "$usrname" = "Jae Joon Lee" ]; then
		n 3
		w 1
		echo "Ayyy! We have the same name!"
		wn 1 3
	fi
	echo "I heard this is the guy who goes by the name JJ."
	w 1
	echo "I should return this to the PennCard Center later."
	w 1
	echo "I'm sure the guy must be looking for it."
	wn 1 1
}

usekey () {
	n 1
	echo "I stare at the key."
	w 1
	echo "I stare at the key. Real hard."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "Well..."
	w 1
	echo "Nothing's happening."
	w 1
	echo "The key ain't gonna tell me the key to all my life's problems."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 3
	w 1
	echo "Just as I try to throw away the key towards the farthest galaxy, a voice inside me says,"
	w 1
	echo "${usrname}'s Voice: Stop, ${usrname}."
	w 1
	echo "${usrname}'s Voice: You know better than this."
	w 1
	echo "${usrname}'s Voice: You know you will need this key at some point in the game."
	w 1
	echo "${usrname}'s Voice: Now is not the time."
	w 1
	echo "${usrname}'s Voice: Remember, patience."
	w 1
	echo "${usrname}'s Voice: Patience is the key."
	w 1
	echo "${usrname}'s Voice: Patience."
	w 1
	echo "${usrname}'s Voice: Patience."
	w 1
	echo "${usrname}'s Voice: Patien..."
	echo "${usrname}: Yeah, I get it. Now will you just shut up and leave me alone?"
	wn 1 1
}

usekey_house () {
	n 1
	wn 1 1
	w 1
	echo "I try to fit the key that I found in the garbage bin inside the tiny heyhole."
	wn 1 1
	w 1
	echo "..."
	w 1
	echo "Hmmm... It doesn't seem like it wants to go inside."
	loop_wn 1 1 2
	w 1
	echo "Just as I'm about to give up..."
	w 1
	echo "${usrname}'s Voice: Hey, ${usrname}. Maybe it's just because the key is a rusty. You should try it again."
	w 1
	echo "${usrname}: ..."
	wn 1 1
	w 1
	echo "${usrname}: A'ight."
	w 1
	echo "I exert a bit more force into pushing the key inside the keyhole."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Click!"
	wn 1 1
	w 1
	echo "It worked!"
	loop_wn 1 1 2
	w 1
	echo "..."
	w 1
	echo "${usrname}: Thanks, ${usrname}'s Voice."
	w 1
	echo "${usrname}'s Voice: My pleasure."
	loop_wn 1 1 2
	wn 1 4
	can_use_key=0
	can_open_door=1
}

usebutterfly () {
	have_butterfly=0
	loop_wn 1 1 2
	w 1
	echo "I realize that there is a dead butterfly in my pocket."
	w 1
	echo "${usrname}: How did this get in here?"
	w 1
	echo "${usrname}: Hmmm... That's peculiar."
	w 1
	echo "Placing the butterfly in my hands, I stare at it for a while."
	w 1
	echo "It's yellow."
	w 1
	echo "It has beautiful wings."
	w 1
	echo "It looks so vibrant, that it almost seems alive."
	w 1
	echo "..."
	loop_wn 1 1 2
	w 1
	echo "Just as I was thinking that, the butterfly suddenly wakes up and flies out of my hands."
	w 1
	echo "${usrname}: Woah!"
	wn 1 4
	dialogue_butterfly_class
}

# look functions (no argument)

lookclass () {
	whatsee
	init
	echo "${ctr}. Broken Clock			[look clock]"
	incr
	echo "${ctr}. Chalk Board			[look board]"
	incr
	if [ $dark_outside -eq 0 ]; then
		echo "${ctr}. Girls			[look girls]"
		incr
	fi
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Hallway			[look hallway]"
	incr
	wn 1 1
}

lookhallway () {
	whatsee
	init
	echo "${ctr}. Piece of Paper		[look paper]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Class			[look class]"
	incr
	echo "${ctr}. Bathroom			[look bathroom]"
	incr
	echo "${ctr}. Outside			[look outside]"
	incr
	wn 1 1
}

lookbathroom () {
	whatsee
	init
	echo "${ctr}. Poster			[look poster]"
	incr
	echo "${ctr}. Urinal			[look urinal]"
	incr
	echo "${ctr}. Half-Eaten Burrito		[look burrito]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Hallway			[look hallway]"
	incr
	wn 1 1
}

lookoutside () {
	whatsee
	if [ $dark_outside -eq 0 ]; then
		init
		echo "${ctr}. Homeless Man			[look hobo]"
		incr
		echo "${ctr}. Someone's Bike		[look bike]"
		incr
		echo "${ctr}. Blue Sky			[look sky]"
		incr
		wn 1 1
	fi
	echo "Places:"
	init
	echo "${ctr}. Hallway			[look hallway]"
	incr
	echo "${ctr}. Street			[look street]"
	incr
	if [ $palestra -eq 1 ]; then
		echo "${ctr}. Palestra			[look palestra]"
		incr
	fi
	if [ $shady_house -eq 1 ]; then
		echo "${ctr}. Shady's House		[look shady's house]"
		incr
	fi
	wn 1 1
}

lookstreet () {
	whatsee
	init
	if [ $dark_outside -eq 1 ]; then
		echo "${ctr}. Stripper			[look stripper]"
		incr
	fi
	echo "${ctr}. Parked Cars			[look cars]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Outside			[look outside]"
	incr
	echo "${ctr}. Fresh Grocer			[look fresh grocer]"
	incr
	echo "${ctr}. Garbage Bin			[look garbage bin]"
	incr
	echo "${ctr}. Pottruck Gym			[look pottruck]"
	incr
	if [ $chipotle -eq 1 ]; then
		echo "${ctr}. Chipotle			[look chipotle]"
		incr
	fi
	wn 1 1
}

lookfreshgrocer () {
	whatsee
	init
	echo "${ctr}. Apples			[look apples]"
	incr
	echo "${ctr}. Bananas			[look bananas]"
	incr
	echo "${ctr}. Cheesecake			[look cheesecake]"
	incr
	echo "${ctr}. Packs of Beef Jerkey		[look jerkey]"
	incr
	echo "${ctr}. Bottle of Vodka		[look vodka]"
	incr
	echo "${ctr}. \$100				[look 100]"
	incr
	echo "${ctr}. Salmon 			[look salmon]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Street			[look street]"
	incr
	wn 1 1
}

lookgarbagebin () {
	whatsee
	init
	echo "${ctr}. Black Garbage Bag		[look garbage bag]"
	incr
	if [ $have_key -eq 0 ]; then
		echo "${ctr}. Key				[look key]"
		incr
	fi
	if [ $garbagebag_poked -eq 1 ]; then
		echo "${ctr}. Mouse			[look mouse]"
		incr
	fi
	echo "${ctr}. Unknown Soup			[look soup]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Street			[look street]"
	incr
	wn 1 1
}

lookpottruck () {
	whatsee
	init
	echo "${ctr}. Broken Clock			[look clock]"
	incr
	echo "${ctr}. Girls			[look girls]"
	incr
	echo "${ctr}. Elliptical Machine		[look elliptical machine]"
	incr
	echo "${ctr}. Towel			[look towel]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Street			[look street]"
	incr
	wn 1 1
}

lookchipotle () {
	whatsee
	init
	echo "${ctr}. Tables			[look tables]"
	incr
	echo "${ctr}. Piece of Paper		[look paper]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Street			[look street]"
	incr
	wn 1 1
}

lookpalestra () {
	whatsee
	init
	echo "${ctr}. Broken Clock			[look clock]"
	incr
	if [ $have_ring -eq 0 ]; then
		echo "${ctr}. Ring				[look ring]"
		incr
	fi
	if [ $have_card -eq 0 ]; then
		echo "${ctr}. PennCard			[look penncard]"
		incr
	fi
	echo "${ctr}. Basketball			[look basketball]"
	incr
	echo "${ctr}. ???				[look ???]"
	incr
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Outside			[look outside]"
	incr
	wn 1 1
}

lookshadyshouse () {
	whatsee
	init
	echo "${ctr}. Front Door			[look door]"
	incr
	echo "${ctr}. Bush				[look bush]"
	incr
	echo "${ctr}. Dog Poop			[look poop]"
	wn 1 1
	echo "Places:"
	init
	echo "${ctr}. Outside			[look outside]"
	incr
	wn 1 1
}

# look functions (with argument)

lookclock () {
	n 1
	echo "There is a broken clock hanging on the wall."
	w 1
	echo "It remains at 11:59PM."
	wn 1 1
}

lookboard_class () {
	n 1
	echo "Spencer had written some illegible scribbles on the chalk board."
	w 1
	echo "There is one line that I can definitely read."
	w 1
	echo "\"\$vim -gt \$emacs\""
	w 1
	echo "..."
	w 1
	echo "Of course."
	w 1
	echo "In the corner of the chalk board, it also says,"
	w 1
	echo "\"Joel was here :)\""
	wn 1 1
	wn 1 2
	w 1
	echo "That's cute."
	wn 1 1
}

lookgirls2_class () {
	n 1
	echo "I look around the classroom."
	w 1
	echo "Eh, there are some cute girls around here."
	w 1
	echo "Some of the girls are looking at their phones, while other girls are doodling on their notes."
	w 1
	echo "None of them seems to be actually listening to Spencer."
	w 1
	echo "...Poor Spencer."
	w 1
	echo "I almost feel sorry enough for Spencer that I want to shout at these girls about how beautiful bash scripting is."
	w 1
	echo "But then again, I'm a gentleman."
	w 1
	echo "So chances are, I would rather shout at these girls about how beautiful they are."
	wn 1 1
	if [ $meet_girls_class2 -eq 0 ]; then
		meet_girls_class2=1
		girls_update
	fi
}

lookgirls3_class () {
	n 1
	echo "I look around the classroom."
	w 1
	echo "Eh, there are some cute girls around here."
	w 1
	echo "I wouldn't mind dating some of them."
	w 1
	echo "That one over there, the one at the far back. Now she's hot."
	w 1
	echo "She probably already has a boyfriend though."
	w 1
	echo "Well, doesn't hurt to ask, does it! I'll try striking up a conversation tomorrow."
	w 1
	echo "I mean, isn't that what engineering is all about?"
	wn 1 1
	if [ $meet_girls_class3 -eq 0 ]; then
		meet_girls_class3=1
		girls_update
	fi
}

lookhallway_class () {
	n 1
	echo "Outside the door is Towne Hall's 3rd floor hallway."
	w 1
	echo "Rumor has that this hallway used to be a hideout for a group of computer scientists during World War 2."
	wn 1 1
}

lookpaper_hallway () {
	n 1
	echo "I pick up the piece of paper from the floor."
	w 1
	echo "It says,"
	w 1
	echo "\"Wanna see a trick?"
	w 1
	echo "           Here's a trick!"
	loop_wn 1 1 3
	troll_dots () {
		for i in $(seq 1 42);
		do
			w 1
			echo "."
		done
		for i in $(seq 1 3);
		do
			w 1
			echo " ."
			n 1
			w 1
			echo "  ."
			n 1
			w 1
			echo "   ."
			n 1
			w 1
			echo "    ."
			n 1
			w 1
			echo "     ."
			n 1
			w 1
			echo "      ."
			n 1
			w 1
			echo "       ."
			n 1
			w 1
			echo "        ."
			n 1
			w 1
			echo "         ."
			n 1
			w 1
			echo "        ."
			n 1
			w 1
			echo "       ."
			n 1
			w 1
			echo "      ."
			n 1
			w 1
			echo "     ."
			n 1
			w 1
			echo "    ."
			n 1
			w 1
			echo "   ."
			n 1
			w 1
			echo "  ."
			n 1
			w 1
			echo " ."
			n 1
			w 1
			echo "."
			n 1
		done
		loop_wn 1 3 10
	}
	troll_dots
	w 1
	echo "Drum roll, please!"
	wn 1 1
	troll_dots
	echo "                         ...TROLLOLOLOLOLOLOLOL!!!\""
	wn 1 1
	w 1
	echo "${usrname}: ..."
	wn 1 1
	w 1
	echo "I silently place the piece of paper back on the floor."
	w 1
	echo "I promise myself never to look at that paper, ever again."
	wn 1 1
}

lookclass_hallway () {
	n 1
	echo "What lies in front of my eyes is where the Legend once learnt Bash."
	wn 1 1
	w 1
	echo "...Towne 303."
	wn 1 1
}

lookbathroom_hallway () {
	n 1
	echo "The gentlemen's bathroom in Towne Hall 3rd floor bathroom."
	w 1
	echo "If the creator of this game wasn't so busy, he would've added the option to choose my gender."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "We'll see if it ever happens."
	wn 1 1
}

lookoutside_hallway () {
	n 1
	if [ $dark_outside -eq 1 ]; then
		echo "It is dark outside."
		wn 1 1
		wn 1 2
		w 1
		echo "...and I've already said that."
	else
		echo "Outside the Towne building are some people wandering about,"
		w 1
		echo "some daffodils,"
		w 1
		echo "and a reminder of our sad engineering lives, spent inside this building for more than three quarters of our day every single day."
	fi
	wn 1 1
}

lookposter_bathroom () {
	n 1
	if [ $palestra -eq 0 ]; then
		echo "I notice a poster hastily taped on the bathroom wall that had not been there before."
		w 1
		echo "${usrname}: What is this?"
		w 1
		echo "I look closer at the poster."
		w 1
	fi
	echo "\"Attention, Penn students and staff! And everyone else for that matter!"
	wn 1 1
	w 1
	echo "There is a speech given by our deary president Shady Gutzmann in the Palestra at 3:00PM."
	w 1
	echo "This is MANDATORY. Everyone is expected to attend."
	w 1
	echo "Should you not attend this speech, there will be consequences!"
	wn 1 1
	w 1
	echo "Sincerely,"
	wn 1 1
	w 1
	echo "PBBC"
	loop_wn 1 1 3
	w 1
	echo "P.S. If your name goes by JJ, please report yourself to the Office of Student Conduct."
	w 1
	echo "                                       :)                                            \""
	w 1
	if [ $palestra -eq 0 ]; then
		echo "PBBC..."
		w 1
		echo "That's the Penn Big Brother Council."
		w 1
		echo "${usrname}: But woah, this is supposed to happen right after my CIS 191 class!"
		w 1
		echo "${usrname}: How did I not know about this?"
		w 1
		echo "${usrname}: What about my CIS 320 midterm?"
		w 1
		echo "${usrname}: ..."
		w 1
		echo "${usrname}: ......I guess it's either cancelled or postponed, then."
		w 1
	fi
	n 1
	palestra=1
}

lookurinal_bathroom () {
	n 1
	echo "The urinal is dirty."
	w 1
	echo "So dirty that I can't even describe how dirty it is in words."
	w 1
	echo "This is like... alien stuff."
	w 1
	echo "Something that came from an entirely different universe."
	w 1
	echo "..."
	w 1
	echo "${usrname}: Well... Somebody forgot to flush the urinal!"
	w 1
	echo "${usrname}: ...Let's just leave it at that."
	wn 1 1
}

lookburrito_bathroom () {
	chipotle=1
	n 1
	echo "A half-eaten burrito."
	w 1
	echo "Made up of..."
	w 1
	echo "Flour tortilla."
	w 1
	echo "Black beans."
	w 1
	echo "Grilled chicken."
	w 1
	echo "Guacamole."
	w 1
	echo "Salsa."
	w 1
	echo "Cheese."
	w 1
	echo "And sour cream."
	wn 1 1
	wn 1 2
	w 1
	echo "Yup, I know my burritos."
	wn 1 1
}

lookhallway_bathroom () {
	n 1
	echo "Outside the door is Towne Hall's 3rd floor hallway."
	w 1
	echo "Rumor has that this hallway used to be a museum of sorts during the Sexual Revolution in the 1960s."
	wn 1 1
}

lookhobo_outside () {
	to_hobo=1
	n 1
	echo "There is a homeless man lying on the ground in front of the Towne building, begging for some money."
	w 1
	if [ $hobo_level -lt 3 ]; then
		echo "He seems like he will appreciate some 10 dollar bills."
		w 1
	fi
	n 1
}

lookbike_outside () {
	n 1
	echo "Someone seems to have left his or her bike in the bike rack."
	w 1
	echo "The color of the bike is 1 + 2 + 3."
	wn 1 1
	wn 1 2
	w 1
	echo "I would love to be able to ride on this bike."
	w 1
	echo "I'm sure it'll make this game play a lot faster."
	w 1
	echo "...But unfortunately, someone didn't forget to bring a U-lock."
	wn 1 3
	echo "...I mean, not \"unfortunately\"! That is something to be praised of!"
	wn 1 3
	echo "HALLELUJAH!"
	n 3
	w 1
	echo "..."
	wn 1 1
}

looksky_outside () {
	n 1
	echo "The sky is blue."
	n 1
	w 1
	echo "I look up to the sky, full of dreams."
	n 1
	w 1
	echo "Full of freedom."
	n 1
	w 1
	echo "Full of spirit."
	n 1
	w 1
	echo "I gaze into the outer space."
	n 1
	w 1
	echo "Where the stars shine bright."
	n 1
	w 1
	echo "And the clouds of dust float about."
	n 1
	w 1
	echo "And the silence of the dark seeps through the dimensions of the universe."
	n 1
	w 1
	echo "That's it."
	n 1
	w 1
	echo "Peace."
	n 1
	w 1
	echo "The universe is still."
	n 1
	w 1
	echo "So still, everything covers itself into complete nothingness."
	n 1
	w 1
	echo "This is peace."
	n 1
	w 1
	echo "Not the chaos that has swept our lands."
	n 1
	w 1
	echo "Not the thousands of years of fightings that have been tainting our Mother Earth."
	n 1
	w 1
	echo "Not the promises of us human beings."
	n 1
	w 1
	echo "We, human beings."
	n 1
	w 1
	echo "We are capable of thinking."
	n 1
	w 1
	echo "Perhaps more importantly,"
	n 1
	w 1
	echo "We are capable of feeling."
	n 1
	w 1
	echo "But why can't we stop hating on each other and start calling ourselves Brothers?"
	n 1
	w 1
	echo "Why can't we drop our swords and guns, and just speak to one another,"
	n 1
	w 1
	echo "\"I am alive.\""
	n 1
	w 1
	echo "\"We are alive.\""
	n 1
	w 1
	echo "And embrace one another as one big family?"
	n 1
	w 1
	echo "Why can't we hold each other's hands,"
	n 1
	w 1
	echo "Clutch each other's hands ever so tight,"
	n 1
	w 1
	echo "And swing them together before the rising Sun, in the name of Love?"
	n 1
	w 1
	echo "Love that brought all of us here."
	n 1
	w 1
	echo "From our very own Mothers' wombs."
	n 1
	w 1
	echo "Love."
	n 1
	w 1
	echo "I believe Love can bring us peace."
	n 1
	w 1
	echo "And gazing into the nebulous universe,"
	n 1
	w 1
	echo "I feel myself lifted up high."
	n 1
	w 1
	echo "High, like a butterfly,"
	n 1
	w 1
	echo "The newborn soul within me speaks,"
	n 1
	w 1
	echo "We must"
	n 1
	w 1
	echo "        learn"
	n 1
	w 1
	echo "              from the universe directly above us."
	n 1
	w 1
	echo "We must"
	n 1
	w 1
	echo "        realize"
	n 1
	wn 1 1
	w 1
	echo "                ...that this has nothing to do with the game."
	wn 1 1
	if [ $sky_life -eq 0 ]; then
		achievementsnotify
		sky_life=1
		unlocked_sky
		achievementscheck
	fi
}

lookhallway_outside () {
	n 1
	echo "I can see Towne Hall 3rd floor hallway through the window."
	w 1
	echo "I must say,"
	w 1
	echo "Banjamin Franklin must've been proud."
	wn 1 1
}

lookstreet_outside () {
	n 1
	echo "A few steps from here is the street."
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "Nothing special about that."
	wn 1 1
}

lookpalestra_outside () {
	n 1
	echo "I see the Palestra into the distance."
	w 1
	echo "That's where a lot of big events are held."
	w 1
	echo "I remember Convocation was held there in my freshman year, because it was raining outside."
	w 1
	echo "...I guess basketball games are big events too."
	wn 1 1
}

lookshadyshouse_outside () {
	n 1
	echo "Over there is our 10th president Shady Gutzmann's house."
	w 1
	echo "There have been a lot of stories about the dirty things that go around that place."
	w 1
	echo "But noone has been able to find any clear evidence of shady business."
	wn 1 1
}

lookstripper_street () {
	n 1
	if [ $meet_stripper -eq 0 ]; then
		echo "Finally! Another human being!"
		w 1
		echo "...A stripper."
		w 1
		echo "A stripper is out on the street, waving at me with a pretty smile on her face."
		w 1
		echo "Her cheeks are pink, and her lips are bright crimson."
		w 1
		echo "She seems ready for a wild night."
		wn 1 1
		w 1
		echo "..."
		wn 1 1
		w 1
		echo "I didn't say that."
		meet_stripper=1
		unlocked_stripper
		achievementscheck
	else
		echo "Come on! I've already stared at the stripper long enough!"
		w 1
		echo "As much as I've enjoyed it, I really need to run away from this place!"
		w 1
		echo "...Besides, how do I even know if she's a stripper? Noone told me that."
	fi
	wn 1 1
}

lookcars_street () {
	n 1
	echo "There are cars parked along the street."
	w 1
	echo "This."
	w 1
	echo "This is the picture that I would hang on my wall in 50 years, when I want to remind myself of what Philadelphia felt like."
	wn 1 1
}

lookoutside_street () {
	n 1
	echo "Near this street is the Engineering Quad."
	wn 1 3
	echo "The place where the mighty warriors at Penn make history."
	wn 1 1
}

lookfreshgrocer_street () {
	n 1
	echo "Fresh Grocer."
	w 1
	echo "Otherwise known as Fro Gro."
	w 1
	echo "The place of fresh groceries."
	w 1
	echo "The place where half of the students go to pretend they are living healthy lives, while the other half make themselves comfortable in McDonalds right next to it."
	wn 1 1
}

lookgarbagebin_street () {
	n 1
	echo "I look at the garbage bin."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "Really? You want me to give me a description of a garbage bin?"
	wn 1 1
}

lookpottruck_street () {
	n 1
	echo "The Pottruck Gym."
	w 1
	echo "Otherwise known as... Ummm, the Pottruck Gym."
	w 1
	echo "The place of sweat and pain."
	w 1
	echo "The place where less than half of the students go to preteynd they are living healthy lives, while the rest make themselves comfortable in, like, Van Pelt or something..."
	wn 1 1
}

lookchipotle_street () {
	n 1
	echo "Chipotle."
	w 1
	echo "Otherwise known as Heaven."
	w 1
	echo "The place of burrrrrrrrrrritos."
	w 1
	echo "The place where I buy burrrrrrrrrrritos."
	wn 1 1
}

lookapples_freshgrocer () {
	n 1
	echo "I see some delicious looking apples."
	w 1
	echo "Upon closer inspection, I realize that apples begin with the letter A."
	wn 1 1
}

lookbananas_freshgrocer () {
	n 1
	echo "Some bananas are laid out."
	w 1
	echo "Sadly, most of them are pretty much rotten."
	w 1
	echo "Upon closer inspection, I realize that bananas begin with the letter B."
	wn 1 1
}

lookcheesecake_freshgrocer () {
	n 1
	if [ $secret_cake -eq 0 ]; then
		echo "The moment I notice a New York cheesecake in the corner, I immediately sprint towards it."
		w 1
		echo "${usrname}: ER MA GERDDDD!!!"
		w 1
		echo "It looks so soft."
		wn 1 1
		echo "So juicy."
		n 1
		wn 1 2
		echo "So scrumptuous."
		n 2
		wn 1 3
		echo "So sexy."
		n 3
		w 1
		echo "Mmmm..."
		w 1
		echo "I begin drooling."
		w 1
		echo "I look at the price tag."
		w 1
		echo "\"\$1,999.99\""
		wn 1 1
		echo "..."
		wn 1 1
		wn 1 2
		wn 1 3
		w 1
		echo "Upon closer inspection, I realize that cheesecake ends with the letter E."
		loop_wn 1 1 3
		w 1
		echo "You thought I would say \"begins with the letter C\", didn't you?!"
	else
		echo "..."
		wn 1 1
		w 1
		echo "Where is the cheesecake?"
		w 1
		echo "...It's not here anymore."
		w 1
		echo "......But the price tag is still there."
		loop_wn 1 3 6
		wn 1 1
		echo "THE CAKE IS A LIE!"
		n 1
		if [ $secret_shady -eq 0 ]; then
			secret_shady=1
			unlocked_shady
			achievementscheck
		fi
	fi
	wn 1 1
}

lookjerkey_freshgrocer () {
	n 1
	echo "Packs of beef jerkey."
	w 1
	echo "They are \$20 each."
	w 1
	echo "Eh, whattaya say?"
	w 1
	echo "I'm feeling a little jerkey today!"
	wn 1 1
}

lookvodka_freshgrocer () {
	n 1
	echo "Sometimes, you encounter moments when you look at something totally random and start thinking about life."
	w 1
	echo "This is one of those moments."
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "There is a bottle of vodka neatly placed on one of the racks."
	w 1
	echo "${usrname}: Why the heck is this even in Fro Gro?!"
	w 1
	echo "The price tag for it doesn't even mention vodka."
	w 1
	echo "Hmmm..."
	w 1
	echo "Perhaps one of the customers accidentally left it there."
	w 1
	echo "Well, that would make a lot of sense."
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "A moment of a serious life decision."
	w 1
	echo "Should I take it?"
	w 1
	echo "Or should I not?"
	w 1
	echo "..."
	w 1
	echo "This is a crucial dilemma."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 3
	w 1
	echo "I probably shouldn't."
	wn 1 3
	w 1
	echo "I decide not to claim the bottle of vodka."
	w 1
	echo "That's when I feel the liberation of all tainted emotions."
	wn 1 1
	echo "Catharthis."
	n 1
	wn 1 1
}

lookfake_freshgrocer () {
	n 1
	if [ $saw_fake -eq 0 ]; then
		echo "I notice a dollar bill on the ground."
		w 1
		echo "${usrname}: Seems like today is my lucky day!"
		w 1
		echo "I pick up the dollar bill from the ground."
		w 1
		echo "\"\$100\""
		w 1
		echo "${usrname}: No. Bloody. Way."
		w 1
		echo "Is anybody witnessing this?"
		w 1
		echo "This historical moment when ${usrname} becomes the next Bill Gates?"
		wn 1 3
		w 1
		echo "Upon closer inspection, I realize that the \$100 dollar bill is fake."
		w 1
		echo "${usrname}: ..."
		wn 1 1
		wn 1 2
		w 1
		echo "I gently place the fake dollar bill back on the ground."
		w 1
		echo "...Because I'd like the next person who sees this to suffer the same false happiness as I just did."
		w 1
		echo "I'm evil like that."
		saw_fake=1
	else
		echo "Gosh."
		w 1
		echo "I already know it's fake."
		w 1
		echo "I'm not a fan of breaking the fourth wall..."
		w 1
		echo "...but Player, you can only let me be fooled a certain number times."
		w 1
		echo "Seriously."
		if [ $fake_glitch -eq 1 ]; then
			loop_wn 1 3 2
			w 1
			echo "[Okay, Player, you found a glitch."
			w 1
			echo " You were able to realize, either accidentally or purposefully, that leaving Fresh Grocer and then coming back allows me to be fooled again."
			w 1
			echo " Congrats."
			w 1
			echo " You're awesome."
			w 1
			echo " You deserve a medal.]"
		fi
	fi
	wn 1 1
}

looksalmongod_freshgrocer () {
	n 1
	if [ $saw_salmon -eq 0 ]; then
		echo "???: Hey, you!"
		w 1
		echo "I hear an aquatic voide from nearby."
		w 1
		echo "${usrname}: Hmmm?"
		w 1
		echo "???: Yeah, you! I know you can hear me!"
		w 1
		echo "I turn around."
		w 1
		echo "Noone's around me."
		w 1
		echo "What was that?"
		w 1
		echo "Just as I'm about to leave..."
		w 1
		echo "???: Hey, kiddo! You don't want to miss this opportunity!"
		wn 1 1
		echo "..."
		n 1
		w 1
		echo "I look around once more."
		w 1
		echo "There's nothing around me but some dead fish."
		wn 1 1
		echo "Is God speaking to me?"
		n 1
		wn 1 1
		echo "Is this the moment of truth?"
		n 1
		w 1
		echo "???: Look down! I'm talking to you!"
		w 1
		echo "${usrname}: Huh?"
		w 1
		echo "I swear to God."
		w 1
		echo "I just saw that fish talking to me."
		wn 1 3
		w 1
		echo "${usrname}: Wait... Ummm..."
		w 1
		echo "???: Yeah, that's right."
		w 1
		echo "???: Surprised seeing a fish speaking English?"
		w 1
		echo "???: You oughta keep yourself outside of the box, my friend! You can't just limit your vision to be so narrow!"
		w 1
		echo "${usrname}: Excuse me?"
		w 1
		echo "???: Call me the Salmon God."
		w 1
		echo "${usrname}: Ummm... Hello, Salmon God."
		w 1
		echo "Salmon God: Yes. I am hear to tell you the single most important thing in life."
		w 1
		echo "${usrname}: What is the single most important thing in life, dear Salmon G..."
		w 1
		echo "Salmon God: The single most important thing in life is that you should never consider anything impossible!"
		w 1
		echo "Salmon God: Remember that time when you got rejected by a bunch of universities?"
		w 1
		echo "Salmon God: Remember that time when you got rejected by a bunch of companies?"
		w 1
		echo "Salmon God: Remember that time when everyone said no?"
		w 1
		echo "Salmon God: Well, guess what you did?"
		w 1
		echo "Salmon God: You didn't give a damn about those things, and you stayed strong!"
		w 1
		echo "Salmon God: You kept applying, and you made it to a great university!"
		w 1
		echo "Salmon God: You kept applying, and you made it to your dream job!"
		w 1
		echo "Salmon God: When everyone else said no, you said yes!"
		w 1
		echo "Salmon God: Now, I want you to know that that is no coincidence, my friend!"
		w 1
		echo "Salmon God: The key to success? The key to happiness?"
		w 1
		echo "Salmon God: It ain't money, power, or fame!"
		w 1
		echo "Salmon God: It ain't sleeping with the hottest girl in your town!"
		w 1
		echo "Salmon God: It ain't shaking hands with Barack Obama!"
		w 1
		echo "Salmon God: It's never giving up!"
		w 1
		echo "Salmon God: That's right."
		w 1
		echo "Salmon God: Kid, I'm telling you. Never give up."
		w 1
		echo "Salmon God: Even if you end up forgetting everything you learnt from school, don't forget: Never give up!"
		w 1
		echo "Salmon God: I was once an ordinary salmon, meeting my time to swim up stream."
		w 1
		echo "Salmon God: But then one of you fellows was lucky enough to catch me."
		w 1
		echo "Salmon God: And now I'm here, stuck in this grocery store, waiting to be eaten."
		w 1
		echo "Salmon God: But you know what?"
		w 1
		echo "Salmon God: I ain't gonna just stay here and waiting for the moment to leave this world!"
		w 1
		echo "Salmon God: If there is one thing that I ought to do, that is to deliver a message to someone special!"
		w 1
		echo "Salmon God: And you, my friend! I know, you're special!"
		w 1
		echo "Salmon God: The power of will is a tremendous thing, you see!"
		w 1
		echo "Salmon God: It's what got me to speak to you in English, instead of some blubbery Salmon language!"
		w 1
		echo "Salmon God: So, before I let you go, I want to tell you this."
		w 1
		echo "Salmon God: If you can take away one lesson from this game, whether or not you actually beat this game..."
		w 1
		echo "Salmon God: ...it's that you should always believe in the power of will!"
		w 1
		echo "Salmon God: Never fear to strive for the impossible!"
		w 1
		echo "Salmon God: Then all you ever wanted and all you ever needed will naturally follow you!"
		w 1
		echo "Salmon God: Now, farewell, my friend!"
		w 1
		echo "Salmon God: I have spoken too much! It's time for me to shut up and remain an ordinary dead fish!"
		loop_wn 1 1 3
		loop_wn 1 3 3
		wn 1 1
		echo "${usrname}: ..."
		n 1
		w 1
		echo "Thank you, Salmon God."
		w 1
		echo "I will never forget what you told me."
		w 1
		echo "Your message will forever be remembered."
		wn 1 1
		wn 1 2
		w 1
		echo "I bow down before the Salmon God in my utmost appreciation."
		saw_salmon=1
	else
		echo "I look at the Salmon God."
		w 1
		echo "No word is spoken."
		w 1
		echo "Now it's just an ordinary dead fish."
		wn 1 1
		echo "."
		w 1
		echo "."
		w 1
		echo "."
		w 1
		echo "${usrname}: It's okay."
		w 1
		echo "I know it was real."
		w 1
		echo "I know the Salmon God was real."
		w 1
		echo "The Salmon God was there to help me."
		w 1
		echo "To help me become a great man."
		w 1
		echo "Don't worry, Salmon God."
		w 1
		echo "No matter what anyone says, you are a legit fish that will stay forever in my heart."
		w 1
		echo "I will never forget you."
		wn 1 1
		wn 1 2
		w 1
		echo "Thank you, Salmon God."
	fi
	wn 1 1
}

lookstreet_freshgrocer () {
	n 1
	echo "From Fresh Grocer, I look outside the window."
	w 1
	echo "Everything seems mildly peaceful and mildly chaotic as usual."
	w 1
	echo "Philadelphia."
	w 1
	echo "I will miss this place."
	wn 1 1
}

lookgarbagebag_garbagebin () {
	n 1
	echo "There is a black garbage bag, filled with..."
	w 1
	echo "                                           ...stuff."
	w 1
	echo "A dozen flies are flying around the garbage bag, like a bunch of planets orbiting around the Sun."
	w 1
	echo "They're making fly noises, because they're flies."
	w 1
	echo "I would rather not touch this garbage bag. It almost seems like an omen."
	w 1
	action_garbagebag_shouldpoke () {
		n 1
		if [ $poke_sure -eq 0 ]; then
			echo "Should I poke it?"
		else
			echo "Am I sure?"
		fi
		echo "(Type \"yes\" or \"no\".)"
		n 1
	}
	action_garbagebag_shouldpoke
	while read action
	do
		case $action in
			"yes")
				if [ $poke_sure -eq 0 ]; then
					poke_sure=1
				else
					n 1
					echo "Blarp!"
					w 1
					echo "The moment I poked the garbage bag, it made a weird sound."
					w 1
					echo "From the bag, a tiny mouse popped out."
					wn 1 4
					garbagebag_poked=1
					action_garbagebin
				fi
			;;
			"no")
				n 1
				echo "Good choice."
				w 1
				echo "Let's not go near this garbage bag."
				wn 1 4
				poke_sure=0
				action_garbagebin
			;;
			*)
				invalid
			;;
		esac
		action_garbagebag_shouldpoke
	done
}

lookkey_garbagebin () {
	n 1
	echo "I see a key in the corner of the garbage bin."
	w 1
	echo "I don't know what it's for, but maybe it'll come in handy somewhere."
	w 1
	echo "I reach out my arm towards the key, trying not to touch anything else."
	wn 1 1
	wn 1 2
	w 1
	echo "${usrname}: Gotcha!"
	wn 1 1
	have_key=1
}

lookmouse_garbagebin () {
	n 1
	echo "A tiny, tiny, tiny little mouse."
	w 1
	echo "It seems to have been trapped in the garbage bag for quite a while."
	w 1
	echo "I have no idea how it got in there in the first place."
	w 1
	echo "It's moving freely inside the garbage bin, as if trying to breathe in some fresh air."
	w 1
	echo "As if trying to get out of the garbage bin."
	w 1
	echo "${usrname}: ..."
	w 1
	echo "The mouse is staring at me."
	w 1
	echo "Squeak, squeak!"
	w 1
	echo "..."
	wn 1 3
	w 1
	echo "Sorry, poor mouse."
	w 1
	echo "I would rescue you, but I'm not about that touching-mouse life, if ya know what I mean."
	w 1
	echo "..."
	w 1
	echo "......Sorry."
	wn 1 1
	if [ $theres_a_mouse -eq 0 ]; then
		theres_a_mouse=1
		unlocked_mouse
		achievementscheck
	fi
}

looksoup_garbagebin () {
	n 1
	loop_wn 1 1 3
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "${usrname}: Ewww..."
	w 1
	echo "A puddle of unknown soup in the corner of the garbage bin."
	wn 1 1
	wn 1 2
	loop_wn 1 3 3
	wn 1 1
	echo "Nope."
	n 1
	wn 1 1
}

lookstreet_garbagebin () {
	n 1
	echo "From the garbage bin, I look towards the street."
	w 1
	echo "..."
	w 1
	echo "Am I not still on the street?"
	wn 1 1
}

lookgirls_nsh_pottruck () {
	n 1
	echo "There are some girls working out in the gym."
	w 1
	echo "Many of them are running on elliptical machines, while a few others are lifting weights."
	wn 1 3
	wn 1 1
	echo "...Better not piss them off."
	n 1
	w 1
	echo "One girl is on the erging machine."
	w 1
	echo "For those of you who don't know what an erging machine is, isn't a cooler word for an indoor rowing machine, used for training rowers."
	w 1
	echo "I remember back when I used to row in high school."
	w 1
	echo "Erging was one of the hardest things to do back then..."
	w 1
	echo "But there always was an unparalleled amount of satisfaction that came with completing a training on the erging machine."
	w 1
	if [ $erg_girl -eq 0 ]; then
		echo "Out of nostalgia, I appraoch the girl on the erging machine."
		w 1
		echo "${usrname}: Hey! How long are you erging for right now?"
		wn 1 1
		wn 1 2
		w 1
		echo "..."
		wn 1 1
		wn 1 2
		w 1
		echo "I just got completely ignored."
		w 1
		echo "I guess I should just leave her alone."
		w 1
		echo "..."
		w 1
		erg_girl=1
	fi
	n 3
	w 1
	echo "In general, all of the girls in here seem fit and very attractive."
	w 1
	echo "I'm sure they have all spent a great deal of time to create and maintain bodies like that."
	w 1
	echo "So all that work seems to be paying off!"
	wn 1 3
	w 1
	echo "${usrname}'s Voice: Not all of them are working out to please guys like you, you know?"
	w 1
	echo "${usrname}: Yeah, I get it. Just let me enjoy a moment of serenity for a second here!"
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "I bet any girl here can beat the hell out of me."
	wn 1 1
	if [ $meet_girls_potnsh -eq 0 ]; then
		meet_girls_potnsh=1
		girls_update
	fi
}

lookgirls_sh_pottruck () {
	n 1
	echo "Some girls are still working out in the gym."
	wn 1 1
	w 1
	echo "...So are some guys, but my eyes naturally get fixated to the girls."
	wn 1 1
	wn 1 2
	w 1
	echo "..."
	w 1
	echo "Gosh, I'm perverted."
	w 1
	echo "I conclude that I'm a trash."
	wn 1 3
	w 1
	echo "But on second thought, I'm a guy. A straight one, too."
	w 1
	echo "Obviously I'll look at girls!"
	w 1
	echo "This is a completely normal thing to do."
	w 1
	echo "Now, all I need to do is impress them with my abs..."
	wn 1 1
	wn 1 2
	w 1
	echo "...olutely bloated confidence."
	wn 1 1
	echo "${usrname}: *sigh*"
	n 1
	w 1
	echo "I really should work out."
	w 1
	echo "Perhaps I'll even get a Pottruck Gym membership and find some time to work out with these girls!"
	w 1
	echo "Killing two birds with one stone, you know what I'm sayin'?"
	wn 1 1
	if [ $meet_girls_potsh -eq 0 ]; then
		meet_girls_potsh=1
		girls_update
	fi
}

lookelliptical_pottruck () {
	n 1
	echo "I look at an elliptical machine."
	w 1
	echo "I picture myself hopping on the elliptical machine."
	w 1
	echo "I picture myself jogging on the elliptical machine."
	w 1
	echo "I picture myself slowly increasing the spead on the elliptical machine."
	w 1
	echo "I picture myself running on the elliptical machine."
	w 1
	echo "I picture myself momentarily decreasing the speed on the elliptical machine."
	w 1
	echo "I picture myself significantly increasing the speed on the elliptical machine."
	w 1
	echo "I picture myself sprinting and panting on the elliptical machine."
	w 1
	echo "I picture myself tripping over my own leg on the elliptical machine."
	w 1
	echo "I picture myself being hurt and crying on the elliptical machine."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Yeah, no. Right now is not the right time."
	w 1
	echo "Maybe \"later\"."
	wn 1 1
}

looktowel_pottruck () {
	n 1
	echo "There is a wet, red towel on the counter."
	w 1
	echo "Upon closer inspection, it's all sweat."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Duh."
	w 1
	echo "I mean, what else would it be in the gym?"
	w 1
	echo "Vinegar?"
	w 1
	echo "Coconut oil?"
	w 1
	echo "..."
	w 1
	echo "......Exactly."
	wn 1 3
	w 1
	echo "Anyhow, I don't think I'll have any business with this wet towel."
	wn 1 1
}

lookstreet_pottruck () {
	n 1
	echo "Outside Pottruck is the street."
	w 1
	echo "People are passing by the gym, taking a short glance inside, and then just moving on with their lives."
	w 1
	echo "...How should I interpret that?"
	wn 1 1
}

looktables_chipotle () {
	n 1
	echo "There are several tables here in Chipotle."
	w 1
	echo "If you look closely enough, you can see that these tables are made out of burritos."
	wn 1 1
}

interactive_abc () {
	interactive_letter () {
		echo "Type \"$1\", please."
		n 1
		letter_to_be_typed=$1
		while read action
		do
			case $action in
				$1)
					break
				;;
				*)
					echo "Y U NO TYPE ${letter_to_be_typed}???"
				;;
			esac
		done
	}
	for letter in {A..Z}
	do
		n 1
		interactive_letter $letter
		n 1
	done
}

lookpaper_chipotle () {
	n 1
	echo "I pick up the piece of paper from the floor."
	w 1
	echo "It says,"
	w 1
	echo "\"Wanna see an interactive trick?"
	w 1
	echo "           Here's an interactive trick!"
	loop_wn 1 3 2
	w 1
	interactive_abc
	loop_wn 1 3 3
	w 1
	echo "Isn't this so fun?!"
	w 1
	echo "Let's do this one more time!!!"
	loop_wn 1 1 3
	w 1
	echo "(Trust me! Rewards await!)"
	wn 1 3
	w 1
	interactive_abc
	loop_wn 1 3 3
	w 1
	echo "                         ...TROLLOLOLOLOLOLOLOL!!!\""
	wn 1 1
	w 1
	troll_paper_count=$((${troll_paper_count} + 1))
	if [ $troll_paper_count -eq 1 ]; then
		sing_or_plur="time"
	else
		sing_or_plur="times"
	fi
	echo "(I have looked at this piece of paper a total of ${troll_paper_count} ${sing_or_plur}.)"
	wn 1 1
	w 1
	echo "${usrname}: ..."
	wn 1 1
	w 1
	echo "I silently place the piece of paper back on the floor."
	w 1
	echo "I promise myself never to look at that paper, ever again."
	wn 1 1
	if [ $troll_paper_count -ge 5 -a $troll_paper -eq 0 ]; then
		troll_paper=1
		unlocked_paper
		achievementscheck
	fi
}

lookstreet_chipotle () {
	n 1
	echo "Right now, I'm looking at the street from Chipotle."
	w 1
	echo "This is because the Player decided to type \"look street\" while I am in Chipotle."
	w 1
	echo "So I'm granting his or her wish."
	w 1
	echo "I hope he or she is happy now."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
}

lookring_palestra () {
	n 1
	echo "Amidst the chaos, I notice a ring that is dropped on the floor."
	w 1
	echo "Without making a sound, I bend over and pick up the ring."
	w 1
	echo "..."
	w 1
	echo "The ring has a Batman logo on it."
	wn 1 1
	wn 1 2
	w 1
	echo "${usrname}: Huh?"
	w 1
	echo "Upon closer inspection, I realize that the ring has a name ingrained on its side."
	w 1
	echo "\"SPENCER\""
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	echo "This is Spencer's."
	wn 1 1
	w 1
	echo "I take another glance at Spencer."
	w 1
	echo "Among the audience, Spencer seems rather calm."
	w 1
	echo "Spencer, do you believe in what Shady is saying?"
	w 1
	echo "Please tell me you don't..."
	loop_wn 1 3 2
	w 1
	echo "I put Spencer's Batman ring in my pocket."
	wn 1 1
	have_ring=1
}

lookpenncard_palestra () {
	n 1
	echo "Hmmm?"
	w 1
	echo "Why is there a PennCard on the floor?"
	w 1
	echo "Someone among the audience must've dropped it by accident."
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "It's a shame."
	w 1
	echo "It's a shame that I won't be able to return this to its owner right now."
	w 1
	echo "Because whoever the owner is, he or she will want to kill me."
	w 1
	echo "..."
	wn 1 1
	wn 1 2
	w 1
	echo "I put the PennCard in my pocket."
	wn 1 1
	w 1
	echo "Hopefully this nonsense will be resolved soon."
	w 1
	echo "Then I can return this PennCard to its owner."
	wn 1 1
	w 1
	echo "Until then, perhaps I can even pretend I am this PennCard's owner after some preparation?"
	wn 1 1
	have_card=1
}

lookbasketball_palestra () {
	n 1
	echo "There is a basketball on the floor."
	w 1
	echo "..."
	w 1
	echo "I believe there are more important things to do than to play basketball right now."
	wn 1 1
}

lookcondom_palestra () {
	n 1
	if [ $saw_condom -eq 0 ]; then
		echo "Hmmm?"
		w 1
		echo "...What is this?"
		w 1
		echo "I notice an unknown object at the end of a bench."
		w 1
		echo "I pick it up."
		w 1
		echo "Upon closer inspection..."
		loop_wn 1 1 3
		w 1
		echo "WHAT THE HELL?!"
		w 1
		echo "WHY IS THERE A USED CONDOM LYING HERE?!"
		w 1
		echo "I instantly drop it on the floor."
		w 1
		echo "It makes a disgusting splash sound upon hitting the floor."
		w 1
		echo "I look around."
		w 1
		echo "."
		w 1
		echo "."
		w 1
		echo "."
		wn 1 1
		echo "Luckily, it doesn't seem like anyone heard the splash."
		wn 1 1
		w 1
		echo "...My fingers are forever contaminated."
		saw_condom=1
	else
		echo "I already saw the used condom."
		loop_wn 1 1 3
		w 1
		echo "I think a used condom will be the last thing I'll ever need in this game."
	fi
	wn 1 1
}

lookoutside_palestra () {
	n 1
	echo "I look outside through the window."
	w 1
	echo "Everything seems so peaceful outside."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "The suspense is real."
	wn 1 1
}

lookdoor_shadyshouse () {
	saw_door=1
	echo "The main entrance door to Shady Gutzmann's house."
	w 1
	echo "There is a bell I can ring at the side."
	if [ $have_key -eq 1 ]; then
		wn 1 1
		w 1
		echo "Underneath the bell is a small keyhole."
	fi
	wn 1 1
}

lookbush_shadyshouse () {
	n 1
	echo "There is a rose bush that spans the length of the entire front wall of the building."
	w 1
	echo "The red, pink, and white roses are neatly arranged."
	wn 1 1
	w 1
	echo "So neatly arranged that snatching one of them will horribly ruin the picture."
	wn 1 1
	wn 1 2
	w 1
	echo "I guess romance will be the last thing that'll ever come into my so-called \"date\" with Shady."
	wn 1 1
}

lookpoop_shadyshouse () {
	n 1
	echo "Sometimes, in music, excessive harmony can be a poison."
	w 1
	echo "If all the notes are in the right chord for the entirety of a musical piece, the audience may end up finding it boring or repetitive."
	w 1
	echo "One way to resolve this issue is by playing with the dynamics."
	w 1
	echo "Some notes may be played louder, while other notes may be played quieter."
	w 1
	echo "Dynamics may also refer to certain stylistic (such as staccato, ligato, etc.) or functional (such as velocity) aspects of the execution of the musical piece."
	w 1
	echo "By playing with dynamics, one can create music that lives and breathes."
	loop_wn 1 1 2
	w 1
	echo "Another way to resolve this issue is by incorporating dissonance."
	w 1
	echo "That is, the lack of harmony."
	w 1
	echo "Incorporating dissonance can disrupt the flow of the music in interesting ways, often creating a big contrast to the predictable pleasantness that is yielded from harmonic chords."
	w 1
	echo "With the right mixture of harmony and dissonance, one can truly interact with the audience, as the audience may often find themselves anticipating a break from structure or a resolution from chaos."
	wn 1 1
	wn 1 2
	loop_wn 1 3 2
	w 1
	echo "..."
	wn 1 1
	w 1
	echo "This is what I think when I stare at the dog poop right in front of the otherwise magnificent house."
	wn 1 1
}

lookoutside_shadyshouse () {
	n 1
	echo "Gazing at the Engineering Quad from here, I realize for how long I have been walking."
	w 1
	echo "Being this far away from the Engineering Quad, I begin to slowly feel the engineer inside me dying."
	loop_wn 1 1 2
	w 1
	echo "That's when I realize, I was not supposed to come here."
	w 1
	echo "I was no supposed to go so far away from the Engineering Quad."
	w 1
	echo "..."
	wn 1 3
	w 1
	echo "GAME OVER"
	loop_wn 1 3 2
	wn 1 1
	echo "Sike!"
	n 1
	w 1
	echo "Just kidding. I'm still young and alive."
	w 1
	echo "..."
	w 1
	echo "And so is the engineer inside me."
	w 1
	echo "Let me tell you a secret..."
	loop_wn 1 1 2
	w 1
	echo "The engineer inside me never dies!"
	wn 1 1
}

# help functions

instructions () {
	echo "This game comprises of two separate modes: namely, dialogue mode and action mode. In dialogue mode, you as the player simply have to press ENTER to read the next line."
	wn 1 1
	echo "In action mode, you will be prompted with the question, \"What should I do?\" This question is followed by a list of possible actions that you can take, such as \"stay in class\" or \"hide under desk\". You may choose an action to take by typing the action word-by-word. For instance, if \"stay in class\" is one of the actions that you can take, you can choose to do so by typing \"stay in class\" and pressing ENTER. If what you type is not a valid action (this includes typo!), you will be presented with an error message accordingly."
	wn 1 1
	echo "Among the actions is a special action that will often appear on the list of possible actions you can take, which is \"go to\". This action will move you to another location. Call this action by typing \"go to <location>\", which will move you to that specific location, if it's possible. (You must specify the <location> argument.) Otherwise, you will be presented with a message that you can't go to the location you have specified."
	wn 1 1
	echo "Another special action that you will often see on the list is \"look\". This action will let you observe a specified nearby object or place. Call this action by typing \"look <thing>\". (Unlike \"go to\", you may just type \"look\", which will give you a list of objects and places that you can specify as <thing>.) The places listed are where you can \"go to\" (e.g. \"go to hallway\"). If the specified <thing> is invalid, you will be presented with a message that you can't look at the thing you have specified."
	wn 1 1
	echo "Whenever you're in action mode, you are free to use the commands \"item\" and \"use\", which will not be mentioned explicitly on the list of actions you can take. (Hint: These commands will come in handy!) The command \"item\" shows you a list of items that you currently possess. The command \"use <item>\" corresponds to an action in which you use the specified item. If you don't have the item you specify, or the item you want to use cannot be used at the time of your action, a corresponding error message will appear."
	wn 1 1
	echo "When in doubt, always try pressing ENTER. The only time when simply pressing ENTER gives you an error message is when you're prompted to take an action. (\"What should I do?\")"
	wn 1 1
	echo "Finally, throughout the game, there are several unmentioned 'checkpoints' that you can spawn back from in the case that you reach GAME OVER. When you reach GAME OVER, you can type \"retry\", \"restart\", or \"quit\". Typing \"retry\" allows you to return to the last checkpoint. You will notice that you don't start from the very beginning of the game, if you had gone far enough in the game prior to reaching GAME OVER. Typing \"restart\", on the other hand, restarts the entire game, in which case all the checkpoints are disabled back. Typing \"quit\" allows you to quit the game. (This is similar to \"restart\".) If you beat the game, you can only type either \"restart\" or \"quit\"."
}

helpmessage () {
	n 1
	echo "--------------------------------------------------------------------------------"
	wn 1 1
	instructions
	wn 1 1
	echo "--------------------------------------------------------------------------------"
	wn 1 1
}

# end of game functions

game_complete () {
	just_completed=1
	n 1
	w 1
	echo "Narrator X: CONGRATULATIONS!"
	w 1
	echo "Narrator X: You have successfully beat the game!"
	w 1
	echo "Narrator X: Was it fun?"
	w 1
	echo "Narrator X: Was it meaningful?"
	w 1
	echo "Narrator X: Most importantly!"
	w 1
	echo "Narrator X: Was it worth your time?"
	wn 1 1
	w 1
	echo "Narrator X: I hope so!"
	wn 1 1
	w 1
	echo "Narrator X: Anyhow, you're awesome for having made it this far into the game!"
	w 1
	echo "Narrator X: Really, this game isn't the easiest game!"
	w 1
	echo "Narrator X: So either you looked at the game cheat sheet, or you actually spent a lot of time on this game!"
	w 1
	echo "Narrator X: Speaking of which, do you know how long the creator of this game spent on this game?"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: About 30 hours, more or less!"
	wn 1 1
	w 1
	echo "Narrator X: Anyhow, before I say good bye, I want to tell you one last thing!"
	w 1
	echo "Narrator X: Sure, you have accomplished a lot of things on your way..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: But do you think you've done everything that you can in this game?"
	w 1
	echo "Narrator X: Or perhaps..."
	w 1
	echo "Narrator X: Perhaps there are more things to be accomplished!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: If you were lucky, you would've seen me earlier when I told you about the various Achievements in this game."
	w 1
	echo "Narrator X: Have you achieved 'em all?"
	w 1
	echo "Narrator X: What will happen when you achieve 'em all?"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Well, there's only one way to figure it out!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: If you're willing to figure it out, good luck!"
	w 1
	echo "Narrator X: But before that, give yourself a pat on the back for having made it this far!"
	loop_wn 1 1 4
	w 1
	echo "Narrator X: Did you pat yourself on the back?"
	wn 1 1
	w 1
	echo "Narrator X: Okay, now that you patted yourself on the back, it's time for me to go back to playing video games again!"
	w 1
	echo "Narrator X: Good bye for now!"
	wn 1 4
	if [ $beat_game -eq 0 ]; then
		beat_game=1
		unlocked_beat
		achievementscheck
	fi
	game_choice
}

game_over () {
	n 1
	echo "GAME OVER"
	n 1
	loop_wn 1 1 3
	w 1
	echo "Narrator X: Hi! It's me again, Narrator X!"
	w 1
	echo "Narrator X: Oh no! You reached GAME OVER!"
	w 1
	echo "Narrator X: Poor you!"
	w 1
	echo "Narrator X: Don't worry, though!"
	w 1
	echo "Narrator X: As I said earlier, if you have gone far enough in the game, chances are, you won't be starting from the very beginning of the game!"
	w 1
	echo "Narrator X: Even if it seems like the very beginning!"
	w 1
	echo "Narrator X: Trust me!"
	w 1
	echo "Narrator X: Otherwise..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Just kidding! There isn't any \"Otherwise\"!"
	w 1
	echo "Narrator X: If you reached GAME OVER, that means you have already passed through at least one checkpiont!"
	w 1
	echo "Narrator X: Of course, the creator of the game decided not to tell you where all of the checkpoints are."
	w 1
	echo "Narrator X: But telling it to you would ruin the fun, right?"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Try again!"
	w 1
	echo "Narrator X: Next time, see if you can make a different course of action!"
	w 1
	echo "Narrator X: Here's an advice, free of charge!"
	w 1
	echo "Narrator X: Sometimes, you may be able to proceed by doing something you had already done before!"
	w 1
	echo "Narrator X: Like, ages ago!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Okay, bye for now!"
	wn 1 4
	game_choice
}

game_choice () {
	n 1
	w 1
	action_game_choice_whatdo () {
		whatdo
		init
		if [ $just_completed -eq 0 ]; then
			echo "${ctr}. retry"
			incr
		fi
		echo "${ctr}. restart"
		incr
		echo "${ctr}. quit"
		incr
		n 1
	}
	action_game_choice_whatdo
	while read action
	do
		case $action in
			"retry")
				if [ $just_completed -eq 0 ]; then
					num_retry=$((${num_retry} + 1))
					if [ $num_retry -ge 7 -a $retry_seven -eq 0 ]; then
						retry_seven=1
						unlocked_seven
						achievementscheck
					fi
					game_retry
				else
					invalid
				fi
			;;
			"restart")
				game_restart
			;;
			"quit")
				game_quit
			;;
			*)
				invalid
			;;
		esac
		action_game_choice_whatdo
	done
}

game_retry () {
	n 1
	echo "Narrator X: You fight against the odds and give it another try!"
	wn 1 1
	w 1
	echo "Narrator X: I like that!"
	wn 1 1
	w 1
	echo "Narrator X: Here we go again!"
	loop_wn 1 1 2
	echo "......"
	wn 1 1
	echo "..."
	wn 1 4
	reset_clock
	dialogue_130_class
}

game_restart () { # allows change name
	n 1
	echo "Narrator X: You want to restart from the beginning, huh?"
	w 1
	echo "Narrator X: Okay!"
	w 1
	echo "Narrator X: Feel free to change your name this time around!"
	wn 1 1
	w 1
	echo "(Game restarted.)"
	wn 1 5
	reset_clock
	world=0
	restart_name=1
	choosename
}

game_quit () {
	n 1
	echo "Narrator X: Farewell!"
	w 1
	exit 0
}

# special mode

special_mode_fake_timer () {
	fake_message=$1
	fake_time=$2
	fake_start=$(date +%s)
	fake_elapse=-1
	fake_time_left=$fake_time
	while [ $fake_time_left -gt 1 ]
	do
		fake_tick=$(($(date +%s) - $fake_start))
		if [ $fake_tick -ne $fake_elapse ]; then
			fake_elapse=$fake_tick
			fake_time_left=$(($fake_time - $fake_elapse))
			if [ $fake_time_left -eq 1 ]; then
				fake_sec_sing_or_plur="SECOND"
			else
				fake_sec_sing_or_plur="SECONDS"
			fi
			n 1
			echo "${fake_message} ${fake_time_left} ${fake_sec_sing_or_plur}."
			n 1
		fi
	done
}

special_mode () {
	w 1
	echo "My name is JJ."
	n 1
	loop_wn 1 1 3
	loop_wn 1 3 10
	w 1
	echo "System Output:"
	wn 1 1
	w 1
	echo "je0f9aj0fjeifoaweivnareguhvawefjapewfjwefpreg?AWfewfwfewfWEFWEFVRG#\$RgregRgreg\$V35g5hy76er32t5gbtGRB6h\$Wtg46hn5yreRT%yhsehi787oL98jhs4hgqa4t2a#K*7uh45trtuk87JHrhg43qh7tyhbsverH%TRGEHBehrhnTg4g46hgeb7tyresth76tHGAWrthbdrtherge4dtyg46trgfd1#@\$TGF#@\$gf243hg3576iOYOIKyfbdvcxwqd\$Thtrmytj898yHGewsdfags46uhw342tjIU-9o8ihsgqe1ewfg4Uhrtyh5"
	w 1
	echo "EFATGW#GB4tryw5rgTRDHE^TRBSdgdfhyijftfhb67j67uijTYGFBFDSBVSRTjhawedsvserhe56rtdfgbfyRg35ygervdsergsdgSErgbxvnghnbfdvbdfg23545y4wF#regesrgbtsgdAWEAFafsdgsbrtsvcqEGBRTYFHB7R68IGerSERGVSEDFVCDSFVTRHNYTFBXDvDRTHGSVERDFHNGUYGHVBESRZGBNTFYCFGHBESVDFSC234T5678IKJYTDXFBCXvDSZFDsfvdsvDSVDgrveg46hyutn"
	w 1
	echo "ASDFEWFDV#4ert24354trh65rtgfdsbFGhdfxdvdfhr67U&*ygunfgcfxgbvdGCVFCGBDFZFVerdgVDFBVFDvdfVdsverdgrevdCgvervDFBVDFgerqrewfedvxcgst5ytu544532r34y678ujhgfbg45ecfesfsdfdsgERVF#\$efdsevrgrtfgh^&YTREGEfddfgeRGCVgfdgfvgdgbrtgtrvewnd9qf8e9ahfiayegliewtw4ERVFHYTIHYGU)(OP(IUHJNHJLILyesfewfaftrhb5ytuj78ntyitjhdfgvsESREGRTHR67tdhgesfdsfaewcewsfqc2q3rfvdfchgtyfghbd\"whysoserious?\"fawefverghvawerfeawefs#\$%RYHR^&FTHBTRDFGVtrgeva43ergCEWRG%^TUI&*UYNBDGVwefdfhgbdrthberdfq23rfrFDBDFGHrtgrsgdrtdxhnfyuuj7tftghERGF\$wefegrtdgfdvzdsgesrCWFWEFDGSERvstygesrsfdsfadsfaGSDFEC13ERF43ERGEGthFDGDSF24T55HY78JTHRGDdsfREFGDVRGSDVRYE6GSGFWEFCWEFrth7BTRGDZF3ERGRH7TDGsvFEDERGV6RTH67TYHTDFGsdferGRTGTFHtyrtfdrgfewf@#r\$fFeDSFDSGRTDGFCVDCDSFSDGB7876RTGfdfsdfSDFSDF"
	w 1
	echo "jirejver8fjewfj0329rjf3rjvrrigrtgerfEWF#EWFDSGrth6tybfdvewfHJYK*IJTFBfcbfghdrfDGDGdetyu87FWEBrefwefrdhggfjhntYRG#RTGBNU*ngvcbtyjyugcvdvescxcbghouy0YTGFDGDFcsdfvbfghjy8ujyngfbFDSFSFewffgjhjnbvbmnvcvdxdsterdgdsdvdfgbfgbnfgbvdsfdszfcewsdfsdfdewsd1@EWRDHRH&*TRGREDSFDSfcsdfrfvcxvsdferF\$gthgffddgfdfhgfhtrgfewfvfdhtyujyhtjIYK(H*ik0ujyhgnb7"
	w 1
	echo "aSDVDFGbrgbdsfosdijfvdfoigjviodsfgihjfighnbofghbfdgdfhNUYJKuhsodijsdojsidjisodjeiferhvddsFSGDsgdsifodsihgibgcniofggfdgDGDGFGJYJUGGFGRSDGDKFSDFDIGIDFSDIFSfwe90jd90cvckbmodfvniwdT\$QWUYYTGH^&revdgfbhdfGDFDGFdg09u90jgFGDSFDhnisodifh88h039j90js0dfdDFGH&U*^YGDFVDFh7ij78tyf23efv6tfgfdsdfgbfgjyfgdfht8yjijgh"
	wn 1 1
	w 1
	echo "SYSTEM MALFUNCTION: ERROR CODE 950722."
	w 1
	echo "PLEASE REPORT TO SYSTEM ADMIN IMMEDIATELY."
	loop_wn 1 3 3
	w 1
	special_mode_fake_timer "SYSTEM SHUTDOWN IN" 30
	n 5
	echo "PROCEED..."
	w 42
	special_mode_fake_timer "REMOVE OPERATING SYSTEM IN" 10
	n 1
	echo "..."
	n 5
	echo "PRESS [ENTER] TO COMPLETE REMOVAL."
	wn 42 1
	echo "SHREK IS LOVE."
	n 1
	wn 1 1
	echo "SHREK IS LIFE."
	n 1
	loop_wn 1 5 6
	wn 1 1
	w 3
	echo "[[Turning On: Special Mode]]"
	wn 1 1
	echo "......"
	wn 1 1
	echo "..."
	wn 1 5
	special_dialogue_hallway0
}

special_helpmessage () {
	n 1
	wn 1 1
	w 1
	echo "Nah, brah."
	w 1
	echo "A true man ain't gettin' no help."
	loop_wn 1 1 4
	w 1
	echo "SWAG"
	wn 1 1
}

special_itemshow () {
	n 1
	echo "Items that I think I have:"
	wn 1 1
	init
	echo "${ctr}. PennCard			[use penncard]"
	incr
	if [ $dignity -eq 1 ]; then
		echo "${ctr}. Dignity			[use dignity]"
		incr
	fi
	echo "${ctr}. Buttloads of Cash	        [use cash]"
	incr
	if [ $burrito -eq 1 ]; then
		echo "${ctr}. Burrito 		        [use burrito]"
		incr
	fi
	echo "${ctr}. ???				[use ???]"
	incr
	if [ $manliness -eq 1 ]; then
		echo "${ctr}. Manliness			[use manliness]"
		incr
	fi
	wn 1 1
}

special_action_common () {
	special_not_common=0
	case $special_action in
		"help")
			special_helpmessage
		;;
		"item")
			special_itemshow
		;;
		"use penncard")
			n 1
			echo "This is my PennCard."
			w 1
			echo "Name: Jae Joon Lee"
			w 1
			echo "Student ID:"
			wn 1 1
			w 1
			echo "...Dude."
			w 1
			echo "You seriously think I'm gonna tell you my student ID?"
			wn 1 1
		;;
		"use dignity")
			if [ $dignity -eq 1 ]; then
				n 1
				echo "I've got a sense of dignity the size of the population in China."
				wn 1 1
			else
				invalid
			fi
		;;
		"use cash")
			n 1
			echo "I've got buttloads of cash."
			w 1
			echo "But I don't know where to spend it on!"
			wn 1 1
			w 1
			echo "Ah, first world problems!"
			wn 1 1
		;;
		"use burrito")
			if [ $burrito -eq 1 ]; then
				n 1
				echo "A burrito I bought from Chipotle."
				w 1
				echo "The line was pretty short at the time, so I was lucky enough to grab one fairly quickly."
				wn 1 1
			else
				invalid
			fi
		;;
		"use ???")
			if [ $fun_time -eq 1 ]; then
				n 5
				special_dialogue_happy
			else
				n 1
				echo "Protection."
				w 1
				echo "..."
				loop_wn 1 1 3
				w 1
				echo "Yeah, it's what you think it is."
				wn 1 1
			fi
		;;
		"use manliness")
			if [ $manliness -eq 1 ]; then
				n 1
				echo "I FEEL LIKE A MAN!"
				w 1
				echo "UHHHHHHH!!!"
				w 1
				echo "DO YOU EVEN LIFT, BRAH?"
				wn 1 1
			else
				invalid
			fi
		;;
		"achievements")
			n 1
			echo "..."
			w 1
			echo "What achievements?"
			wn 1 1
		;;
		*)
			special_not_common=1
		;;
	esac
}

special_swag () {
	n 1
	echo "You know what I've got?"
	loop_wn 1 1 7
	w 1
	echo "Buttloads of cash!"
	wn 1 1
	echo "Thought I would say \"SWAG\", didn't you?"
	w 1
	echo "HAH!"
	w 1
	echo "Gotchu!"
	wn 1 1
	w 1
	echo "SWAG"
	wn 1 1
}

special_dialogue_hallway0 () {
	w 1
	echo "."
	wn 1 1
	echo "..."
	wn 1 1
	echo "......"
	wn 1 1
	echo "............"
	wn 1 7
	echo "WEDNESDAY"
	n 3
	wn 1 3
	echo "1:30PM"
	wn 1 3
	w 1
	echo "CIS 191."
	w 1
	echo "I always skip that class."
	w 1
	echo "I mean, I think the instructor dude said there are weekly quizzes..."
	w 1
	echo "But who cares about grades anyways."
	loop_wn 1 1 2
	w 1
	echo "JJ: Okay, how am I killin' time today?"
	w 1
	echo "I'm in the Towne Hall 3rd floor hallway right now for some reason."
	w 1
	echo "..."
	w 1
	echo "Gotta get some action goin' today, if ya know what I mean!"
	wn 1 5
	special_action_hallway0
}

special_action_hallway0 () {
	special_action_hallway0_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. be a baller"
		incr
		echo "${ctr}. SWAG"
		incr
		echo "${ctr}. sleep"
		incr
		n 1
	}
	special_action_hallway0_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to bathroom")
					n 5
					special_dialogue_bathroom
				;;
				"look")
					n 1
					echo "I gotta go to the bathroom."
					w 1
					echo "So one thing you can type is [go to bathroom]."
					w 1
					echo "..."
					w 1
					echo "Without the square brackets, of course."
					wn 1 1
				;;
				"look bathroom")
					n 1
					echo "I look at the bathroom."
					loop_wn 1 1 2
					w 1
					echo "JJ: Yup, that's the bathroom."
					w 1
					echo "JJ: ...As it always has been."
					wn 1 1
				;;
				"be a baller")
					n 1
					echo "I'm already a baller."
					w 1
					echo "What you gon' do about it, huh?"
					loop_wn 1 1 4
					w 1
					echo "Yeah, that's right."
					w 1
					echo "You ain't got nothin' to say."
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				"sleep")
					n 1
					echo "Sleep?"
					loop_wn 1 1 2
					w 1
					echo "What's sleep?"
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_hallway0_whatdo
	done
}

special_dialogue_bathroom () {
	w 1
	echo "..."
	w 1
	echo "I walk towards the urinal."
	w 1
	echo "JJ: Eh, this looks clean."
	w 1
	echo "JJ: The cleaner must've gone through this bathroom pretty recently."
	w 1
	echo "JJ: Yeee!"
	w 1
	echo "I open my zipper."
	loop_wn 1 1 2
	w 1
	echo "Oh, wait."
	w 1
	echo "Let me eat my burrito that I got from Chipotle while I'm at it."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "I close my zipper."
	w 1
	echo "My aim was horrible."
	wn 1 1
	w 1
	echo "Ah, whatever."
	w 1
	echo "Doesn't matter."
	loop_wn 1 1 2
	w 1
	echo "I leave the remainder of my burrito on the counter."
	wn 1 5
	burrito=0
	special_action_bathroom
}

special_action_bathroom () {
	special_action_bathroom_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_bathroom_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to hallway")
					n 5
					special_dialogue_hallway1
				;;
				"look")
					n 1
					echo "I gotta get out of the bathroom now."
					w 1
					echo "So one thing you can type is [go to hallway]."
					w 1
					echo "..."
					w 1
					echo "Without the square brackets, of course."
					w 1
				;;
				"look hallway")
					n 1
					echo "I look at the hallway."
					loop_wn 1 1 2
					w 1
					echo "JJ: Yup, that's the hallway."
					w 1
					echo "JJ: ...As it always has been."
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_bathroom_whatdo
	done
}

special_dialogue_hallway1 () {
	w 1
	echo "I'm back in the hallway."
	w 1
	echo "JJ: Okay, what's next?"
	wn 1 5
	special_action_hallway1
}

special_action_hallway1 () {
	special_action_hallway1_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. what's life?"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_hallway1_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to class")
					n 1
					echo "Let's go to class for once!"
					w 1
					echo "I'm sure Spencer has amazing things to say about Bash scripting!"
					loop_wn 1 1 2
					w 1
					echo "Psyche!"
					w 1
					echo "Pffft, like I would actually go to class..."
					wn 1 1
				;;
				"go to outside")
					n 5
					special_dialogue_outside0
				;;
				"look")
					n 1
					echo "There are two places I can go to."
					w 1
					echo "One's class."
					w 1
					echo "The other's outside."
					loop_wn 1 1 2
					w 1
					echo "I think you know which one I should pick."
					wn 1 1
				;;
				"look class")
					n 1
					echo "It says Towne 303."
					w 1
					echo "If I squint my eyes,"
					wn 1 1
					w 1
					echo "It look likes 'Towne BOB'."
					wn 1 1
					w 1
					echo "Hah."
					wn 1 1
				;;
				"look outside")
					n 1
					echo "I look outside."
					wn 1 1
					w 1
					echo "."
					w 1
					echo "."
					w 1
					echo "."
					wn 1 1
					w 1
					echo "Does the creator of this game not understand that there isn't a single window near where I stand?"
					wn 1 1
				;;
				"what's life?")
					n 1
					echo "The result is: 42"
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_hallway1_whatdo
	done
}

special_dialogue_outside0 () {
	w 1
	echo "Alright, now I'm outside of the Engineering Quad."
	w 1
	echo "..."
	wn 1 1
	w 1
	echo "Let's hustle!"
	w 1
	echo "Great things await!"
	wn 1 5
	special_action_outside0
}

special_action_outside0 () {
	special_action_outside0_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_outside0_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to hallway")
					n 1
					echo "This is where I say..."
					wn 1 1
					w 1
					echo "Ummm... Nope! Wrong direction!"
					wn 1 1
				;;
				"go to street")
					n 5
					special_dialogue_street0
				;;
				"look")
					n 1
					echo "Street."
					w 1
					echo "Or back to the hallway."
					w 1
					echo "You decide."
					loop_wn 1 1 2
					w 1
					echo "Don't screw it up."
					wn 1 1
				;;
				"look hallway")
					n 1
					echo "Over there,"
					w 1
					echo "about nine miles yonder,"
					w 1
					echo "is the infamous Towne Hall 3rd floor hallway."
					wn 1 1
				;;
				"look street")
					n 1
					echo "I look at street."
					wn 1 1
					w 1
					echo "And then, all of a sudden, a crazy thing happens!"
					loop_wn 1 1 4
					w 1
					echo "JK."
					w 1
					echo "Nothing happened."
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_outside0_whatdo
	done
}

special_dialogue_street0 () {
	w 1
	echo "I'm now out at the street."
	wn 1 1
	w 1
	echo "I walk past the cars."
	wn 1 1
	w 1
	echo "And then I see..."
	wn 1 1
	w 1
	echo "And then I see a stripper!"
	w 1
	echo "Jackpot!"
	wn 1 1
	w 1
	echo "Actually, she's the stripper I see every other day."
	loop_wn 1 1 2
	w 1
	echo "JJ: Hey, you!"
	w 1
	echo "Stripper: Hmmm? You talking to me, fine young man?"
	w 1
	echo "JJ: Oh hellz yeah, I'm talking to you!"
	w 1
	echo "JJ: You down for some fun?"
	w 1
	echo "Stripper: Ummm, yeah."
	wn 1 1
	w 1
	echo "Stripper: Hey, I'm just curious... How did you know that I'm a stripper the first time you saw me?"
	w 1
	echo "JJ: The creator of this game told me."
	wn 1 1
	w 1
	echo "Stripper: Oh, gotcha."
	loop_wn 1 1 2
	w 1
	echo "JJ: Okay, you stay here."
	w 1
	echo "JJ: I'll be right back."
	w 1
	echo "Stripper: Uhhh, okay!"
	wn 1 5
	special_action_street0
}

special_action_street0 () {
	special_action_street0_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. wink at her"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_street0_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to fresh grocer")
					n 1
					echo "..."
					w 1
					echo "I'll go there later."
					wn 1 1
				;;
				"go to garbage bin")
					n 1
					echo "Why the hell do you want me to go to the garbage bin?"
					wn 1 1
					w 1
					echo "You cray."
					wn 1 1
				;;
				"go to pottruck")
					n 5
					special_dialogue_pottruck
				;;
				"go to chipotle")
					n 1
					echo "I already went there earlier today."
					w 1
					echo "I think that's enough Mexicano for one day."
					wn 1 1
				;;
				"look")
					n 1
					echo "I can [go to fresh grocer]."
					w 1
					echo "I can [go to garbage bin]."
					w 1
					echo "I can [go to pottruck]."
					w 1
					echo "And I can even [go to chipotle]!"
					wn 1 1
					w 1
					echo "Wow!"
					w 1
					echo "The street has so many options!"
					w 1
					echo "It's mind-blowing!"
					w 1
					echo "Ahhh!"
					wn 1 1
				;;
				"look fresh grocer")
					n 1
					echo "JJ: Oh yeah, this is ma homie Fro Gro!"
					w 1
					echo "JJ: Oh yeah, they call me Bro Bro!"
					wn 1 1
					w 1
					echo "..."
					wn 1 1
				;;
				"look garbage bin")
					n 1
					echo "How about, instead of looking at garbage bin,"
					w 1
					echo "I tell you a cool secret?"
					w 1
					echo "If you type \"gullible\", you will see a special message!"
					wn 1 1
				;;
				"look pottruck")
					n 1
					echo "Now this!"
					w 1
					echo "This, my friend, is my home away from home!"
					wn 1 1
				;;
				"look chipotle")
					n 1
					echo "I'm totes down for some mo' chipotes tomorrow."
					w 1
					echo "Oh hellz yeah."
					wn 1 1
				;;
				"wink at her")
					n 1
					echo "JJ: *wink*"
					wn 1 1
					w 1
					echo "Stripper: *wink*"
					loop_wn 1 1 2
					w 1
					echo "That's what I'm talking about."
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_street0_whatdo
	done
}

special_dialogue_pottruck () {
	w 1
	echo "JJ: EAUGHHHHHHHHH!!!!!!!!!!!!!!"
	w 1
	echo "JJ: OHHHHHHH YEAHHHHHHHHHHHHH!!!!!!!!!!!!!!!!!!!!"
	w 1
	echo "..."
	w 1
	echo "I make all kinds of manly noises, as I work out in the Pottruck Gym."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Whooo-ah!"
	w 1
	echo "JJ: I FEEL THE BULK!"
	w 1
	echo "JJ: I FEEL THE BURN!"
	w 1
	echo "JJ: OH HELLZ YEAH!"
	wn 1 1
	w 1
	echo "Now I'm ready for the holy ritual."
	wn 1 1
	w 1
	echo "Before I leave the gym, I borrow a red towel and wipe the sweat off my face with it."
	w 1
	echo "Then, like a real douche, I leave it on the counter."
	w 1
	echo "..."
	wn 1 5
	manliness=1
	special_action_pottruck
}

special_action_pottruck () {
	special_action_pottruck_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. SWAG"
		incr
		echo "${ctr}. look at myself in the mirror"
		incr
		n 1
	}
	special_action_pottruck_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to street")
					n 5
					special_dialogue_street1
				;;
				"look")
					n 1
					echo "The only place I can go to from here is the street."
					wn 1 1
				;;
				"look street")
					n 1
					echo "The street is filled with all of the people who didn't just work out."
					loop_wn 1 1 2
					w 1
					echo "JJ: Pffft, peasants..."
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				"look at myself in the mirror")
					n 1
					echo "Anyone who lifts knows that looking yourself in the mirror is pretty much part of the work out."
					w 1
					echo "JJ: Oh yeah, that's one sexy looking man!"
					wn 1 1
					w 1
					echo "..."
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_pottruck_whatdo
	done
}

special_dialogue_street1 () {
	w 1
	echo "Before I pick her up with my gigantic biceps, I go to Fresh Grocer to buy her a 2,000 dollar cheesecake."
	wn 1 1
	w 1
	echo "Cuz I'm a true gentleman, of course."
	wn 1 1
	w 1
	echo "She's still there."
	w 1
	echo "JJ: Oi, stripper girl!"
	w 1
	echo "Stripper: I have a name, JJ."
	w 1
	echo "JJ: Of course I know you have a name, baby girl!"
	w 1
	echo "JJ: I just don't want the Player to know your name!"
	w 1
	echo "JJ: ...Cuz your name is only mine!"
	loop_wn 1 1 2
	w 1
	echo "..."
	w 1
	echo "Wow, me."
	w 1
	echo "10 points for being cheesier than the cheesecake."
	loop_wn 1 1 2
	w 1
	echo "JJ: Baby girl, here's a cheesecake for you!"
	w 1
	echo "Stripper: Oh, you know I looooooove cheesecake!"
	w 1
	echo "I hand her the cheesecake."
	wn 1 1
	w 1
	echo "She finishes it in the blink of an eye."
	loop_wn 1 1 2
	echo "I'm impressed."
	wn 1 1
	w 1
	echo "JJ: You ready to go, baby girl?"
	w 1
	echo "Stripper: Hellz yeah!"
	wn 1 1
	w 1
	echo "Time for some fun!"
	w 1
	echo "Oh yeah!"
	wn 1 5
	dignity=0
	special_action_street1
}

special_action_street1 () {
	special_action_street1_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. Time for some fun!"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_street1_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to outside")
					n 5
					special_dialogue_outside1
				;;
				"go to pottruck")
					n 1
					echo "Brah."
					w 1
					echo "I'm already ready for the game."
					wn 1 1
				;;
				"look")
					n 1
					echo "I can go back to the front of the Engineering Quad, which is for some reason called \"outside\". I honestly don't understand why."
					w 1
					echo "...Or I can go back to Pottruck."
					wn 1 1
				;;
				"look outside")
					n 1
					echo "I look at the Engineering Quad."
					w 1
					echo "A bunch of engineering students are going in and out of the Engineering Quad."
					w 1
					echo "..."
					w 1
					echo "Nothing surprising there."
					wn 1 1
				;;
				"look pottruck")
					n 1
					echo "Farewell, my home away from home..."
					loop_wn 1 1 2
					w 1
					echo "...for today."
					wn 1 1
				;;
				"Time for some fun!")
					n 1
					echo "Not here, you dumb dumb!"
					w 1
					echo "I gotta take her to somewhere more private!"
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_street1_whatdo
	done
}

special_dialogue_outside1 () {
	w 1
	echo "Okay, now I'm at the Engineering Quad."
	wn 1 1
	w 1
	echo "With my stripper."
	loop_wn 1 1 2
	w 1
	echo "Hustle!"
	w 1
	echo "It's time for some action!"
	wn 1 5
	special_action_outside1
}

special_action_outside1 () {
	special_action_outside1_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_outside1_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to palestra")
					n 5
					special_dialogue_palestra
				;;
				"look"|"look palestra")
					n 1
					echo "Hurry!"
					wn 1 1
					w 1
					echo "The Palestra is the place to be!"
					wn 1 1
				;;
				"SWAG")
					special_swag
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_outside1_whatdo
	done
}

special_dialogue_palestra () {
	w 1
	echo "Now, my stripper and I are in the Palestra."
	w 1
	echo "Noone is here."
	wn 1 1
	w 1
	echo "That means this is the place for some fun time!"
	w 1
	echo "JJ: Is this okay?"
	w 1
	echo "Stripper: Yeah, this'll work."
	w 1
	echo "JJ: Sweet!"
	w 1
	echo "Stripper: Let's not make it too long though, okay?"
	w 1
	echo "Stripper: I have to go off to work."
	w 1
	echo "JJ: Ah, fine."
	wn 1 5
	special_action_palestra
}

special_action_palestra () {
	fun_time=1
	special_action_palestra_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. Time for some fun!"
		incr
		echo "${ctr}. SWAG"
		incr
		n 1
	}
	special_action_palestra_whatdo
	while read special_action
	do
		special_action_common
		if [ $special_not_common -eq 1 ]; then
			case $special_action in
				"go to outside"|"look"|"look outside"|"SWAG")
					n 1
					echo "Wrong move, my friend!"
					w 1
					echo "I'm almost at my goal!"
					w 1
					echo "It's right in front of me!"
					w 1
					echo "And you're gonna delay the process?"
					wn 1 1
				;;
				"Time for some fun!")
					n 1
					echo "Hellz yeah!"
					loop_wn 1 1 2
					w 1
					echo "Hold on."
					wn 1 1
					w 1
					echo "I forgot something."
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		special_action_palestra_whatdo
	done
}

special_dialogue_happy () {
	fun_time=0
	loop_wn 1 3 3
	echo "."
	n 3
	wn 1 3
	echo "."
	n 3
	wn 1 3
	echo "."
	n 3
	wn 1 3
	echo "."
	n 3
	wn 1 3
	echo "."
	n 3
	wn 1 3
	echo "."
	n 3
	loop_wn 1 3 2
	w 1
	echo "JJ: Hah..."
	w 1
	echo "Stripper: Hah..."
	w 1
	echo "We have finished our fun."
	w 1
	echo "..."
	loop_wn 1 1 2
	w 1
	echo "Yeah, yeah, I get it."
	w 1
	echo "You're complaining that I skipped all the good details."
	w 1
	echo "The best part of the game, obviously."
	w 1
	echo "Well, sorry, pal."
	w 1
	echo "It's not because I'm tryna have all the fun by myself, I swear!"
	wn 1 1
	w 1
	echo "The creator of this game wants to keep this relatively PG."
	loop_wn 1 1 5
	w 1
	echo "The stripper puts her clothes back on."
	w 1
	echo "JJ: You ready to leave?"
	w 1
	echo "Stripper: Yeah. You?"
	w 1
	echo "JJ: I'm gonna stick around for a few minutes."
	w 1
	echo "JJ: You know, school pride and all."
	w 1
	echo "Stripper: Alright, well take care!"
	w 1
	echo "JJ: Yeah, I'll see you around!"
	w 1
	echo "She leaves."
	w 1
	echo "..."
	loop_wn 1 1 2
	w 1
	echo "Then she comes back."
	w 1
	echo "Stripper: Hey JJ. I just wanted to say..."
	w 1
	echo "Stripper: ...SWAG!"
	wn 1 1
	w 1
	echo "JJ: Hellz yeah!"
	wn 1 1
	w 1
	echo "Now she actually leaves."
	loop_wn 1 1 4
	w 1
	echo "I put my clothes back on."
	w 1
	echo "As I try to admire the grandeur of the stadium, I hear a sound."
	wn 1 1
	w 1
	echo "The sound of people coming in."
	w 1
	echo "JJ: Crap!"
	w 1
	echo "Is something going on in the Palestra this afternoon?"
	w 1
	echo "Argh, I better get going!"
	loop_wn 1 1 2
	w 1
	echo "Without a moment of hesitation, I rush out of the Palestra..."
	wn 1 1
	wn 1 2
	wn 1 3
	loop_wn 1 7 3
	wn 1 3
	echo "Today is a sunny day."
	n 3
	wn 1 1
	echo "THE END"
	n 1
	wn 1 4
	special_game_complete
}

special_game_complete () {
	just_completed=1
	n 1
	loop_wn 1 3 3
	w 1
	echo "Narrator X: Well!"
	w 1
	echo "Narrator X: It seems like you unlocked and beat the special mode of this game!"
	w 1
	echo "Narrator X: Uhhh..."
	w 1
	echo "Narrator X: I didn't write out a script for this part..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: CONGRATULATIONS!"
	w 1
	echo "Narrator X: ..."
	wn 1 1
	w 1
	echo "Narrator X: I hope that was... Ummm, meaningful?"
	w 1
	echo "Narrator X: ..."
	wn 1 1
	w 1
	echo "Narrator X: Okay, you know what."
	w 1
	echo "Narrator X: Let's just end it at that."
	w 1
	echo "Narrator X: You beat the special mode."
	w 1
	echo "Narrator X: I'm happy for you."
	w 1
	echo "Narrator X: You're happy for yourself."
	w 1
	echo "Narrator X: The end."
	w 1
	echo "Narrator X: You live happily ever after."
	w 1
	echo "Narrator X: ..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Ehem..."
	wn 1 1
	w 1
	echo "Narrator X: Good bye for now!"
	wn 1 4
	if [ $unlock_special -eq 0 ]; then
		unlock_special=1
		unlocked_special
		achievementscheck
	fi
	game_choice
}

# achievement functions

achievementsnotify () {
	n 1
	loop_wn 1 3 3
	w 1
	echo "Narrator X: Hello there!"
	w 1
	echo "Narrator X: It's great to see you again!"
	w 1
	echo "Narrator X: \"Why are you here?\", you may ask?"
	w 1
	echo "Narrator X: Well, I did say that I will not appear until you either reach GAME OVER or beat the game."
	w 1
	echo "Narrator X: ...But it seems like the creator of this game hired only one narrator to do every narrator job that exists in this game!"
	w 1
	echo "Narrator X: So I'm back here, having to show to you this cool little thing called Achievements as explained below!"
	wn 1 1
	echo "--------------------------------------------------------------------------------"
	wn 1 1
	echo "Welcome to the \"hidden\" Achievements corner!"
	w 1
	echo "I say, quote-on-quote, \"hidden\", because if you have been \"look\"ing at everything that you have encountered so far, chances are you will always arrive at this corner."
	w 1
	echo "So it's really not that hidden, after all."
	wn 1 3
	w 1
	echo "Anyways, welcome to the Achievements corner!"
	w 1
	echo "It turns out that there are several achievements that you can unlock along your way in playing this game!"
	w 1
	echo "Say, WHAT?!?!?!?!"
	w 1
	echo "Yeah, I know. This is pretty mind-blowing."
	w 1
	echo "Let me tell you how this works."
	w 1
	echo "There are about 10 total achievements that you can unlock."
	w 1
	echo "Once you unlock all 10 achievements, you will get to see something."
	w 1
	echo "And of course, if you think I'm going to tell you what that \"something\" is, you're absolutely mistaken."
	w 1
	echo "When you unlock an achievement, you will be notified so."
	w 1
	echo "You may call a hidden action, \"achievements\", in order to check your progress with the achievements you unlocked thus far!"
	w 1
	echo "Feel free to call \"achievements\" whenever you see \"What should I do?\" You can even call it at the beginning of the game!"
	w 1
	echo "I mean, you won't see any achievement unlocked at the beginning of the game, of course. But nothing stops you from being awesome!"
	w 1
	echo "Speaking of which, there actually IS a slightly bigger difference between restarting the game (after GAME OVER) and quitting the game than you may have originally thought."
	w 1
	echo "Guess what? Restarting the game may or may not preserve the achievements you have unlocked so far!"
	w 1
	echo "Oooooooooh! That's exciting, isn't it?!"
	w 1
	echo "Oh, so you're wondering what the first achievement was that you just unlocked?"
	w 1
	echo "Well, why don't you give \"achievements\" a try and check it yourself?"
	w 1
	echo "I mean, who knows? Maybe you have already unlocked some other achievements as well!"
	wn 1 1
	echo "--------------------------------------------------------------------------------"
	wn 1 1
	w 1
	echo "Narrator X: ...and that's it for the Achievements corner!"
	w 1
	echo "Narrator X: Gotta go back to playing video games!"
	w 1
	echo "Narrator X: Adios!"
	wn 1 3
	wn 1 1
}

achievementscheck () {
	if [ $secret_shady -eq 1 -a $all_girls -eq 1 -a $theres_a_mouse -eq 1 -a $meet_stripper -eq 1 -a $troll_paper -eq 1 -a $hobo_happy -eq 1 -a $sky_life -eq 1 -a $retry_seven -eq 1 -a $try_all_names -eq 1 -a $beat_game -eq 1 -a $unlock_special -eq 1 -a $all_achievements -eq 0 ]; then
		all_achievements=1
		halloffame
	fi
}

showachievements () {
	n 1
	echo "Achievements Unlocked:"
	wn 1 1
	init
	if [ $secret_shady -eq 1 ]; then
		echo "${ctr}. The Cake :"
		echo "	Typed \"asdfg\" followed by \"ThE cAkE iS a LiE\" while in front of Shady Gutzmann's house, and then looked at Cheesecake in Fresh Grocer."
	else
		echo "${ctr}."
	fi
	incr
	if [ $all_girls -eq 1 ]; then
		echo "${ctr}. Meet the Girls :"
		echo "	Looked at Girls in all four possible situations: in Class at 2:00PM, in Class at 3:00PM, in Pottruck before enabling Shady Gutzmann's house, in Pottruck after enabling Shady Gutzmann's house."
	else
		echo "${ctr}."
	fi
	incr
	if [ $theres_a_mouse -eq 1 ]; then
		echo "${ctr}. There's a Mouse :"
		echo "	Looked at Mouse in Garbage Bin."
	else
		echo "${ctr}."
	fi
	incr
	if [ $meet_stripper -eq 1 ]; then
		echo "${ctr}. The Stripper @ Night :"
		echo "	Looked at Stripper at 8:00PM in Street."
	else
		echo "${ctr}."
	fi
	incr
	if [ $troll_paper -eq 1 ]; then
		echo "${ctr}. Troll Paper @ Chipotle :"
		echo "	Looked at Paper in Chipotle 5 times."
	else
		echo "${ctr}."
	fi
	incr
	if [ $hobo_happy -eq 1 ]; then
		echo "${ctr}. Happy Hobo :"
		echo "	Looked at Homeless Man in Outside, and then gave him \$30."
	else
		echo "${ctr}."
	fi
	incr
	if [ $sky_life -eq 1 ]; then
		echo "${ctr}. Sky & Life :"
		echo "	Looked at Blue Sky in Outside."
	else
		echo "${ctr}."
	fi
	incr
	if [ $retry_seven -eq 1 ]; then
		echo "${ctr}. Retry 7 :"
		echo "	Retried 7 times."
	else
		echo "${ctr}."
	fi
	incr
	if [ $try_all_names -eq 1 ]; then
		echo "${ctr}. All Character Names :"
		echo "	Tried choosing all in-game named characters' names for main character's name."
	else
		echo "${ctr}."
	fi
	incr
	if [ $beat_game -eq 1 ]; then
		echo "${ctr}. Beat the Game :"
		echo "	Beat the game."
	else
		echo "${ctr}."
	fi
	incr
	if [ $unlock_special -eq 1 ]; then
		echo "${ctr}. Beat the Special :"
		echo "	Beat the special mode of the game."
	fi
	incr
	if [ $all_achievements -eq 1 ]; then
		loop_wn 1 1 2
		w 1
		echo "All achievements unlocked!"
	fi
	wn 1 1
}

unlocked_shady () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"The Cake\"!]]"
	n 1
	wn 1 3
	w 1
}

girls_update () {
	if [ $meet_girls_class2 -eq 1 -a $meet_girls_class3 -eq 1 -a $meet_girls_potnsh -eq 1 -a $meet_girls_potsh -eq 1 ]; then
		all_girls=1
		unlocked_girls
		achievementscheck
	fi
}

unlocked_girls () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Meet the Girls\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_mouse () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"There's a Mouse\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_stripper () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Stripper @ Night\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_paper () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Troll Paper @ Chipotle\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_hobo () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Happy Hobo\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_sky () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Sky & Life\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_seven () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Retry 7\"!]]"
	n 1
	wn 1 3
	w 1
}

names_update () {
	if [ $type_joel -eq 1 -a $type_spencer -eq 1 -a $type_shady -eq 1 -a $type_narrator -eq 1 ]; then
		try_all_names=1
		unlocked_names
		achievementscheck
	fi
}

unlocked_names () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"All Character Names\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_beat () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Beat the Game\"!]]"
	n 1
	wn 1 3
	w 1
}

unlocked_special () {
	wn 1 3
	wn 1 1
	echo "[[Unlocked \"Beat the Special\"!]]"
	n 1
	wn 1 3
	w 1
}

halloffame () {
	w 7
	echo "--------------------------------------------------------------------------------"
	wn 1 1
	echo "<<HALL OF FAME>>"
	wn 1 1
	w 1
	echo "Narrator X: CONGRATULATIONS!"
	w 1
	echo "Narrator X: I mean..."
	loop_wn 1 1 4
	w 1
	echo "Narrator X: SUPER CONGRATULATIONS!!!!!!!!!!!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: You managed to unlock ALL achievements that were created in this game!!!"
	w 1
	echo "Narrator X: This is exciting!"
	wn 1 1
	w 1
	echo "Narrator X: You should feel super awesome right now!"
	w 1
	echo "Narrator X: Gosh!"
	w 1
	echo "Narrator X: I wonder how much time you spent playing this game!"
	w 1
	echo "Narrator X: I mean, WOWZA!!!"
	loop_wn 1 1 4
	w 1
	echo "Narrator X: Hmmm?"
	w 1
	echo "Narrator X: Reward?"
	w 1
	echo "Narrator X: Oh!"
	wn 1 1
	w 1
	echo "Narrator X: Ummm..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: You see..."
	wn 1 1
	w 1
	echo "Narrator X: I'm just a fictitious figure living inside your computer."
	w 1
	echo "Narrator X: It's physically impossible for me to give you any sort of tangible awards."
	w 1
	echo "Narrator X: ..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: But still..."
	wn 1 1
	w 1
	echo "Narrator X: SUPER CONGRATULATIONS!!!!!!!!!!!"
	wn 1 1
	w 1
	echo "Narrator X: You should reward yourself with a nice dinner or something!"
	w 1
	echo "Narrator X: Maybe a nice dinner date with Amy Gutmann?"
	w 1
	echo "Narrator X: In case you don't know who she is, she was the president of the University of Pennsylvania when the creator of this game used to go there."
	w 1
	echo "Narrator X: ...Or maybe even some fun..."
	wn 1 1
	w 1
	echo "Narrator X: ...if ya know what I mean!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: Anyhow, what's next, you ask?"
	w 1
	echo "Narrator X: I mean, to be honest, I'd say you're at a point where you can quit the game."
	w 1
	echo "Narrator X: You've done well."
	w 1
	echo "Narrator X: You, the Mighty Player, did not give up..."
	w 1
	echo "Narrator X: ...like the game has been telling you all this time!!!"
	loop_wn 1 1 2
	w 1
	echo "Narrator X: That being said, if I remember this correctly, the creator of this game did hide a few more little treats for the keenest of you to discover!"
	w 1
	echo "Narrator X: For example, I think there might be a glitch somewhere near Fresh Grocer."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: It's all up to you!"
	w 1
	echo "Narrator X: You'll certainly be given a choice as to whether you would like to continue playing the game or quit it."
	w 1
	echo "Narrator X: If you decide to continue, your progress thus far will still remain with you!"
	w 1
	echo "Narrator X: If you decide to quit, I'll forget about you, and we'll meet each other fresh and anew the next time you play this game!"
	loop_wn 1 1 4
	w 1
	echo "Narrator X: So..."
	w 1
	echo "Narrator X: I have said everything I have to say."
	w 1
	echo "Narrator X: Before I go back to playing my video games..."
	w 1
	echo "Narrator X: Before you go make your decision..."
	loop_wn 1 1 2
	w 1
	echo "Narrator X: I would like to say this on behalf of the creator of this game."
	wn 1 1
	wn 1 2
	wn 1 3
	loop_wn 1 7 7
	wn 1 1
	echo "Thank you for playing this game."
	n 1
	wn 1 1
	echo "Your time spent on playing this game means a lot to me."
	n 1
	wn 1 1
	echo "I truly appreciate your decision to start and continue this journey."
	n 1
	loop_wn 1 1 4
	echo "Until I see you in my next game..."
	n 1
	loop_wn 1 1 2
	echo "Good bye for now!"
	n 1
	w 1
	echo "--------------------------------------------------------------------------------"
	wn 1 5
	wn 1 4
	halloffame_choice
}

halloffame_choice () {
	n 1
	w 1
	halloffame_choice_whatdo () {
		whatdo
		init
		echo "${ctr}. continue"
		incr
		echo "${ctr}. quit"
		incr
		n 1
	}
	halloffame_choice_whatdo
	while read action
	do
		case $action in
			"continue")
				break
			;;
			"quit")
				exit 0
			;;
			*)
				invalid
			;;
		esac
		halloffame_choice_whatdo
	done
}

# pre game

introduction () {
	n 1
	echo "THE CHRYSALIDS"
	n 1
	echo "[Type ENTER to play the game.]"
	wn 1 1
	echo "[Great! From here on out, type ENTER whenever you want to read the next line. Typing ENTER when you have to take a certain course of action or go somewhere will NOT advance you forward.]"
	wn 1 1
	echo "Chrysalid: a quiescent insect pupa, especially of a butterfly or moth."
	echo "                - the hard outer case of this, especially after being discarded."
	echo "                - a preparatory or transitional state."
	wn 1 1
	w 1
	echo "                - (figurative) a state of inhibition... or fear."
	wn 1 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    L"
	w 1
	echo "    O"
	w 1
	echo "    A"
	w 1
	echo "    D"
	w 1
	echo "    I"
	w 1
	echo "    N"
	w 1
	echo "    G"
	w 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    ."
	w 1
	echo "    ."
	wn 1 5
	choosename
}

choosename () {
	echo "What's my name?"
	wn 1 1
	echo "Enter your name:"
	while read usrname
	do
	  if [ "$usrname" = "$str" ]; then
	  	n 1
	    echo "My name must be at least one character!"
	    n 1
	  elif [ "$usrname" = "Joel" -o "$usrname" = "Joel Unzain" -o "$usrname" = "Spencer" -o "$usrname" = "Spencer Lee" -o "$usrname" = "Shady" -o "$usrname" = "Shady Gutzmann" -o "$usrname" = "Narrator X" ]; then
	  	case $usrname in
	  		"Joel"|"Joel Unzain")
					if [ $type_joel -eq 0 ]; then
						type_joel=1
						names_update
					fi
				;;
				"Spencer"|"Spencer Lee")
					if [ $type_spencer -eq 0 ]; then
						type_spencer=1
						names_update
					fi
				;;
				"Shady"|"Shady Gutzmann")
					if [ $type_shady -eq 0 ]; then
						type_shady=1
						names_update
					fi
				;;
				"Narrator X")
					if [ $type_narrator -eq 0 ]; then
						type_narrator=1
						names_update
					fi
				;;
				*)
				;;
	  	esac
	  	n 1
	    echo "This name is already assigned to a character in this game!"
	    n 1
	  elif [ "$usrname" = "JJ" ]; then
	  	if [ $beat_game -eq 1 ]; then
	  		special_mode
	  	else
	  		n 1
	  		echo "403 Forbidden"
	  		n 1
	  	fi
	  else
	    n 1
	    echo "My name is ${usrname}."
	    usrname_fst_three=${usrname:0:3}
	    n 1
	    break
	  fi
	done
	wn 1 3
	if [ $restart_name -eq 0 ]; then
		narrator_x
	else
		restart_name=0
		dialogue_130_class
	fi
}

narrator_x () {
	echo "--------------------------------------------------------------------------------"
	n 1
	echo "Narrator X: Hello, ${usrname}!"
	wn 1 1
	echo "Narrator X: It's a real pleasure to meet you. I am Narrator X. Once I finish providing you with a brief set of instructions, I will not appear again until you either reach GAME OVER or beat this game."
	wn 1 1
	echo "Narrator X: The story is told in your point of view. That is, you, ${usrname}, will be narrating the majority of this story. I will not tell you much about what this story is about, since a whole lot of surprises await you. However, these are some things that you should know as you're playing this game."
	wn 1 1
	instructions
	wn 1 1
	echo "Narrator X: That's it for instructions! Don't worry if you forget all of this. You can always bring out these instructions by typing \"help\" when you're in action mode. Just remember that the only commands or actions that are not explicitly mentioned are \"item\", \"use\", and \"help\"!"
	wn 1 1
	echo "Narrator X: Good luck!"
	wn 1 3
	echo "                                   _    ,-,    _"
	echo "                           ,--, /: :\\/': :\`\\/: :\\"
	echo "                          |\`;  ' \`,'   \`.;    \`: |"
	echo "                          |    |     |  '  |     |."
	echo "                          | :  |     |     |     ||"
	echo "                          | :. |  :  |  :  |  :  | \\"
	echo "                           \\__/: :.. : :.. | :.. |  )"
	echo "                                \`---',\\___/,\\___/ /'"
	echo "                                     \`==._ .. . /'"
	echo "                                          \`-::-'"
	n 3
	wn 1 1
	echo "--------------------------------------------------------------------------------"
	wn 1 3
	echo "Now, let the game begin............"
	wn 1 1
	echo "......"
	wn 1 1
	echo "..."
	wn 1 1
	echo "."
	wn 1 4
	dialogue_130_class
}

# main game

reset_clock () {
	chipotle=0
	palestra=0
	shady_house=0
	pocket_money=50
	jerkey=0
	have_ring=0
	have_card=0
	have_key=0
	garbagebag_poked=0
	can_use_key=0
	can_open_door=0
	plop=0
	fake_glitch=0
	saw_salmon=0
	poke_sure=0
	saw_door=0
	can_give_hobo=0
	to_hobo=0
	hobo_level=0
	can_give_shady=0
	shady_level=0
	dark_outside=0
	tried_leaving=0
	talked_spencer0=0
	talked_spencer1=0
	bathroom_joel=0
	to_joel=0
	just_completed=0
	compliments=0
	try_kiss=0
	try_dance=0
	secret_asdfg=0
	secret_cake=0
}

action_common () {
	not_common=0
	case $action in
		"help")
			helpmessage
		;;
		"item")
			itemshow
		;;
		"use notebook")
			if [ $to_joel -eq 1 ]; then
				usenotebook_joel
			else
				usenotebook
			fi
		;;
		"use cash")
			if [ $can_give_hobo -eq 1 -a $to_hobo -eq 1 ]; then
				usecash_hobo
			elif [ $can_give_shady -eq 1 ]; then
				usecash_shady
			else
				usecash
			fi
		;;
		"use jerkey")
			usejerkey
		;;
		"use ring")
			if [ $have_ring -eq 1 ]; then
				usering
			else
				invalid
			fi
		;;
		"use penncard")
			if [ $have_card -eq 1 ]; then
				usepenncard
			else
				invalid
			fi
		;;
		"use key")
			if [ $have_key -eq 1 ]; then
				if [ $can_use_key -eq 1 -a $can_open_door -eq 0 -a $saw_door -eq 1 ]; then
					usekey_house
				else
					usekey
				fi
			else
				invalid
			fi
		;;
		"use butterfly")
			if [ $have_butterfly -eq 1 ]; then
				usebutterfly
			else
				invalid
			fi
		;;
		"achievements")
			showachievements
		;;
		*)
			not_common=1
		;;
	esac
}

dialogue_130_class () {
	n 1
	echo "."
	wn 1 1
	echo "..."
	wn 1 1
	echo "......"
	wn 1 1
	echo "............"
	wn 1 7
	echo "WEDNESDAY"
	n 3
	wn 1 3
	echo "1:30PM"
	wn 1 3
	w 1
	echo "CIS 191."
	w 1
	echo "A class full of adventure."
	w 1
	echo "Exploration."
	w 1
	echo "...and manhood."
	w 1
	echo "Everytime I enter the room Towne 303, I breathe in a breath of fresh air."
	w 1
	echo "The ceiling is bright."
	w 1
	echo "My future is bright."
	w 1
	echo "And so is the halo behind Spencer's back."
	w 1
	echo "Spencer, our wonderful grad student bashtastic instructor."
	w 1
	echo "Spencer, the boss."
	w 1
	echo "(Spencer Lee, the man with apparently the same last name as the creator of this game... the fourth wall, what?!)"
	wn 1 3
	echo "This."
	w 1
	echo "${usrname}: This. This is complete glory."
	w 1
	echo "Spencer: Okay, enough with the self-gratifying, poetic crap. Get to your seat, so I can put on my instructor face."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "So, if you haven't guessed already, I'm in my CIS 191 class right now."
	w 1
	echo "The materials are the same-old, same-old. Spencer is saying, as usual,"
	w 1
	echo "Spencer: Hey, guys! So, I'm gonna hand out the quiz for this week in about 10 minutes, just so we can let people come in before we start the quiz. In the meantime, let's talk about how cool bash scripting is! So... Who wants to tell me what's an alternative to writing 'test'?"
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "Silence."
	w 1
	echo "Like a true hero, I raise my hand up."
	w 1
	echo "Spencer: Okay, ${usrname}."
	w 1
	echo "${usrname}: It's square brackets. We gotta make sure that the command we're testing with is separated by spaces from the square brackets."
	w 1
	echo "Spencer: That's right! Thank you, ${usrname}. So, today, I'm about to tell you..."
	w 1
	echo "I have a midterm for my next class, CIS 320. To be honest, I love Spencer from the bottom of my heart to the top of my sternum, but I can't care less about bash scripting right now."
	w 1
	echo "Unfortunately, I was falling asleep in last week's CIS 320 lecture, so I think I'm gonna have to ask my friend Joel Unzain, who happens to be in both my CIS 191 and CIS 320 classes, for his CIS 320 notes."
	w 1
	echo "${usrname}: Tsk tsk! Yo Joel! May I borrow your CIS 320 notebook for a moment? Gotta prep for dat CIS 320 tho!"
	w 1
	echo "Joel: Oh, for sure dude! Just keep it until after the midterm. I won't be reading it before the midterm!"
	w 1
	echo "${usrname}: Thanks, dude! I owe you a dinner at Sitar!"
	w 1
	echo "Joel: Hahah, don't sweat it, brah."
	w 1
	echo "${usrname}: What's in your bag? It looks pretty heavy."
	w 1
	echo "Joel: Eh, nothing much. Just a lot of, you know, books."
	w 1
	echo "${usrname}: Oh, yeah. \"Books\", I see."
	w 1
	echo "Joel: Yeee!"
	w 1
	echo "Joel and I have been friends for quite a while now. Ever since we met in kindergarden..."
	loop_wn 1 1 3
	echo "LOL, just kidding. I met him in my freshman year."
	w 1
	echo "Anyhow, Joel is probably, arguably, most likely, definitely the nicest guy I know around here."
	w 1
	echo "And when I say \"around here\", I don't mean the four peeps that are surrounding me right now."
	w 1
	echo "Joel is literally the nicest guy I've seen in my entire 19 years of life."
	w 1
	echo "...Okay, maybe that was too big of a compliment."
	w 1
	echo "Regardless, this guy is simply the definition of 'selfless'."
	w 1
	echo "Even though I just told him I will buy him some good ole Indian food, he knows I'm broke, being a college student and all."
	w 1
	echo "It's always been this way. He always gives and never asks for return."
	w 1
	echo "I mean, that's probably why we're friends."
	w 1
	echo "We're like the yin and the yang, you see."
	w 1
	echo "I always receive, and never give."
	w 1
	echo "..."
	w 1
	echo "Okay, enough with the \"just kidding\". But here's a real compliment."
	w 1
	echo "He has wrapped around his wrist a red bandana."
	w 1
	echo "...and it looks pretty freaking awesome."
	wn 1 1
	wn 1 2
	w 1
	echo "Spencer: Hey, guys! So this one time, I wrote in my script 'mv ~ /dev/null' just for fun! And guess what -- it wasn't fun at all!"
	w 1
	if [ $world -ge 2 ]; then
		dialogue_200_class
	fi
	echo "While Spencer is talking about how awesome and beautiful bash scripting is, I decide to do some crash CIS 320 review..."
	wn 1 1
	echo "."
	wn 1 1
	echo "."
	wn 1 1
	echo "."
	wn 1 1
	wn 1 6
	dialogue_300_class
}

dialogue_200_class () {
	wn 1 3
	echo "2:00PM"
	wn 1 3
	w 1
	echo "All of sudden!"
	loop_wn 1 3 2
	w 1
	echo "...I have an urge to go to the bathroom."
	wn 1 4
	action_200_class
}

dialogue_300_class () {
	wn 1 3
	echo "3:00PM"
	wn 1 3
	w 1
	echo "Spencer: ...Okay, I guess it's time to stop now. Homework 12 is out, guys! Remember, you don't HAVE to do it! You just probably won't pass this class if you don't do it, that's all!"
	w 1
	echo "CIS 191 class is over. Spencer is saying good bye."
	wn 1 4
	action_300_class
}

dialogue_800_class () {
	n 5
	echo "8:00PM"
	wn 1 3
	w 1
	echo "I had a bad feeling about leaving the classroom after class."
	w 1
	echo "I mean, sure, I just totally missed my CIS 320 midterm. But something just didn't feel right about leaving the classroom right at that moment."
	w 1
	echo "Besides, I can always send an e-mail to my CIS 320 professor that I got awfully sick today, so I couldn't attend the exam."
	w 1
	echo "I'm sure he can arrange a make-up midterm for me."
	w 1
	echo "..."
	w 1
	echo "So I decided to stay in Towne 303 for a while."
	w 1
	echo "${usrname}: God, only if I can figure out what time it is right now..."
	w 1
	echo "The clock here is broken."
	w 1
	echo "I forgot to bring my watch."
	w 1
	echo "My phone is dead."
	w 1
	echo "..."
	w 1
	echo "Hurray, me."
	w 1
	echo "Good job, me."
	w 1
	echo "..."
	wn 1 1
	wn 1 2
	w 1
	echo "Well, the sky is dark."
	w 1
	echo "And there is no reason for me to stay here, after all."
	w 1
	echo "I should probably get back to my room to send my CIS 320 professor a very well-crafted e-mail."
	wn 1 4
	action_800_class
}

dialogue_1150_class () {
	n 5
	echo "11:50PM"
	wn 1 3
	w 1
	echo "No, I shouldn't."
	w 1
	echo "I shouldn't just now."
	w 1
	echo "I can send my CIS 320 professor a very well-crafted e-mail later."
	w 1
	echo "Right now, I should stay safe."
	w 1
	echo "Maybe I'll stay here in Towne 303 over night."
	w 1
	echo "That doesn't seem like a bad idea."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "What about blankets, though?"
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "I hear footsteps."
	w 1
	echo "Someone is coming towards the classroom."
	wn 1 4
	action_1150_class
}

dialogue_post_1150_class () {
	n 4
	echo "I decide to hide under one of the desks next to the wall."
	w 1
	echo "This is a long shot."
	w 1
	echo "If whoever comes in and turns on the light, I'll be seen right away anyways."
	w 1
	echo "But if the light is off, there's a chance that I'll stay unnoticed."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 3
	w 1
	echo "???: Hmmm..."
	w 1
	echo "A man comes into the classroom."
	w 1
	echo "He has a ring with a Batman logo on his right pinky finger."
	w 1
	echo "It's too dark for me to see his face."
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "???: Doesn't seem like he's here..."
	w 1
	echo "His voice is familiar."
	w 1
	echo "The man is leaving."
	w 1
	if [ $world -ge 4 ]; then
		dialogue_1155_class
	fi
	dialogue_1159_class
}

dialogue_1155_class () {
	n 5
	echo "11:55PM"
	wn 1 3
	w 1
	echo "Who is he?"
	w 1
	echo "I must figure out!"
	wn 1 4
	action_1155_class
}

dialogue_post_1155_class () {
	n 4
	w 1
	echo "I reach my arm towards the wall next to the desk."
	w 1
	echo "${usrname}: Grrr... Come on..."
	loop_wn 1 1 3
	echo "Click!"
	n 1
	w 1
	echo "Just when the man with the Batman ring turns around to leave, I manage to turn the light switch on."
	w 1
	echo "The classroom is lit bright."
	wn 1 1
	wn 1 2
	w 1
	echo "The man turns back around to see that I'm here."
	w 1
	echo "???: !!!"
	w 1
	echo "And the man is..."
	wn 1 1
	wn 1 2
	wn 1 1
	echo "${usrname}: Spence..."
	n 1
	wn 1 1
	echo "Spencer: ..."
	n 1
	wn 1 1
	echo "..."
	n 1
	wn 1 3
	w 1
	echo "Spencer: ${usrname}..."
	w 1
	echo "${usrname}: Spencer... Were you looking for me?"
	w 1
	echo "Spencer: ............Yes."
	w 1
	echo "${usrname}: Wh..."
	wn 1 1
	w 1
	echo "${usrname}: What's up, man?"
	w 1
	echo "Spencer: ..."
	w 1
	echo "${usrname}: Hey... Hey, I'm sorry I didn't pay much attention to your class toda..."
	w 1
	echo "Spencer: It's fine."
	w 1
	echo "${usrname}: Oh, okay."
	w 1
	echo "Spencer: ..."
	w 1
	echo "${usrname}: ..."
	wn 1 1
	wn 1 2
	w 1
	echo "This is really,"
	w 1
	echo "and I mean REALLY awkward."
	w 1
	echo "..."
	wn 1 1
	w 1
	echo "${usrname}: So, ummm..."
	w 1
	echo "Spencer: Hey... Hey, listen."
	w 1
	echo "${usrname}: Yeah, what's up?"
	w 1
	echo "Spencer: I..."
	w 1
	echo "${usrname}: Mhm?"
	w 1
	echo "Spencer: I..."
	w 4
	echo "Spencer: I need to kill you."
	w 1
	echo "Spencer pulls out a knife from his pocket."
	w 1
	echo "He begins slowly walking towards me."
	wn 1 3
	echo "He's scared."
	n 3
	wn 1 1
	w 1
	echo "${usrname}: Woah, woah, woah! Wait... Hold on! This is a joke, right?"
	wn 1 1
	w 1
	echo "I end up saying the cliche \"This is a joke, right?\" line... Darn it."
	wn 1 1
	w 1
	echo "Spencer: Sorry, ${usrname}! Please forgive me, buddy!"
	wn 1 4
	action_post_1155_class
}

dialogue_post_post0_1155_class () {
	n 5
	wn 1 3
	w 1
	echo "..."
	w 1
	echo "${usrname}: Well, Spencer."
	w 1
	echo "${usrname}: I have no idea why you need to kill me, but I respect you a lot."
	w 1
	echo "${usrname}: So if you need to kill me, there must be a good reason for it."
	w 1
	echo "${usrname}: ...Go ahead and try to kill me!"
	wn 1 1
	w 1
	echo "Spencer: ..."
	wn 1 1
	echo "${usrname}: But I'm gonna tell you right now..."
	w 1
	echo "${usrname}: I have a damn good reason to stay alive."
	w 1
	echo "${usrname}: So, I'm gonna do whatever it takes to overcome you!"
	w 1
	echo "${usrname}: Bring it, Spencer!"
	loop_wn 1 1 3
	w 1
	echo "Spencer runs towards me, holding the knife in one of his right hand."
	w 1
	echo "He is now within stabbing distance."
	w 1
	futile_attempt0_whatdo () {
		whatdo
		init
		echo "${ctr}. duck and roll"
		incr
		echo "${ctr}. jump and kick"
		incr
		echo "${ctr}. grab and flip"
		incr
		n 1
	}
	futile_attempt0_whatdo
	while read action
	do
		case $action in
			"duck and roll")
				n 1
				echo "${usrname}: Easy!"
				w 1
				echo "As Spencer pushes his right arm forward, I swiftly duck."
				w 1
				echo "Then, I roll backwards to move away from him."
				wn 1 1
				break
			;;
			"jump and kick")
				n 1
				echo "${usrname}: Hiyyappp!"
				w 1
				echo "As Spencer pushes his right arm forward, I jump as high as I can."
				w 1
				echo "Then, I kick his chest from mid-air."
				w 1
				echo "Spencer: Eaugh!"
				w 1
				echo "Spencer is pushed back."
				w 1
				echo "He rubs his chest as he sees me land back on the floor like a ninja."
				wn 1 1
				break
			;;
			"grab and flip")
				n 1
				echo "${usrname}: Raaarghhhh!"
				w 1
				echo "As Spencer pushes his right arm forwardd, I grab his right arm and turn my back against him."
				w 1
				echo "Then, with all my might, I flip him over my shoulder."
				w 1
				echo "Spencer: Eaugh!"
				w 1
				echo "After a second of spinning mid-air, Spencer is struck down onto the floor."
				w 1
				echo "Bang!"
				w 1
				echo "Spencer stands back up and rubs the dust off of himself."
				wn 1 1
				break
			;;
			*)
				invalid
			;;
		esac
		futile_attempt0_whatdo
	done
	n 1
	w 1
	echo "${usrname}: Heh, how is that for a change, huh?"
	w 1
	echo "Spencer: ..."
	loop_wn 1 1 2
	w 1
	echo "Spencer charges towards me once more."
	w 1
	futile_attempt1_whatdo () {
		whatdo
		init
		echo "${ctr}. hook punch"
		incr
		echo "${ctr}. throw chair"
		incr
		echo "${ctr}. run away"
		incr
		n 1
	}
	futile_attempt1_whatdo
	while read action
	do
		case $action in
			"hook punch")
				n 1
				echo "I throw a hook with my right arm."
				w 1
				echo "Spencer blocks it with his left arm."
				w 1
				echo "${usrname}: Uh!"
				w 1
				echo "Then, in a split second, Spencer drops his knife and grabs me by my waist with both of his hands."
				w 1
				echo "I try to kick him as hard as I can."
				w 1
				echo "But my legs fail to reach him."
				wn 1 1
				break
			;;
			"throw chair")
				n 1
				echo "I grab a chair right next to me, and I throw it towards Spencer."
				w 1
				echo "Spencer simply kicks it off."
				w 1
				echo "..."
				w 1
				echo "What a champ."
				w 1
				echo "I'm too impressed by what he just did to react to what he does right at this moment."
				w 1
				echo "${usrname}: Uh!"
				w 1
				echo "In a split second, Spencer drops his knife and grabs me by my waist with both of his hands."
				w 1
				echo "I try to swing my arms around."
				w 1
				echo "But he guards his face with his elbows."
				wn 1 1
				break
			;;
			"run away")
				n 1
				echo "I take this opportunity to run away through the classroom door that is now right behind me."
				w 1
				echo "Just as I attempt to exit the classroom, Spencer throws his knife at my back."
				wn 1 1
				echo "Tzing!"
				n 1
				w 1
				echo "${usrname}: Uh!"
				w 1
				echo "Instantly, I feel a sharp pain running from my back."
				w 1
				echo "I fall onto the ground."
				w 1
				echo "Not missing this opportunity, Spencer approaches and grabs me by my waist with both of his hands."
				w 1
				echo "I try to break out from his hold by twisting like an eel."
				w 1
				echo "But he grasps me even harder."
				wn 1 1
				break
			;;
			*)
				invalid
			;;
		esac
		futile_attempt1_whatdo
	done
	n 1
	echo "${usrname}: Let me go, dammit!"
	w 1
	echo "Spencer walks towards the open classroom window, holding me above."
	w 1
	echo "Before I can do something about it..."
	wn 1 1
	echo "Spencer: Sorry, ${usrname_fst_three}..."
	n 1
	w 1
	echo "He throws me out the window."
	wn 1 1
	wn 1 2
	w 1
	echo "${usrname}: Ahhhhhhh!!!"
	w 1
	echo "As I fall down from the Towne 303 window, I take a glance at the window."
	wn 1 1
	echo "The image of Spencer becomes smaller and smaller..."
	n 1
	wn 1 3
	echo "...and smaller..."
	n 3
	wn 1 3
	wn 1 1
	echo "A yellow butterfly flies out of the window."
	n 1
	loop_wn 1 3 2
	echo "......and smaller......"
	n 3
	loop_wn 1 3 3
	echo ".........and sma..."
	n 3
	wn 1 1
	echo "BAM!"
	n 1
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 4 ]; then
		# PROPER DEATH IN WORLD 4 ... MOVE TO WORLD 5
		world=5
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_post_post1_1155_class () {
	n 5
	wn 1 3
	w 1
	echo "..."
	w 1
	echo "No."
	w 1
	echo "this isn't right."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Spencer, put that knife down."
	w 1
	echo "${usrname}: I have no idea why you need to kill me."
	w 1
	echo "${usrname}: But I can tell you right now, killing me isn't going to fix any of your problems."
	loop_wn 1 1 2
	w 1
	echo "Spencer: ..."
	w 1
	echo "I look at the Batman ring on his right pinky finger."
	w 1
	echo "${usrname}: You found your Batman ring!"
	w 1
	echo "${usrname}: I'm happy for you!"
	w 1
	echo "${usrname}: ...But you look scared."
	w 1
	echo "Spencer: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Listen, Spencer. You don't have to tell me why you must kill me, though I would very much appreciate it if you do."
	w 1
	echo "${usrname}: All I want to tell you right now..."
	w 1
	echo "${usrname}: ...is that no matter how scared you are, the only way to beat fear is by confronting it face-to-face."
	w 1
	echo "${usrname}: Not by removing it completely out of your life."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: You know this already!"
	w 1
	echo "${usrname}: I mean, look at your Batman ring!"
	w 1
	echo "${usrname}: Isn't that exactly what the ring is there for?"
	w 1
	echo "${usrname}: To remind you this one thing?"
	w 1
	echo "${usrname}: That..."
	wn 1 1
	w 1
	echo "${usrname}: That you never obliterate your fear, but you always overcome it!"
	wn 1 1
	w 1
	echo "${usrname}: It's like mountains, you see."
	w 1
	echo "${usrname}: No matter how steep the mountain."
	w 1
	echo "${usrname}: No matter how rough the path."
	w 1
	echo "${usrname}: No matter how uncertain what lies ahead."
	w 1
	echo "${usrname}: You always push yourself!"
	w 1
	echo "${usrname}: Climb up that blood mountain!"
	w 1
	echo "${usrname}: See another one?"
	w 1
	echo "${usrname}: Climb up that one, too!"
	w 1
	echo "${usrname}: Don't just get rid of the mountains!"
	w 1
	echo "${usrname}: You don't become stronger by getting rid of the mountains."
	w 1
	echo "${usrname}: You become stronger by struggling through them!"
	w 1
	echo "${usrname}: Because at the end of the day, the mountains are not what is stopping you from going forward!"
	w 1
	echo "${usrname}: In fact nothing is stopping you from doing whatever you want."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: ...Other than yourself."
	w 1
	echo "${usrname}: You fear."
	w 1
	echo "${usrname}: Your fear is your worst enemy."
	w 1
	echo "${usrname}: Once you can flip your finger to your scared little self, you know nothing can stop you!"
	loop_wn 1 1 2
	w 1
	echo "Spencer: ${usrname}..."
	w 1
	echo "${usrname}: You can do this, Spencer."
	w 1
	echo "${usrname}: You were able to conquer the bats."
	wn 1 1
	w 1
	echo "${usrname}: Now it's time to conquer whatever it is that you're afraid of right now."
	wn 1 1
	w 1
	echo "${usrname}: Let's do this together, yeah?"
	loop_wn 1 1 4
	echo "Clink!"
	n 1
	w 1
	echo "He drops his knife on the ground."
	w 1
	echo "He looks at me with a subtle smile on his face."
	w 1
	echo "Spencer: You're right."
	w 1
	echo "Spencer: All this time, my dad was telling me not to be so blind with these kinds of things."
	w 1
	echo "Spencer: And here I am, madly trying chase away my fears."
	wn 1 1
	w 1
	echo "Spencer: I must've lost it when I lost my ring for a while."
	loop_wn 1 1 2
	w 1
	echo "Spencer:..."
	w 1
	echo "Spencer: There's no way you're the source of our fear."
	w 1
	echo "..."
	w 1
	echo "${usrname}: Hmmm?"
	w 1
	echo "Spencer: I don't believe you're the source of our fear."
	w 1
	echo "${usrname}: What are you talking about?"
	w 1
	echo "Spencer: Were you not there?"
	w 1
	echo "${usrname}: Where? I have been here the whole time."
	wn 1 1
	w 1
	echo "Spencer: Oh, I see. That makes sense."
	w 1
	echo "Spencer: I guess you wouldn't be here if you knew about this."
	w 1
	echo "${usrname}: Care to explain?"
	w 1
	echo "Spencer: Yeah."
	loop_wn 1 1 2
	w 1
	echo "Spencer: You see, in the Palestra..."
	loop_wn 1 1 3
	w 1
	echo "${usrname}: ...Spencer?"
	wn 1 1
	w 1
	echo "Spencer: ...the Palest......ra..."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	loop_wn 1 3 2
	w 1
	echo "That's when I realize, someone had sneaked behind Spencer."
	w 1
	echo "And the guy just stabbed him with his sword."
	wn 1 2
	echo "Flop!"
	n 2
	w 1
	echo "Spencer falls down to the floor, already a corpse."
	wn 1 1
	wn 1 2
	w 1
	echo "${usrname}: Who... Who are you?!"
	w 1
	echo "The guy who just killed Spencer has on a full golden armor suit."
	w 1
	echo "The gold is so shiny that it can probably lit up the classroom even without the light on."
	w 1
	echo "The suit includes a helmet, so I can't see his face."
	wn 1 1
	w 1
	echo "???: Time's up!"
	loop_wn 1 1 3
	w 1
	echo "The guy is sprinting towards me."
	w 1
	futile_attempt2_whatdo () {
		whatdo
		init
		echo "${ctr}. duck"
		incr
		echo "${ctr}. jump"
		incr
		echo "${ctr}. sprint"
		incr
		echo "${ctr}. surrender"
		incr
		echo "${ctr}. shout"
		incr
		echo "${ctr}. sing"
		incr
		echo "${ctr}. spencer"
		incr
		n 1
	}
	futile_attempt2_whatdo
	while read action
	do
		case $action in
			"duck"|"jump"|"sprint"|"surrender"|"shout"|"sing"|"spencer")
				n 1
				break
			;;
			*)
				invalid
			;;
		esac
		futile_attempt2_whatdo
	done
	n 1
	wn 1 2
	wn 1 3
	wn 1 1
	echo "Before I can do anything, the guy stabs me in the belly, through my back."
	n 1
	w 1
	echo "${usrname}: Eaugh..."
	wn 1 1
	wn 1 2
	w 1
	echo "I spit out some blood on the guy's golden armor."
	w 1
	echo "The armor still remains bright."
	wn 1 1
	wn 1 2
	w 1
	echo "He slowly takes his sword out of my belly."
	loop_wn 1 3 3
	echo "Flop!"
	n 3
	loop_wn 1 3 3
	w 1
	echo "I swear I had seen his armor before..."
	w 1
	echo "...Where was it?"
	loop_wn 1 1 2
	w 1
	echo "As the world begins to fade away before my eyes, I desperately try to recall the armor from my memory."
	wn 1 1
	w 1
	echo "Then, Spencer's last words spring into my mind."
	loop_wn 1 1 2
	w 1
	echo "Palest..."
	wn 1 1
	wn 1 2
	loop_wn 1 3 2
	wn 1 1
	echo "Palestra..."
	n 1
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 5 ]; then
		# PROPER DEATH IN WORLD 5 ... MOVE TO WORLD 6
		world=6
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_1159_class () {
	n 5
	echo "11:59PM"
	wn 1 3
	w 1
	echo "The man has already left, and I remain under the desk."
	w 1
	echo "It feels comfortable here."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 3 2
	w 1
	echo "Just as I'm about to fall asleep, I hear a sound from nearby."
	wn 1 1
	echo "An explosion sound."
	n 1
	w 1
	echo "${usrname}: What?!"
	w 1
	echo "I look at the broken clock."
	w 1
	echo "It starts ticking."
	wn 1 1
	echo "Tik."
	n 1
	wn 1 1
	echo "Tok."
	n 1
	loop_wn 1 3 4
	echo "Explosion."
	n 3
	loop_wn 1 3 2
	w 1
	echo "Farewell."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 2 ]; then
		# PROPER DEATH IN WORLD 0 ... MOVE TO WORLD 1
		world=3
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_butterfly_class () {
	w 1
	echo "The butterfly flies away, out of the classroom window."
	loop_wn 1 1 2
	w 1
	echo "Wait, didn't this happen before?"
	w 1
	echo "I swear I remember this happening..."
	loop_wn 1 1 2
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	w 1
	echo "The butterfly is now out of sight."
	w 1
	echo "${usrname}: Hah, that was a beautfiul moment."
	loop_wn 1 1 2
	w 1
	echo "Just as I'm about to leave the classroom, I become really sleepy all of a sudden."
	loop_wn 1 1 2
	w 1
	echo "Uhhh... I'm about to pass out..."
	loop_wn 1 1 4
	w 1
	echo "Before I can even notice, I fall into a very deep sleep......"
	loop_wn 1 1 2
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 6 9
	wn 1 4
	dialogue_spencers_view
}

dialogue_talk_spencer () {
	talked_spencer0=1
	if [ $world -ge 6 ]; then
		talked_spencer1=1
	fi
	wn 1 5
	w 1
	echo "Spencer looks a little concerned."
	w 1
	echo "I wonder what's up with him."
	wn 1 1
	wn 1 2
	w 1
	echo "${usrname}: Hey, Spencer. Is anything wrong?"
	w 1
	echo "Spencer is looking through the pile of papers in front of him as well as around his desk, as if he's searching for something."
	w 1
	echo "${usrname}: Are you looking for something? I can help you."
	w 1
	echo "Spencer: ..."
	w 1
	echo "..."
	wn 1 1
	w 1
	echo "Spencer: Eh, I don't think it's here."
	w 1
	echo "${usrname}: What is...?"
	w 1
	echo "Spencer: Ah, sorry, ${usrname}. Didn't mean to ignore you there!"
	w 1
	echo "${usrname}: No worries. What's up?"
	w 1
	echo "Spencer: It seems like I lost my ring that I usually put on my right pinky finger. It has a Batman logo on it."
	w 1
	echo "Spencer: I think I know where I dropped it, though!"
	w 1
	echo "${usrname}: Batman ring, huh?"
	w 1
	echo "${usrname}: Is there anything special about it?"
	wn 1 1
	w 1
	echo "..."
	w 1
	echo "Spencer seems to think for a second how he should respond to my question."
	w 1
	echo "${usrname}: I mean, if it's personal, no need to..."
	wn 1 1
	w 1
	echo "Spencer: Nah, I can tell you! I gotta leave soon, though."
	w 1
	echo "${usrname}: Oh, okay."
	loop_wn 1 1 4
	w 1
	echo "Spencer: So, believe it or not, I'm actually scared of a lot of things."
	w 1
	if [ $talked_spencer1 -eq 1 ]; then
		n 3
		loop_wn 1 3 2
		w 1
		echo "Spencer: ...Like that one time, I had to visit Shady Gutzmann to get her signature for approval of my grad research paper."
		w 1
		echo "Spencer: I was so scared of Shady Gutzmann, I almost considered scrapping my entire research paper when I realized I had to go talk to her myself."
		w 1
		echo "Spencer: You have no idea, man. Shady can be scary!"
		loop_wn 1 3 3
		w 1
	fi
	echo "Spencer: You see, my entire life has been me dealing with my fears."
	w 1
	echo "Spencer: Sometimes I even got so sicked and tired of having a fear of something, that I just wanted to give up on life."
	loop_wn 1 1 2
	w 1
	echo "Spencer: But... Hmmm, when was it?"
	w 1
	echo "Spencer: ...Oh, yeah! When I was in third grade of elementary school, a miracle happened."
	w 1
	echo "Spencer: So, one of the things I was really, REALLY scared of was bats."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Like, those little mice with wings?"
	w 1
	echo "Spencer: Exactly. Bats."
	w 1
	echo "Spencer: I was so scared of it, that my parents were often worried that I would break down because of my fear."
	w 1
	echo "Spencer: So one day on a weekend, my dad called me over and suggested that we watch the Batman movie."
	w 1
	echo "Spencer: I had no idea what Batman was, so I just blindly said yes!"
	loop_wn 1 1 2
	w 1
	echo "Spencer: So, here's my dad and I watching the Batman movie... and I'm just, like, getting really into the movie, right?"
	w 1
	echo "Spencer: When I saw that Batman was scared of bats, I was like \"Oh my god! That's exactly me!\""
	w 1
	echo "Spencer: And you see, my dad was telling me to keep on watching."
	w 1
	echo "Spencer: So I kept on watching."
	w 1
	echo "Spencer: You know that crazy part where Batman goes into a cave full of bats, right?"
	w 1
	echo "${usrname}: Of course!"
	w 1
	echo "Spencer: Yeah! At that part, I was just... How would I describe it... Ah, I was absolutely 'dumbfounded' by him just facing the bats like that!"
	w 1
	echo "${usrname}: Yeah, he decided to just tough it up and face his fear. You know, \"overcome\" it."
	w 1
	echo "Spencer: Exactly!"
	loop_wn 1 1 2
	w 1
	echo "Spencer: I was so inspired by that scene. Like, really, that was a big turning point in my life."
	w 1
	echo "Spencer: After watching the movie for like 20 times, I told my dad that I wanted to try the same thing."
	w 1
	echo "Spencer: He didn't even give it any time to think. He immediately said, \"Definitely!\""
	w 1
	echo "Spencer: So we drove to the nearest cave preserved in Philly."
	w 1
	echo "Spencer: We walked deep into the cave, where we were told that hundreds of bats would live."
	w 1
	echo "Spencer: After some walking, my dad paused and urged me to go a bit farther. He told me it's important that I face the fear on my own, after having been assisted by him until then."
	w 1
	echo "Spencer: I was afraid. Like, REALLY afraid."
	w 1
	echo "Spencer: But a voice inside me was telling me to just, you know... Just go for it!"
	w 1
	echo "Spencer: So I walked a bit deeper into the cave an. And then guess what?"
	w 1
	echo "${usrname}: Let me take a \"wild\" guess. A bunch of bats flew past you?"
	w 1
	echo "Spencer: Hahah, yup!"
	w 1
	echo "${usrname}: Like in the movie?"
	w 1
	echo "Spencer: Yup."
	loop_wn 1 1 2
	w 1
	echo "Spencer: I alsmot peed in my pants."
	w 1
	echo "Spencer: But when all the bats finally flew past me, I felt like I was reborn into something else."
	w 1
	echo "Spencer: I felt like I had overcome my fear of bats."
	loop_wn 1 1 2
	wn 1 3
	echo "Spencer: I felt like Batman."
	n 3
	wn 1 1
	w 1
	echo "Spencer: I was so happy, I started laughing like an idiot."
	w 1
	echo "Spencer: That's when my dad came to me."
	w 1
	echo "Spencer: He then handed me the ring."
	w 1
	echo "Spencer: He told me to keep this ring on at all times. He told me that this ring will serve as a reminder of that time..."
	loop_wn 1 1 2
	w 1
	echo "Spencer: ..."
	loop_wn 1 1 2
	w 1
	echo "Spencer: That was such a long time..."
	wn 1 1
	w 1
	echo "Spencer: Anyways, sorry, I think I dragged on a bit there!"
	w 1
	echo "${usrname}: No worries at all! I see that ring certainly means a lot to you!"
	w 1
	echo "Spencer: Yeah, most definitely!"
	w 1
	echo "Spencer: Okay, I gotta get going now. I have to retrieve my ring!"
	w 1
	echo "${usrname}: For sure! I'll let you know if I find it!"
	w 1
	echo "Spencer: Thanks, bud!"
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "Spencer rushes out of the classroom."
	wn 1 1
	w 1
	echo "..."
	wn 1 1
}

something_else () {
	n 1
	echo "Wait!"
	wn 1 1
	w 1
	echo "I think I have to do something else right now."
	wn 1 1
}

action_200_class () {
	action_200_class_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		if [ $world -ge 3 ]; then
			echo "${ctr}. leave class without asking"
			incr
		fi
		echo "${ctr}. stay in class"
		incr
		n 1
	}
	action_200_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to hallway")
					tried_leaving=1
					n 1
					echo "Spencer: Wait, ${usrname}, where are you going?"
					w 1
					echo "${usrname}: Uh, may I go to the bathroom, please?"
					w 1
					echo "Spencer: I don't think going to the bathroom is as important as listening to me talk about how awesome bash scripting is, is it?"
					w 1
					echo "${usrname}: ..."
					w 1
					echo "${usrname}: ......"
					w 1
					echo "${usrname}: .........Debatable."
					w 1
					echo "Spencer: Well, I think not! So get back to your seat!"
					wn 1 1
					echo "."
					wn 1 1
					echo "."
					wn 1 1
					echo "."
					wn 1 1
					wn 1 6
					dialogue_300_class
				;;
				"look")
					lookclass
				;;
				"look clock")
					lookclock
				;;
				"look board")
					lookboard_class
				;;
				"look girls")
					lookgirls2_class
				;;
				"look hallway")
					lookhallway_class
				;;
				"leave class without asking")
					if [ $world -eq 8 ]; then
						something_else
					elif [ $world -ge 3 ]; then
						n 1
						echo "Spencer: Wait, ${usrname}, where are you going?"
						w 1
						echo "I know that Spencer is not going to let me go to the bathroom if I ask him politely, even if I say \"please\"."
						w 1
						echo "${usrname}: Sorry, Spencer! I'm gonna explode any second!"
						w 1
						echo "Just like that, I sprinted out of the classroom."
						w 1
						echo "Spencer: ${usrname_fst_three}...!"
						wn 1 4
						dialogue_hallway
					else
						invalid
					fi
				;;
				"stay in class")
					n 1
					echo "While Spencer is talking about how awesome and beautiful bash scripting is, I decide to do some crash CIS 320 review..."
					wn 1 1
					echo "."
					wn 1 1
					echo "."
					wn 1 1
					echo "."
					wn 1 1
					wn 1 6
					dialogue_300_class
				;;
				*)
					invalid
				;;
			esac
		fi
		action_200_class_whatdo
	done
}

action_300_class () {
	talked_spencer0=0
	talked_spencer1=0
	action_300_class_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		if [ $world -ge 1 ]; then
			echo "${ctr}. stay in class"
			incr
		fi
		if [ $world -eq 7 -a $bathroom_joel -eq 0 ]; then
			echo "${ctr}. talk with joel"
			incr
		fi
		if [ $world -ge 5 -a $talked_spencer0 -eq 0 ]; then
			echo "${ctr}. talk with spencer"
			incr
		fi
		if [ $talked_spencer1 -eq 1 ]; then
			echo "${ctr}. ask spencer about shady"
			incr
		fi
		n 1
	}
	action_300_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to hallway")
					if [ $world -eq 8 ]; then
						something_else
					elif [ $bathroom_joel -eq 1 ]; then
						dialogue_hallway
					else
						dialogue_300_hallway
					fi
				;;
				"look")
					lookclass
				;;
				"look clock")
					lookclock
				;;
				"look board")
					lookboard_class
				;;
				"look girls")
					lookgirls3_class
				;;
				"look hallway")
					lookhallway_class
				;;
				"stay in class")
					if [ $world -eq 8 ]; then
						something_else
					elif [ $world -ge 1 ]; then
						dialogue_800_class
					else
						invalid
					fi
				;;
				"talk with joel")
					if [ $world -eq 7 -a $bathroom_joel -eq 0 ]; then
						dialogue_joel_bathroom
					else
						invalid
					fi
				;;
				"talk with spencer")
					if [ $world -eq 8 ]; then
						something_else
					elif [ $world -ge 5 -a $talked_spencer0 -eq 0 ]; then
						dialogue_talk_spencer
					else
						invalid
					fi
				;;
				"ask spencer about shady")
					if [ $talked_spencer1 -eq 1 ]; then
						shady_house=1
						n 1
						echo "Something tells me that I must meet Shady Gutzmann."
						w 1
						echo "${usrname}: Wait!"
						w 1
						echo "I sprint out of the classroom and stop Spencer before he goes downstairs."
						wn 1 1
						w 1
						echo "Spencer: Hmmm?"
						w 1
						echo "${usrname}: I'm so sorry..."
						w 1
						echo "Spencer: It's fine. What's up?"
						w 1
						echo "${usrname}: You told me that you had once visited Shady Gutzmann, right?"
						w 1
						echo "Spencer: Did I?"
						w 1
						echo "${usrname}: Yes, you did."
						w 1
						echo "Spencer: Well, if you say so!"
						w 1
						echo "${usrname}: Can you please tell me where she lives?"
						loop_wn 1 1 2
						w 1
						echo "Spencer: Ummm... Sure? May I ask why?"
						w 1
						echo "${usrname}: Uhhh.... You see, I don't have a grad research paper to be approved..."
						w 1
						echo "Spencer: ...but?"
						w 1
						echo "${usrname}: ...but...but Shady and I are having a dinner date later this evening!"
						loop_wn 1 1 3
						w 1
						echo "Spencer: That's so awesome, man! Congrats!"
						w 1
						echo "Spencer: That's the first step to success, my friend!"
						w 1
						echo "Spencer: Man, I'm so jealous of you now, you know?"
						w 1
						echo "Spencer: A dinner date with Shady Gutzmann..."
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						loop_wn 1 1 3
						w 1
						echo "Spencer seems to have immersed himself into a pleasant dream."
						loop_wn 1 1 2
						w 1
						echo "${usrname}: Ummm... Spencer?"
						w 1
						echo "Spencer: Heh......"
						w 1
						echo "${usrname}: Spencer?"
						w 1
						echo "..."
						loop_wn 1 1 3
						w 1
						echo "${usrname}: SPENCER!"
						w 1
						echo "Spencer: Woah, woah, woah, woah, woah! What's up?!"
						w 1
						echo "Spencer: Is everything okay?!"
						wn 1 1
						w 1
						echo "..."
						w 1
						echo "${usrname}: Yeah, everything's fine."
						w 1
						echo "${usrname}: Can you please tell me where Shady Gutzmann lives?"
						w 1
						echo "Spencer: Ah, sure!"
						w 1
						echo "Spencer: So you get out of the Engineering Quad, then you walk this way, then..."
						wn 1 1
						wn 1 2
						wn 1 3
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						loop_wn 1 3 2
						w 1
						echo "${usrname}: Thanks, Spencer!"
						w 1
						echo "Spencer: You bet! Okay, bye!"
						w 1
						echo "${usrname}: See ya!"
						loop_wn 1 1 2
						w 1
						echo "I walk out of the Engineering Quad."
						wn 1 4
						dialogue_outside
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_300_class_whatdo
	done
}

action_800_class () {
	dark_outside=1
	action_800_class_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		if [ $world -ge 2 -a $world -lt 4 -a $tried_leaving -eq 1 ] || [ $world -ge 4 ]; then
			echo "${ctr}. stay in class"
			incr
		fi
		n 1
	}
	action_800_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to hallway")
					dialogue_800_hallway
				;;
				"look")
					lookclass
				;;
				"look clock")
					lookclock
				;;
				"look board")
					lookboard_class
				;;
				"look hallway")
					lookhallway_class
				;;
				"stay in class")
					if [ $world -ge 2 -a $world -lt 4 -a $tried_leaving -eq 1 ] || [ $world -ge 4 ]; then
						dialogue_1150_class
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_800_class_whatdo
	done
}

action_1150_class () {
	action_1150_class_whatdo () {
		whatdo
		init
		echo "${ctr}. hide under desk"
		incr
		n 1
	}
	action_1150_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"hide under desk")
					dialogue_post_1150_class
				;;
				*)
					invalid
				;;
			esac
		fi
		action_1150_class_whatdo
	done
}

action_1155_class () {
	action_1155_class_whatdo () {
		whatdo
		init
		if [ $light_on -eq 1 ]; then
			echo "${ctr}. turn light on"
			incr
		fi
		echo "${ctr}. don't do anything"
		incr
		n 1
	}
	action_1155_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"turn light on")
					if [ $light_on -eq 1 ]; then
						dialogue_post_1155_class
					else
						invalid
					fi
				;;
				"don't do anything")
					n 1
					echo "...Actually, no."
					w 1
					echo "This man is probably here to kill me."
					w 1
					echo "Let's just let this man leave."
					wn 1 1
					w 1
					dialogue_1159_class
				;;
				*)
					invalid
				;;
			esac
		fi
		action_1155_class_whatdo
	done
}

action_post_1155_class () {
	action_post_1155_class_whatdo () {
		whatdo
		init
		echo "${ctr}. fight with spencer"
		incr
		if [ $talked_spencer0 -eq 1 ]; then
			echo "${ctr}. talk with spencer"
			incr
		fi
		n 1
	}
	action_post_1155_class_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"fight with spencer")
					dialogue_post_post0_1155_class
				;;
				"talk with spencer")
					if [ $talked_spencer0 -eq 1 ]; then
						dialogue_post_post1_1155_class
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_post_1155_class_whatdo
	done
}

dialogue_300_hallway () {
	n 1
	echo "I leave Towne 303, and I'm out in Towne Hall 3rd floor hallway."
	w 1
	echo "${usrname}: Time for my CIS 320 midterm!"
	w 1
	echo "I turn around to go downstairs."
	wn 1 1
	wn 1 2
	echo "I turn around to go downstairs, and..."
	wn 1 5
	echo "STAB!!!"
	n 5
	w 1
	echo "${usrname}: Uh...?"
	wn 1 1
	echo "Flop!"
	n 1
	w 1
	echo "I fall down to the floor."
	w 1
	echo "I stare at my belly."
	w 1
	echo "It's going red."
	w 1
	echo "I try to crawl toward an unknown direction with the last bit of strength I have."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 3
	w 1
	echo "Before I can look up and see who just stabbed me in the back, my eyes close."
	w 1
	echo "Ah, darn it. My shirt is now all smothered in red."
	w 1
	echo "Gotta put it in the washing machine..."
	wn 1 1
	wn 1 2
	wn 1 3
	echo "I hear a laughter."
	n 3
	w 1
	echo "...and I dive into complete darkness."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 0 ]; then
		# PROPER DEATH IN WORLD 0 ... MOVE TO WORLD 1
		world=1
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_800_hallway () {
	n 3
	w 1
	echo "I'm out in the Towne Hall 3rd floor hallway."
	wn 1 1
	wn 1 2
	w 1
	echo "This is weird."
	w 1
	echo "There is literally no one here."
	w 1
	echo "Yes, the sky has gone dark..."
	w 1
	echo "...but this is Towne Hall in the Engineering Quad!"
	w 1
	echo "I can't get rid off this eerie feeling that I've been having since, ummm..."
	w 1
	echo "...like, 20 seconds ago."
	wn 1 1
	wn 1 2
	w 1
	echo "It feels like..."
	w 1
	echo "                      ...someone is watching me."
	wn 1 4
	action_hallway
}

dialogue_hallway () {
	n 1
	echo "In the Towne Hall 3rd floor hallway, I see a couple of students rushing off late to their classes and professors..."
	w 1
	echo "...who are also rushing off late to their classes."
	w 1
	echo "There isn't anything particularly interesting about this hallway."
	w 1
	echo "But this is where I often feel most comfortable."
	w 1
	echo "I sometimes told myself that I was sick of this place, where I have spent hours during the day on my lectures and hours during the night on my assignments."
	w 1
	echo "But I always came here for the learning, the \"Eureka!\" moments."
	w 1
	echo "More importantly, I came here for the memories of ordering Papa John's pizza with a group of my friends past midnight."
	w 1
	echo "${usrname}: Ah, good times."
	w 1
	echo "This is the place to be."
	w 1
	echo "This is my home away from home."
	wn 1 1
	wn 1 2
	wn 1 1
	echo "Okay, maybe that's slightly exaggerated."
	n 1
	wn 1 4
	action_hallway
}

action_hallway () {
	action_hallway_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		n 1
	}
	action_hallway_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to class")
					n 1
					echo "I don't think we have any reason to go back into the class right now."
					wn 1 1
				;;
				"go to bathroom")
					if [ $dark_outside -eq 1 ]; then
						n 1
						echo "...Hold on."
						w 1
						echo "Before I decide to go to the bathroom, let's think about what's really important."
						w 1
						echo "I should probably head back to my room."
						w 1
						echo "I can take care of my business as much as I want then."
						wn 1 1
					else
						dialogue_bathroom
					fi
				;;
				"go to outside")
					if [ $dark_outside -eq 1 ]; then
						dialogue_800_outside
					else
						dialogue_outside
					fi
				;;
				"look")
					lookhallway
				;;
				"look paper")
					lookpaper_hallway
				;;
				"look class")
					lookclass_hallway
				;;
				"look bathroom")
					lookbathroom_hallway
				;;
				"look outside")
					lookoutside_hallway
				;;
				*)
					invalid
				;;
			esac
		fi
		action_hallway_whatdo
	done
}

dialogue_joel_bathroom () {
	n 1
	loop_wn 1 1 2
	w 1
	echo "I look at Joel, putting his heavy backpack on his shoulders."
	w 1
	echo "${usrname}: Hey Joel."
	w 1
	echo "Joel: Yeah, what's up?"
	w 1
	echo "${usrname}: I know we have our CIS 320 midterm right now, but do you mind talking with me for a bit?"
	w 1
	echo "Joel: ..."
	w 1
	echo "Joel: Sure thing, dude! Not a problem!"
	w 1
	echo "${usrname}: Thanks, man."
	w 1
	echo "Joel: Where would you like to talk? I assume this is pretty serious?"
	w 1
	echo "${usrname}: Y... Yeah......"
	w 1
	echo "Joel: How about this."
	w 1
	echo "Joel: I'll go to the bathroom right now and stay there for a while."
	w 1
	echo "Joel: You make up your mind."
	w 1
	echo "Joel: And then you come into the bathroom whenever you're ready."
	wn 1 1
	w 1
	echo "Joel: How does that sound?"
	wn 1 1
	w 1
	echo "${usrname}: That sounds good."
	w 1
	echo "${usrname}: Thanks so much, man."
	w 1
	echo "${usrname}: You're a real pal."
	w 1
	echo "Joel: No problem, dude."
	loop_wn 1 1 2
	w 1
	echo "Joel: You know I'm always here for ya!"
	wn 1 1
	w 1
	echo "He leaves the classroom."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	bathroom_joel=1
}

dialogue_post_joel_bathroom () {
	wn 1 3
	echo "4:00PM"
	wn 1 3
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "I point to the scribble he made in the corner of the last page."
	w 1
	echo "${usrname}: Can you explain to me what you meant by this?"
	w 1
	echo "Joel: ..."
	loop_wn 1 1 2
	w 1
	echo "Joel: Sorry man, but that's personal."
	w 1
	echo "${usrname}: I get that it's personal, but hear me out."
	w 1
	echo "${usrname}: This may sound ridiculous, but I've been having these weird dreams lately."
	w 1
	echo "${usrname}: And in every single one of those dreams, I end up dying."
	w 1
	echo "${usrname}: I don't remember the details of those dreams, but I do vaguely remember what happened towards the end of one of them."
	w 1
	if [ $saw_salmon -eq 1 ]; then
		n 1
		wn 1 2
		w 1
		echo "${usrname}: Actually, I also remember talking with the Salmon God."
		loop_wn 1 1 2
		w 1
		echo "${usrname}: Anyhow..."
		w 1
	fi
	echo "${usrname}: In one of those dreams, I was killed by you."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Actually, no, I was killed by you in several of those dreams!"
	w 1
	echo "${usrname}: But in this one dream, you seemed extremely sad."
	w 1
	echo "${usrname}: And I just can't stay calm after seeing that!"
	w 1
	echo "${usrname}: I know I don't have the right to know about your personal things."
	w 1
	echo "${usrname}: But you're my pal."
	w 1
	echo "${usrname}: We're buddies, Joel!"
	w 1
	echo "${usrname}: I care about you."
	w 1
	echo "${usrname}: And if me caring is worth anything to you..."
	w 1
	echo "${usrname}: If even me dying in some of my dreams because of you can be enough of a reason for me to be worried about you..."
	w 1
	echo "${usrname}: I want to know."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Is something going on?"
	w 1
	echo "${usrname}: Or is this just all in my dreams?"
	w 1
	echo "Joel: ..."
	wn 1 1
	wn 1 2
	loop_wn 1 3 2
	w 1
	echo "Joel: Those weren't dreams, ${usrname}."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: You're kidding."
	w 1
	echo "Joel: No, I'm not."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Joel: I'll explain."
	w 1
	echo "Joel: You were not experiencing dreams."
	w 1
	echo "Joel: They were all real."
	w 1
	echo "Joel: But you are forever stuck in one day, Wednesday."
	w 1
	echo "Joel: And that's because I casted a spell on you."
	w 1
	echo "Joel: I casted a spell on you, because..."
	loop_wn 1 1 2
	w 1
	echo "Joel: ...because I wanted you to feel eternal pain."
	w 1
	echo "${usrname}: Why?"
	w 1
	echo "Joel: Because I..."
	loop_wn 1 1 2
	w 1
	echo "Joel: I'm scared of you!"
	wn 1 1
	w 1
	echo "Joel: Ever since freshman year, I've been trying really hard at school."
	w 1
	echo "Joel: I've always worked my ass off."
	w 1
	echo "Joel: I've always worked my ass off to be as good as you!"
	w 1
	echo "Joel: But it never happened."
	w 1
	echo "Joel: You were too good for me."
	w 1
	echo "Joel: I would work on something for hours, only to receive a score that is less than half of what you get."
	w 1
	echo "Joel: That CIS 320 midterm that we're missing?"
	w 1
	echo "Joel: Well, guess what."
	w 1
	echo "Joel: Chances are, you are gonna ace it, and I'm gonna get screwed over."
	loop_wn 1 1 2
	w 1
	echo "Joel: That's right."
	w 1
	echo "Joel: You were always the smarter one."
	w 1
	echo "Joel: You were always the better one."
	wn 1 1
	w 1
	echo "Joel: And I was scared."
	w 1
	echo "Joel: I was scared that I will become so upset because of you..."
	w 1
	echo "Joel: ...so upset that I will stop being normal, you know?"
	w 1
	echo "Joel: I was scared that because you were always better than me, I would become weird."
	w 1
	echo "Joel: ...Like, one of those psychopaths or something."
	w 1
	echo "Joel: ...And I didn't want to live a life like that."
	w 1
	echo "Joel: So I decided to put you in this time loop."
	loop_wn 1 1 2
	w 1
	echo "Joel: It's like a while loop, you see..."
	w 1
	echo "Joel: A while loop with true as its conditional expression!"
	w 1
	echo "${usrname}: ..."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Why..."
	w 1
	echo "${usrname}: Why didn't you tell me this sooner, Joel?"
	w 1
	echo "${usrname}: I... I couldn't helped you."
	w 1
	echo "${usrname}: I'm your friend! I could've helped you understand materials and get good grades!"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: You didn't have to go through all of that..."
	w 1
	echo "${usrname}: You didn't have to be so scared all this time..."
	loop_wn 1 1 2
	w 1
	echo "Joel: ..."
	w 1
	echo "${usrname}: Listen, Joel."
	w 1
	echo "${usrname}: School isn't everything."
	w 1
	echo "${usrname}: But I know it sucks to fail on assignments and get lower grades than someone else."
	w 1
	echo "${usrname}: I myself have always worked on things for hours and hours, staying up very late and often pulling a bunch of all nighters in a row!"
	w 1
	echo "${usrname}: But do you know what always pushed me to work harder and never give up?"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: My will."
	w 1
	echo "${usrname}: The power of will."
	w 1
	echo "${usrname}: I've always strongly believed that I will eventually overcome obstacles."
	w 1
	echo "${usrname}: I've always strongly believed that I will eventually succeed."
	w 1
	echo "${usrname}: And yes, times are rough."
	w 1
	echo "${usrname}: But when you tell yourself that you'll eventually get there..."
	w 1
	echo "${usrname}: ...I swear to god, nothing can stop you!"
	loop_wn 1 1 2
	w 1
	if [ $saw_salmon -eq 1 ]; then
		echo "${usrname}: In fact, it's funny that I'm saying this to you right now..."
		w 1
		echo "${username}: ...because I pretty much heard the exact same thing from the Salmon God."
		loop_wn 1 1 2
		echo "Joel: Salmon God?"
		w 1
		echo "${usrname}: Ah, nevermind!"
		loop_wn 1 1 2
		w 1
	fi
	echo "${usrname}: Trust me, Joel."
	w 1
	echo "${usrname}: You just gotta believe in yourself."
	w 1
	echo "${usrname}: Sometimes, all you need is a good splash of water on your face."
	loop_wn 1 1 2
	w 1
	echo "Joel: ..."
	w 1
	echo "${usrname}: I can help you."
	w 1
	echo "${usrname}: So don't beat yourself up for struggling with school all the time, buddy."
	w 1
	echo "${usrname}: I've been there."
	w 1
	echo "${usrname}: It feels horrible."
	w 1
	echo "${usrname}: But if we truly believe in ourselves..."
	w 1
	echo "${usrname}: If we truly believe in the power of will..."
	w 1
	echo "${usrname}: We will get there."
	w 1
	echo "${usrname}: We will succeed."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Let's climb the ladder together, huh?"
	wn 1 1
	w 1
	echo "Joel: ..."
	loop_wn 1 1 10
	w 1
	echo "Joel: You're right."
	w 1
	echo "Joel: Sorry, ${usrname}."
	w 1
	echo "Joel: I really shouldn't have done this."
	w 1
	echo "${usrname}: It's okay, dude."
	w 1
	echo "${usrname}: I completely understand your feeling."
	w 1
	echo "Joel: You know, it's funny you told me all this."
	w 1
	echo "Joel: ...Cuz you just reminded me that this red bandana on my wrist..."
	w 1
	echo "Joel: ...This red bandana is supposed to mean the power of will."
	w 1
	echo "Joel: I remember telling myself the other day that I will overcome whatever obstacles that come along my way."
	w 1
	echo "Joel: Even if I get scared of some of those obstacles..."
	w 1
	echo "Joel: I told myself that I will even conquer fear itself!"
	loop_wn 1 1 2
	w 1
	echo "Joel: ...But I guess I just never took that vow."
	wn 1 1
	w 1
	echo "Joel: I really should've just tried harder."
	w 1
	echo "Joel: And ask you for some help."
	w 1
	echo "Joel: I was always just blinded by the fact that I was worse than you."
	loop_wn 1 1 2
	w 1
	echo "Joel: And I thought that getting rid of the very source of my fear would solve my problems."
	wn 1 1
	w 1
	echo "Joel: ...It didn't."
	loop_wn 1 1 4
	w 1
	echo "Tear drops begin to fall down acorss Joel's cheeks."
	w 1
	echo "${usrname}: You okay, bud?"
	w 1
	echo "Joel: ..."
	loop_wn 1 1 2
	w 1
	echo "Joel: Thanks, ${usrname}."
	w 1
	echo "Joel: I really appreciate your words."
	w 1
	echo "Joel: I really should've spent more time with you and become true friends with you."
	w 1
	echo "Joel: I... I guess we were so busy all this time, haha!"
	w 1
	echo "${usrname}: Yeah, man!"
	w 1
	echo "${usrname}: Hey, don't worry, dude. When we get out of this freaking time loop, I'll make sure that we spend a lot more time chilling together!"
	loop_wn 1 1 2
	w 1
	echo "Joel: Haha... Yeah..."
	w 1
	echo "${usrname}: Cheer up, buddy!"
	loop_wn 1 1 4
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 4
	w 1
	echo "Joel stops crying."
	wn 1 1
	w 1
	echo "Joel: Okay, listen to me carefully."
	w 1
	echo "Joel: I'm gonna tell you how to get out of this time loop."
	w 1
	echo "Joel: It's gonna be like hittig a break statement within an infinite while loop!"
	w 1
	echo "${usrname}: For sure!"
	w 1
	echo "Joel: Here, take this butterfly."
	w 1
	echo "He hands me a butterfly."
	w 1
	echo "${usrname}: It's...dead?"
	w 1
	echo "Joel: Whenever you're ready, just place the butterfly in your hands, and..."
	w 1
	echo "${usrname}: ...and?"
	loop_wn 1 1 2
	w 1
	echo "Joel: Just believe in it."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: What?"
	wn 1 1
	w 1
	echo "All of a sudden, I hear a crowd of people storming in from outside of the Towne Hall 3rd floor hallway."
	w 1
	echo "\"We want freedom! Freedom from fear!"
	w 1
	echo "So let fear be gone! We shall take it down here!\""
	w 1
	echo "${usrname}: Wh... What is this?"
	w 1
	echo "Joel: It's the people."
	w 1
	echo "Joel: They've come to kill you."
	w 1
	echo "${usrname}: Are you kidding m..."
	w 1
	echo "Joel: Listen, ${usrname}!"
	w 1
	echo "Joel: I'll do whatever I can to stop these people."
	w 1
	echo "Joel: Meanwhile, you stay here and try to escape from this time loop!"
	w 1
	echo "Joel: Is this clear?"
	n 1
	wn 1 1
	w 1
	echo "${usrname}: But then, you..."
	w 1
	echo "Joel: I said, is this clear?"
	w 1
	echo "${usrname}: Y... Yeah..."
	w 1
	echo "Joel: Cool."
	loop_wn 1 1 4
	w 1
	echo "Joel: It's great to have known you, ${usrname}. Thanks for helping me overcome my fears."
	loop_wn 1 1 2
	w 1
	echo "He walks out of the bathroom."
	w 1
	echo "I stay here, not knowing what to do next."
	loop_wn 1 1 10
	w 1
	echo "..."
	wn 1 1
	w 1
	echo "How much time has passed?"
	w 1
	echo "Not that much, probably."
	w 1
	echo "I'm worried what might've happened to Joel."
	loop_wn 1 1 2
	w 1
	echo "I step out of the bathroom."
	loop_wn 1 1 2
	w 1
	echo "..."
	w 1
	echo "And there he was, lying in a puddle of blood."
	w 1
	echo "Smiling like the happiest man in the world."
	w 1
	echo "Joel: ${usrname_fst_three}..."
	w 1
	echo "The moment he sees me, he lifts his arm up."
	w 1
	echo "The one with the red bandana around his wrist."
	wn 1 1
	wn 1 2
	wn 1 3
	echo "Then, he gives me a thumbs up."
	n 3
	loop_wn 1 1 2
	w 1
	echo "${usrname}: JOEL!!!!!!!"
	w 1
	echo "Just as I'm about to run towards Joel..."
	wn 1 3
	echo "STAB!!!"
	n 3
	loop_wn 1 1 2
	w 1
	echo "\"We found him!\""
	w 1
	echo "Ah, I thought the people had left."
	w 1
	echo "I guess some of them still remained."
	w 1
	echo "..."
	wn 1 3
	echo "Flop!"
	n 3
	w 1
	echo "Was this all for nothing?"
	loop_wn 1 1 2
	w 1
	echo "Before I die, I take one last look at Joel..."
	w 1
	echo "He's dead."
	w 1
	echo "Still smiling like the happiest man in the world."
	loop_wn 1 1 2
	w 1
	echo "Then, I take another look at the dead butterfly..."
	w 1
	echo "What was I supposed to do with this, Joel?"
	wn 1 1
	w 1
	echo "..."
	loop_wn 1 1 2
	w 1
	echo "My eyes close..."
	loop_wn 1 5 3
	wn 1 4
	have_butterfly=1
	if [ $world -eq 7 ]; then
		# PROPER DEATH IN WORLD 7 ... MOVE TO WORLD 8
		world=8
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_bathroom () {
	n 1
	echo "This is the male bathroom."
	w 1
	echo "It stinks in here."
	w 1
	echo "The cleaner must've taken a day off or something."
	w 1
	echo "Either that, or someone just took a big fat dump."
	wn 1 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "I'm gonna vote on the latter."
	wn 1 4
	action_bathroom
}

action_bathroom () {
	action_bathroom_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. take care of business"
		n 1
	}
	action_bathroom_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to hallway")
					to_joel=0
					dialogue_hallway
				;;
				"look")
					lookbathroom
				;;
				"look poster")
					lookposter_bathroom
				;;
				"look urinal")
					lookurinal_bathroom
				;;
				"look burrito")
					lookburrito_bathroom
				;;
				"look hallway")
					lookhallway_bathroom
				;;
				"take care of business")
					if [ $world -eq 7 -a $bathroom_joel -eq 1 ]; then
						n 5
						loop_wn 1 5 4
						wn 1 1
						echo "It's time to take care of business with Joel."
						n 1
						wn 1 1
						echo "I must end this madness once and for all!"
						n 1
						wn 1 1
						to_joel=1
					else
						if [ $plop -lt 2 ]; then
							n 3
							echo "."
							w 1
							echo "."
							w 1
							echo "."
							w 1
							echo "${usrname}: ERRRRRRRRRRRRRGGGGHHHHHHH!!!"
							w 1
							echo "Plop!"
							w 1
							echo "Ah, this feels good."
							w 1
							echo "This is euphoria."
							wn 1 1
							plop=$((${plop} + 1))
						else
							n 1
							echo "..."
							n 1
							w 1
							echo "Dear Player of ${usrname},"
							wn 1 1
							w 1
							echo "I've already taken a dump twice for you."
							w 1
							echo "If you think I'm some sort of a superhuman and can take a dump an infinite number of times..."
							w 1
							echo "...you are mistaken."
							wn 1 1
							w 1
							echo "Sincerely,"
							wn 1 1
							w 1
							echo "${usrname}"
							wn 1 1
						fi
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_bathroom_whatdo
	done
}

dialogue_800_outside () {
	n 1
	echo "As soon as I get out of the Towne building, I begin to feel that someone is actually following me."
	w 1
	echo "${usrname}: Is somebody there?"
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "Of course."
	w 1
	echo "Of course, no one would reply."
	w 1
	echo "I find it strange that I have not seen a single person as I rushed downstairs."
	wn 1 3
	echo "My heart is racing."
	w 1
	echo "I must hurry."
	wn 1 4
	action_outside
}

dialogue_outside () {
	n 1
	echo "I am outside of the Engineering Quad."
	w 1
	echo "In front of me is the rest of the world."
	w 1
	echo "Behind me is the darkness, the hell that we call the Engineering Quad."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "Okay, enough with the blabbering."
	wn 1 4
	action_outside
}

action_outside () {
	can_give_hobo=1
	action_outside_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		n 1
	}
	action_outside_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to hallway")
					if [ $dark_outside -eq 1 ]; then
						n 1
						echo "Ummm... Nope! Wrong direction!"
						wn 1 1
					elif [ $shady_house -eq 1 ]; then
						n 1
						echo "Ummm... Nope! Wrong direction!"
						loop_wn 1 1 3
						w 1
						echo "That is, I'm not going to get to Shady Gutzmann's house by going back into the Towne Hall 3rd floor hallway."
						wn 1 1
					else
						can_give_hobo=0
						dialogue_hallway
					fi
				;;
				"go to street")
					can_give_hobo=0
					if [ $dark_outside -eq 1 ]; then
						dialogue_800_street
					else
						dialogue_street
					fi
				;;
				"go to palestra")
					if [ $palestra -eq 1 ]; then
						n 5
						can_give_hobo=0
						dialogue_palestra
					else
						invalid
					fi
				;;
				"go to shady's house")
					if [ $shady_house -eq 1 ]; then
						can_give_hobo=0
						dialogue_shadyshouse
					else
						invalid
					fi
				;;
				"look")
					lookoutside
				;;
				"look hobo")
					if [ $dark_outside -eq 1 ]; then
						invalid
					else
						lookhobo_outside
					fi
				;;
				"look bike")
					if [ $dark_outside -eq 1 ]; then
						invalid
					else
						lookbike_outside
					fi
				;;
				"look sky")
					if [ $dark_outside -eq 1 ]; then
						invalid
					else
						looksky_outside
					fi
				;;
				"look hallway")
					lookhallway_outside
				;;
				"look street")
					lookstreet_outside
				;;
				"look palestra")
					if [ $palestra -eq 1 ]; then
						lookpalestra_outside
					else
						invalid
					fi
				;;
				"look shady's house")
					if [ $shady_house -eq 1 ]; then
						lookshadyshouse_outside
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_outside_whatdo
	done
}

dialogue_800_street () {
	n 1
	echo "By now, I'm speed walking on the street."
	w 1
	echo "I can hear footsteps from behind!"
	w 1
	echo "My heart is beating like crazy."
	loop_wn 1 3 2
	echo "* I MUST RUN AWAY * "
	n 3
	wn 1 4
	action_street
}

dialogue_street () {
	n 1
	echo "${usrname}:"
	wn 1 1
	echo "	\"It's Philadelphia\""
	echo "	(Parody of \"Good Morning Baltimore\" in Hairspray)"
	n 1
	echo "				- Originally performed by Penn Glee Club"
	n 1
	w 1
	echo "	Oh, oh, oh, woke up today, feeling the way I always do!"
	w 1
	echo "	Oh, oh, oh, hungry for something that I can't eat, when I hear the beat!"
	w 1
	echo "	The rhythm of town, starts calling me down!"
	w 1
	echo "	It's like a message from high above!"
	w 1
	echo "	Oh, oh, oh, pulling me out to the smiles and the streets that I love!"
	wn 1 1
	echo "	It's Philadelphia!"
	w 1
	echo "	It's the heart of America!"
	w 1
	echo "	Where every night is a fantasy!"
	w 1
	echo "	And every sound's like a symphony!"
	w 1
	echo "	Oh Philadelphia!"
	w 1
	echo "	And some day when I take to the streets, the world's gonna wake up and see!"
	w 1
	echo "	Philadelphia and me!"
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "${usrname}: ...Okay, I think I sang enough for now."
	wn 1 3
	w 1
	echo "Now I'm on a street in Penn's campus."
	wn 1 4
	action_street
}

action_street () {
	action_street_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		n 1
	}
	action_street_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to outside")
					if [ $dark_outside -eq 1 ]; then
						n 1
						echo "I'm not turning around!"
						wn 1 1
					else
						dialogue_outside
					fi
				;;
				"go to fresh grocer")
					if [ $dark_outside -eq 1 ]; then
						dialogue_800_freshgrocer
					else
						dialogue_freshgrocer
					fi
				;;
				"go to garbage bin")
					if [ $dark_outside -eq 1 ]; then
						dialogue_800_garbagebin
					else
						dialogue_garbagebin
					fi
				;;
				"go to pottruck")
					if [ $dark_outside -eq 1 ]; then
						dialogue_800_pottruck
					else
						dialogue_pottruck
					fi
				;;
				"go to chipotle")
					if [ $chipotle -eq 1 ]; then
						dialogue_chipotle
					else
						invalid
					fi
				;;
				"look")
					lookstreet
				;;
				"look stripper")
					if [ $dark_outside -eq 1 ]; then
						lookstripper_street
					else
						invalid
					fi
				;;
				"look cars")
					lookcars_street
				;;
				"look outside")
					if [ $dark_outside -eq 1 ]; then
						n 1
						echo "Dear Game Player Across The Monitor,"
						wn 1 1
						w 1
						echo "Sorry, but I'm not going to look back for the life of me."
						wn 1 1
						w 1
						echo "Sincerely,"
						wn 1 1
						w 1
						echo "${usrname} (The Character Played By The Game Player Across The Monitor)"
						wn 1 1
					else
						lookoutside_street
					fi
				;;
				"look fresh grocer")
						lookfreshgrocer_street
				;;
				"look garbage bin")
						lookgarbagebin_street
				;;
				"look pottruck")
						lookpottruck_street
				;;
				"look chipotle")
					if [ $chipotle -eq 1 ]; then
						lookchipotle_street
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_street_whatdo
	done
}

dialogue_800_freshgrocer () {
	n 1
	wn 1 3
	w 1
	echo "${usrname}: *pant* *pant* *pant*"
	w 1
	echo "As I arrive at Fresh Grocer, I realize that I actually began running at some point."
	w 1
	echo "${usrname}: Okay, I should be safe now."
	w 1
	echo "${usrname}: Geez, what a feeling that was!"
	w 1
	echo "I decide to stay in Fresh Grocer for a bit."
	w 1
	echo "At least until my breathing returns calm and my heart stops thumping like crazy."
	wn 1 3
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 3
	w 1
	echo "How much time has passed?"
	w 1
	echo "I've been patrolling here for quite a while now, looking at the latest sales items and stuff."
	w 1
	echo "The weird thing is, there is absolutely noone here."
	w 1
	echo "Isn't Fro Gro open 24/7?"
	w 1
	echo "Like, what if I just steal all of this stuff?"
	w 1
	echo "${usrname}: Oh!"
	w 1
	echo "Nevermind. I see a man in the corner, stumbling, struggling to walk properly."
	w 1
	echo "${usrname}: Excuse me, sir? Would you like me to help you with something?"
	w 1
	echo "I approach him with grace."
	w 1
	echo "The man stops moving."
	w 1
	echo "The man has a black mask on his face and a ring with a Batman logo on his right pinky finger."
	w 1
	echo "${usrname}: Excuse me, I was wondering if you needed any help?"
	wn 1 3
	w 1
	echo "Pause."
	w 1
	echo "Then something stops me and makes me think,"
	w 1
	echo "I don't feel good about this..."
	wn 1 3
	echo "And in that moment..."
	w 1
	echo "${usrname}: Ugh!"
	w 1
	echo "The man suddenly begins sprinting towards me."
	wn 1 3
	wn 1 5
	echo "STAB!!!"
	n 5
	w 1
	echo "Before I am able to completely grasp the situation, he stabs me in the chest."
	w 1
	echo "I instantly regret my decision to approach the man."
	wn 1 1
	echo "Flop!"
	n 1
	w 1
	echo "Surprisingly, however, I don't feel too bad about this."
	w 1
	echo "Somehow, I get this feeling that I more or less deserved this, given my stupidity."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	w 1
	echo "As the unknown man walks away, I remain lying on the floor, staring at the ceiling in Fresh Grocer."
	wn 1 1
	echo "My eyes become heavy."
	n 1
	w 1
	echo "..."
	wn 1 3
	w 1
	echo "I guess it's time for a long nap..."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 1 ]; then
		# PROPER DEATH IN WORLD 1 ... MOVE TO WORLD 2
		world=2
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_freshgrocer () {
	n 1
	echo "Fresh Grocer."
	w 1
	echo "Always there to greet me. 24/7."
	w 1
	echo "What can I do without you?"
	w 1
	echo "People are moving around their carts."
	w 1
	echo "They are chucking whatever groceries they find tempting into their carts."
	w 1
	echo "The cashiers are all like,"
	w 1
	echo "\"Ugh, whatever... What's life, anyways? Let me just get over with this workshift..."
	wn 1 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	echo "Just kidding. None of them seem to be like that."
	w 1
	echo "They all at least seem genuine and hard working."
	wn 1 3
	w 1
	echo "Unfortunately, I don't see much stuff placed in the store right now."
	w 1
	echo "It seems like a lot of stuff has been sold out."
	w 1
	echo "I hope they stack up on my favorite potato chips soon."
	wn 1 4
	action_freshgrocer
}

action_freshgrocer () {
	saw_fake=0
	action_freshgrocer_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. purchase jerkey"
		incr
		n 1
	}
	action_freshgrocer_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to street")
					if [ $saw_fake -eq 1 ]; then
						fake_glitch=1
					fi
					dialogue_street
				;;
				"look")
					lookfreshgrocer
				;;
				"look apples")
					lookapples_freshgrocer
				;;
				"look bananas")
					lookbananas_freshgrocer
				;;
				"look cheesecake")
					lookcheesecake_freshgrocer
				;;
				"look jerkey")
					lookjerkey_freshgrocer
				;;
				"look vodka")
					lookvodka_freshgrocer
				;;
				"look 100")
					lookfake_freshgrocer
				;;
				"look salmon")
					looksalmongod_freshgrocer
				;;
				"look street")
					lookstreet_freshgrocer
				;;
				"purchase jerkey")
					buyjerkey
				;;
				*)
					invalid
				;;
			esac
		fi
		action_freshgrocer_whatdo
	done
}

dialogue_800_garbagebin () {
	n 1
	wn 1 3
	w 1
	echo "I decide to turn around the corner and hide inside the nearby garbage bin until whoever is chasing me disappears."
	w 1
	echo "I open the garbage bin lid..."
	wn 1 1
	wn 1 2
	w 1
	echo "...and that's when I regretted my decision."
	wn 1 1
	wn 1 2
	loop_wn 1 3 2
	echo "TO BE CONTINUED..."
	n 3
	loop_wn 1 3 2
	wn 1 1
	echo "                    ...right now."
	n 1
	w 1
	echo "${usrname}: This is disgusting."
	w 1
	echo "After a moment of hesitation, I jump right into the garbage bin in the company of the flies."
	w 1
	echo "I close the lid."
	w 1
	echo "I wait."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 6
	w 1
	echo "It's silent."
	w 1
	echo "And warm."
	w 1
	echo "I decide to wait a little longer, just so that I'm absolutely certain that whoever was chasing me has gone away."
	loop_wn 1 1 3
	w 1
	echo "It's warm."
	w 1
	echo "It's getting really warm."
	wn 1 1
	w 1
	echo "Like, absurdly warm."
	wn 1 3
	echo "It's hot."
	n 3
	w 1
	echo "I try to push the lid back up from the inside of the garbage bin."
	wn 1 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "I can't."
	loop_wn 1 1 4
	echo "I panic."
	n 1
	w 1
	echo "${usrname}: What's going on?!"
	w 1
	echo "${usrname}: How can I not get out of this garbage bin?!"
	w 1
	echo "I swing my body back and forth, only to realize that the garbage bin was tightly sealed and firmly planted on the ground."
	w 1
	echo "I can hear paper crumbling from the outside."
	w 1
	echo "I can smell the smoke."
	w 1
	echo "It's really hot."
	wn 1 2
	echo "It hurts."
	n 2
	wn 1 1
	wn 1 2
	loop_wn 1 3 3
	w 1
	echo "..."
	wn 1 3
	w 1
	echo "And that's the story of how I became a barbecue."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 1 ]; then
		# PROPER DEATH IN WORLD 1 ... MOVE TO WORLD 2
		world=2
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_garbagebin () {
	n 1
	echo "For some odd reason, I decide to walk towards a garbage bin nearby."
	w 1
	echo "Let me just say this..."
	wn 1 3
	w 1
	echo "...It stinks."
	w 1
	echo "This is the smell of Shrek's armpits."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	echo "I wonder what kind of crazy thing I can do over here?!"
	wn 1 4
	action_garbagebin
}

action_garbagebin () {
	action_garbagebin_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		n 1
	}
	action_garbagebin_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to street")
					dialogue_street
				;;
				"look")
					lookgarbagebin
				;;
				"look garbage bag")
					if [ $garbagebag_poked -eq 0 ]; then
						lookgarbagebag_garbagebin
					else
						n 1
						echo "The garbage bag now has a gaping hole in the corner."
						w 1
						echo "Now the smell is beyond unbearable."
						w 1
						echo "I don't know what's inside the bag."
						w 1
						echo "And frankly, I don't want to know."
						wn 1 3
						w 1
						echo "What have I done..."
						wn 1 1
					fi
				;;
				"look key")
					if [ $have_key -eq 0 ]; then
						lookkey_garbagebin
					else
						invalid
					fi
				;;
				"look mouse")
					if [ $garbagebag_poked -eq 1 ]; then
						lookmouse_garbagebin
					else
						invalid
					fi
				;;
				"look soup")
					looksoup_garbagebin
				;;
				"look street")
					lookstreet_garbagebin
				;;
				*)
					invalid
				;;
			esac
		fi
		action_garbagebin_whatdo
	done
}

dialogue_800_pottruck () {
	n 1
	wn 1 3
	w 1
	echo "I cross the road and run towards the Pottruck Gym."
	w 1
	echo "I grab the door,"
	wn 1 1
	w 1
	echo "                 and it's closed."
	w 1
	echo "${usrname}: Darn, I should've known better. I even read a notice that said Pottruck will close early today!"
	wn 1 1
	w 1
	echo "I cling onto the door handle for a few seconds, strugglin to hold back my tears."
	w 1
	echo "${usrname}: All I wanted was to go to Pottruck!!!"
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "Hopeless, I turn around, ready to leave the gym that I had never entered."
	w 1
	echo "That's when a man approaches, and..."
	wn 1 3
	wn 1 5
	echo "STAB!!!"
	n 5
	wn 1 3
	w 1
	echo "The man has a black mask on his face and a ring with a Batman logo on his right pinky finger."
	w 1
	echo "His right pinky finger is now covered in red, as he takes his knife out from my chest."
	wn 1 1
	echo "Flop!"
	n 1
	w 1
	echo "Having lost my hope from seeing the Pottruck was closed, I struggle to speak a word out of my mouth."
	w 1
	echo "${usrname}: Y... You..."
	w 1
	echo "The man walks away."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	w 1
	echo "My hands reach towards where the man used to be, as I remain in a fetal position on the ground in front of the Pottruck Gym."
	wn 1 1
	echo "It's cold."
	n 1
	wn 1 1
	echo "My eyes become heavy."
	n 1
	w 1
	echo "..."
	wn 1 3
	w 1
	echo "I guess it's time for a long nap..."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 1 ]; then
		# PROPER DEATH IN WORLD 1 ... MOVE TO WORLD 2
		world=2
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

dialogue_pottruck () {
	n 1
	echo "Pottruck is open right now."
	w 1
	echo "People are working out and getting fit."
	w 1
	echo "People of all sizes, from small to big."
	w 1
	echo "People of all ages, from babies to old men and women."
	w 1
	echo "People of all skin colors, from the palest white to the darkest black."
	w 1
	echo "People of all sexes, from males and females to those who identify as neither."
	w 1
	echo "Now this is what I call equality."
	w 1
	echo "That's right."
	w 1
	echo "The Pottruck Gym is most definitely the symbol of equality."
	wn 1 4
	action_pottruck
}

action_pottruck () {
	erg_girl=0
	action_pottruck_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. lift"
		incr
		n 1
	}
	action_pottruck_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to street")
					dialogue_street
				;;
				"look")
					lookpottruck
				;;
				"look clock")
					lookclock
				;;
				"look girls")
					if [ $shady_house -eq 0 ]; then
						lookgirls_nsh_pottruck
					else
						lookgirls_sh_pottruck
					fi
				;;
				"look elliptical machine")
					lookelliptical_pottruck
				;;
				"look towel")
					looktowel_pottruck
				;;
				"look street")
					lookstreet_pottruck
				;;
				"lift")
					n 1
					w 1
					echo "Back in kindergarden, my teacher used to say to me,"
					w 1
					echo "\"Do you even lift, brah?\""
					w 1
					echo "I remember being so fed up with it, I grabbed a hammer from the kindergarden maintenance room and swung it as hard as I can, hitting the teacher's left knee with all my might."
					w 1
					echo "The teacher remained in the hospital for a week."
					w 1
					echo "I was spanked by my mom that evening."
					w 1
					echo "It hurt."
					wn 1 1
					w 1
					echo "But I'm sure it didn't hurt as much as a hammer to the knee."
					loop_wn 1 3 2
					w 1
					echo "I walk up to the weights rack like a man."
					w 1
					echo "I lift up a 5 pound medicine ball."
					w 1
					echo "...With all my might."
					w 1
					echo "${usrname}: EAURGHHH!"
					w 1
					echo "I make the loudest grumbling sound that I can possibly make, so that I can impress the people around me."
					w 1
					echo "."
					w 1
					echo "."
					w 1
					echo "."
					wn 1 1
					w 1
					echo "I place the medicine ball back on the rack."
					w 1
					echo "Hah! I think that's it for my workout."
					w 1
					echo "I went really hard this time."
					wn 1 1
					echo "I live like a boss."
					n 1
					wn 1 1
					echo "I lift like a boss."
					n 1
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		action_pottruck_whatdo
	done
}

dialogue_chipotle () {
	n 1
	echo "I'm here in Chipotle, the definition of Mexican convenience made in America."
	w 1
	echo "Whenever the cashier asks whether I'd like some drink, I ask for a cup for water."
	w 1
	echo "Then, I go to the vending machine and fill up the cup with root beer."
	w 1
	echo "Then, I feel like a badass."
	wn 1 3
	w 1
	echo "The line of people waiting for their orders is long, as always."
	wn 1 4
	action_chipotle
}

action_chipotle () {
	action_chipotle_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. order something"
		incr
		n 1
	}
	action_chipotle_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to street")
					dialogue_street
				;;
				"look")
					lookchipotle
				;;
				"look tables")
					looktables_chipotle
				;;
				"look paper")
					lookpaper_chipotle
				;;
				"look street")
					lookstreet_pottruck
				;;
				"order something")
					n 1
					echo "Nah."
					w 1
					echo "I love burritos."
					w 1
					echo "But this line is just way too long."
					w 1
					echo "I'll try again tomorrow."
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		action_chipotle_whatdo
	done
}

dialogue_palestra () {
	wn 1 3
	echo "3:00PM"
	wn 1 3
	w 1
	echo "I sneak into the Palestra at what seems to be 3:00PM."
	w 1
	echo "Literally thousands of people are gathered in here, ready to listen to the speech presented by our very own school president..."
	wn 1 1
	echo "Shady Gutzmann."
	n 1
	w 1
	echo "Shady: Ehem... Good afternoon, everyone."
	w 1
	echo "I quietly station myself near one of the entrances to the main stadium."
	w 1
	echo "Everyone is focused on what Shady Gutzmann has to say."
	wn 1 1
	w 1
	echo "...And all I can think is,"
	w 1
	echo "Wow, this is almost intimidating."
	w 1
	echo "All I can hear is Shady Gutzmann's voice that sounds like sand paper."
	w 1
	echo "Noone else is making a squeak."
	wn 1 3
	w 1
	echo "Shady: I will make this quick, because this is rather an urgent matter."
	w 1
	echo "Shady: Students, staff, and everyone else who are part of the Philadelphia community."
	w 1
	echo "Shady: Everyone, I'd like to thank you for gathering here in short notice."
	wn 1 1
	w 1
	echo "I look around the stadium, filled with thousands of people."
	w 1
	echo "..."
	loop_wn 1 1 2
	w 1
	echo "Ooh, that's Spencer!"
	w 1
	echo "Spencer is seated a few feet away from me, with a serious expression on his face."
	w 1
	echo "Wow, he must've come here immediately after class."
	w 1
	echo "...This is intense."
	wn 1 3
	w 1
	echo "Shady: First, let me ask you this question."
	w 1
	echo "Shady: Why do we inhibit fear?"
	w 1
	echo "Shady: Is it because inhibiting fear makes us brave?"
	w 1
	echo "Shady: Is it because it is what everyone else tells us to do?"
	w 1
	echo "Shady: No. We inhibit fear, because although we all experience fear, not one of us has known exactly what the source of that fear is."
	w 1
	echo "Shady: Because we are all human beings, not knowing the source of our fear makes us afraid of the very idea of exhibiting or expressing that fear."
	w 1
	echo "Shady: No matter who we are, no matter what we have accomplished in our lives, we all have this never-ending question of what the source of our fear is."
	w 1
	echo "Shady: So far, over the past few millenia, we as human beings have simply overlooked this problem and continued keeping the doors of our emotions shut."
	w 1
	echo "Shady: We often attributed our fear to something else very much trivial, in our attempt to convince ourselves that our negligence of the source of our problem can be justified."
	w 1
	echo "Shady: However, I'm here to tell you otherwise."
	w 1
	echo "Shady: I'm here to tell you that after decades of hard work, I have found the source of our fear."
	wn 1 3
	w 1
	echo "Everyone gasps."
	wn 1 3
	w 1
	echo "Shady: I claim that once we remove this source, we as mankind will forever be free of fear!"
	w 1
	echo "Shady: We will no longer have to inhibit our fear, for fear will no longer exist!"
	w 1
	echo "Shady: We will no longer need to pretend to be fearless!"
	w 1
	echo "Shady: We will live happily ever after!"
	wn 1 3
	w 1
	echo "Everyone's eyes are filled with anticipation."
	w 1
	echo "And desire."
	wn 1 1
	w 1
	echo "Burning desire."
	wn 1 3
	w 1
	echo "Shady: Sadly, I must confess to you that the source of our fear is none other than the existence of one of our students."
	w 1
	echo "Shady: In order for mankind to prosper in absence of fear, it is my duty to disclose to you who that student is."
	w 1
	echo "Shady: And it is our collective duty to responsibly remove that student thereafter."
	w 1
	echo "Shady: His name is..."
	w 1
	echo "Shady:"
	loop_wn 1 1 3
	w 1
	echo "                ${usrname}."
	wn 1 3
	w 1
	echo "W... What?!"
	w 1
	echo "Where does that come from?!"
	w 1
	echo "I can't believe what I just heard."
	w 1
	echo "I am the source of all human beings' fear?"
	w 1
	echo "I must be removed for everyone's fear to disappear?"
	w 1
	echo "Can someone explain to me how she reached that conclusion?"
	wn 1 1
	wn 1 2
	w 1
	echo "Surely people are rational enough to ignore what she just said, right?"
	wn 1 3
	w 1
	echo "Seconds after Shady announced my name, I begin to hear people's cheers slowly filling the stadium."
	w 1
	echo "Shady: As much as the whole of Penn dearly love our student ${usrname}, the Penn Big Brother Council and I have determined that it is for the best of mankind that we as a community make the most of our efforts to find ${usrname}."
	w 1
	echo "Shady: To find him."
	w 1
	echo "Shady: And to kill him."
	wn 1 1
	wn 1 2
	w 1
	echo "\"...\""
	w 1
	echo "\"......\""
	w 1
	echo "\"............\""
	wn 1 1
	w 1
	echo "\"YEAHHHHHHHHH!!!!!!!\""
	w 1
	echo "The audience, that is the entire Philadelphia, goes wild."
	w 1
	echo "Everyone's eyes are now filled with blood thirst."
	wn 1 3
	w 1
	echo "This is bad."
	wn 1 3
	w 1
	echo "Shady: From this point on, for anyone who gets to find ${usrname} and remove him, a total of \$2,000 will be rewarded."
	w 1
	echo "Shady: If ${usrname} is not killed by today, we must all evacuate Philadelphia."
	w 1
	echo "Shady: I will admit. Soon enough, ${usrname} will realize that we are trying to fulfill our duty of mankind."
	w 1
	echo "Shady: And ${usrname} will run away. Far away from Philadelphia. As far as he can, such that no man on Earth can reach him or know his whereabouts."
	w 1
	echo "Shady: Therefore, the Penn Big Brother Council and I have made the executive decision to explode this entire city at midnight, should ${usrname} not be found and killed with our own hands!"
	w 1
	echo "Shady: The sooner we fulfill our duty, the quicker we will be able to remove 'fear' from our history moving forward!"
	w 1
	echo "Shady: People!"
	w 1
	echo "Shady: My word is the Truth!"
	w 1
	echo "Shady: My word is the Law!"
	w 1
	echo "Shady: My word is your Savior!"
	w 1
	echo "Shady: My word is..."
	wn 1 1
	w 1
	echo "I have no darn clue what is going on."
	w 1
	echo "But just by Shady's words, it seems like I have successfully become everyone's enemy."
	w 1
	echo "Or perhaps I should say, everyone's \"target\"."
	wn 1 3
	w 1
	echo "I must think fast."
	wn 1 1
	w 1
	echo "Everyone is paying attention to the last few words Shady has to say."
	wn 1 4
	action_palestra
}

dialogue_post_palestra () {
	n 1
	wn 1 3
	echo "3:30PM"
	wn 1 3
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 3 3
	w 1
	echo "${usrname}: Who the heck are you..."
	wn 1 1
	w 1
	echo "In front of me stands a guy with a golden armor, blocking the Palestra building main entrance."
	w 1
	echo "???: ..."
	w 1
	echo "${usrname}: What do you want!"
	w 1
	echo "???: You may have made it this far..."
	w 1
	echo "${usrname}: Huh?"
	wn 1 1
	wn 1 2
	w 1
	echo "???: But that's not good enough."
	w 1
	echo "${usrname}: What the hell are you talk..."
	wn 1 1
	w 1
	echo "The guy with a golden armor sprints towards me."
	w 1
	echo "Before I can defend myself, he stabs me in the belly with his sword."
	wn 1 5
	echo "STAB!!!"
	n 5
	w 1
	echo "${usrname}: UGHHHHH!"
	wn 1 1
	wn 1 2
	w 1
	echo "The stab drains the energy out of me at exponential speed."
	wn 1 1
	w 1
	echo "With the last bit of strength that I have, I grab the guy's golden helmet with both of my arms."
	w 1
	echo "???: !!!"
	w 1
	echo "${usrname}: I'm... I'm not... I'm not going to let you simply kill me like this!"
	w 1
	echo "As I try to take the helmet off of the guy's head,"
	w 1
	echo "I feel a sudden pull away from the guy."
	w 1
	echo "${usrname}: Argh!"
	w 1
	echo "The next thing I know, whoever was behind me puts me in an arm lock."
	w 1
	echo "${usrname}: Arggghhhh!"
	w 1
	echo "It hurts."
	loop_wn 1 1 4
	echo "Crack..."
	n 1
	loop_wn 1 1 2
	echo "...SNAP!!!"
	n 1
	w 1
	echo "My elbow snaps, and my right arm breaks like a popsicle."
	loop_wn 1 1 4
	echo "${usrname}: AAARRRRRGGGGGGGHHHHHHHHHHHH!!!!!!!!!!!!!!!!"
	n 1
	w 1
	echo "I scream my lungs out in excruciating pain and agony."
	w 1
	echo "???: Okay, that's enough!"
	w 1
	echo "As soon as the golden armor dude signals the other guy to stop, I am released from the arm lock."
	wn 1 1
	w 1
	echo "I don't even feel a thing in my belly right now."
	w 1
	echo "The pain in what used to be my right arm is burning like crazy."
	w 1
	echo "I continue to scream, making non-human sounds."
	wn 1 1
	w 1
	echo "I feel like a monster being defeated by a hero."
	w 1
	echo "A hero with a golden armor."
	wn 1 1
	echo "..."
	n 1
	w 1
	echo "The hero seems to be staring at me silently, as if to wait until I slowly die a grueling death."
	loop_wn 1 3 3
	wn 1 1
	echo "Before I die..."
	n 1
	wn 1 1
	echo "               ...can someone tell me..."
	n 1
	wn 1 1
	echo "                                        ...why?"
	n 1
	loop_wn 1 3 3
	w 1
	echo "I lie in the ever so spreading pool of my own blood, as I gently let go of my last string of life."
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 3 ]; then
		# PROPER DEATH IN WORLD 3 ... MOVE TO WORLD 4
		world=4
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

action_palestra () {
	saw_condom=0
	action_palestra_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		echo "${ctr}. shout"
		incr
		echo "${ctr}. sing"
		incr
		echo "${ctr}. spencer"
		incr
		n 1
	}
	action_palestra_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to outside")
					w 1
					echo "As Shady Gutzmann nears the end of her grand nonsense speech, I decide to leave the Palestra."
					wn 1 1
					wn 1 2
					w 1
					echo "..."
					w 1
					echo "That's when Spencer and my eyes meet."
					wn 1 1
					w 1
					echo "I think,"
					w 1
					echo "'Hey, Spencer."
					w 1
					echo "I wish I can talk to you right now."
					w 1
					echo "Because I'd really appreciate your help."
					w 1
					echo "...But I don't think I know telepathy."
					w 1
					echo "..."
					w 1
					echo "......"
					w 1
					echo "So good bye for now.'"
					wn 1 1
					wn 1 2
					w 1
					echo "Just as Spencer stands up and reach his arms out towards me, I turn around and sprint out of the stadium."
					loop_wn 1 1 2
					dialogue_post_palestra
				;;
				"look")
					lookpalestra
				;;
				"look clock")
					lookclock
				;;
				"look ring")
					if [ $have_ring -eq 0 ]; then
						lookring_palestra
					else
						invalid
					fi
				;;
				"look penncard")
					if [ $have_card -eq 0 ]; then
						lookpenncard_palestra
					else
						invalid
					fi
				;;
				"look basketball")
					lookbasketball_palestra
				;;
				"look ???")
					lookcondom_palestra
				;;
				"look outside")
					lookoutside_palestra
				;;
				"shout")
					n 1
					echo "\"shout\"?"
					w 1
					echo "W... What do you mean \"shout\"?"
					w 1
					echo "Shout out Spencer's name?"
					w 1
					echo "Shout out random words to Shady?"
					w 1
					echo "Shout in front of thousands of people who are all willing to kill me?"
					loop_wn 1 1 3
					w 1
					echo "Are you completely out of your mind?"
					wn 1 1
				;;
				"sing")
					w 1
					echo "${usrname}:"
					w 1
					echo "			Oh, say can you see by the dawn's early light"
					w 1
					echo "			What so proudly we hailed at the twilight's last gleaming?"
					w 1
					echo "			Whose broad stripes and bright stars through the perilous fight,"
					w 1
					echo "			O'er the ramparts we watched were so gallantly streaming?"
					w 1
					echo "			And the rocket's red glare, the bombs bursting in air,"
					w 1
					echo "			Gave proof through the night that our flag was still there."
					w 1
					echo "			Oh, say does that star-spangled banner yet wave"
					w 1
					echo "			O'er the land of the free and the home of the brave?"
					wn 1 1
					w 1
					echo "."
					w 1
					echo "."
					w 1
					echo "."
					wn 1 1
					wn 1 2
					w 1
					echo "When everything was heading the wrong direction, it seemed to me that the best thing to do at this very moment was to sing the national anthem."
					wn 1 1
					w 1
					echo "..."
					wn 1 1
					w 1
					echo "I know I am dead meat."
					w 1
					echo "At least I can prove to everyone in here that I can beautifully sing the national anthem."
					w 1
					echo "...At least I can honestly shed my tears."
					wn 1 1
					wn 1 2
					w 1
					echo "Everyone is looking at me."
					wn 1 1
					wn 1 2
					w 1
					echo "Just as everyone in the stadium stands up, I turn around and sprint out of the stadium."
					loop_wn 1 1 2
					dialogue_post_palestra
				;;
				"spencer")
					n 1
					echo "I would really, really love to believe that Spencer doesn't believe what Shady just said."
					w 1
					echo "It would mean so much to me if Spencer is on my side."
					w 1
					if [ $have_ring -eq 1 ]; then
						echo "Also, I have his Batman ring."
						w 1
					fi
					n 1
					w 1
					echo "But there isn't much I can do right now."
					w 1
					echo "It's not like I can approach him without getting noticed by other people between me and him, anyways."
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		action_palestra_whatdo
	done
}

dialogue_shadyshouse () {
	n 1
	loop_wn 1 1 3
	w 1
	echo "So, this is Shady Gutzmann's house, huh?"
	wn 1 1
	echo "There have been rumors about how a lot of dirty things go on around this place."
	loop_wn 1 1 2
	w 1
	echo "If that is true, it's definitely going on inside the house."
	loop_wn 1 1 2
	w 1
	echo "...Cuz it look tremendously glamorous on the outside!"
	wn 1 1
	echo "Like, wow..."
	w 1
	echo "Seriously..."
	w 1
	echo "This place isn't a house."
	w 1
	echo "It's a palace."
	w 1
	echo "Or more like, a castle."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 2
	w 1
	echo "I guess I'm a little nervous."
	wn 1 4
	action_shadyshouse
}

dialogue_nokeyenter_shadyshouse () {
	n 1
	loop_wn 1 3 2
	w 1
	echo "Ring!"
	loop_wn 1 1 3
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 3
	w 1
	echo "No response."
	wn 1 1
	w 1
	echo "Ringgggggg!"
	wn 1 1
	w 1
	echo "${usrname}: Is anyone there?"
	loop_wn 1 1 2
	w 1
	echo "???: Who is this?"
	w 1
	echo "I hear a voice from across the door."
	w 1
	echo "${usrname}: This is ${usrname}."
	w 1
	echo "And I tell the person who I am."
	wn 1 1
	w 1
	echo "???: ..."
	loop_wn 1 1 3
	w 1
	echo "???: Hold on for a moment, please."
	wn 1 1
	w 1
	echo "${usrname}: Uh, okay!"
	wn 1 1
	w 1
	echo "Familiar voice..."
	w 1
	echo "Where have I heard it?"
	wn 1 1
	w 1
	echo "I hear the sound of metal parts hitting themselves from across the door."
	w 1
	echo "I try to eavesdrop a little closer."
	w 1
	echo "I put my ear against the door."
	wn 1 1
	w 1
	echo "???: I didn't think he would come here..."
	w 1
	echo "???: ..."
	w 1
	echo "???: That was a close call."
	loop_wn 1 1 3
	w 1
	echo "\"I didn't think he would come here\"?"
	w 1
	echo "Is the person referring to me?"
	w 1
	echo "..."
	w 1
	echo "Why?"
	w 1
	echo "I try to think."
	w 1
	echo "I try to think what the person across the door meant."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Ummm... Hello?"
	loop_wn 1 1 2
	w 1
	echo "???: Sorry for keeping you waiting."
	w 1
	echo "The door opens."
	w 1
	echo "The moment the door opens, my heart for some reason fills with sudden regret."
	wn 1 1
	w 1
	echo "The guy who just opened the door has on a full golden armor suit."
	loop_wn 1 1 3
	w 1
	echo "${usrname}: You...!"
	w 1
	echo "All of a sudden, I remember the previous time when..."
	wn 1 5
	echo "STAB!!!"
	n 5
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "{usrname}: ......"
	w 1
	echo "A sword has gotten into my belly..."
	w 1
	echo "...through my back."
	wn 1 1
	wn 1 2
	wn 1 3
	loop_wn 1 5 3
	wn 1 4
	game_over
}

dialogue_enter_shadyshouse () {
	can_use_key=0
	n 1
	wn 1 1
	w 1
	echo "I decide to sneak into the house."
	w 1
	echo "Something tells me that danger roams near."
	w 1
	echo "I slowly and quietly walk through the hall."
	w 1
	echo "...Wow, the inside looks even more gorgeous than the outside."
	w 1
	echo "Like, there are chandeliers and stuff..."
	w 1
	echo "If dirty things are going on in this place, noone will ever notice!"
	loop_wn 1 1 2
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	w 1
	echo "As I walk silently through the hall, I peek at the signs on the doors I pass by."
	w 1
	echo "On my way through the hall, I notice a backpack lying in the corner."
	w 1
	echo "${usrname}: Huh, that seems familiar."
	w 1
	echo "The backpack seems like it has a lot of heavy things inside it."
	wn 1 1
	w 1
	echo "..."
	w 1
	echo "Ah! There it is!"
	w 1
	echo "'Shady's Room'!"
	wn 1 1
	w 1
	echo "I knock on the door."
	loop_wn 1 1 2
	w 1
	echo "No response."
	loop_wn 1 1 2
	w 1
	echo "After a moment of thought, I decide to enter Shady Gutzmann's room."
	wn 1 1
	w 1
	echo "Noone's inside."
	wn 1 1
	w 1
	echo "Hmmm... Shady must be away right now."
	w 1
	echo "I decide to wait."
	wn 1 1
	wn 1 2
	loop_wn 1 3 5
	wn 1 2
	echo "."
	n 2
	wn 1 2
	echo "."
	n 2
	wn 1 2
	echo "."
	n 2
	wn 1 2
	echo "."
	n 2
	wn 1 2
	echo "."
	n 2
	wn 1 2
	echo "."
	n 2
	loop_wn 1 3 6
	echo "6:00PM"
	wn 1 3
	w 1
	echo "${usrname}: ..."
	w 1
	echo "After what felt like hours of waiting, I hear someone coming in."
	wn 1 1
	w 1
	echo "My nerves kick in."
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	w 1
	echo "Shady: How the HELL did you get in here?"
	wn 1 1
	w 1
	echo "...It's Shady Gutzmann."
	w 1
	echo "${usrname}: First things first, I want to ask you a few questions."
	w 1
	echo "Shady: Nope, ladies first. I asked you a question."
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: I found your house key in a garbage in on the street."
	w 1
	echo "Shady: Oh, okay."
	w 1
	echo "Shady: So that's where I dropped it three years ago!"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Okay, now I believe it's my turn."
	w 1
	echo "${usrname}: First off, where were you?"
	w 1
	echo "Shady: That's quite the rude behavior for someone who sneaked into my house!"
	w 1
	echo "${usrname}: ..."
	w 1
	echo "Shady: It's none of your business."
	wn 1 1
	w 1
	echo "Shady: But I'll tell you anyway."
	w 1
	echo "Shady: I was in the Palestra giving a speech."
	w 1
	echo "Shady: And guess what my speech was about?"
	w 1
	echo "${usrname}: What?"
	w 1
	echo "Shady: Your English is a little lacking, isn't it?"
	w 1
	echo "Shady: I can't believe you're a Penn student!"
	w 1
	echo "Shady: A student of mine!"
	w 1
	echo "Shady: I asked you to guess what my speed was about, not say \"What?\"."
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Fine."
	w 1
	echo "${usrname}: Your speech was about... Uh, I don't know, Bash?"
	w 1
	echo "Shady: Wrong!"
	loop_wn 1 1 2
	w 1
	echo "Shady: What's a Bash, anyway?"
	loop_wn 1 1 2
	w 1
	echo "Shady: My speech was about how you should die."
	w 1
	echo "${usrname}: W... What?!"
	w 1
	echo "Shady: You heard me."
	w 1
	echo "Shady: I said, my speech was about how you should die."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: W... Why..."
	w 1
	echo "Shady: Someone told me to make that speech."
	w 1
	echo "Shady: I mean, TBH, I couldn't care less whether you're dead or alive."
	wn 1 1
	w 1
	echo "Shady: But I got a good deal."
	w 1
	echo "Shady: And that's all I wanted."
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Who was it?!"
	w 1
	echo "I can see myself getting excited."
	w 1
	echo "Shady: Who was what?"
	w 1
	echo "${usrname}: Who told you to make that speech?!"
	w 1
	echo "Shady: Hah!"
	wn 1 1
	w 1
	echo "Shady: You think I'm gonna tell you that easily?"
	w 1
	echo "Shady: There's a reason I called it a 'deal', kiddo."
	w 1
	echo "${usrname}: Dammit!"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Dammit you!"
	loop_wn 1 1 2
	w 1
	echo "Shady: Well, who knows?"
	w 1
	echo "Shady: Maybe..."
	w 1
	echo "Shady: Maybe I might just accidentally say it out loud..."
	w 1
	echo "Shady: ...for the right price!"
	w 1
	echo "${usrname}: ..."
	w 1
	echo "Not surprising at all."
	loop_wn 1 1 2
	w 1
	echo "Shady: You have one minute to convince me."
	wn 1 4
	timer_start=$(date +%s)
	action_enter_shadyshouse
}

dialogue_timeout_shadyshouse () {
	wn 1 1
	wn 1 2
	loop_wn 1 3 5
	echo "???: Time's up!"
	n 3
	wn 1 3
	echo "STAB!!!"
	n 3
	loop_wn 1 5 3
	wn 1 4
	game_over
}

dialogue_post_shadyshouse () {
	wn 1 1
	wn 1 2
	wn 1 3
	w 1
	echo "I hand over the last 10 dollar bill I had in my pocket."
	w 1
	echo "${usrname}: This is literally all I have."
	w 1
	echo "Shady: Alright."
	w 1
	echo "Shady: That was a measly \$50, but I can live with it."
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "${usrname}: So... Who was it?"
	loop_wn 1 1 2
	w 1
	echo "Shady: His name is Joel Unzain."
	loop_wn 1 1 2
	w 1
	echo "WHAT."
	wn 1 1
	w 1
	echo "Shady: Oh, you seem surprised, ${usrname}!"
	w 1
	echo "Shady: Well, I guess that's understandable."
	w 1
	echo "Shady: He's one of your friends, ater all."
	w 1
	echo "Shady: Though I must say..."
	w 1
	echo "Shady: I don't know if you're one of his?"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: ..."
	w 1
	echo "Shady: Anyhow, Joel came up to me and told me that he wanted me to do me a favor."
	w 1
	echo "Shady: Eh, of course, he gave me something in return."
	w 1
	echo "Shady: But that's none of your business."
	w 1
	echo "Shady: So, Joel told me to make that speech in the Palestra, after gathering everyone, not just within our school, but in the entire Philadelphia community."
	w 1
	echo "Shady: I'm not exactly sure why he wanted you to die."
	w 1
	echo "Shady: But I received my part of the deal, so I went ahead with it."
	w 1
	echo "${usrname}: ..."
	loop_wn 1 1 2
	w 1
	echo "Shady: If you will excuse me..."
	w 1
	echo "Shady: I think I've told you more than enough of what you wanted me to say."
	w 1
	echo "Shady: Now..."
	loop_wn 1 1 2
	w 1
	echo "Shady: Get the hell out of my house!"
	loop_wn 1 1 2
	w 1
	echo "???: Not just yet."
	w 1
	echo "Shady: !!!"
	w 1
	echo "${usrname}: !!!"
	w 1
	echo "Before I can grasp the situation, a sword appears and..."
	loop_wn 1 1 2
	w 1
	echo "It slits Shady Gutzmann right in her throat."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	wn 1 1
	wn 1 3
	echo "Flop!"
	n 3
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Joel..."
	loop_wn 1 1 2
	w 1
	echo "Joel: That beach..."
	w 1
	echo "Joel: I told her not tell anyone..."
	w 1
	echo "Joel: ...and she sells my name for freaking 50 dollars!"
	loop_wn 1 1 2
	w 1
	echo "Joel: She didn't even give me time to put on my armor suit..."
	w 1
	echo "Joel: And now look what's happened..."
	w 1
	echo "Joel: *sigh*"
	w 1
	echo "${usrname}: ..."
	wn 1 1
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 3
	w 1
	echo "${usrname}: Can you explain all this, Joel?"
	w 1
	echo "Joel: ..."
	w 1
	echo "Joel: Explain what?"
	w 1
	echo "${usrname}: I think you know what I mean."
	w 1
	echo "Joel: Well, I think you're not gonna get what you want."
	w 1
	echo "${usrname}: Explain why you told Shady to make that speech, Joel!"
	loop_wn 1 1 2
	w 1
	echo "He has seems sad."
	w 1
	echo "Very sad."
	w 1
	echo "He has an indelible frown on his face."
	wn 1 1
	w 1
	echo "Joel: Why does that matter?"
	w 1
	echo "${usrname}: Huh?"
	w 1
	echo "Joel: Why does that matter, ${usrname}?"
	w 1
	echo "${usrname}: What... What do you mean?"
	w 1
	echo "Joel: I mean, you're gonna die anyways."
	w 1
	echo "Joel: So why does that matter?"
	w 1
	echo "${usrname}: What the hell do you mean, Joel?!"
	w 1
	echo "${usrname}: Why do you want to kill me?!"
	wn 1 1
	w 1
	echo "He kicks off the ground and sprints towards me with his blood-covered sword."
	w 1
	echo "I fight back."
	loop_wn 1 3 7
	echo "7:00PM"
	wn 1 3
	w 1
	echo "..."
	w 1
	echo "He silently leaves the room."
	w 1
	echo "I remain lied down on the ground, right next to Shady Gutzmann."
	wn 1 1
	w 1
	echo "We share our puddles of blood, as two puddles become one."
	wn 1 1
	w 1
	echo "How romantic."
	loop_wn 1 1 2
	w 1
	echo "I look up to the big chandelier on the ceiling."
	w 1
	echo "And I wonder..."
	loop_wn 1 1 6
	wn 1 3
	echo "Why?"
	n 3
	loop_wn 1 5 3
	wn 1 4
	if [ $world -eq 6 ]; then
		# PROPER DEATH IN WORLD 6 ... MOVE TO WORLD 7
		world=7
		reset_clock
		dialogue_130_class
	else
		# WRONG DEATH
		game_over
	fi
}

action_shadyshouse () {
	can_use_key=1
	action_shadyshouse_whatdo () {
		whatdo
		init
		echo "${ctr}. go to"
		incr
		echo "${ctr}. look"
		incr
		if [ $saw_door -eq 1 ]; then
			echo "${ctr}. ring door bell"
			incr
		fi
		if [ $can_open_door -eq 1 ]; then
			echo "${ctr}. open door"
			incr
		fi
		n 1
	}
	action_shadyshouse_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"go to outside")
					can_use_key=0
					secret_asdfg=0
					dialogue_outside
				;;
				"look")
					lookshadyshouse
				;;
				"look door")
					lookdoor_shadyshouse
				;;
				"look bush")
					lookbush_shadyshouse
				;;
				"look poop")
					lookpoop_shadyshouse
				;;
				"look outside")
					lookoutside_shadyshouse
				;;
				"ring door bell")
					if [ $saw_door -eq 1 ]; then
						can_use_key=0
						secret_asdfg=0
						dialogue_nokeyenter_shadyshouse
					else
						invalid
					fi
				;;
				"open door")
					if [ $can_open_door ]; then
						can_use_key=0
						secret_asdfg=0
						dialogue_enter_shadyshouse
					else
						invalid
					fi
				;;
				"asdfg")
					secret_asdfg=1
				;;
				"ThE cAkE iS a LiE")
					if [ $secret_asdfg -eq 1 ]; then
						secret_cake=1
					else
						invalid
					fi
				;;
				*)
					invalid
				;;
			esac
		fi
		action_shadyshouse_whatdo
	done
}

timer () {
	elapse=$(($(date +%s) - $timer_start))
	time_left=$((60 - $elapse))
	if [ $time_left -le 0 ]; then
		dialogue_timeout_shadyshouse
	elif [ $time_left -eq 1 ]; then
		n 1
		echo "[[1 SECOND LEFT]]"
		n 1
	else
		n 1
		echo "[[$time_left SECONDS LEFT]]"
		n 1
	fi
}

action_enter_shadyshouse () {
	can_give_shady=1
	compliments=0
	try_kiss=0
	try_dance=0
	action_enter_shadyshouse_whatdo () {
		whatdo
		init
		echo "${ctr}. give compliment"
		incr
		echo "${ctr}. kiss her"
		incr
		echo "${ctr}. dance"
		incr
		echo "${ctr}. red rose"
		incr
		echo "${ctr}. pink rose"
		incr
		echo "${ctr}. white rose"
		incr
		echo "${ctr}. blue rose"
		incr
		echo "${ctr}. red and blue roses"
		n 1
	}
	timer
	action_enter_shadyshouse_whatdo
	while read action
	do
		action_common
		if [ $not_common -eq 1 ]; then
			case $action in
				"give compliment")
					if [ $compliments -eq 0 ]; then
						n 1
						echo "This is gonna be hard..."
						w 1
						echo "...but I try to be a gentleman to Shady."
						w 1
						echo "${usrname}: You... You look pretty today."
						w 1
						echo "Shady: Oh why, thank you, ${usrname}!"
						w 1
						echo "..."
						wn 1 1
						compliments=1
					elif [ $compliments -eq 1 ]; then
						n 1
						echo "I try giving her another compliment."
						w 1
						echo "${usrname}: I know it's hard..."
						w 1
						echo "${usrname}: ...but you're really killin' it in the \"Managing the University of Pennsylvania\" game!"
						w 1
						echo "${usrname}: You think so? Thanks so much!"
						w 1
						echo "..."
						wn 1 1
						compliments=2
					elif [ $compliments -eq 2 ]; then
						n 1
						echo "Is this working?"
						w 1
						echo "Is she going to tell me now?"
						w 1
						echo "I try complimenting her one more time."
						w 1
						echo "${usrname}: Are you from Korea?"
						w 1
						echo "${usrname}: Because you could be my Seoul mate."
						w 1
						echo "...Wait."
						w 1
						echo "That's not a compliment."
						w 1
						echo "That's a horrible pick-up line."
						w 1
						echo "Shady: You make me blush."
						w 1
						echo "..."
						wn 1 1
						compliments=3
					else
						n 1
						echo "Okay..."
						w 1
						echo "I'm not sure if giving her compliments is gonna do anything..."
						w 1
						echo "SMH..."
						wn 1 1
					fi
				;;
				"kiss her")
					if [ $try_kiss -eq 0 ]; then
						n 1
						echo "I walk towards Shady, as I make a kissy face."
						w 1
						echo "..."
						wn 1 1
						try_kiss=1
					elif [ $try_kiss -eq 1 ]; then
						n 1
						echo "Now I'm within her kissing distance."
						w 1
						echo "French kiss?"
						w 1
						echo "I think so."
						w 1
						echo "..."
						wn 1 1
						try_kiss=2
					elif [ $try_kiss -eq 2 ]; then
						w 1
						echo "As I aim my lips towards her lips..."
						wn 4 3
						echo "SLAP!!!"
						n 3
						w 1
						echo "She gives me the biggest slap of all slaps."
						w 1
						echo "Shady: Back off!"
						w 1
						echo "..."
						wn 1 1
						try_kiss=3
					else
						n 1
						echo "WHY DON'T YOU LOVE MEEEEEEE!!!"
						wn 1 3
						w 1
						echo "Let's try it again."
						w 1
						echo "..."
						wn 1 1
						try_kiss=0
					fi
				;;
				"dance")
					if [ $try_dance -eq 0 ]; then
						n 1
						echo "Okay, ${usrname}, are you ready?!"
						loop_wn 1 1 2
						w 1
						echo "I start break dancing in front of Shady."
						w 1
						echo "Shady: Wow! You're good!"
						wn 1 1
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						wn 1 1
						w 1
						echo "${usrname}: *pant* *pant* *pant*"
						w 1
						echo "Shady: I'm impressed!"
						w 1
						echo "..."
						wn 1 1
						try_dance=1
					elif [ $try_dance -eq 1 ]; then
						n 1
						echo "Let me try another dance."
						loop_wn 1 1 2
						w 1
						echo "I take out a piece of cloth that I've been keeping just for this moment."
						w 1
						echo "${usrname}: Hoiya!"
						w 1
						echo "I start belly dancing in front of Shady."
						w 1
						echo "Shady: Ooooh! Belly dancing!"
						wn 1 1
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						wn 1 1
						w 1
						echo "${usrname}: *pant* *pant* *pant* *pant* *pant*"
						w 1
						echo "Shady: I'm even more impressed! You're a talented young man!"
						w 1
						echo "..."
						wn 1 1
						try_dance=2
					elif [ $try_dance -eq 2 ]; then
						n 1
						echo "Okay, one last time."
						w 1
						echo "I swear, if this won't get her to tell me, I don't know what will."
						loop_wn 1 1 2
						w 1
						echo "I walk up to Shady."
						w 1
						echo "Then I push her to the chair behind her."
						w 1
						echo "${usrname}: Are you ready for this?"
						w 1
						echo "I slowly unbotton my shirt."
						loop_wn 1 1 2
						w 1
						echo "I start lap dancing in front of Shady."
						wn 1 1
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						w 1
						echo "."
						wn 1 1
						echo "${usrname}: *pant* *pant* *pa...... I mean, not *pant* *pant* *pant* for this one!!!"
						w 1
						echo "Shady: Ooh la la!"
						w 1
						echo "..."
						wn 1 1
						try_dance=3
					else
						n 1
						echo "I think I'm done with dancing for Shady..."
						w 1
						echo "I'm too tired..."
						w 1
						echo "...and embarrassed..."
						loop_wn 1 1 2
						w 1
						echo "I'm not sure if this works..."
						wn 1 1
					fi
				;;
				"red rose"|"pink rose"|"white rose")
					n 1
					echo "Darn!"
					loop_wn 1 1 2
					w 1
					echo "I really should've picked up a rose from outside."
					w 1
					echo "I could've presented it to Shady."
					loop_wn 1 1 2
					w 1
					echo "...But then again, The roses are Shady's."
					w 1
					echo "..."
					wn 1 1
				;;
				"blue rose")
					n 1
					echo "What about a blue rose?"
					w 1
					echo "A blue rose would be cool."
					loop_wn 1 1 2
					w 1
					echo "Where can I get a blue rose?"
					w 1
					echo "..."
					wn 1 1
				;;
				"red and blue roses")
					n 1
					echo "Come all ye loyal classmates now"
					w 1
					echo "In all and campus through,"
					w 1
					echo "Lift up your hearts and voices"
					w 1
					echo "For the Royal Red and Blue"
					w 1
					echo "Fair Harvard has her crimson"
					w 1
					echo "Old Yale her colors too,"
					w 1
					echo "But for dear Pennsylvania"
					w 1
					echo "We wear the Red and Blue."
					wn 1 1
					w 1
					echo "Hurrah!"
					w 1
					echo "Hurrah!"
					w 1
					echo "Pennsylvania!"
					w 1
					echo "Hurrah for the Red and the Blue!"
					w 1
					echo "Hurrah!"
					w 1
					echo "Hurrah!"
					w 1
					echo "Hurrah!"
					w 1
					echo "Hurrah!"
					w 1
					echo "Hurrah for the Red and Blue!"
					loop_wn 1 1 2
					w 1
					echo "..."
					wn 1 1
				;;
				*)
					invalid
				;;
			esac
		fi
		timer
		action_enter_shadyshouse_whatdo
	done
}

dialogue_spencers_view () {
	n 1
	echo "."
	wn 1 1 
	echo "..."
	wn 1 1
	echo "......"
	wn 1 1
	echo "............"
	wn 1 7
	echo "THURSDAY"
	n 3
	wn 1 3
	echo "1:30PM"
	wn 1 3
	w 1
	echo "CIS 191."
	w 1
	echo "A class full of adventure."
	w 1
	echo "And that adventure was over yesterday."
	loop_wn 1 1 2
	w 1
	echo "My name is Spencer."
	w 1
	echo "Spencer Lee."
	w 1
	echo "I'm a comp sci grad student at the University of Pennsylvania."
	w 1
	echo "I'm also the instructor of one of its courses, CIS 191."
	w 1
	echo "This will be my last time teaching that course."
	w 1
	echo "I teach Linux and Unix."
	w 1
	echo "So... Bash is pretty amazing."
	loop_wn 1 1 2
	w 1
	echo "I'm heading towards the HUP right now."
	w 1
	echo "That's the Hospital of the University of Pennsylvania."
	w 1
	echo "I was told that two of my students, Joel and ${usrname}, were driving in a car yesterday afternoon after their CIS 320 midterm."
	w 1
	echo "Apparently, they were crossing their bridge, and then one of them, Joel, took a right in the middle of the bridge."
	w 1
	echo "The car flew off the bridge, into the ocean."
	loop_wn 1 1 2
	w 1
	echo "Apparently, by the time the boys were rescued, they were both unconscious."
	w 1
	echo "They were immediately taken to the hospital."
	loop_wn 1 1 2
	w 1
	echo "I've been told that, unfortunately, Joel was dead."
	wn 1 1
	w 1
	echo "However, it seems like ${usrname} was able to stay alive."
	w 1
	echo "He was taken care of in the hospital last night."
	w 1
	echo "And I'm about to pick him up."
	loop_wn 1 1 2
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	w 1
	echo "I see ${usrname} lying on his patient bed."
	w 1
	echo "Spencer: ${usrname}!"
	w 1
	echo "He looks at me, with a smile on his face."
	w 1
	echo "${usrname}: Spencer!"
	w 1
	echo "Spencer: You all good?"
	w 1
	echo "${usrname}: Yup!"
	w 1
	echo "Spencer: You ready to head out!"
	w 1
	echo "${usrname}: Yup!"
	loop_wn 1 1 2
	w 1
	echo "${usrname}: Wait, Spencer."
	w 1
	echo "Spencer: What's up?"
	w 1
	echo "${usrname}: I remember Joel was with me."
	w 1
	echo "${usrname}: Where is he?"
	w 1
	echo "${usrname}: Is he okay?"
	w 1
	echo "Spencer: ..."
	loop_wn 1 1 4
	w 1
	echo "Spencer: Yup, he's okay."
	wn 1 1
	w 1
	echo "Spencer: He's resting in a happy place right now."
	wn 1 1 
	w 1
	echo "${usrname}: Oh, okay!"
	wn 1 1
	w 1
	echo "I wait for ${usrname} to put on his sneakers."
	loop_wn 1 1 2
	w 1
	echo "."
	w 1
	echo "."
	w 1
	echo "."
	loop_wn 1 1 2
	w 1
	echo "I look outside the hospital window."
	loop_wn 1 1 3
	wn 1 3
	echo "...Today is a sunny day..."
	n 3
	wn 1 3
	echo "        ...Life is rough sometimes..."
	n 3
	wn 1 3
	echo "               ...And you may often want to give up..."
	n 3
	wn 1 3
	echo "                       ...But just know that..."
	n 3
	wn 1 3
	echo "                                     ...Just know that the clouds will eventually go away..."
	n 3
	wn 1 3
	echo "                                                ...That after a rainy day always come a sunny day..."
	n 3
	loop_wn 1 7 3
	wn 1 3
	echo "Today is a sunny day."
	n 3
	wn 1 1
	echo "THE END"
	n 1
	wn 1 4
	game_complete
}

# run game

introduction