--羽翼入魂
RoleTaskInfo49109 = {}
function RoleTaskInfo49109:GetTaskDailyInfo(uid, outvec)
	if outvec == nil then return end
	--taskid
	table.insert(outvec, 49109)

	--dayNum,dayDoneNum
	local level = s_getValue(SCENE_ENTRY_PLAYER,uid,VALUE_TYPE_LEVEL)
	if level >= 61 then
		table.insert(outvec, 5)

		local daydonenum = 0
		local days = s_getCurTime(TIME_ALLDAYS)
		local last = s_getVar(uid,116,33)
		local daydonenum = s_getVar(uid,116,34)
		if last ~= days then
			daydonenum = 0
		end
		table.insert(outvec, daydonenum)
	else
		table.insert(outvec, 0)
		table.insert(outvec, 0)
	end

	--weekNum
	table.insert(outvec, 0)
	--weekDoneNum
	table.insert(outvec, 0)
end