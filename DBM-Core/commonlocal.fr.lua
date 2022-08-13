if GetLocale() ~= "frFR" then return end
if not DBM_COMMON_L then DBM_COMMON_L = {} end

local CL = DBM_COMMON_L

CL.NONE						= "Aucun"
CL.RANDOM					= "Aléatoire"
CL.UNKNOWN					= "inconnu"
CL.LEFT						= "Gauche"
CL.RIGHT					= "Droite"
CL.BACK						= "Derrière"
CL.MIDDLE					= "Milieu"
CL.FRONT					= "Devant"--"En face"?/In front
CL.INTERMISSION				= "Intermission"--No blizz global for this, and will probably be used in most end tier fights with intermission phases
CL.YOU						= "Vous"