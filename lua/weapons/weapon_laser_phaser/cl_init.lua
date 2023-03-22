include("shared.lua")

local enemyMat = Material("laser_phaser/icon_mats/enemy.vmt")		--rot
local friendlyMat = Material("laser_phaser/icon_mats/friendly.vmt")	--grün
local neutralMat = Material("laser_phaser/icon_mats/neutral.vmt")	--pink
local defaultMat = Material("vgui/white")
local defCol = Color(255, 255, 255)
local lineColor = Color(0, 188, 217)

local WorldModel = ClientsideModel(SWEP.WorldModel)
WorldModel:SetSkin(1)
WorldModel:SetNoDraw(true)

function SWEP:DrawWorldModel()
	local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(7.8, -2, -4)
			local offsetAng = Angle(180, 92, -10)

			local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
end

function SWEP:DrawHUD()

	local ow = self:GetOwner()
	if (not ow:IsValid()) then return end

	local pViewModel = ow:GetViewModel()
	if (not pViewModel:IsValid()) then return end

	local uAttachment = pViewModel:LookupAttachment("muzzle")
	if (uAttachment < 1) then return end

	local tAttachment = pViewModel:GetAttachment(uAttachment)
	if (tAttachment == nil) then return end

	cam.Start3D()
	render.SetMaterial(defaultMat)
	render.DrawLine(tAttachment.Pos, tAttachment.Pos + ow:GetAimVector() * 500, lineColor, true)
	cam.End3D()

	for i, v in pairs(player.GetAll()) do
		if (v:Alive() and IsValid(v) and v ~= ow) then
			if (ow:IsLineOfSightClear(v)) then continue end

			local distanceVec = ow:GetPos() - v:GetPos()
			if (distanceVec:Length() > LASER_PHASER.CVARS.laser_phaser_sighting_range) then continue end

			cam.Start3D()

			if (LASER_PHASER.CVARS.laser_phaser_annonnymous) then
				render.SetMaterial(enemyMat)
			else
				if (v:GetSubRoleData().name ~= ow:GetSubRoleData().name) then
					if (v:GetSubRoleData().name ~= "none" and v:GetSubRoleData().name ~= "detective") then
						render.SetMaterial(neutralMat)
					else
						render.SetMaterial(enemyMat)
					end
				else
					render.SetMaterial(friendlyMat)
				end
			end

			local distance = v:GetPos() - ow:GetPos()
			render.DrawSprite(v:GetPos() + Vector(0, 0, 40), 40 + distance:Length() / 15, 40 + distance:Length() / 15, defCol)

			cam.End3D()
		end
	end
end

function SWEP:PrimaryAttack()

end