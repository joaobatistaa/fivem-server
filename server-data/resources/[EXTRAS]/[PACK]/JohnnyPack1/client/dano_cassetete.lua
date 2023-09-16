Citizen.CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame(GetHashKey("WEAPON_NIGHTSTICK"), 0)
		Wait(0)
		SetWeaponDamageModifierThisFrame(GetHashKey("WEAPON_SNIPERRIFLE"), 1.5) -- Test (Apagar depois)
		Wait(0)
	end
end)