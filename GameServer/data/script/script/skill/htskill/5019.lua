--血战八方(攻击周围24个目标)
function OnUseSkill_5019(level,etype1,eid1,etype2,eid2,posx,posy)
	if 1 then return end
	if s_getValue(etype1,eid1,VALUE_TYPE_PROFESSION) ~= Profession_Soldier then
        s_debug("5019 err");
		return USE_SKILL_ERROR
	end

    local damage  = GetAttackValue(etype1,eid1);
	local percent = {1,1,1,1,1}
	local victim  = {}
    local num    = 0;
	--是否可PK
	if s_checkPK(5019,etype1,eid1,etype2,eid2) == VALUE_OK then
		local entry_x = s_getValue(etype2,eid2,VALUE_TYPE_POSX)
		local entry_y = s_getValue(etype2,eid2,VALUE_TYPE_POSY)
        local att_x   = s_getValue(etype1,eid1,VALUE_TYPE_POSX);
        local att_y   = s_getValue(etype1,eid1,VALUE_TYPE_POSY);
		local dst = math.sqrt((entry_x- att_x)^2 + (entry_y-att_y)^2)
        if dst < 3 then
			table.insert(victim,etype2)
			table.insert(victim,eid2)
			table.insert(victim, math.floor(damage * ( percent[level])))
			num = num+1
		end
	end
	--9屏取敌15个，根据距离循环判断是否在技能范围内，然后结算伤害和人数，最后根据人数是否达到技能上限来判断填出循环
	local list = s_getNineEntry(etype1,eid1,15)
	for i = 1,table.getn(list), 2 do
		if (list[i] ~= etype1 or list[i+1] ~= eid1)  then
			if(list[i] ~= etype2 or list[i+1] ~= eid2) then
					local entry_x = s_getValue(list[i],list[i+1],VALUE_TYPE_POSX)
					local entry_y = s_getValue(list[i],list[i+1],VALUE_TYPE_POSY)
                    local att_x   = s_getValue(etype1,eid1,VALUE_TYPE_POSX);
                    local att_y   = s_getValue(etype1,eid1,VALUE_TYPE_POSY);
					local dst = math.sqrt((entry_x- att_x)^2 + (entry_y-att_y)^2)
                    if dst < 3 then
                        if s_checkPK(5019,etype1,eid1,list[i],list[i+1]) == VALUE_OK then
                            table.insert(victim,list[i])
                            table.insert(victim,list[i+1])
                            table.insert(victim, math.floor(damage * (percent[level])))
                            num = num+1
                        end
                    end
                    if num == 24 then
                        break
                    end
			end
		end
	end
    MagicAttack(5019,VALUE_TYPE_PDAM,etype1,eid1,unpack(victim))

	if etype1 == SCENE_ENTRY_PLAYER then
		s_addValue(etype1,eid1,VALUE_TYPE_SKILL_5019,1)
	end
end
