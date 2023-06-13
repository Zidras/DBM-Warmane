if GetLocale() ~= "deDE" then return end
local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetMiscLocalization({
	YellPull	= "Meine Geduld ist am Ende. Ich werde mich eurer entledigen!",
	EmoteSpark	= "Ein Energiefunke bildet sich aus einem nahegelegenen Graben!",
	YellPhase2	= "Ich hatte gehofft, eure Leben schnell zu beenden, doch ihr zeigt euch... hartnäckiger als erwartet.",
	YellBreath	= "Solange ich atme, werdet ihr nicht obsiegen!",
	YellPhase3	= "Eure Wohltäter sind eingetroffen, doch sie kommen zu spät! Die hier gespeicherten Energien reichen aus, die Welt zehnmal zu zerstören. Was, denkt ihr, werden sie mit euch machen?",
	EmoteSurge	= "Die Augen von %s sind auf Euch fixiert!"
})
