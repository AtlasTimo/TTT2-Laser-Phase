SWEP.PrintName			= "Laser Phaser"
SWEP.Author				= "Atlas"
SWEP.Instructions		= "Equip to enable x-ray. Red are your enemies, Green are your friends and pink are neutrals or jesters.\nLeft click to shoot through walls."
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true

SWEP.HoldType 	= "ar2"
SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/c_laser_phaser/c_rifle.mdl"
SWEP.WorldModel = "models/w_laser_phaser/w_laser_phaser.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Icon 		= "VGUI/ttt/weapon_laser_phaser.png"

SWEP.Base 			= "weapon_tttbase"
SWEP.Kind 			= WEAPON_EQUIP2
SWEP.AutoSpawnable 	= false
SWEP.AmmoEnt 		= "item_ammo_ttt"

SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor 	= nil
SWEP.LimitedStock 	= true
SWEP.AllowDelete 	= false
SWEP.AllowDrop 		= true

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "Equip to enable x-ray. Red are your enemies, Green are your friends and pink are neutrals or jesters.\nLeft click to shoot through walls."
	};
end
