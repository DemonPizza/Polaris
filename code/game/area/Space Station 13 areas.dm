/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = 0 				(defaults to 1)
	music = "music/music.ogg"		(defaults to "music/music.ogg")

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/



/area
	var/fire = null
	var/atmos = 1
	var/atmosalm = 0
	var/poweralm = 1
	var/party = null
	level = null
	name = "Unknown"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	layer = 10
	luminosity = 0
	mouse_opacity = 0
	var/lightswitch = 1

	var/eject = null

	var/debug = 0
	var/requires_power = 1
	var/always_unpowered = 0	//this gets overriden to 1 for space in area/New()

	var/power_equip = 1
	var/power_light = 1
	var/power_environ = 1
	var/music = null
	var/used_equip = 0
	var/used_light = 0
	var/used_environ = 0

	var/has_gravity = 1
	var/obj/machinery/power/apc/apc = null
	var/no_air = null
//	var/list/lights				// list of all lights on this area
	var/list/all_doors = list()		//Added by Strumpetplaya - Alarm Change - Contains a list of doors adjacent to this area
	var/air_doors_activated = 0
	var/list/ambience = list('sound/ambience/ambigen1.ogg','sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambigen14.ogg')
	var/list/forced_ambience = null
	var/sound_env = 2	//reverb preset for sounds played in this area, see sound datum reference for more
/*Adding a wizard area teleport list because motherfucking lag -- Urist*/
/*I am far too lazy to make it a proper list of areas so I'll just make it run the usual telepot routine at the start of the game*/
var/list/teleportlocs = list()

/hook/startup/proc/setupTeleportLocs()
	for(var/area/AR in world)
		if(istype(AR, /area/shuttle) || istype(AR, /area/syndicate_station) || istype(AR, /area/wizard_station)) continue
		if(teleportlocs.Find(AR.name)) continue
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z in config.station_levels)
			teleportlocs += AR.name
			teleportlocs[AR.name] = AR

	teleportlocs = sortAssoc(teleportlocs)

	return 1

var/list/ghostteleportlocs = list()

/hook/startup/proc/setupGhostTeleportLocs()
	for(var/area/AR in world)
		if(ghostteleportlocs.Find(AR.name)) continue
		if(istype(AR, /area/turret_protected/aisat) || istype(AR, /area/derelict) || istype(AR, /area/tdome) || istype(AR, /area/shuttle/specops/centcom))
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z in config.player_levels)
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR

	ghostteleportlocs = sortAssoc(ghostteleportlocs)

	return 1

/*-----------------------------------------------------------------------------*/

/////////
//SPACE//
/////////

/area/space
	name = "\improper Space"
	icon_state = "space"
	requires_power = 1
	always_unpowered = 1
	power_light = 0
	power_equip = 0
	power_environ = 0
	ambience = list('sound/ambience/ambispace.ogg','sound/music/title2.ogg','sound/music/space.ogg','sound/music/main.ogg','sound/music/traitor.ogg')

area/space/atmosalert()
	return

/area/space/fire_alert()
	return

/area/space/fire_reset()
	return

/area/space/readyalert()
	return

/area/space/partyalert()
	return

/area/turret_protected/

/area/arrival
	requires_power = 0

/area/arrival/start
	name = "\improper Arrival Area"
	icon_state = "start"

/area/admin
	name = "\improper Admin room"
	icon_state = "start"



////////////
//SHUTTLES//
////////////
//shuttle areas must contain at least two areas in a subgroup if you want to move a shuttle from one
//place to another. Look at escape shuttle for example.
//All shuttles should now be under shuttle since we have smooth-wall code.

/area/shuttle
	requires_power = 0

/area/shuttle/arrival
	name = "\improper Arrival Shuttle"

/area/shuttle/arrival/pre_game
	icon_state = "shuttle2"

/area/shuttle/arrival/station
	icon_state = "shuttle"

/area/shuttle/escape
	name = "\improper Emergency Shuttle"
	music = "music/escape.ogg"

/area/shuttle/escape/station
	name = "\improper Emergency Shuttle Station"
	icon_state = "shuttle2"

/area/shuttle/escape/centcom
	name = "\improper Emergency Shuttle Centcom"
	icon_state = "shuttle"

/area/shuttle/escape/transit // the area to pass through for 3 minute transit
	name = "\improper Emergency Shuttle Transit"
	icon_state = "shuttle"

/area/shuttle/escape_pod1
	name = "\improper Escape Pod One"
	music = "music/escape.ogg"

/area/shuttle/escape_pod1/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod1/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod1/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod2
	name = "\improper Escape Pod Two"
	music = "music/escape.ogg"

/area/shuttle/escape_pod2/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod2/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod2/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod3
	name = "\improper Escape Pod Three"
	music = "music/escape.ogg"

/area/shuttle/escape_pod3/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod3/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod3/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod4
	name = "\improper Escape Pod Four"
	music = "music/escape.ogg"

/area/shuttle/escape_pod4/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod4/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod4/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod5
	name = "\improper Escape Pod Five"
	music = "music/escape.ogg"

/area/shuttle/escape_pod5/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod5/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod5/transit
	icon_state = "shuttle"

/area/shuttle/escape_pod6
	name = "\improper Escape Pod Six"
	music = "music/escape.ogg"

/area/shuttle/escape_pod6/station
	icon_state = "shuttle2"

/area/shuttle/escape_pod6/centcom
	icon_state = "shuttle"

/area/shuttle/escape_pod6/transit
	icon_state = "shuttle"

/area/shuttle/large_escape_pod1
	name = "\improper Large Escape Pod One"
	music = "music/escape.ogg"

/area/shuttle/large_escape_pod1/station
	icon_state = "shuttle2"

/area/shuttle/large_escape_pod1/centcom
	icon_state = "shuttle"

/area/shuttle/large_escape_pod1/transit
	icon_state = "shuttle"

/area/shuttle/large_escape_pod2
	name = "\improper Large Escape Pod Two"
	music = "music/escape.ogg"

/area/shuttle/large_escape_pod2/station
	icon_state = "shuttle2"

/area/shuttle/large_escape_pod2/centcom
	icon_state = "shuttle"

/area/shuttle/large_escape_pod2/transit
	icon_state = "shuttle"

/area/shuttle/cryo
	name = "\improper Cryogenic Storage"

/area/shuttle/cryo/station
	icon_state = "shuttle2"

/area/shuttle/cryo/centcom
	icon_state = "shuttle"

/area/shuttle/cryo/transit
	icon_state = "shuttle"

/area/shuttle/mining
	name = "\improper Mining Shuttle"
	music = "music/escape.ogg"

/area/shuttle/mining/station
	icon_state = "shuttle2"

/area/shuttle/mining/outpost
	icon_state = "shuttle"

/area/shuttle/transport1/centcom
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Centcom"

/area/shuttle/transport1/station
	icon_state = "shuttle"
	name = "\improper Transport Shuttle"

/area/shuttle/alien/base
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Base"
	requires_power = 1

/area/shuttle/alien/mine
	icon_state = "shuttle"
	name = "\improper Alien Shuttle Mine"
	requires_power = 1

/area/shuttle/prison/
	name = "\improper Prison Shuttle"

/area/shuttle/prison/station
	icon_state = "shuttle"

/area/shuttle/prison/prison
	icon_state = "shuttle2"

/area/shuttle/specops/centcom
	name = "\improper Special Ops Shuttle"
	icon_state = "shuttlered"

/area/shuttle/specops/station
	name = "\improper Special Ops Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/syndicate_elite/mothership
	name = "\improper Merc Elite Shuttle"
	icon_state = "shuttlered"

/area/shuttle/syndicate_elite/station
	name = "\improper Merc Elite Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/administration/centcom
	name = "\improper Administration Shuttle Centcom"
	icon_state = "shuttlered"

/area/shuttle/administration/station
	name = "\improper Administration Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/thunderdome
	name = "honk"

/area/shuttle/thunderdome/grnshuttle
	name = "\improper Thunderdome GRN Shuttle"
	icon_state = "green"

/area/shuttle/thunderdome/grnshuttle/dome
	name = "\improper GRN Shuttle"
	icon_state = "shuttlegrn"

/area/shuttle/thunderdome/grnshuttle/station
	name = "\improper GRN Station"
	icon_state = "shuttlegrn2"

/area/shuttle/thunderdome/redshuttle
	name = "\improper Thunderdome RED Shuttle"
	icon_state = "red"

/area/shuttle/thunderdome/redshuttle/dome
	name = "\improper RED Shuttle"
	icon_state = "shuttlered"

/area/shuttle/thunderdome/redshuttle/station
	name = "\improper RED Station"
	icon_state = "shuttlered2"
// === Trying to remove these areas:

/area/shuttle/research
	name = "\improper Research Shuttle"
	music = "music/escape.ogg"

/area/shuttle/research/station
	icon_state = "shuttle2"

/area/shuttle/research/outpost
	icon_state = "shuttle"

/area/shuttle/skipjack/station
	name = "\improper Skipjack"
	icon_state = "yellow"
	requires_power = 0

/area/airtunnel1/      // referenced in airtunnel.dm:759

/area/dummy/           // Referenced in engine.dm:261

/area/start            // will be unused once kurper gets his login interface patch done
	name = "start area"
	icon_state = "start"
	requires_power = 0
	lighting_use_dynamic = 0
	has_gravity = 1

// === end remove

/area/alien
	name = "\improper Alien base"
	icon_state = "yellow"
	requires_power = 0

// CENTCOM

/area/centcom
	name = "\improper Centcom"
	icon_state = "centcom"
	requires_power = 0
	lighting_use_dynamic = 0

/area/centcom/control
	name = "\improper Centcom Control"

/area/centcom/evac
	name = "\improper Centcom Emergency Shuttle"

/area/centcom/suppy
	name = "\improper Centcom Supply Shuttle"

/area/centcom/ferry
	name = "\improper Centcom Transport Shuttle"

/area/centcom/shuttle
	name = "\improper Centcom Administration Shuttle"

/area/centcom/test
	name = "\improper Centcom Testing Facility"

/area/centcom/living
	name = "\improper Centcom Living Quarters"

/area/centcom/specops
	name = "\improper Centcom Special Ops"

/area/centcom/creed
	name = "Creed's Office"

/area/centcom/holding
	name = "\improper Holding Facility"

/area/centcom/terminal
	name = "\improper Docking Terminal"
	icon_state = "centcom_dock"

/area/centcom/tram
	name = "\improper Tram Station"

/area/centcom/security
	name = "\improper Centcom Security"
	icon_state = "centcom_security"

/area/centcom/medical
	name = "\improper Centcom Medical"
	icon_state = "centcom_medical"

/area/centcom/command
	name = "\improper Centcom Command" //Central Command Command totally isn't RAS Syndrome in action.
	icon_state = "centcom_command"

/area/centcom/main_hall
	name = "\improper Main Hallway"
	icon_state = "centcom_hallway1"

/area/centcom/bar
	name = "\improper Centcom Bar"
	icon_state = "centcom_crew"

/area/centcom/restaurant
	name = "\improper Centcom Restaurant"
	icon_state = "centcom_crew"

/area/centcom/bathroom
	name = "\improper Centcom Bathroom"
	icon_state = "centcom_crew"

//SYNDICATES

/area/syndicate_mothership
	name = "\improper Mercenary Base"
	icon_state = "syndie-ship"
	requires_power = 0
	lighting_use_dynamic = 0

/area/syndicate_mothership/control
	name = "\improper Mercenary Control Room"
	icon_state = "syndie-control"

/area/syndicate_mothership/elite_squad
	name = "\improper Elite Mercenary Squad"
	icon_state = "syndie-elite"

//EXTRA

/area/asteroid					// -- TLE
	name = "\improper Moon"
	icon_state = "asteroid"
	requires_power = 0

/area/asteroid/cave				// -- TLE
	name = "\improper Moon - Underground"
	icon_state = "cave"
	requires_power = 0

/area/asteroid/artifactroom
	name = "\improper Moon - Artifact"
	icon_state = "cave"















/area/planet/clown
	name = "\improper Clown Planet"
	icon_state = "honk"
	requires_power = 0

/area/tdome
	name = "\improper Thunderdome"
	icon_state = "thunder"
	requires_power = 0
	lighting_use_dynamic = 0

/area/tdome/tdome1
	name = "\improper Thunderdome (Team 1)"
	icon_state = "green"

/area/tdome/tdome2
	name = "\improper Thunderdome (Team 2)"
	icon_state = "yellow"

/area/tdome/tdomeadmin
	name = "\improper Thunderdome (Admin.)"
	icon_state = "purple"

/area/tdome/tdomeobserve
	name = "\improper Thunderdome (Observer.)"
	icon_state = "purple"

//ENEMY

//names are used
/area/syndicate_station
	name = "\improper Independant Station"
	icon_state = "yellow"
	requires_power = 0
	flags = RAD_SHIELDED

/area/syndicate_station/start
	name = "\improper Mercenary Forward Operating Base"
	icon_state = "yellow"

/area/syndicate_station/southwest
	name = "\improper south-west of SS13"
	icon_state = "southwest"

/area/syndicate_station/northwest
	name = "\improper north-west of SS13"
	icon_state = "northwest"

/area/syndicate_station/northeast
	name = "\improper north-east of SS13"
	icon_state = "northeast"

/area/syndicate_station/southeast
	name = "\improper south-east of SS13"
	icon_state = "southeast"

/area/syndicate_station/north
	name = "\improper north of SS13"
	icon_state = "north"

/area/syndicate_station/south
	name = "\improper south of SS13"
	icon_state = "south"

/area/syndicate_station/commssat
	name = "\improper south of the communication satellite"
	icon_state = "south"

/area/syndicate_station/mining
	name = "\improper northeast of the mining station"
	icon_state = "north"

/area/syndicate_station/arrivals_dock
	name = "\improper docked with station"
	icon_state = "shuttle"

/area/syndicate_station/maint_dock
	name = "\improper docked with station"
	icon_state = "shuttle"

/area/syndicate_station/transit
	name = "\improper hyperspace"
	icon_state = "shuttle"

/area/wizard_station
	name = "\improper Wizard's Den"
	icon_state = "yellow"
	requires_power = 0
	lighting_use_dynamic = 0

/area/skipjack_station/transit

	name = "\improper hyperspace"
	icon_state = "shuttle"

/area/skipjack_station/southwest_solars
	name = "\improper aft port solars"
	icon_state = "southwest"

/area/skipjack_station/northwest_solars
	name = "\improper fore port solars"
	icon_state = "northwest"

/area/skipjack_station/northeast_solars
	name = "\improper fore starboard solars"
	icon_state = "northeast"

/area/skipjack_station/southeast_solars
	name = "\improper aft starboard solars"
	icon_state = "southeast"

/area/skipjack_station/mining
	name = "\improper south of mining station"
	icon_state = "north"

//PRISON
/area/prison
	name = "\improper Prison Station"
	icon_state = "brig"

/area/prison/arrival_airlock
	name = "\improper Prison Station Airlock"
	icon_state = "green"
	requires_power = 0

/area/prison/control
	name = "\improper Prison Security Checkpoint"
	icon_state = "security"

/area/prison/crew_quarters
	name = "\improper Prison Security Quarters"
	icon_state = "security"

/area/prison/rec_room
	name = "\improper Prison Rec Room"
	icon_state = "green"

/area/prison/closet
	name = "\improper Prison Supply Closet"
	icon_state = "dk_yellow"

/area/prison/hallway/fore
	name = "\improper Prison Fore Hallway"
	icon_state = "yellow"

/area/prison/hallway/aft
	name = "\improper Prison Aft Hallway"
	icon_state = "yellow"

/area/prison/hallway/port
	name = "\improper Prison Port Hallway"
	icon_state = "yellow"

/area/prison/hallway/starboard
	name = "\improper Prison Starboard Hallway"
	icon_state = "yellow"

/area/prison/morgue
	name = "\improper Prison Morgue"
	icon_state = "morgue"

/area/prison/medical_research
	name = "\improper Prison Genetic Research"
	icon_state = "medresearch"

/area/prison/medical
	name = "\improper Prison Medbay"
	icon_state = "medbay"

/area/prison/solar
	name = "\improper Prison Solar Array"
	icon_state = "storage"
	requires_power = 0

/area/prison/podbay
	name = "\improper Prison Podbay"
	icon_state = "dk_yellow"

/area/prison/solar_control
	name = "\improper Prison Solar Array Control"
	icon_state = "dk_yellow"

/area/prison/solitary
	name = "Solitary Confinement"
	icon_state = "brig"

/area/prison/cell_block/A
	name = "Prison Cell Block A"
	icon_state = "brig"

/area/prison/cell_block/B
	name = "Prison Cell Block B"
	icon_state = "brig"

/area/prison/cell_block/C
	name = "Prison Cell Block C"
	icon_state = "brig"

////////////////////
//SPACE STATION 13//
////////////////////

//Maintenance

/area/maintenance
	flags = RAD_SHIELDED

/area/maintenance/aft
	name = "Aft Maintenance"
	icon_state = "amaint"

/area/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "fmaint"

/area/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "smaint"

/area/maintenance/port
	name = "Port Maintenance"
	icon_state = "pmaint"

/area/maintenance/atmos_control
	name = "Atmospherics Maintenance"
	icon_state = "fpmaint"

/area/maintenance/fpmaint
	name = "Fore Port Maintenance - 1"
	icon_state = "fpmaint"

/area/maintenance/fpmaint2
	name = "Fore Port Maintenance - 2"
	icon_state = "fpmaint"

/area/maintenance/fsmaint
	name = "Fore Starboard Maintenance - 1"
	icon_state = "fsmaint"

/area/maintenance/fsmaint2
	name = "Fore Starboard Maintenance - 2"
	icon_state = "fsmaint"

/area/maintenance/asmaint
	name = "Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/maintenance/engi_shuttle
	name = "Engineering Shuttle Access"
	icon_state = "maint_e_shuttle"

/area/maintenance/engi_engine
	name = "Engine Maintenance"
	icon_state = "maint_engine"

/area/maintenance/asmaint2
	name = "Science Maintenance"
	icon_state = "asmaint"

/area/maintenance/apmaint
	name = "Cargo Maintenance"
	icon_state = "apmaint"

/area/maintenance/maintcentral
	name = "Bridge Maintenance"
	icon_state = "maintcentral"

/area/maintenance/arrivals
	name = "Arrivals Maintenance"
	icon_state = "maint_arrivals"

/area/maintenance/bar
	name = "Bar Maintenance"
	icon_state = "maint_bar"

/area/maintenance/central
	name = "Central Maintenance"
	icon_state = "maint_central"

/area/maintenance/cafe_dock
	name = "Cafeteria Dock Maintenance"
	icon_state = "maint_cafe_dock"

/area/maintenance/cargo
	name = "Cargo Maintenance"
	icon_state = "maint_cargo"

/area/maintenance/cargo_research
	name = "Cargo Research Maintenance"
	icon_state = "maint_cargo_research"

/area/maintenance/chapel
	name = "Chapel Maintenance"
	icon_state = "maint_chapel"

/area/maintenance/disposal
	name = "Waste Disposal"
	icon_state = "disposal"

/area/maintenance/engineering
	name = "Engineering Maintenance"
	icon_state = "maint_engineering"

/area/maintenance/evahallway
	name = "\improper EVA Maintenance"
	icon_state = "maint_eva"

/area/maintenance/dormitory
	name = "Dormitory Maintenance"
	icon_state = "maint_dormitory"

/area/maintenance/incinerator
	name = "\improper Incinerator"
	icon_state = "disposal"

/area/maintenance/library
	name = "Library Maintenance"
	icon_state = "maint_library"

/area/maintenance/locker
	name = "Locker Room Maintenance"
	icon_state = "maint_locker"

/area/maintenance/medbay
	name = "Medbay Maintenance"
	icon_state = "maint_medbay"

/area/maintenance/medbay_aft
	name = "Medbay Maintenance - Aft"
	icon_state = "maint_medbay_aft"

/area/maintenance/medbay_fore
	name = "Medbay Maintenance - Fore"
	icon_state = "maint_medbay_fore"

/area/maintenance/research_port
	name = "Research Maintenance - Port"
	icon_state = "maint_research_port"

/area/maintenance/research_starboard
	name = "Research Maintenance - Starboard"
	icon_state = "maint_research_starboard"

/area/maintenance/research_starboard
	name = "Research Maintenance - Starboard"
	icon_state = "maint_research_cargo"

/area/maintenance/research_shuttle
	name = "Research Shuttle Dock Maintenance"
	icon_state = "maint_research_shuttle"

/area/maintenance/security_port
	name = "Security Maintenance - Port"
	icon_state = "maint_security_port"

/area/maintenance/security_starboard
	name = "Security Maintenance - Starboard"
	icon_state = "maint_security_starboard"

/area/maintenance/storage
	name = "Atmospherics"
	icon_state = "green"

/area/maintenance/tool_storage
	name = "Tool Storage Maintenance"
	icon_state = "maint_tool_storage"


// SUBSTATIONS (Subtype of maint, that should let them serve as shielded area during radstorm)

/area/maintenance/substation
	name = "Substation"
	icon_state = "substation"

/area/maintenance/substation/engineering // Probably will be connected to engineering SMES room, as wires cannot be crossed properly without them sharing powernets.
	name = "Engineering Substation"

// No longer used:
/area/maintenance/substation/medical_science // Medbay and Science. Each has it's own separated machinery, but it originates from the same room.
	name = "Medical Research Substation"

/area/maintenance/substation/medical // Medbay
	name = "Medical Substation"

/area/maintenance/substation/research // Research
	name = "Research Substation"

/area/maintenance/substation/cafeteria_dock // Hydro, kitchen, docks, hotel
	name = "Cafeteria Dock Substation"

/area/maintenance/substation/civilian // Dorms, Lockerroom, Pool
	name = "Civilian Substation"

/area/maintenance/substation/civilian_east // Bar, kitchen, dorms, ...
	name = "Civilian East Substation"

/area/maintenance/substation/civilian_west // Cargo, PTS, locker room, probably arrivals, ...)
	name = "Civilian West Substation"

/area/maintenance/substation/cargo // Cargo
	name = "Cargo Substation"

/area/maintenance/substation/command // AI and central cluster. This one will be between HoP office and meeting room (probably).
	name = "Command Substation"

/area/maintenance/substation/security // Security, Brig, Permabrig, etc.
	name = "Security Substation"




//Hallway

/area/hallway/primary/
	sound_env = 12 //hallway

/area/hallway/primary/fore
	name = "\improper Fore Primary Hallway"
	icon_state = "hallF"

/area/hallway/primary/starboard
	name = "\improper Starboard Primary Hallway"
	icon_state = "hallS"

/area/hallway/primary/aft
	name = "\improper Aft Primary Hallway"
	icon_state = "hallA"

/area/hallway/primary/port
	name = "\improper Port Primary Hallway"
	icon_state = "hallP"

/area/hallway/primary/central_one
	name = "\improper Central Primary Hallway - Fore"
	icon_state = "hallC1"

/area/hallway/primary/central_two
	name = "\improper Central Primary Hallway - Starboard"
	icon_state = "hallC2"

/area/hallway/primary/central_three
	name = "\improper Central Primary Hallway - Aft"
	icon_state = "hallC3"

/area/hallway/primary/central_four
	name = "\improper Central Primary Hallway - Port"
	icon_state = "hallC4"

/area/hallway/secondary/exit
	name = "\improper Escape Shuttle Hallway"
	icon_state = "escape"

/area/hallway/secondary/construction
	name = "\improper Construction Area"
	icon_state = "construction"

/area/hallway/secondary/entry/fore
	name = "\improper Arrival Shuttle Hallway - Fore"
	icon_state = "entry_1"

/area/hallway/secondary/entry/port
	name = "\improper Arrival Shuttle Hallway - Port"
	icon_state = "entry_2"

/area/hallway/secondary/entry/starboard
	name = "\improper Arrival Shuttle Hallway - Starboard"
	icon_state = "entry_3"

/area/hallway/secondary/entry/aft
	name = "\improper Arrival Shuttle Hallway - Aft"
	icon_state = "entry_4"

/area/hallway/secondary/entry/D1
	name = "\improper Arrival Shuttle Hallway - Dock One"
	icon_state = "entry_D1"

/area/hallway/secondary/entry/D2
	name = "\improper Arrival Shuttle Hallway - Dock Two"
	icon_state = "entry_D2"

/area/hallway/secondary/entry/D3
	name = "\improper Arrival Shuttle Hallway - Dock Three"
	icon_state = "entry_D3"

/area/hallway/secondary/entry/docking_lounge
	name = "\improper Docking Lounge"
	icon_state = "docking_lounge"

/area/hallway/secondary/escape/fore_port_escape_pod_hallway
	name = "\improper Fore Port Escape Pod Hallway"
	icon_state = "fore_port_escape_pod_hallway"

/area/hallway/secondary/escape/fore_escape_pod_hallway
	name = "\improper Fore Escape Pod Hallway"
	icon_state = "fore_escape_pod_hallway"

/area/hallway/secondary/escape/medical_escape_pod_hallway
	name = "\improper Medical Escape Pod Hallway"
	icon_state = "medical_escape_pod_hallway"

/area/hallway/secondary/aft_civilian_hallway
	name = "\improper Aft Civilian Hallway"
	icon_state = "aft_civilian_hallway"

/area/hallway/secondary/fore_civilian_hallway
	name = "\improper Fore Civilian Hallway"
	icon_state = "fore_civilian_hallway"

/area/hallway/secondary/cryostorage_hallway
	name = "\improper Cryostorage Hallway"
	icon_state = "cryostorage_hallway"

/area/hallway/secondary/docking_hallway
	name = "\improper Docking Hallway"
	icon_state = "docking_hallway"

/area/hallway/secondary/engineering_hallway
	name = "\improper Engineering Primary Hallway"
	icon_state = "engineering_primary_hallway"

/area/hallway/secondary/eva_hallway
	name = "\improper EVA Hallway"
	icon_state = "eva_hallway"

/area/hallway/secondary/medical_emergency_hallway
	name = "\improper Medical Emergency Hallway"
	icon_state = "medical_emergency_hallway"

//Command

/area/bridge
	name = "\improper Bridge"
	icon_state = "bridge"
	music = "signal"

/area/bridge_hallway
	name = "\improper Bridge Hallway"
	icon_state = "bridge"

/area/bridge/meeting_room
	name = "\improper Heads of Staff Meeting Room"
	icon_state = "bridge"
	music = null

/area/crew_quarters/captain
	name = "\improper Command - Captain's Office"
	icon_state = "captain"

/area/crew_quarters/heads/hop
	name = "\improper Command - HoP's Office"
	icon_state = "head_quarters"

/area/crew_quarters/heads/hor
	name = "\improper Research - RD's Office"
	icon_state = "head_quarters"

/area/crew_quarters/heads/chief
	name = "\improper Engineering - CE's Office"
	icon_state = "head_quarters"

/area/crew_quarters/heads/hos
	name = "\improper Security - HoS' Office"
	icon_state = "head_quarters"

/area/crew_quarters/heads/cmo
	name = "\improper Medbay - CMO's Office"
	icon_state = "head_quarters"

/area/crew_quarters/courtroom
	name = "\improper Courtroom"
	icon_state = "courtroom"

/area/mint
	name = "\improper Mint"
	icon_state = "green"

/area/comms
	name = "\improper Communications Relay"
	icon_state = "tcomsatcham"

/area/server
	name = "\improper Messaging Server Room"
	icon_state = "server"

//Crew

/area/crew_quarters
	name = "\improper Dormitories"
	icon_state = "Sleep"
	flags = RAD_SHIELDED

/area/crew_quarters/toilet
	name = "\improper Dormitory Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep
	name = "\improper Dormitories"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A1
	name = "\improper Apartment A1"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A2
	name = "\improper Apartment A2"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A3
	name = "\improper Apartment A3"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A4
	name = "\improper Apartment A4"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A5
	name = "\improper Apartment A5"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A6
	name = "\improper Apartment A6"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A7
	name = "\improper Apartment A7`"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_A8
	name = "\improper Apartment A8"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_B1
	name = "\improper Apartment B1"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_B2
	name = "\improper Apartment B2"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Apartment_B3
	name = "\improper Apartment B3"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_1
	name = "\improper Dormitory Room 1"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_2
	name = "\improper Dormitory Room 2"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_3
	name = "\improper Dormitory Room 3"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_4
	name = "\improper Dormitory Room 4"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_5
	name = "\improper Dormitory Room 5"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_6
	name = "\improper Dormitory Room 6"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_7
	name = "\improper Dormitory Room 7"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_8
	name = "\improper Dormitory Room 8"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_9
	name = "\improper Dormitory Room 9"
	icon_state = "Sleep"

/area/crew_quarters/sleep/Dorm_10
	name = "\improper Dormitory Room 10"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_1
	name = "\improper Visitor Room 1"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_2
	name = "\improper Visitor Room 2"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_3
	name = "\improper Visitor Room 3"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_4
	name = "\improper Visitor Room 4"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_5
	name = "\improper Visitor Room 5"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_6
	name = "\improper Visitor Room 6"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_7
	name = "\improper Visitor Room 7"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_8
	name = "\improper Visitor Room 8"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_9
	name = "\improper Visitor Room 9"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_10
	name = "\improper Visitor Room 10"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_11
	name = "\improper Visitor Room 11"
	icon_state = "Sleep"

/area/crew_quarters/sleep/vistor_room_12
	name = "\improper Visitor Room 12"
	icon_state = "Sleep"

/area/crew_quarters/sleep/engi_wash
	name = "\improper Engineering Washroom"
	icon_state = "toilet"

/area/crew_quarters/sleep/bedrooms
	name = "\improper Dormitory Bedroom One"
	icon_state = "Sleep"

/area/crew_quarters/sleep/cryo
	name = "\improper Cryogenic Storage"
	icon_state = "Sleep"

/area/crew_quarters/sleep_male
	name = "\improper Male Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_male/toilet_male
	name = "\improper Male Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep_female
	name = "\improper Female Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_female/toilet_female
	name = "\improper Female Toilets"
	icon_state = "toilet"

/area/crew_quarters/locker
	name = "\improper Locker Room"
	icon_state = "locker"

/area/crew_quarters/locker/locker_toilet
	name = "\improper Locker Toilets"
	icon_state = "toilet"

/area/crew_quarters/fitness
	name = "\improper Fitness Room"
	icon_state = "fitness"

/area/crew_quarters/recreation_area
	name = "\improper Recreation Area"
	icon_state = "recreation_area"

/area/crew_quarters/recreation_area_hallway
	name = "\improper Recreation Area Hallway"
	icon_state = "recreation_area_hallway"

/area/crew_quarters/recreation_area_restroom
	name = "\improper Recreation Area Restroom"
	icon_state = "recreation_area_restroom"

/area/crew_quarters/pool
	name = "\improper Pool"
	icon_state = "pool"

/area/crew_quarters/cafeteria
	name = "\improper Cafeteria"
	icon_state = "cafeteria"

/area/crew_quarters/coffee_shop
	name = "\improper Coffee Shop"
	icon_state = "coffee_shop"

/area/crew_quarters/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

/area/crew_quarters/bar
	name = "\improper Bar"
	icon_state = "bar"

/area/crew_quarters/theatre
	name = "\improper Theatre"
	icon_state = "Theatre"

/area/crew_quarters/visitor_lodging
 	name = "\improper Visitor Lodging"
 	icon_state = "visitor_lodging"

/area/crew_quarters/visitor_dinning
 	name = "\improper Visitor Dinning"
 	icon_state = "visitor_dinning"

/area/crew_quarters/visitor_laundry
 	name = "\improper Visitor Laundry"
 	icon_state = "visitor_laundry"

/area/library
 	name = "\improper Library"
 	icon_state = "library"

/area/library_conference_room
 	name = "\improper Library Conference Room"
 	icon_state = "library_conference_room"

/area/chapel/main
	name = "\improper Chapel"
	icon_state = "chapel"
	ambience = list('sound/ambience/ambicha1.ogg','sound/ambience/ambicha2.ogg','sound/ambience/ambicha3.ogg','sound/ambience/ambicha4.ogg','sound/music/traitor.ogg')

/area/chapel/office
	name = "\improper Chapel Office"
	icon_state = "chapeloffice"

/area/chapel/chapel_morgue
	name = "\improper Chapel Morgue"
	icon_state = "chapel_morgue"

/area/lawoffice
	name = "\improper Internal Affairs"
	icon_state = "law"

/area/holodeck_control
	name = "\improper Holodeck Control"
	icon_state = "holodeck_control"

/area/vacant/vacant_shop
	name = "\improper Vacant Shop"
	icon_state = "vacant_shop"

/area/vacant/vacant_site
	name = "\improper Vacant Site"
	icon_state = "vacant_site"


/area/holodeck
	name = "\improper Holodeck"
	icon_state = "Holodeck"
	lighting_use_dynamic = 0

/area/holodeck/alphadeck
	name = "\improper Holodeck Alpha"

/area/holodeck/source_plating
	name = "\improper Holodeck - Off"

/area/holodeck/source_emptycourt
	name = "\improper Holodeck - Empty Court"

/area/holodeck/source_boxingcourt
	name = "\improper Holodeck - Boxing Court"

/area/holodeck/source_basketball
	name = "\improper Holodeck - Basketball Court"

/area/holodeck/source_thunderdomecourt
	name = "\improper Holodeck - Thunderdome Court"

/area/holodeck/source_courtroom
	name = "\improper Holodeck - Courtroom"

/area/holodeck/source_beach
	name = "\improper Holodeck - Beach"

/area/holodeck/source_burntest
	name = "\improper Holodeck - Atmospheric Burn Test"

/area/holodeck/source_wildlife
	name = "\improper Holodeck - Wildlife Simulation"

/area/holodeck/source_meetinghall
	name = "\improper Holodeck - Meeting Hall"

/area/holodeck/source_theatre
	name = "\improper Holodeck - Theatre"

/area/holodeck/source_picnicarea
	name = "\improper Holodeck - Picnic Area"

/area/holodeck/source_snowfield
	name = "\improper Holodeck - Snow Field"

/area/holodeck/source_desert
	name = "\improper Holodeck - Desert"

/area/holodeck/source_space
	name = "\improper Holodeck - Space"
	has_gravity = 0

//Engineering

/area/engineering/
	name = "\improper Engineering"
	icon_state = "engineering"
	ambience = list('sound/ambience/ambisin1.ogg','sound/ambience/ambisin2.ogg','sound/ambience/ambisin3.ogg','sound/ambience/ambisin4.ogg')

/area/engineering/atmos
 	name = "\improper Atmospherics"
 	icon_state = "atmos"

/area/engineering/atmos/monitoring
	name = "\improper Atmospherics Monitoring Room"
	icon_state = "atmos_monitoring"

/area/engineering/atmos/storage
	name = "\improper Atmospherics Storage"
	icon_state = "atmos_storage"

/area/engineering/drone_fabrication
	name = "\improper Engineering Drone Fabrication"
	icon_state = "drone_fab"

/area/engineering/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"

/area/engineering/engine_room
	name = "\improper Engine Room"
	icon_state = "engine"

/area/engineering/engine_airlock
	name = "\improper Engine Room Airlock"
	icon_state = "engine"

/area/engineering/engine_monitoring
	name = "\improper Engine Monitoring Room"
	icon_state = "engine_monitoring"

/area/engineering/engine_waste
	name = "\improper Engine Waste Handling"
	icon_state = "engine_waste"

/area/engineering/engineering_monitoring
	name = "\improper Engineering Monitoring Room"
	icon_state = "engine_monitoring"

/area/engineering/foyer
	name = "\improper Engineering Foyer"
	icon_state = "engineering_foyer"

/area/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "engineering_storage"

/area/engineering/break_room
	name = "\improper Engineering Break Room"
	icon_state = "engineering_break"

/area/engineering/engine_eva
	name = "\improper Engine EVA"
	icon_state = "engine_eva"

/area/engineering/locker_room
	name = "\improper Engineering Locker Room"
	icon_state = "engineering_locker"

/area/engineering/workshop
	name = "\improper Engineering Workshop"
	icon_state = "engineering_workshop"



//Solars

/area/solar
	requires_power = 1
	always_unpowered = 1
	lighting_use_dynamic = 0

	auxport
		name = "\improper Fore Port Solar Array"
		icon_state = "panelsA"

	auxstarboard
		name = "\improper Fore Starboard Solar Array"
		icon_state = "panelsA"

	fore
		name = "\improper Fore Solar Array"
		icon_state = "yellow"

	aft
		name = "\improper Aft Solar Array"
		icon_state = "aft"

	starboard
		name = "\improper Aft Starboard Solar Array"
		icon_state = "panelsS"

	port
		name = "\improper Aft Port Solar Array"
		icon_state = "panelsP"

/area/maintenance/auxsolarport
	name = "Solar Maintenance - Fore Port"
	icon_state = "SolarcontrolP"

/area/maintenance/starboardsolar
	name = "Solar Maintenance - Aft Starboard"
	icon_state = "SolarcontrolS"

/area/maintenance/portsolar
	name = "Solar Maintenance - Aft Port"
	icon_state = "SolarcontrolP"

/area/maintenance/auxsolarstarboard
	name = "Solar Maintenance - Fore Starboard"
	icon_state = "SolarcontrolS"

/area/maintenance/foresolar
	name = "Solar Maintenance - Fore"
	icon_state = "SolarcontrolA"

/area/assembly/chargebay
	name = "\improper Mech Bay"
	icon_state = "mechbay"

/area/assembly/showroom
	name = "\improper Robotics Showroom"
	icon_state = "showroom"

/area/assembly/robotics
	name = "\improper Robotics Lab"
	icon_state = "robotics"

/area/assembly/assembly_line //Derelict Assembly Line
	name = "\improper Assembly Line"
	icon_state = "ass_line"
	power_equip = 0
	power_light = 0
	power_environ = 0

//Teleporter

/area/teleporter
	name = "\improper Teleporter"
	icon_state = "teleporter"
	music = "signal"

/area/gateway
	name = "\improper Gateway"
	icon_state = "teleporter"
	music = "signal"

/area/AIsattele
	name = "\improper AI Satellite Teleporter Room"
	icon_state = "teleporter"
	music = "signal"
	ambience = list('sound/ambience/ambimalf.ogg')

//MedBay

/area/medical/medbay
	name = "\improper Medbay Hallway - Port"
	icon_state = "medbay"
	music = 'sound/ambience/signal.ogg'

//Medbay is a large area, these additional areas help level out APC load.
/area/medical/medbay2
	name = "\improper Medbay Hallway - Starboard"
	icon_state = "medbay2"
	music = 'sound/ambience/signal.ogg'

/area/medical/medbay3
	name = "\improper Medbay Hallway - Fore"
	icon_state = "medbay3"
	music = 'sound/ambience/signal.ogg'

/area/medical/medbay4
	name = "\improper Medbay Hallway - Aft"
	icon_state = "medbay4"
	music = 'sound/ambience/signal.ogg'

/area/medical/biostorage
	name = "\improper Secondary Storage"
	icon_state = "medbay2"
	music = 'sound/ambience/signal.ogg'

/area/medical/reception
	name = "\improper Medbay Reception"
	icon_state = "medbay"
	music = 'sound/ambience/signal.ogg'

/area/medical/medbay_emt_bay
	name = "\improper Medical EMT Bay"
	icon_state = "medbay_emt_bay"
	music = 'sound/ambience/signal.ogg'

/area/medical/medbay_primary_storage
	name = "\improper Medbay Primary Storage"
	icon_state = "medbay_primary_storage"
	music = 'sound/ambience/signal.ogg'

/area/medical/psych
	name = "\improper Psych Room"
	icon_state = "medbay3"
	music = 'sound/ambience/signal.ogg'

/area/crew_quarters/medbreak
	name = "\improper Break Room"
	icon_state = "medbay3"
	music = 'sound/ambience/signal.ogg'

/area/crew_quarters/medical_restroom
	name = "\improper Medbay Restroom"
	icon_state = "medbay_restroom"

/area/medical/patients_rooms
	name = "\improper Patient's Rooms"
	icon_state = "patients"

/area/medical/ward
	name = "\improper Recovery Ward"
	icon_state = "patients"

/area/medical/patient_a
	name = "\improper Patient A"
	icon_state = "medbay_patient_room_a"

/area/medical/patient_b
	name = "\improper Patient B"
	icon_state = "medbay_patient_room_b"

/area/medical/patient_c
	name = "\improper Patient C"
	icon_state = "medbay_patient_room_c"

/area/medical/patient_d
	name = "\improper Patient D"
	icon_state = "medbay_patient_room_d"

/area/medical/patient_e
	name = "\improper Patient E"
	icon_state = "medbay_patient_room_e"

/area/medical/patient_wing
	name = "\improper Patient Wing"
	icon_state = "patients"

/area/medical/cmostore
	name = "\improper Secure Storage"
	icon_state = "CMO"

/area/medical/robotics
	name = "\improper Robotics"
	icon_state = "medresearch"

/area/medical/virology
	name = "\improper Virology"
	icon_state = "virology"

/area/medical/virologyaccess
	name = "\improper Virology Access"
	icon_state = "virology"

/area/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	ambience = list('sound/ambience/ambimo1.ogg','sound/ambience/ambimo2.ogg','sound/music/main.ogg')

/area/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

/area/medical/surgery
	name = "\improper Operating Theatre 1"
	icon_state = "surgery"

/area/medical/surgery2
	name = "\improper Operating Theatre 2"
	icon_state = "surgery"

/area/medical/surgeryobs
	name = "\improper Operation Observation Room"
	icon_state = "surgery"

/area/medical/surgeryprep
	name = "\improper Pre-Op Prep Room"
	icon_state = "surgery"

/area/medical/surgery_hallway
	name = "\improper Surgery Hallway"
	icon_state = "surgery_hallway"

/area/medical/surgery_storage
	name = "\improper Surgery Storage"
	icon_state = "surgery_storage"

/area/medical/cryo
	name = "\improper Cryogenics"
	icon_state = "cryo"

/area/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"

/area/medical/genetics
	name = "\improper Genetics Lab"
	icon_state = "genetics"

/area/medical/genetics_cloning
	name = "\improper Cloning Lab"
	icon_state = "cloning"

/area/medical/sleeper
	name = "\improper Emergency Treatment Centre"
	icon_state = "exam_room"

//Security

/area/security/main
	name = "\improper Security Office"
	icon_state = "security"

/area/security/lobby
	name = "\improper Security Lobby"
	icon_state = "security"

/area/security/brig
	name = "\improper Security - Brig"
	icon_state = "brig"

/area/security/brig/prison_break()
	for(var/obj/structure/closet/secure_closet/brig/temp_closet in src)
		temp_closet.locked = 0
		temp_closet.icon_state = temp_closet.icon_closed
	for(var/obj/machinery/door_timer/temp_timer in src)
		temp_timer.releasetime = 1
	..()

/area/security/prison
	name = "\improper Security - Prison Wing"
	icon_state = "sec_prison"

/area/security/prison/prison_break()
	for(var/obj/structure/closet/secure_closet/brig/temp_closet in src)
		temp_closet.locked = 0
		temp_closet.icon_state = temp_closet.icon_closed
	for(var/obj/machinery/door_timer/temp_timer in src)
		temp_timer.releasetime = 1
	..()

/area/security/warden
	name = "\improper Security - Warden's Office"
	icon_state = "Warden"

/area/security/armoury
	name = "\improper Security - Armory"
	icon_state = "armory"

/area/security/evidence_storage
	name = "\improper Security - Equipment Storage"
	icon_state = "security_equipment_storage"

/area/security/evidence_storage
	name = "\improper Security - Evidence Storage"
	icon_state = "evidence_storage"

/area/security/interrogation
	name = "\improper Security - Interrogation"
	icon_state = "interrogation"

/area/security/riot_control
	name = "\improper Security - Riot Control"
	icon_state = "riot_control"

/area/security/detectives_office
	name = "\improper Security - Forensic Office"
	icon_state = "detective"

/area/security/range
	name = "\improper Security - Firing Range"
	icon_state = "firingrange"

/area/security/security_aid_station
	name = "\improper Security - Security Aid Station"
	icon_state = "security_aid_station"

/area/security/security_bathroom
	name = "\improper Security - Restroom"
	icon_state = "security_bathroom"

/area/security/security_cell_hallway
	name = "\improper Security - Cell Hallway"
	icon_state = "security_cell_hallway"

/area/security/security_equiptment_storage
	name = "\improper Security - Equipment Storage"
	icon_state = "security_equip_storage"

/area/security/security_lockerroom
	name = "\improper Security - Lockerroom"
	icon_state = "security_lockerroom"

/area/security/security_processing
	name = "\improper Security - Security Processing"
	icon_state = "security_processing"

/area/security/tactical
	name = "\improper Security - Tactical Equipment"
	icon_state = "Tactical"


/*
	New()
		..()

		spawn(10) //let objects set up first
			for(var/turf/turfToGrayscale in src)
				if(turfToGrayscale.icon)
					var/icon/newIcon = icon(turfToGrayscale.icon)
					newIcon.GrayScale()
					turfToGrayscale.icon = newIcon
				for(var/obj/objectToGrayscale in turfToGrayscale) //1 level deep, means tables, apcs, locker, etc, but not locker contents
					if(objectToGrayscale.icon)
						var/icon/newIcon = icon(objectToGrayscale.icon)
						newIcon.GrayScale()
						objectToGrayscale.icon = newIcon
*/

/area/security/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"

/area/security/checkpoint
	name = "\improper Security Checkpoint"
	icon_state = "checkpoint1"

/area/security/checkpoint2
	name = "\improper Security - Arrival Checkpoint"
	icon_state = "security"

/area/security/checkpoint/supply
	name = "Security Post - Cargo Bay"
	icon_state = "checkpoint1"

/area/security/checkpoint/engineering
	name = "Security Post - Engineering"
	icon_state = "checkpoint1"

/area/security/checkpoint/medical
	name = "Security Post - Medbay"
	icon_state = "checkpoint1"

/area/security/checkpoint/science
	name = "Security Post - Science"
	icon_state = "checkpoint1"

/area/security/vacantoffice
	name = "\improper Vacant Office"
	icon_state = "security"

/area/security/vacantoffice2
	name = "\improper Vacant Office"
	icon_state = "security"

/area/quartermaster
	name = "\improper Quartermasters"
	icon_state = "quart"

/area/quartermaster/office
	name = "\improper Cargo Office"
	icon_state = "quartoffice"

/area/quartermaster/storage
	name = "\improper Cargo Bay"
	icon_state = "quartstorage"

/area/quartermaster/qm
	name = "\improper Cargo - Quartermaster's Office"
	icon_state = "quart"

/area/quartermaster/delivery
	name = "\improper Cargo - Delivery Office"
	icon_state = "quart"

/area/quartermaster/miningdock
	name = "\improper Cargo Mining Dock"
	icon_state = "mining"

/area/janitor/
	name = "\improper Custodial Closet"
	icon_state = "janitor"

/area/hydroponics
	name = "\improper Hydroponics"
	icon_state = "hydro"

/area/hydroponics/cafegarden
	name = "\improper Cafeteria Garden"
	icon_state = "cafe_garden"

/area/hydroponics/garden
	name = "\improper Garden"
	icon_state = "garden"

//rnd (Research and Development
/area/rnd/research
	name = "\improper Research and Development"
	icon_state = "research"

/area/rnd/research_foyer
	name = "\improper Research Foyer"
	icon_state = "research_foyer"

/area/rnd/research_restroom
	name = "\improper Research Restroom"
	icon_state = "research_restroom"

/area/rnd/docking
	name = "\improper Research Dock"
	icon_state = "research_dock"

/area/rnd/lab
	name = "\improper Research Lab"
	icon_state = "toxlab"

/area/rnd/rdoffice
	name = "\improper Research Director's Office"
	icon_state = "head_quarters"

/area/rnd/supermatter
	name = "\improper Supermatter Lab"
	icon_state = "toxlab"

/area/rnd/xenobiology
	name = "\improper Xenobiology Lab"
	icon_state = "xeno_lab"

/area/rnd/xenobiology/xenoflora_storage
	name = "\improper Xenoflora Storage"
	icon_state = "xeno_f_store"

/area/rnd/xenobiology/xenoflora
	name = "\improper Xenoflora Lab"
	icon_state = "xeno_f_lab"

/area/rnd/storage
	name = "\improper Toxins Storage"
	icon_state = "toxstorage"

/area/rnd/test_area
	name = "\improper Toxins Test Area"
	icon_state = "toxtest"

/area/rnd/mixing
	name = "\improper Toxins Mixing Room"
	icon_state = "toxmix"

/area/rnd/misc_lab
	name = "\improper Miscellaneous Research"
	icon_state = "toxmisc"

/area/toxins/server
	name = "\improper Server Room"
	icon_state = "server"

//Storage

/area/storage/tools
	name = "Auxiliary Tool Storage"
	icon_state = "storage"

/area/storage/primary
	name = "Primary Tool Storage"
	icon_state = "primarystorage"

/area/storage/autolathe
	name = "Autolathe Storage"
	icon_state = "storage"

/area/storage/art
	name = "Art Supply Storage"
	icon_state = "storage"

/area/storage/auxillary
	name = "Auxillary Storage"
	icon_state = "auxstorage"

/area/storage/eva
	name = "EVA Storage"
	icon_state = "eva"

/area/storage/secure
	name = "Secure Storage"
	icon_state = "storage"

/area/storage/emergency
	name = "Starboard Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/emergency2
	name = "Port Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/emergency3
	name = "Central Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/emergency4
	name = "Civilian Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/emergency5
	name = "Dock Emergency Storage"
	icon_state = "emergencystorage"

/area/storage/tech
	name = "Technical Storage"
	icon_state = "auxstorage"

/area/storage/testroom
	requires_power = 0
	name = "\improper Test Room"
	icon_state = "storage"

//DJSTATION

/area/djstation
	name = "\improper Listening Post"
	icon_state = "LP"

/area/djstation/solars
	name = "\improper Listening Post Solars"
	icon_state = "LPS"

//DERELICT

/area/derelict
	name = "\improper Derelict Station"
	icon_state = "storage"

/area/derelict/hallway/primary
	name = "\improper Derelict Primary Hallway"
	icon_state = "hallP"

/area/derelict/hallway/secondary
	name = "\improper Derelict Secondary Hallway"
	icon_state = "hallS"

/area/derelict/arrival
	name = "\improper Derelict Arrival Centre"
	icon_state = "yellow"

/area/derelict/storage/equipment
	name = "Derelict Equipment Storage"

/area/derelict/storage/storage_access
	name = "Derelict Storage Access"

/area/derelict/storage/engine_storage
	name = "Derelict Engine Storage"
	icon_state = "green"

/area/derelict/bridge
	name = "\improper Derelict Control Room"
	icon_state = "bridge"

/area/derelict/secret
	name = "\improper Derelict Secret Room"
	icon_state = "library"

/area/derelict/bridge/access
	name = "Derelict Control Room Access"
	icon_state = "auxstorage"

/area/derelict/bridge/ai_upload
	name = "\improper Derelict Computer Core"
	icon_state = "ai"

/area/derelict/solar_control
	name = "\improper Derelict Solar Control"
	icon_state = "engine"

/area/derelict/crew_quarters
	name = "\improper Derelict Crew Quarters"
	icon_state = "fitness"

/area/derelict/medical
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/derelict/medical/morgue
	name = "\improper Derelict Morgue"
	icon_state = "morgue"

/area/derelict/medical/chapel
	name = "\improper Derelict Chapel"
	icon_state = "chapel"

/area/derelict/teleporter
	name = "\improper Derelict Teleporter"
	icon_state = "teleporter"

/area/derelict/eva
	name = "Derelict EVA Storage"
	icon_state = "eva"

/area/derelict/ship
	name = "\improper Abandoned Ship"
	icon_state = "yellow"

/area/solar/derelict_starboard
	name = "\improper Derelict Starboard Solar Array"
	icon_state = "panelsS"

/area/solar/derelict_aft
	name = "\improper Derelict Aft Solar Array"
	icon_state = "aft"

/area/derelict/singularity_engine
	name = "\improper Derelict Singularity Engine"
	icon_state = "engine"

//HALF-BUILT STATION (REPLACES DERELICT IN BAYCODE, ABOVE IS LEFT FOR DOWNSTREAM)

/area/shuttle/constructionsite
	name = "\improper Construction Site Shuttle"
	icon_state = "yellow"

/area/shuttle/constructionsite/station
	name = "\improper Construction Site Shuttle"

/area/shuttle/constructionsite/site
	name = "\improper Construction Site Shuttle"

/area/constructionsite
	name = "\improper Construction Site"
	icon_state = "storage"

/area/constructionsite/storage
	name = "\improper Construction Site Storage Area"

/area/constructionsite/science
	name = "\improper Construction Site Research"

/area/constructionsite/bridge
	name = "\improper Construction Site Bridge"
	icon_state = "bridge"

/area/constructionsite/maintenance
	name = "\improper Construction Site Maintenance"
	icon_state = "yellow"

/area/constructionsite/hallway/aft
	name = "\improper Construction Site Aft Hallway"
	icon_state = "hallP"

/area/constructionsite/hallway/fore
	name = "\improper Construction Site Fore Hallway"
	icon_state = "hallS"

/area/constructionsite/atmospherics
	name = "\improper Construction Site Atmospherics"
	icon_state = "green"

/area/constructionsite/medical
	name = "\improper Construction Site Medbay"
	icon_state = "medbay"

/area/constructionsite/ai
	name = "\improper Construction Computer Core"
	icon_state = "ai"

/area/constructionsite/engineering
	name = "\improper Construction Site Engine Bay"
	icon_state = "engine"

/area/solar/constructionsite
	name = "\improper Construction Site Solars"
	icon_state = "aft"

/area/constructionsite/teleporter
	name = "Construction Site Teleporter"
	icon_state = "yellow"


//area/constructionsite
//	name = "\improper Construction Site Shuttle"

//area/constructionsite
//	name = "\improper Construction Site Shuttle"


//Construction

/area/construction
	name = "\improper Engineering Construction Area"
	icon_state = "yellow"

/area/construction/supplyshuttle
	name = "\improper Supply Shuttle"
	icon_state = "yellow"

/area/construction/quarters
	name = "\improper Engineer's Quarters"
	icon_state = "yellow"

/area/construction/qmaint
	name = "Maintenance"
	icon_state = "yellow"

/area/construction/hallway
	name = "\improper Hallway"
	icon_state = "yellow"

/area/construction/solars
	name = "\improper Solar Panels"
	icon_state = "yellow"

/area/construction/solarscontrol
	name = "\improper Solar Panel Control"
	icon_state = "yellow"

/area/construction/Storage
	name = "Construction Site Storage"
	icon_state = "yellow"

//AI

/area/ai_monitored/storage/eva
	name = "EVA Storage"
	icon_state = "eva"

/area/ai_monitored/storage/secure
	name = "Secure Storage"
	icon_state = "storage"

/area/ai_monitored/storage/emergency
	name = "Emergency Storage"
	icon_state = "storage"

/area/turret_protected/ai_upload
	name = "\improper AI Upload Chamber"
	icon_state = "ai_upload"
	ambience = list('sound/ambience/ambimalf.ogg')

/area/turret_protected/ai_upload_foyer
	name = "AI Upload Access"
	icon_state = "ai_foyer"
	ambience = list('sound/ambience/ambimalf.ogg')

/area/turret_protected/ai_server_room
	name = "AI Server Room"
	icon_state = "ai_server"

/area/turret_protected/ai
	name = "\improper AI Chamber"
	icon_state = "ai_chamber"
	ambience = list('sound/ambience/ambimalf.ogg')

/area/turret_protected/ai_cyborg_station
	name = "\improper Cyborg Station"
	icon_state = "ai_cyborg"

/area/turret_protected/aisat
	name = "\improper AI Satellite"
	icon_state = "ai"

/area/turret_protected/aisat_interior
	name = "\improper AI Satellite"
	icon_state = "ai"

/area/turret_protected/AIsatextFP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextFS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextAS
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/AIsatextAP
	name = "\improper AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	lighting_use_dynamic = 0

/area/turret_protected/NewAIMain
	name = "\improper AI Main New"
	icon_state = "storage"



//Misc



/area/wreck/ai
	name = "\improper AI Chamber"
	icon_state = "ai"

/area/wreck/main
	name = "\improper Wreck"
	icon_state = "storage"

/area/wreck/engineering
	name = "\improper Power Room"
	icon_state = "engine"

/area/wreck/bridge
	name = "\improper Bridge"
	icon_state = "bridge"

/area/generic
	name = "Unknown"
	icon_state = "storage"



// Telecommunications Satellite
/area/tcommsat/
	ambience = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg')

/area/tcommsat/entrance
	name = "\improper Telecoms Teleporter"
	icon_state = "tcomsatentrance"

/area/tcommsat/chamber
	name = "\improper Telecoms Central Compartment"
	icon_state = "tcomsatcham"

/area/turret_protected/tcomsat
	name = "\improper Telecoms Satellite"
	icon_state = "tcomsatlob"
	ambience = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg')

/area/turret_protected/tcomfoyer
	name = "\improper Telecoms Foyer"
	icon_state = "tcomsatentrance"
	ambience = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg')

/area/turret_protected/tcomwest
	name = "\improper Telecommunications Satellite West Wing"
	icon_state = "tcomsatwest"
	ambience = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg')

/area/turret_protected/tcomeast
	name = "\improper Telecommunications Satellite East Wing"
	icon_state = "tcomsateast"
	ambience = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg')

/area/tcommsat/computer
	name = "\improper Telecoms Control Room"
	icon_state = "tcomsatcomp"

/area/tcommsat/lounge
	name = "\improper Telecommunications Satellite Lounge"
	icon_state = "tcomsatlounge"

/area/tcommsat/powercontrol
	name = "\improper Telecommunications Power Control"
	icon_state = "tcomsatwest"


// Away Missions
/area/awaymission
	name = "\improper Strange Location"
	icon_state = "away"

/area/awaymission/example
	name = "\improper Strange Station"
	icon_state = "away"

/area/awaymission/wwmines
	name = "\improper Wild West Mines"
	icon_state = "away1"
	luminosity = 1
	requires_power = 0

/area/awaymission/wwgov
	name = "\improper Wild West Mansion"
	icon_state = "away2"
	luminosity = 1
	requires_power = 0

/area/awaymission/wwrefine
	name = "\improper Wild West Refinery"
	icon_state = "away3"
	luminosity = 1
	requires_power = 0

/area/awaymission/wwvault
	name = "\improper Wild West Vault"
	icon_state = "away3"
	luminosity = 0

/area/awaymission/wwvaultdoors
	name = "\improper Wild West Vault Doors"  // this is to keep the vault area being entirely lit because of requires_power
	icon_state = "away2"
	requires_power = 0
	luminosity = 0

/area/awaymission/desert
	name = "Mars"
	icon_state = "away"

/area/awaymission/BMPship1
	name = "\improper Aft Block"
	icon_state = "away1"

/area/awaymission/BMPship2
	name = "\improper Midship Block"
	icon_state = "away2"

/area/awaymission/BMPship3
	name = "\improper Fore Block"
	icon_state = "away3"

/area/awaymission/spacebattle
	name = "\improper Space Battle"
	icon_state = "away"
	requires_power = 0

/area/awaymission/spacebattle/cruiser
	name = "\improper Nanotrasen Cruiser"

/area/awaymission/spacebattle/syndicate1
	name = "\improper Syndicate Assault Ship 1"

/area/awaymission/spacebattle/syndicate2
	name = "\improper Syndicate Assault Ship 2"

/area/awaymission/spacebattle/syndicate3
	name = "\improper Syndicate Assault Ship 3"

/area/awaymission/spacebattle/syndicate4
	name = "\improper Syndicate War Sphere 1"

/area/awaymission/spacebattle/syndicate5
	name = "\improper Syndicate War Sphere 2"

/area/awaymission/spacebattle/syndicate6
	name = "\improper Syndicate War Sphere 3"

/area/awaymission/spacebattle/syndicate7
	name = "\improper Syndicate Fighter"

/area/awaymission/spacebattle/secret
	name = "\improper Hidden Chamber"

/area/awaymission/listeningpost
	name = "\improper Listening Post"
	icon_state = "away"
	requires_power = 0

/area/awaymission/beach
	name = "Beach"
	icon_state = "null"
	luminosity = 1
	lighting_use_dynamic = 0
	requires_power = 0
	ambience = list()
	var/sound/mysound = null

	New()
		..()
		var/sound/S = new/sound()
		mysound = S
		S.file = 'sound/ambience/shore.ogg'
		S.repeat = 1
		S.wait = 0
		S.channel = 123
		S.volume = 100
		S.priority = 255
		S.status = SOUND_UPDATE
		process()

	Entered(atom/movable/Obj,atom/OldLoc)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_UPDATE
				Obj << mysound
		return

	Exited(atom/movable/Obj)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_PAUSED | SOUND_UPDATE
				Obj << mysound

	proc/process()
		set background = 1

		var/sound/S = null
		var/sound_delay = 0
		if(prob(25))
			S = sound(file=pick('sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag3.ogg'), volume=100)
			sound_delay = rand(0, 50)

		for(var/mob/living/carbon/human/H in src)
			if(H.s_tone > -55)
				H.s_tone--
				H.update_body()
			if(H.client)
				mysound.status = SOUND_UPDATE
				H << mysound
				if(S)
					spawn(sound_delay)
						H << S

		spawn(60) .()

/////////////////////////////////////////////////////////////////////
/*
 Lists of areas to be used with is_type_in_list.
 Used in gamemodes code at the moment. --rastaf0
*/

// CENTCOM
var/list/centcom_areas = list (
	/area/centcom,
	/area/shuttle/escape/centcom,
	/area/shuttle/escape_pod1/centcom,
	/area/shuttle/escape_pod2/centcom,
	/area/shuttle/escape_pod3/centcom,
	/area/shuttle/escape_pod5/centcom,
	/area/shuttle/transport1/centcom,
	/area/shuttle/administration/centcom,
	/area/shuttle/specops/centcom,
)

//SPACE STATION 13
var/list/the_station_areas = list (
	/area/shuttle/arrival,
	/area/shuttle/escape/station,
	/area/shuttle/escape_pod1/station,
	/area/shuttle/escape_pod2/station,
	/area/shuttle/escape_pod3/station,
	/area/shuttle/escape_pod5/station,
	/area/shuttle/mining/station,
	/area/shuttle/transport1/station,
	// /area/shuttle/transport2/station,
	/area/shuttle/prison/station,
	/area/shuttle/administration/station,
	/area/shuttle/specops/station,
	/area/maintenance,
	/area/hallway,
	/area/bridge,
	/area/crew_quarters,
	/area/holodeck,
	/area/mint,
	/area/library,
	/area/chapel,
	/area/lawoffice,
	/area/engineering,
	/area/solar,
	/area/assembly,
	/area/teleporter,
	/area/medical,
	/area/security,
	/area/quartermaster,
	/area/janitor,
	/area/hydroponics,
	/area/rnd,
	/area/storage,
	/area/construction,
	/area/ai_monitored/storage/eva, //do not try to simplify to "/area/ai_monitored" --rastaf0
	/area/ai_monitored/storage/secure,
	/area/ai_monitored/storage/emergency,
	/area/turret_protected/ai_upload, //do not try to simplify to "/area/turret_protected" --rastaf0
	/area/turret_protected/ai_upload_foyer,
	/area/turret_protected/ai,
)




/area/beach
	name = "Keelin's private beach"
	icon_state = "null"
	luminosity = 1
	lighting_use_dynamic = 0
	requires_power = 0
	var/sound/mysound = null

	New()
		..()
		var/sound/S = new/sound()
		mysound = S
		S.file = 'sound/ambience/shore.ogg'
		S.repeat = 1
		S.wait = 0
		S.channel = 123
		S.volume = 100
		S.priority = 255
		S.status = SOUND_UPDATE
		process()

	Entered(atom/movable/Obj,atom/OldLoc)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_UPDATE
				Obj << mysound
		return

	Exited(atom/movable/Obj)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_PAUSED | SOUND_UPDATE
				Obj << mysound

	proc/process()
		set background = 1

		var/sound/S = null
		var/sound_delay = 0
		if(prob(25))
			S = sound(file=pick('sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag3.ogg'), volume=100)
			sound_delay = rand(0, 50)

		for(var/mob/living/carbon/human/H in src)
//			if(H.s_tone > -55)	//ugh...nice/novel idea but please no.
//				H.s_tone--
//				H.update_body()
			if(H.client)
				mysound.status = SOUND_UPDATE
				H << mysound
				if(S)
					spawn(sound_delay)
						H << S

		spawn(60) .()

