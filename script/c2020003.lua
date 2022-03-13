--The God Of Osiris (J)
--[[
	参数介绍：
	GetFlagEffect:"8888","20200030","2020003"为效果名，作用未知（8888，密码+0，密码）
	"2020013":用来表示是否进入了抹灭模式+（前缀改1）
]]--
function c2020003.initial_effect(c)
	c:SetUniqueOnField(1,1,10000020)
	local vekey = true
	--防内奸开关
	c2020003.vekey2 = true
	

	--解放3只祭品通召
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c2020003.ttcon)
	e1:SetOperation(c2020003.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCondition(c2020003.sumsetcon)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e2)
--[[

]]--
	
	--summon cannot disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	c:RegisterEffect(e4)
--race effect
	local erace=Effect.CreateEffect(c)
	erace:SetType(EFFECT_TYPE_SINGLE)
	erace:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	erace:SetCode(EFFECT_ADD_RACE)
	erace:SetValue(RACE_DRAGON)
	c:RegisterEffect(erace)
--immue
	local e100=Effect.CreateEffect(c)
	e100:SetType(EFFECT_TYPE_SINGLE)
	e100:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e100:SetRange(LOCATION_MZONE)
	e100:SetCode(EFFECT_CANNOT_DISABLE)
	e100:SetValue(1)
	c:RegisterEffect(e100)
	local e101=e100:Clone()
	e101:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e101)
	local e102=e101:Clone()
	e102:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e102)
	
	local e103=e102:Clone()
	e103:SetRange(0xff)
	e103:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e103:SetValue(c2020003.recon)
	--c:RegisterEffect(e103)
	--[[
	local e104=Effect.CreateEffect(c)
	e104:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e104:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e104:SetCode(EVENT_EQUIP)
	e104:SetRange(LOCATION_SZONE)
	e104:SetCondition(c2020003.eqspsucon)
	e104:SetOperation(c2020003.eqspsuop)
	c:RegisterEffect(e104)
	]]--

	local esummon=Effect.CreateEffect(c)
	esummon:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	esummon:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	esummon:SetCode(EVENT_SPSUMMON_SUCCESS)
	esummon:SetOperation(c2020003.selectop)
	--esummon:SetLabelObject(e104)
	c:RegisterEffect(esummon)

	local espsummon=esummon:Clone()
	espsummon:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(espsummon)

--[[
	--leave field return
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_LEAVE_FIELD)
	e8:SetCondition(c2020003.refiledcon)
	e8:SetOperation(c2020003.refiledop)
	c:RegisterEffect(e8)

	]]--

	
	
	--不受陷阱效果以及魔法效果怪兽生效一回合
	local e82=Effect.CreateEffect(c)
	e82:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e82:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e82:SetCode(EVENT_CHAINING)
	e82:SetRange(LOCATION_MZONE)
	--e82:SetCondition(c2020003.sdcon2)
	e82:SetOperation(c2020003.sdop2)
	c:RegisterEffect(e82)
	local e80=Effect.CreateEffect(c)
	e80:SetType(EFFECT_TYPE_SINGLE)
	e80:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e80:SetRange(LOCATION_MZONE)
	e80:SetCode(EFFECT_IMMUNE_EFFECT)
	e80:SetValue(c2020003.efilterr)
	c:RegisterEffect(e80)
	local e83=Effect.CreateEffect(c)
	e83:SetDescription(aux.Stringid(2020003,1))
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetRange(0xff)
	e83:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e83:SetCountLimit(1)
	e83:SetLabelObject(c)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	e83:SetCondition(c2020003.setcon)
	e83:SetOperation(c2020003.setop)
	c:RegisterEffect(e83)
	local xe83 = e83:Clone()
	xe83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_XMATERIAL)
	xe83:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xe83)

	local e14trap=Effect.CreateEffect(c)
	e14trap:SetType(EFFECT_TYPE_SINGLE)
	e14trap:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e14trap:SetRange(LOCATION_MZONE)
	e14trap:SetCode(EFFECT_IMMUNE_EFFECT)
	e14trap:SetValue(c2020003.immefilter)
	c:RegisterEffect(e14trap)

---------------------------------------------

	--Can only be killed in battle,This Effect is used to Confirm its death
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_BATTLE_DESTROYED)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c2020003.bdiecon)
	e8:SetOperation(c2020003.dieop)
	c:RegisterEffect(e8)
	--
	local e08 = Effect.CreateEffect(c)
	e08:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e08:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e08:SetCode(EVENT_RELEASE)
	e08:SetCondition(c2020003.rediecon)
	e08:SetOperation(c2020003.dieop)
	c:RegisterEffect(e08)

	--
	local ke8=Effect.CreateEffect(c)
	ke8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ke8:SetCode(EVENT_BE_MATERIAL)
	ke8:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	ke8:SetCondition(c2020003.mdiecon)
	ke8:SetOperation(c2020003.dieop)
	c:RegisterEffect(ke8)

	--两用，一者作为cost离场解除复活，二者作为正常模式下的离场抽卡
	local elf=Effect.CreateEffect(c)
	elf:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	elf:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	elf:SetCode(EVENT_LEAVE_FIELD)
	elf:SetCondition(c2020003.lfiledcon)
	elf:SetOperation(c2020003.lfiledop)
	c:RegisterEffect(elf)

	

------------------------------------------------------------------------------
--------------------------------------------unique effects------------------
-----------------------------------------------------------------------------------

	

	local echange=Effect.CreateEffect(c)
	echange:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	echange:SetDescription(aux.Stringid(2020003,0))
	echange:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	echange:SetCode(EVENT_FREE_CHAIN)
	--echange:SetHintTiming(TIMING_BATTLE_PHASE)
	echange:SetRange(LOCATION_MZONE)
	echange:SetCountLimit(1)
	echange:SetCondition(c2020003.changecon)
	echange:SetTarget(c2020003.changetg)
	echange:SetOperation(c2020003.changeop)
	c:RegisterEffect(echange)


	local eflag=Effect.CreateEffect(c)
	eflag:SetType(EFFECT_TYPE_SINGLE)
	eflag:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	eflag:SetRange(LOCATION_MZONE)
	--eflag:SetCondition(c2020003.flagcon)
	eflag:SetCode(EFFECT_ADD_ATTRIBUTE)
	eflag:SetValue(c2020003.attval)

	


-------------------------------------------------------------------------------------------


	


--atk and def change
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SET_BASE_ATTACK)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c2020003.adval)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e6)


	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_UNCOPYABLE)
	e10:SetDescription(aux.Stringid(2020003,5))
	e10:SetCategory(CATEGORY_ATKCHANGE)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCountLimit(60)
	e10:SetCode(EVENT_SUMMON_SUCCESS)
	e10:SetCondition(c2020003.atkcon)
	e10:SetTarget(c2020003.atktg)
	e10:SetOperation(c2020003.atkop)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e11)
	local e12=e11:Clone()
	e12:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e12)
	
	--下降对手怪兽防御、破坏
	local e13=Effect.CreateEffect(c)
	e13:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_UNCOPYABLE)
	e13:SetDescription(aux.Stringid(2020003,6))
	e13:SetCategory(CATEGORY_DEFCHANGE)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCountLimit(60)
	e13:SetCode(EVENT_SUMMON_SUCCESS)
	e13:SetCondition(c2020003.defcon)
	e13:SetTarget(c2020003.deftg)
	e13:SetOperation(c2020003.defop)
	c:RegisterEffect(e13)
	local e14=e13:Clone()
	e14:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e14)
	local e15=e13:Clone()
	e15:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e15)
	
	local e16=Effect.CreateEffect(c)
	e16:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e16:SetCategory(CATEGORY_TOGRAVE)
	e16:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e16:SetCode(EVENT_LEAVE_FIELD)
	e16:SetCondition(c2020003.descon)
	e16:SetTarget(c2020003.destg)
	e16:SetOperation(c2020003.desop)
	c:RegisterEffect(e16)

	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e17:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e17:SetRange(LOCATION_MZONE)
	e17:SetValue(c2020003.indct)
	--c:RegisterEffect(e17)

	local e110=Effect.CreateEffect(c)
	e110:SetType(EFFECT_TYPE_SINGLE)
	e110:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e110:SetRange(LOCATION_MZONE)
	e110:SetCondition(c2020003.normalimmcon)
	e110:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e110:SetValue(1)
	c:RegisterEffect(e110)
--[[
	local e111=e110:Clone()
	e111:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e111)
	local e112=e111:Clone()
	e112:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e112)
	local e113=e112:Clone()
	e113:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e113)
	local e114=e113:Clone()
	e114:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e114)
]]--

	--suicide
	local esuicide=Effect.CreateEffect(c)
	esuicide:SetDescription(aux.Stringid(57793869,1))
	esuicide:SetType(EFFECT_TYPE_IGNITION)
	esuicide:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_UNCOPYABLE)
	esuicide:SetCategory(CATEGORY_DESTROY)
	esuicide:SetRange(LOCATION_MZONE)
	esuicide:SetCondition(c2020003.flagcon)
	esuicide:SetTarget(c2020003.desselftg)
	esuicide:SetOperation(c2020003.desselfop)
	c:RegisterEffect(esuicide)
	
	
	 --Guard Effect
	local e1g =  Effect.CreateEffect(c)
	e1g:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1g:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1g:SetDescription(aux.Stringid(2020001,8))
	e1g:SetCode(EVENT_CHAIN_ACTIVATING)
	e1g:SetRange(LOCATION_MZONE)
	e1g:SetCondition(c2020003.guardecon)
	e1g:SetOperation(c2020003.guardeop)
	c:RegisterEffect(e1g)
	--must atk this card
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetCode(EFFECT_MUST_ATTACK)
	ge1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	ge1:SetRange(LOCATION_MZONE)
	ge1:SetTargetRange(0,LOCATION_MZONE)
	ge1:SetCondition(c2020003.protectcon)
	c:RegisterEffect(ge1)
	local ge2=ge1:Clone()
	ge2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	ge2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	ge2:SetCondition(c2020003.protectcon)
	ge2:SetValue(c2020003.atklimit)
	c:RegisterEffect(ge2)
	--[[
	local e2g = e1g:Clone()
	e2g:SetCode(EVENT_BATTLE_START)
	e2g:SetDescription(aux.Stringid(2020001,9))
	--e2g:SetTargetRange()
	e2g:SetCondition(c2020003.guardbcon)
	e2g:SetOperation(c2020003.guardbop)
	c:RegisterEffect(e2g)
]]
	local e3g = Effect.CreateEffect(c)
	e3g:SetDescription(aux.Stringid(2020001,10))
	e3g:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3g:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
	e3g:SetCode(EFFECT_DESTROY_REPLACE)
	e3g:SetTargetRange(LOCATION_MZONE,0)
	--e3g:SetCondition(c2020001.repcon)
	e3g:SetTarget(c2020003.reptg)
	e3g:SetValue(c2020003.desval)
	e3g:SetOperation(c2020003.repop)
	c:RegisterEffect(e3g)

	if vekey then

	local h2=Effect.CreateEffect(c)
	h2:SetDescription(aux.Stringid(2020003,9))
	h2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)--
	h2:SetRange(LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND)--+LOCATION_MZONE)
	h2:SetCategory(CATEGORY_DRAW)
	h2:SetLabelObject(c)
	h2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	h2:SetCondition(c2020003.mecon)
	--h2:SetCost(c2020003.testcost)
	--h2:SetTarget(c2020003.testtg)
	h2:SetOperation(c2020003.grop2)
	c:RegisterEffect(h2)
	local xh2 = h2:Clone()
	xh2:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	xh2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xh2)
	



	 --negate
	local ve1=Effect.CreateEffect(c)
	ve1:SetCategory(CATEGORY_DISABLE)
	ve1:SetDescription(aux.Stringid(2020003,1))
	ve1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	ve1:SetType(EFFECT_TYPE_QUICK_O)
	ve1:SetCode(EVENT_CHAINING)
	ve1:SetRange(LOCATION_HAND)
	ve1:SetCondition(c2020003.vdcon)
	ve1:SetCost(c2020003.vdcost)
	ve1:SetTarget(c2020003.vdtg)
	ve1:SetOperation(c2020003.vdop)
	c:RegisterEffect(ve1)

	--无限泡影
	local ve2=Effect.CreateEffect(c)
	ve2:SetCategory(CATEGORY_DISABLE)
	ve2:SetDescription(aux.Stringid(2020002,10))
	ve2:SetType(EFFECT_TYPE_QUICK_O)
	ve2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	ve2:SetCode(EVENT_FREE_CHAIN)
	ve2:SetRange(LOCATION_HAND)
	ve2:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	ve2:SetCondition(c2020003.vdcon2)
	ve2:SetCost(c2020003.vdcost)
	ve2:SetTarget(c2020003.pytg)
	ve2:SetOperation(c2020003.pyop)
	c:RegisterEffect(ve2)
		
	end
	
end
c2020003.vekey2 = true

c2020003.Password = {}

function c2020003.Active(c)
	c2020003.Password[c] = true
end

function c2020003.Die(c)
	c2020003.Password[c] = false
end

function c2020003.IsActive(c)
	if c2020003.Password[c] then
		return true
	else
		return false
	end
end

function c2020003.IsActiveByEffect(e)
	if c2020003.Password[e:GetHandler()] then
		return true
	else
		return false
	end
end

function c2020003.NotActiveByEffect(e)
	return not c2020003.IsActiveByEffect(e)
end


function c2020003.eqspsucon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if(eg:GetCount()>0 and eg:IsContains(c))then
		return true
	else
		return false
	end
end

function c2020003.eqspsuop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Duel.MoveToField(c,c:GetOwner(),c:GetOwner(),LOCATION_MZONE,POS_FACEUP,true)
	local ext_p = e:GetLabel()
	c2020003.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
end

function c2020003.equipdescon(e)
	local c = e:GetHandler()
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end

function c2020003.eqlimit(e,c)
	return false
end

function c2020003.immefilter(e,te)
	local c=e:GetHandler()
	  local tc=te:GetOwner()
	return te:IsActiveType(TYPE_TRAP)
	 --and c:GetFlagEffect(2020013)<=0
	--and (not c:IsSummonType(SUMMON_TYPE_SPECIAL))
end


function c2020003.ttcon(e,c,minc,a,b)
	if c==nil then return true end
	--Debug.Message(minc)
	
	local mg = Duel.GetTributeGroup(c)
	local mc = mg:GetFirst()
	local tnum = 0
	while mc do
		tnum = tnum + c2020003.gettnum(mc)
		mc = mg:GetNext()
	end
	
	
	return minc<=3 and tnum>=3--and Duel.CheckTribute(c,3)
end

function c2020003.gettnum(c)
	if c:GetMaterialCount()>1 then
		 return math.min(3,c:GetMaterialCount())
	else
		 return 1
	end
end

function c2020003.checkmg(g)
	return g:CheckWithSumEqual(c2020003.gettnum,3,1,3)
end

function c2020003.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	--local g=Duel.SelectTribute(tp,c,3,3)
	local mg = Duel.GetTributeGroup(c)
	local g = mg:SelectSubGroup(tp,c2020003.checkmg,false,1,3)
	
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c2020003.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c2020003.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end

function c2020003.sumsetcon(e,c,minc) 
	if not c then return true end
	return false
end
function c2020003.normalimmcon(e)
	local c=e:GetHandler()
	return true
	--[[
	if c:GetFlagEffect(2020013)>0 then return false end
	return not c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:GetTurnID()==Duel.GetTurnCount()
]]--
end
-------------------------------------------------
function c2020003.summonfilter(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
-------------------------------------------------
function c2020003.refiledcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c2020003.IsRealSummon(c) and c:IsPreviousPosition(POS_FACEUP) 
	and (c:IsReason(REASON_RULE) or
		c:IsReason(REASON_EFFECT) or
		((c:IsReason(REASON_MATERIAL) or c:IsReason(REASON_RELEASE) or c:IsReason(REASON_COST)) and c:GetReasonPlayer(e:GetHandler():GetControler())~=tp)
		) 
end



function c2020003.lfiledcon(e,tp,eg,ep,ev,re,r,rp)
	if r&REASON_COST > 0 and rp==e:GetOwner():GetOwner() then
		Debug.Message("众所周知，神是用来当祭品的")
		if c2020003.IsRealSummon(c) then
			Debug.Message("The God Had Been Defeated.")
			c2020003.Die(c)
		end
	end
	return e:GetHandler():GetFlagEffect(2020013)<=0 and Duel.GetTurnPlayer()~=tp
end

function c2020003.lfiledop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetDescription(aux.Stringid(2020003,4))
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	e1:SetCountLimit(1)
	e1:SetTarget(c2020003.ltg)
	e1:SetOperation(c2020003.lop)
	Duel.RegisterEffect(e1,tp)

end

function c2020003.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetDescription(aux.Stringid(2020011,0))
	if Duel.GetCurrentPhase()==PHASE_END then
		e1:SetLabel(Duel.GetTurnCount(),ext_p)
	else
		e1:SetLabel(Duel.GetTurnCount()-1,ext_p)
	end
	
	e1:SetLabelObject(c)
	e1:SetCountLimit(1)
	e1:SetCondition(c2020003.retcon)
	e1:SetOperation(c2020003.retop)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,2020003,0,0,1);

end

function c2020003.ltg(e,tp,eg,ep,ev,re,r,rp,chk)
	local x1,x2,x3 = Duel.GetActivityCount(1-tp,ACTIVITY_NORMALSUMMON,ACTIVITY_SPSUMMON,ACTIVITY_FLIPSUMMON)
	local xx=x1+x2+x3
	if chk==0 then
		
		return (not c2020003.vekey2) or (xx>0 and Duel.IsPlayerCanDraw(tp,xx))
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(xx)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,xx)
end

function c2020003.lop(e,tp,eg,ep,ev,re,r,rp)
	local x1,x2,x3 = Duel.GetActivityCount(1-tp,ACTIVITY_NORMALSUMMON,ACTIVITY_SPSUMMON,ACTIVITY_FLIPSUMMON)
	local xx=x1+x2+x3

	if(Duel.Draw(tp,xx,REASON_EFFECT)>0) then
		e:Reset()
	end
end

function c2020003.retcon(e,tp,eg,ep,ev,re,r,rp)
	local count,extp = e:GetLabel()
	return not e:GetLabelObject():IsLocation(LOCATION_MZONE)
	and count<Duel.GetTurnCount()
end
function c2020003.rediecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	return rp==owner and c:IsPreviousLocation(LOCATION_MZONE)
end


function c2020003.mdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	if rp == owner and c:IsPreviousLocation(LOCATION_MZONE) then
		Debug.Message("众所周知，神是用来当祭品的")
		return true
	end
end

function c2020003.dieop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if c2020003.IsRealSummon(c) then
		Debug.Message("The God Had Been Defeated.")
		c2020003.Die(c)
	end


end

function c2020003.efilterr(e,te)
	local c=e:GetHandler()
	  local tc=te:GetOwner()
	if Duel.GetTurnCount()==c:GetTurnID() then return false end
	return tc~=e:GetOwner()
			 and (( te:GetType()==EFFECT_TYPE_FIELD or te:GetType()==EFFECT_TYPE_EQUIP)
			 and Duel.GetTurnCount()-tc:GetTurnID()>=1 )
			-- or (te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --(te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --and tc:GetFlagEffect(20200030)~=0 and tc:GetFlagEffectLabel(20200030)==c:GetFieldID()) )
end

function c2020003.SetStatus(c,model)
	if(model==1)then 
		c:RegisterFlagEffect(2020013,0,0,1)
		c:SetHint(CHINT_CARD,57793869)
	else c:ResetFlagEffect(2020013)
		c:SetHint(CHINT_CARD,10000020)
	end
end

function c2020003.ChangeStatus(c)
	if(c:GetFlagEffect(2020013)<=0)then 
		c:RegisterFlagEffect(2020013,0,0,1)
		c:SetHint(CHINT_CARD,57793869)
	else c:ResetFlagEffect(2020013)
		c:SetHint(CHINT_CARD,10000020)
	end
end

function c2020003.SelectStatus(c,p)
	local info = Duel.SelectOption(p,aux.Stringid(2020003,2),aux.Stringid(2020003,3))
	c2020003.SetStatus(c,1-info)
	
end

function c2020003.selectop(e,tp,eg,ep,ev,re,r,rp)
	c2020003.SelectStatus(e:GetHandler(),tp)
	--e:GetLabelObject():SetLabel(e:GetHandler():GetPreviousLocation())
	if(e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL))then
		c2020003.Active(e:GetHandler())
	end
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end

function c2020003.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	return re:GetOwner()~=e:GetOwner()
	  and (tc:GetFlagEffect(20200030)==0 or (tc:GetFlagEffect(20200030)~=0 and tc:GetFlagEffectLabel(20200030)~=c:GetFieldID()))
end
function c2020003.sdop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	  --tc:RegisterFlagEffect(2020003,RESET_EVENT+0x1fe00000,0,1)
	  if re:IsHasProperty(EFFECT_FLAG_IGNORE_IMMUNE) and tc:GetFlagEffect(8888)==0 then tc:RegisterFlagEffect(8888,0,0,0) end
	local e83=Effect.CreateEffect(c)
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetDescription(aux.Stringid(2020003,1))
	e83:SetRange(LOCATION_MZONE)
	e83:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e83:SetCountLimit(1)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	  e83:SetLabelObject(re)
	e83:SetOperation(c2020003.setop2)
	--c:RegisterEffect(e83)
end

function c2020003.setop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	  local tc=te:GetHandler()
	  if tc:GetFlagEffect(8888)~=0 then return end
	  if tc:GetFlagEffect(2020003)==0 then return end
	tc:RegisterFlagEffect(20200030,RESET_EVENT+0x1fe00000,0,1)
	  tc:SetFlagEffectLabel(20200030,c:GetFieldID())
end

function c2020003.changecon(e,tp,eg,ep,ev,re,r,rp)
		local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp or (Duel.GetTurnPlayer()~=tp and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end

function c2020003.attval(e,c)
if not c:IsLocation(LOCATION_MZONE)then return end
if(c:GetFlagEffect(2020013)>0) then
	return ATTRIBUTE_DARK
else
	return ATTRIBUTE_WIND
end
end

function c2020003.changeop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	c2020003.ChangeStatus(c)
	Debug.Message(c:GetPreviousLocation())
end

function c2020003.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	return c:IsLocation(LOCATION_MZONE) or c2020003.IsRealSummon(c)
end

function c2020003.setop(e,tp,eg,ep,ev,re,r,rp)
	
	local c=e:GetLabelObject()
	local cp = c:GetOwner()
	if c:IsLocation(LOCATION_MZONE) then
		if not c2020003.IsRealSummon(c) then
			c2020003.tgop(e,c)
		else
			if c:GetControler() ~= cp then
				if Duel.MoveToField(c,cp,cp,LOCATION_MZONE,POS_FACEUP,true) then
					c2020003.SelectStatus(c,cp)
				else
					Duel.SendtoGrave(c,REASON_RULE)
				end
			end
			local g=Duel.GetMatchingGroup(nil,tp,0xff,0xff,c)
			local tc=g:GetFirst()
			while tc do
				if tc:GetOriginalCode()~=c:GetOriginalCode() and tc:GetFlagEffect(8888)==0 then
					c:ResetEffect(tc:GetOriginalCode(),RESET_CARD) 
				end
				tc=g:GetNext() 
			end
		end
	elseif c2020003.IsRealSummon(c) then
		 if Duel.MoveToField(c, cp, cp, LOCATION_MZONE,POS_FACEUP,true) then
			c2020003.SelectStatus(c,cp)
		end
	end
end

function c2020003.flagcon(e)
	return e:GetHandler():GetFlagEffect(2020013)>0
end

-----
-------------------------------------------------------------
--unique effect
--------------------------------------------------
---------------------------------------------------
function c2020003.adval(e,c)
	if c:GetFlagEffect(2020013)>0 then 
		return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD)*1000
	else
		return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*1000
	end
end
---------------------------------------------------
----------------------------------------------------
function c2020003.atkfilter(c,e,tp)
	return c:IsControler(tp) and c:IsPosition(POS_FACEUP_ATTACK) and (not e or c:IsRelateToEffect(e)) 
--and not c:IsRace(RACE_CREATORGOD)
end

function c2020003.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return eg:IsExists(c2020003.atkfilter,1,nil,nil,1-tp) and c:GetFlagEffect(2020013)<=0
end

function c2020003.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end--e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetCard(eg)
end

function c2020003.atkop(e,tp,eg,ep,ev,re,r,rp)
	--local g=eg:Filter(c2020709.atkfilter,nil,e,1-tp)
	  local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			--local preatk=tc:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-2000)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1) 
			if tc:GetAttack()==0 then 
				dg:AddCard(tc) 
			end 
			tc=g:GetNext()
		end
		Duel.Destroy(dg,REASON_EFFECT) 
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------
function c2020003.deffilter(c,e,tp)
	return c:IsControler(tp) and c:IsPosition(POS_FACEUP_DEFENSE) and (not e or c:IsRelateToEffect(e)) 
--and not c:IsRace(RACE_CREATORGOD)
end

function c2020003.defcon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return eg:IsExists(c2020003.deffilter,1,nil,nil,1-tp) and c:GetFlagEffect(2020013)<=0
end

function c2020003.deftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end


function c2020003.defop(e,tp,eg,ep,ev,re,r,rp)
	--local g=eg:Filter(c2020709.deffilter,nil,e,1-tp)
	  local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
		
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
			e1:SetValue(-2000)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			if tc:GetDefense()==0 then 
				dg:AddCard(tc) 
			end 
			tc=g:GetNext()
		end
		Duel.Destroy(dg,REASON_EFFECT) 
	end
end

function c2020003.descon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if c:GetFlagEffect(2020013)<=0 then return false end
	return true
end

function c2020003.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,dg,dg:GetCount(),0,0)
end
function c2020003.desop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoGrave(dg,REASON_EFFECT+REASON_RULE)
end

function c2020003.indct(e,re,r,rp)
	if(e:GetHandler():GetFlagEffect(2020013)>0 or e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)) then return 0 end
	if bit.band(r,REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end

function c2020003.desselftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c2020003.desselfop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_RULE)
end


function c2020003.changetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if(chk==0)then
		return true
	end
	Duel.SetChainLimit(aux.FALSE)
end
--error summon deal function

function c2020003.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetHandler():GetPreviousLocation()==LOCATION_GRAVE then
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0) 
	elseif e:GetHandler():GetPreviousLocation()==LOCATION_REMOVED then
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0) 
	elseif e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0) 
	elseif e:GetHandler():GetPreviousLocation()==LOCATION_DECK then
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0) end
end
function c2020003.IsRealSummon(c)
	return c2020003.IsActive(c)
end

function c2020003.tgop(e,c,p,extp)
	if not c then c = e:GetOwner() end
	if not p then
		p = c:GetOwner()
	end
	local tgzone = c:GetPreviousLocation()
	if extp~=nil then tgzone = extp end
	
	if c:IsFaceup() then
		if tgzone==LOCATION_GRAVE then
			Duel.SendtoGrave(c,REASON_RULE) 
		elseif tgzone==LOCATION_REMOVED then
			Duel.Remove(c,0,REASON_RULE) 
		elseif tgzone==LOCATION_HAND then
			Duel.SendtoHand(c,nil,REASON_RULE) 
		elseif tgzone==LOCATION_DECK then
			Duel.SendtoDeck(c,nil,2,REASON_RULE) 
		elseif tgzone==0 then
			Debug.Message(c:GetPreviousLocation())
			Duel.SendtoGrave(c,REASON_RULE)
		else
			Duel.MoveToField(c,p,c:GetPreviousControler(),c:GetPreviousLocation(),c:GetPreviousPosition(),true)
		end 
	end

	--e:Reset()
end
function c2020003.gaincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,2020003)<1
end

function c2020003.gaincost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_COST)
end

function c2020003.gaintg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	--Debug.Message("set p,d="..tp..(oe:GetLabel()+1))
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetChainLimit(aux.FALSE)
end

function c2020003.grop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	--Debug.Message("p,d="..p..d)
	Duel.Draw(p,d,REEASON_EFFECT)
end
function c2020003.testtg(e,tp,eg,ep,ev,re,r,rp,chk)
	Debug.Message("tg-"..chk..":"..tp)
	return true
end

function c2020003.testcost(e,tp,eg,ep,ev,re,r,rp,chk)
	
	Debug.Message("cost-"..chk..":"..tp)
	return true
end


function c2020003.grop2(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	local op = c:GetOwner()
	--Debug.Message(tp)
	--Debug.Message(c:GetOwner())
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	Duel.Draw(op,1,REASON_RULE)
	if c2020003.IsActive(c) then
		c2020003.Die(c)
	end
end


function c2020003.protectcon(e)
	local c = e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) --and c:IsDefensePos()
end

function c2020003.mefilter(c,p)
	return c:IsControler(p)
end

function c2020003.guardecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Debug.Message("tp"..tp..",rp"..rp)
	if false or (tp~=rp and 
		c:IsSummonType(SUMMON_TYPE_SPECIAL)) then --and c:IsDefensePos()) then
		
		local cg = Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		--Debug.Message(cg:GetFirst():GetCode())
		if cg and cg:IsExists(c2020003.mefilter,1,c,tp) then
			--Debug.Message(Duel.CheckChainTarget(ev,c))
			return true
		end
		
	end
	return false
		
end

function c2020003.guardeop(e,tp,eg,ep,ev,re,r,rp)
	if true or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		 Duel.ChangeTargetCard(ev,Group.FromCards(e:GetHandler()))
	end
end

function c2020003.guardbcon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Debug.Message("tp"..tp..",rp"..rp)
	if false or (
		c:IsSummonType(SUMMON_TYPE_SPECIAL)) then --and c:IsDefensePos()) then
		
		local atker = Duel.GetAttacker()
		local atked = Duel.GetAttackTarget()
		if atker and atked and atker:GetControler()~=tp and atked~=c and atked:GetControler()==tp then
			return true
		end
		
	end
	return false
		
end

function c2020003.guardbop(e,tp,eg,ep,ev,re,r,rp)
	if true or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		local c=e:GetHandler()
		Duel.CalculateDamage(Duel.GetAttacker(),c,true)
		
	end
end

function c2020003.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) 
		and ((c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT)) and not c:IsReason(REASON_REPLACE)))
end

function c2020003.reptg(e,tp,eg,ep,ev,re,r,rp,chk)--
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c2020003.repfilter,1,c,tp) and
		c2020003.protectcon(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
	Duel.Hint(HINT_CARD,tp,c)
	return true
	
	--return c2020001.protectcon(e) not c:IsReason(REASON_REPLACE) and e:GetHandler()~=c--Duel.SelectEffectYesNo(tp,c,96)
end

function c2020003.desval(e,c)--e,re,r,rp
	--Duel.Destroy(e:GetHandler(),REASON_REPLACE+REASON_RULE)
	
   return c2020003.repfilter(c,e:GetHandlerPlayer())
end

function c2020003.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_RULE+REASON_EFFECT+REASON_REPLACE)
end

---------------------------------------------------------------------------

function c2020003.vdcon(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
		and ep~=tp and Duel.IsChainDisablable(ev)
end




function c2020003.vdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not re:GetHandler():IsDisabled() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end

function c2020003.vdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end

function c2020003.vdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end


function c2020003.bdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	local atker = Duel.GetAttacker()
	return rp==1-owner and atker and c:IsPreviousLocation(LOCATION_MZONE)
end





function c2020003.fusundofilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end

function c2020003.vecon(e,tp)
	return e:GetHandler():GetOwner()==tp
end

function c2020003.fusundotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c2020003.fusundofilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2020003.fusundofilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c2020003.fusundofilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c2020003.mgfilter(c,e,tp,fusc,mg)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
		and c:GetReason()&(REASON_FUSION+REASON_MATERIAL)==(REASON_FUSION+REASON_MATERIAL) and c:GetReasonCard()==fusc
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and fusc:CheckFusionMaterial(mg,c,PLAYER_NONE,true)
end
function c2020003.fusundoop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=tc:GetSummonType()
	if Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)~=0 and bit.band(sumtype,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and ct>0 and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c2020003.mgfilter),nil,e,tp,tc,mg)==ct
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.SelectYesNo(tp,aux.Stringid(95286165,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c2020003.atklimit(e,c)
	return c==e:GetOwner()
end


function c2020003.mecon(e,tp)
	local c = e:GetLabelObject()
	
	return tp==c:GetOwner()
end


function c2020003.vdcon2(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
end

function c2020003.fudisfilter(c)
	return not c:IsDisabled() and c:IsFaceup() and c:IsOnField()
end

function c2020003.pytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2020003.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,LOCATION_ONFIELD)
end


function c2020003.pyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg = Duel.GetMatchingGroup(c2020003.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if tg:GetCount()<1 then return end
	local tc = tg:Select(tp,1,1,nil):GetFirst()
	if tc and not tc:IsDisabled() and not tc:IsImmuneToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end







