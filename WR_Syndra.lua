local menu = 1
class "Syndra"

function GetDistanceSqr(p1, p2)
  if not p1 then return math.huge end
  p2 = p2 or myHero
  local dx = p1.x - p2.x
  local dz = (p1.z or p1.y) - (p2.z or p2.y)
  return dx*dx + dz*dz
end

function GetDistance(p1, p2)
  p2 = p2 or myHero
  return math.sqrt(GetDistanceSqr(p1, p2))
end

function Teemo:__init()
	if menu ~= 1 then return end
	menu = 2
	self:LoadSpells()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
	PrintChat("One Two Three Fuck")
end

function Teemo:LoadSpells()
	Q = {range = myHero:GetSpellData(_Q).range, delay = myHero:GetSpellData(_Q).delay, speed = myHero:GetSpellData(_Q).speed, width = myHero:GetSpellData(_Q).width}
	W = {range = myHero:GetSpellData(_W).range, delay = myHero:GetSpellData(_W).delay, speed = myHero:GetSpellData(_W).speed, width = myHero:GetSpellData(_W).width}
	--E = {range = myHero:GetSpellData(_E).range, delay = myHero:GetSpellData(_E).delay, speed = myHero:GetSpellData(_E).speed, width = myHero:GetSpellData(_E).width}
	R = {range = 400, delay = myHero:GetSpellData(_R).delay, speed = myHero:GetSpellData(_R).speed, width = myHero:GetSpellData(_R).width}
	R.Range = 400
	LastR = 1000
end
local Icons = {
["SyndraIcon"] = "https://i.imgur.com/zbEoGYR.jpg",
["Q"] = "https://i.imgur.com/TGysBDH.jpg",
["W"] = "https://i.imgur.com/JY8EjPB.jpg",                --Icons
["E"] = "https://i.imgur.com/DsRnBlP.jpg",
["R"] = "https://i.imgur.com/7RjuSDd.jpg",
}

    function Syndra:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo"   , value = true})
        Menu.Q:MenuElement({id = "Pred" , name = "Prediction Mode", value = 1 , drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "Mana" , name = "Min Mana %"     , value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "AutoHarass", name = "Auto Harass"    , value = true})
        Menu.Q:MenuElement({id = "Harass"    , name = "Use on Harass"  , value = true})
        Menu.Q:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2 , drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %"     , value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS"  , name = "Use to KS"           , value = true})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})  
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo"   , value = true})
        Menu.W:MenuElement({id = "Pred" , name = "Prediction Mode", value = 1 , drop = {"Faster", "More Precise"}})
        Menu.W:MenuElement({id = "Mana" , name = "Min Mana %"     , value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "AutoHarass", name = "Auto Harass"    , value = true})
        Menu.W:MenuElement({id = "Harass"    , name = "Use on Harass"  , value = true})
        Menu.W:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2 , drop = {"Faster", "More Precise"}})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %"     , value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "KS"  , name = "Use to KS"           , value = true})
        Menu.W:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})                
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Pred" , name = "Prediction Mode", value = 1 , drop = {"Faster", "More Precise"}})
        Menu.E:MenuElement({id = "Mana" , name = "Min Mana %"  , value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass"    , name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "PredHarass" , name = "Prediction Mode", value = 1 , drop = {"Faster", "More Precise"}})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %"   , value = 15, min = 0, max = 100, step = 1})        
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS"  , name = "Use on KS"  , value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})     
        --R--        
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "KS", name = "Use on KS"      , value = true})         
        Menu.R:MenuElement({id = "Heroes", name = "Whitelist", type = MENU})
            Menu.R.Heroes:MenuElement({id = "Loading", name = "Loading Champions...", type = SPACE}) 
        --       
        Menu:MenuElement({name = " ", drop = {"Extra Features"}})
        --Q+E           
        Menu:MenuElement({id = "QE", name = "Q+E Settings", type = MENU})
        Menu.QE:MenuElement({id = "ComboQ"   , name = "Use on Combo" , value = true})
        Menu.QE:MenuElement({id = "HarassQ"  , name = "Use on Harass", value = true})
        Menu.QE:MenuElement({id = "Flee"     , name = "Use on Flee"  , value = true}) 
        Menu.QE:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
            Menu.QE.Interrupt:MenuElement({id = "Loading", name = "Loading Champions...", type = SPACE})
        Menu.QE:MenuElement({id = "Gapcloser", name = "Anti Gapcloser", type = MENU})
            Menu.QE.Gapcloser:MenuElement({id = "Loading", name = "Loading Champions...", type = SPACE})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local hero = args.unit
			local charName = args.charName
			Interrupter:AddToMenu(hero, Menu.QE.Interrupt)
			Menu.QE.Gapcloser:MenuElement({id = charName, name = charName, value = true})
			Menu.R.Heroes:MenuElement({id = charName, name = charName, value = true})
		end)
    end 

    function Syndra:OnTick() 
        if ShouldWait() then return end 
        --  
        self:ClearBalls()        
        self.enemies = GetEnemyHeroes(1200)
        self.target = GetTarget(1200, 0)
        self.mode = GetMode() 
        --               
        if myHero.isChanneling then return end        
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end        
        local executeMode = 
            self.mode == 1 and self:Combo()   or 
            self.mode == 2 and self:Harass()  or
            self.mode == 6 and self:Flee()      
    end

    function Syndra:OnWndMsg(msg, param)
        if param >= HK_Q and param <= HK_R then
            self:UpdateBalls()
        end
    end

    function Syndra:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then 
            args.Process = false
            return 
        end 
    end

    function Syndra:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then 
            args.Process = false 
            return
        end 
    end

    function Syndra:OnInterruptable(unit, spell)
        if ShouldWait() then return end         
        if Menu.QE.Interrupt[spell.name] and Menu.QE.Interrupt[spell.name]:Value() and IsValidTarget(enemy) and self.E:IsReady() then
            self:CastE(1, unit) 
        end        
    end   

    function Syndra:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)  
        if ShouldWait() or not (IsValidTarget(unit, self.Q.Range) and unit.team == TEAM_ENEMY ) then return end   
        if Menu.QE.Gapcloser[unit.charName] and Menu.QE.Gapcloser[unit.charName]:Value() and GetDistance(unitPosTo) <= self.QE.Range and IsFacing(unit, myHero) then --Gapcloser 
            self:CastE(1, unit)                   
        elseif Menu.Q.Auto:Value() and GetDistance(unitPosTo) <= self.Q.Range then 
            self.Q:CastToPred(unit, 2)                   
        end
    end 

    function Syndra:Auto()        
        if Menu.Q.Auto:Value() then
            for i=1, #self.enemies do
                local enemy = self.enemies[i]
                if GetDistance(enemy) <= self.Q.Range and IsImmobile(enemy, 0.5) then                             
                    self.Q:Cast(enemy)                   
                end   
            end 
        end 
        if Menu.Q.AutoHarass:Value() then
            self:Harass(true)
        end             
    end

    function Syndra:Combo()
        local target = self.target
        if not target then return end
        --
        if Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self:CastQ(target, Menu.Q.Pred:Value())
        end
        if Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            self:CastE(Menu.E.Pred:Value())
        end
        if Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
            self:CastW(target, Menu.W.Pred:Value())
        end
    end

    function Syndra:Harass(auto)
        local target = self.target
        if not target then return end
        --
        if Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            self:CastQ(target, Menu.Q.PredHarass:Value())
        end
        --
        if auto then return end
        if Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() then
            self:CastW(target, Menu.W.PredHarass:Value())
        end
        if Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self:CastE(Menu.E.PredHarass:Value())
        end
    end

    function Syndra:Flee()
        if not self.E:IsReady() then return end
        for i=1, #self.enemies do 
            local enemy = self.enemies[i]            
            if GetDistance(enemy) <= 900 and Menu.QE.Flee:Value() then
                self:CastE(1, enemy)
            elseif GetDistance(enemy) <= 400 and Menu.E.Flee:Value() then
                self.E:CastToPred(enemy, 1)
            end  
        end     
    end

    function Syndra:KillSteal(unit)
        for i=1, #self.enemies do
            local unit = self.enemies[i]
            if not IsValidTarget(unit) then return end
            --
            if self.Q:IsReady() and self.Q:CanCast(unit) and Menu.Q.KS:Value() then
                local damage = self.Q:CalcDamage(unit)
                if unit.health + unit.shieldAP < damage then
                    self:CastQ(unit, 1); return
                end
            end
            if self.W:IsReady() and self.W:CanCast(unit) and Menu.W.KS:Value() then
                local damage = self.W:CalcDamage(unit)
                if unit.health + unit.shieldAP < damage then
                    self:CastW(unit, 1); return
                end
            end
            if self.R:IsReady() and self.R:CanCast(unit) and Menu.R.KS:Value() and Menu.R.Heroes[unit.charName] and Menu.R.Heroes[unit.charName]:Value() then
                local damage = self.R:CalcDamage(unit, 2) 
                if unit.health + unit.shieldAP < damage then
                    self.R:Cast(unit); return
                end
            end
        end
    end

    function Syndra:OnDraw()     
        DrawSpells(self) 
    end

    function Syndra:UpdateBalls() 
        --       
        local qCd = myHero:GetSpellData(_Q).currentCd
        if qCd == 0 then
            self.OrbData.SearchParticles = true
        elseif qCd > 0 and self.OrbData.SearchParticles then
            self.OrbData.SearchParticles = false
            self.OrbData.Spawning = self:GetSpawningOrb()            
        end

        DelayAction(function()
            self.OrbData.Spawning = nil
            self:LoopOrbs()
        end, 0.75)

        --Update spells
        if self.R.Range ~= 750 and myHero:GetSpellData(_R).level >= 3 then
            self.R.Range = 750
        end
    end

    function Syndra:CastQ(target, hC)
        if self.Q:IsReady() and self.Q:CanCast(target) then
            self.Q:CastToPred(target, hC)
        end
    end

    function Syndra:CastW(target, hC)
        if self.W:IsReady() and self.W:CanCast(target) then
            local toggleState = myHero:GetSpellData(_W).toggleState
            if toggleState == 2 then
                self.W:CastToPred(target, hC)
            elseif toggleState == 1 then
                CastPosition = self:GrabObj()                
                if CastPosition then
                    self.W:Cast(CastPosition)
                end
            end
        end
    end

    function Syndra:CanHitQE(target, orbPos, castPos)
        if self.E:IsReady() and GetDistance(orbPos) <= self.E.Range then
            local startPos, endPos = orbPos:Extended(myHero.pos, 100), orbPos:Extended(myHero.pos, -(1050 - 0.6 * GetDistance(orbPos))) 
            DrawCircle(startPos)
            DrawCircle(endPos)           
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(startPos, endPos, castPos)
            return isOnSegment and GetDistance(pointLine, castPos) <= (self.QE.Radius + target.boundingRadius)                
        end        
    end

    function Syndra:CastE(hC, target)
        local enemy = target or GetTarget(1200, 1)
        if not (self.E:IsReady() and enemy) then return end 
        --    
        local unitPos, castPos, hitChance = self.QE:GetPrediction(enemy)
        if castPos and hitChance >= 1 then
            local pos = self.OrbData.PrePos
            if pos and self:CanHitQE(enemy, pos, castPos) then
                self.E:Cast(pos)
            else
                for i, orb in pairs(self.OrbData.Obj) do
                    if orb and not orb.dead and self:CanHitQE(enemy, orb.pos, castPos) then
                        self.E:Cast(orb.pos)
                        return
                    end
                end
                --[[In Case there are no orbs]]
                if self.Q:IsReady() then                    
                    local bestCast = myHero.pos:Extended(castPos, GetDistance(myHero, enemy)*0.6)
                    self.Q:Cast(bestCast) 
                    DelayAction(function() self.E:Cast(bestCast) end, 0.2)                
                end
            end
        end          
    end

    function Syndra:GrabObj()
        for i=1, #self.OrbData.Obj do
            local orb = self.OrbData.Obj[i]
            if orb and not orb.dead and GetDistance(orb) <= self.W.Range then
                return orb.pos
            end
        end

        local minions = GetEnemyMinions(self.W.Range)
        for i=1, #minions do
            local minion = minions[i]
            if minion and not minion.dead and GetDistance(minion) < self.W.Range then
                return minion.pos
            end
        end
    end

    function Syndra:ClearBalls()        
        for i=1, #self.OrbData.Obj do
            local orb = self.OrbData.Obj[i]
            if orb and orb.dead then
                remove(self.OrbData.Obj, i)
            end
        end
    end

    function Syndra:GetSpawningOrb()        
        for i = ParticleCount(), 1, -1 do
            local obj = Particle(i)
            if obj and obj.type == "obj_GeneralParticleEmitter" and obj.name:find("_aoe_gather.troy") then
                return obj.pos                
            end
        end
    end

    function Syndra:LoopOrbs()
        objectCount = ObjectCount()
        for i = ObjectCount(), 1, -1 do
            local obj = Object(i)
            if obj and not obj.dead and obj.name:lower() == "seed" then
                self.OrbData.Obj[#self.OrbData.Obj + 1] = obj                
            end
        end
    end

    table.insert(LoadCallbacks, function()
        Syndra()
    end)