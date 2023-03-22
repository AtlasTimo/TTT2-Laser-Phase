AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local shootsound = Sound("laser_sound.ogg")

function SWEP:Initialize()
	self.laser = nil
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 10.0)

	local ow = self:GetOwner()

	self.AllowDrop = false

	ow:EmitSound(shootsound, 100, 100, 1)

	timer.Simple(1.25, function()

		if (not ow:IsValid()) then return end

		local pViewModel = ow:GetViewModel()
		if (not pViewModel:IsValid()) then return end

		local uAttachment = pViewModel:LookupAttachment("muzzle")
		if (uAttachment < 1) then return end

		local tAttachment = pViewModel:GetAttachment(uAttachment)
		if (tAttachment == nil) then return end

		self.muzzle = ents.Create("info_target")
		self.muzzle:SetKeyValue("targetname", tostring(self.muzzle))
		self.muzzle:SetPos(tAttachment.Pos + Vector(0, 0, 50))
		self.muzzle:Spawn()

		self.targ = ents.Create("info_target")
		self.targ:SetKeyValue("targetname", tostring(self.targ))
		self.targ:SetPos(tAttachment.Pos + Vector(0, 0, 50) + ow:GetAimVector() * LASER_PHASER.CVARS.laser_phaser_range)
		self.targ:Spawn()

		self.stuetzVektor = self.muzzle:GetPos()
		self.richtungsVektor = self.targ:GetPos() - self.muzzle:GetPos()

		self.laser = ents.Create("env_beam")
		self.laser:SetKeyValue("Radius", 0)
		self.laser:SetKeyValue("BoltWidth", 15)
		self.laser:SetKeyValue("LightningStart", tostring(self.muzzle))
		self.laser:SetKeyValue("LightningEnd", tostring(self.targ))
		self.laser:SetKeyValue("rendercolor", "0 255 255")
		self.laser:SetKeyValue("renderamt", "255")
		self.laser:SetKeyValue("damage", "0")
		self.laser:SetKeyValue("texture", "sprites/laserbeam.spr")
		self.laser:SetKeyValue("TextureScroll", "30")

		self.laser:Spawn()
		self.laser:Fire("StrikeOnce")
		self.laser:SetKeyValue("life", "2.3")
		self.muzzle:Fire("Kill", "", 2.3)
		self.targ:Fire("Kill", "", 2.3)
		self.laser:Fire("Kill", "", 2.3)
	end)

	timer.Simple(3.75, function()
		if (not IsValid(self)) then return end

		if (LASER_PHASER.CVARS.laser_phaser_overload_damage > 0) then
			local explode = ents.Create("env_explosion")
			explode:SetPos(ow:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", tostring(LASER_PHASER.CVARS.laser_phaser_overload_damage))
			explode:Fire("Explode", 0, 0)
		end

		ow:StripWeapon("weapon_laser_phaser")
	end)
end

function SWEP:Think()
	if (self.laser == nil) then return end

	local ow = self:GetOwner()

	for i, v in pairs(player.GetAll()) do

		if (v:GetName() == ow:GetName()) then continue end
		if (not v:Alive() and v:GetObserverMode() ~= OBS_MODE_NONE) then continue end

		local erg = self.richtungsVektor.x * (self.stuetzVektor.x - v:GetPos().x)
						+ self.richtungsVektor.y * (self.stuetzVektor.y - v:GetPos().y)
						+ self.richtungsVektor.z * (self.stuetzVektor.z - v:GetPos().z)

		local r = self.richtungsVektor.x * self.richtungsVektor.x + self.richtungsVektor.y * self.richtungsVektor.y + self.richtungsVektor.z * self.richtungsVektor.z

		erg = erg * -1

		local lambda = erg / r

		if (lambda > 1 or lambda < 0) then continue end

		local vektorLot = Vector(self.stuetzVektor + lambda * self.richtungsVektor)

		local vektorSpielerLot = v:GetPos() - vektorLot

		if (vektorSpielerLot:Length() < 100) then
			v:TakeDamage(300, self:GetOwner(), self)
		end
	end

	self.laser = nil

	self:NextThink(CurTime() + 1 / 5)
	return true
end

function SWEP:OnDrop()
	if (self.AllowDrop) then return end
	self:Remove()
end