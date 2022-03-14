--The God Of Obelisk (J)
--[[
	参数介绍：
	GetFlagEffect:"8888","20200010","2020001"为 效 果 名 ， 作 用 未 知 （ 8888，密 码 +0，密 码 ）
	"2020011":用 来 表 示 是 否 进 入 了 威 慑 模 式 + （ 前 缀 改 1 ） 
	”20200114“：用 来 表 示 是 否 通 过 使 用 技 能 来 获 得 对 陷 阱 卡 的 抗 性 （ + 4 ） 
]]--
function c2020001.initial_effect(c)

	local vekey = true
	--关闭后，神拳震撼波不再规则破坏
	c2020001.vekey2 = true
	
	c:SetUniqueOnField(1,1,10000000)

	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c2020001.ttcon)
	e1:SetOperation(c2020001.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c2020001.sumsetcon)
	c:RegisterEffect(e2)
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
	erace:SetValue(RACE_WARRIOR)
	--c:RegisterEffect(erace)

	local eflag=Effect.CreateEffect(c)
	eflag:SetType(EFFECT_TYPE_SINGLE)
	eflag:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	eflag:SetRange(LOCATION_MZONE)
	--eflag:SetCondition(c2020001.flagcon)
	eflag:SetCode(EFFECT_ADD_ATTRIBUTE)
	eflag:SetValue(c2020001.attval)
	--c:RegisterEffect(eflag)


--immue
	local e100=Effect.CreateEffect(c)
	e100:SetType(EFFECT_TYPE_SINGLE)
	e100:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e100:SetRange(LOCATION_MZONE)
	e100:SetCode(EFFECT_CANNOT_DISABLE)
	e100:SetValue(1)
	c:RegisterEffect(e100)
	local e0100 = e100:Clone()
	e0100:SetCode(EFFECT_CANNOT_DISEFFECT)
	c:RegisterEffect(e0100)
	local e101=e100:Clone()
	e101:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e101)
	local e102=e101:Clone()
	e102:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e102)
	local e103=e102:Clone()
	e103:SetRange(0xff)
	e103:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e103:SetValue(c2020001.recon)
	--c:RegisterEffect(e103)
	local e104=Effect.CreateEffect(c)
	e104:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e104:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e104:SetCode(EVENT_EQUIP)
	e104:SetRange(LOCATION_SZONE)
	e104:SetCondition(c2020001.eqspsucon)
	e104:SetOperation(c2020001.eqspsuop)
	--c:RegisterEffect(e104)

	local e105 = e100:Clone()
	e105:SetCode(EFFECT_CANNOT_INACTIVATE)
	c:RegisterEffect(e105)

----Can only be killed in battle,This Effect is used to Confirm its death
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e8:SetCode(EVENT_BATTLE_DESTROYED)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c2020001.bdiecon)
	e8:SetOperation(c2020001.dieop)
	c:RegisterEffect(e8)

	local e08 = Effect.CreateEffect(c)
	e08:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e08:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e08:SetCode(EVENT_RELEASE)
	e08:SetCondition(c2020001.rediecon)
	e08:SetOperation(c2020001.dieop)
	c:RegisterEffect(e08)

	local ke8=Effect.CreateEffect(c)
	ke8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ke8:SetCode(EVENT_BE_MATERIAL)
	ke8:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	ke8:SetCondition(c2020001.mdiecon)
	ke8:SetOperation(c2020001.dieop)
	c:RegisterEffect(ke8)

	--cost离场解除复活
	local ke1=Effect.CreateEffect(c)
	ke1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	ke1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ke1:SetCode(EVENT_LEAVE_FIELD)
	ke1:SetCondition(c2020001.ldiecon)
	ke1:SetOperation(c2020001.dieop)
	c:RegisterEffect(ke1)
	

	--不受陷阱效果以及魔法效果怪兽生效一回合
	local e82=Effect.CreateEffect(c)
	e82:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e82:SetCode(EVENT_CHAINING)
	e82:SetRange(LOCATION_MZONE)
	e82:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e82:SetCondition(c2020001.sdcon2)
	e82:SetOperation(c2020001.sdop2)
	c:RegisterEffect(e82)
	local e80=Effect.CreateEffect(c)
	e80:SetType(EFFECT_TYPE_SINGLE)
	e80:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e80:SetRange(LOCATION_MZONE)
	e80:SetCode(EFFECT_IMMUNE_EFFECT)
	e80:SetValue(c2020001.efilterr)
	c:RegisterEffect(e80)
	local e83=Effect.CreateEffect(c)
	e83:SetDescription(aux.Stringid(2020001,3))
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetRange(0xff)
	e83:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e83:SetCountLimit(1)
	e83:SetLabelObject(c)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	e83:SetCondition(c2020001.setcon)
	e83:SetOperation(c2020001.setop)
	c:RegisterEffect(e83)
	local xe83 = e83:Clone()
	xe83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_XMATERIAL)
	xe83:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xe83)

	local e110=Effect.CreateEffect(c)
	e110:SetType(EFFECT_TYPE_SINGLE)
	e110:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e110:SetRange(LOCATION_MZONE)
	e110:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	--e110:SetCondition(c2020001.realcon)
	e110:SetValue(1)
	c:RegisterEffect(e110)
	
	local echange=Effect.CreateEffect(c)
	echange:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	echange:SetDescription(aux.Stringid(2020001,2))
	echange:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	echange:SetCode(EVENT_FREE_CHAIN)
	echange:SetHintTiming(TIMING_BATTLE_PHASE)
	echange:SetRange(LOCATION_MZONE)
	echange:SetCountLimit(1)
	echange:SetCondition(c2020001.changecon)
	echange:SetTarget(c2020001.changetg)
	echange:SetOperation(c2020001.changeop)
	c:RegisterEffect(echange)

	local esummon=Effect.CreateEffect(c)
	esummon:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	esummon:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	esummon:SetCode(EVENT_SPSUMMON_SUCCESS)
	esummon:SetOperation(c2020001.selectop)
	esummon:SetLabelObject(echange)
	c:RegisterEffect(esummon)

	local espsummon=esummon:Clone()
	espsummon:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(espsummon)


	-----------------------------------------------------------
	--Guard Effect
	local e1g =  Effect.CreateEffect(c)
	e1g:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1g:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1g:SetDescription(aux.Stringid(2020001,8))
	e1g:SetCode(EVENT_CHAIN_ACTIVATING)
	e1g:SetRange(LOCATION_MZONE)
	e1g:SetCondition(c2020001.guardecon)
	e1g:SetOperation(c2020001.guardeop)
	c:RegisterEffect(e1g)
	--must atk this card
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetCode(EFFECT_MUST_ATTACK)
	ge1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	ge1:SetRange(LOCATION_MZONE)
	ge1:SetTargetRange(0,LOCATION_MZONE)
	ge1:SetCondition(c2020001.protectcon)
	c:RegisterEffect(ge1)
	local ge2=ge1:Clone()
	ge2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	ge2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	ge2:SetCondition(c2020001.protectcon)
	ge2:SetValue(c2020001.atklimit)
	c:RegisterEffect(ge2)
	local e3g = Effect.CreateEffect(c)
	e3g:SetDescription(aux.Stringid(2020001,10))
	e3g:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3g:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
	e3g:SetCode(EFFECT_DESTROY_REPLACE)
	e3g:SetTargetRange(LOCATION_MZONE,0)
	--e3g:SetCondition(c2020001.repcon)
	e3g:SetTarget(c2020001.reptg)
	e3g:SetValue(c2020001.desval)
	e3g:SetOperation(c2020001.repop)
	c:RegisterEffect(e3g)

	---------------------------------------------------------
	------解放------------------------------------
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetDescription(aux.Stringid(2020001,0))
	e10:SetCategory(CATEGORY_DESTROY)
	--e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetType(EFFECT_TYPE_QUICK_O)
	e10:SetCode(EVENT_FREE_CHAIN)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCountLimit(1,2020001)
	e10:SetCondition(c2020001.descon2)
	e10:SetCost(c2020001.descost)
	e10:SetTarget(c2020001.destg)
	e10:SetOperation(c2020001.desop)
	c:RegisterEffect(e10)
	
	--解放2只怪提升攻击为无限
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetDescription(aux.Stringid(2020001,1))
	e11:SetCategory(CATEGORY_ATKCHANGE)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetHintTiming(TIMING_BATTLE_PHASE+TIMING_DAMAGE_STEP)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1,2020001)
	e11:SetCondition(c2020001.descon2)
	e11:SetCost(c2020001.atkcost)
	e11:SetOperation(c2020001.atkop)
	c:RegisterEffect(e11)

	local ge11=Effect.CreateEffect(c)
	ge11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	ge11:SetDescription(aux.Stringid(2020001,6))
	ge11:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
	ge11:SetType(EFFECT_TYPE_QUICK_O)
	ge11:SetCode(EVENT_FREE_CHAIN)
	ge11:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	ge11:SetRange(LOCATION_MZONE)
	ge11:SetCountLimit(1,2020001)
	ge11:SetCondition(c2020001.descon2)
	ge11:SetCost(c2020001.onedescost)
	ge11:SetTarget(c2020001.onedestg)
	ge11:SetOperation(c2020001.onedesop)
	c:RegisterEffect(ge11)

	--half atk
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_SET_ATTACK_FINAL)
	e12:SetRange(LOCATION_MZONE)
	e12:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e12:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e12:SetCondition(c2020001.adcon)
	e12:SetTarget(c2020001.atktg)
	e12:SetValue(c2020001.atkval)
	c:RegisterEffect(e12)
	local e13=e12:Clone()
	e13:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e13:SetValue(c2020001.defval)
	c:RegisterEffect(e13)

	--actlimit
	local we2=Effect.CreateEffect(c)
	we2:SetType(EFFECT_TYPE_FIELD)
	we2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	we2:SetCode(EFFECT_CANNOT_ACTIVATE)
	we2:SetRange(LOCATION_MZONE)
	we2:SetTargetRange(0,1)
	we2:SetValue(1)
	we2:SetCondition(c2020001.actcon)
	c:RegisterEffect(we2)
	
	local we4=we2:Clone()
	--we4:SetType(EFFECT_TYPE_FIELD)
	we4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	we4:SetTargetRange(0,LOCATION_ONFIELD)
	we4:SetCode(EFFECT_DISABLE)
	--we4:SetCondition(c2020001.ttcon)
	--we4:SetValue(c2020001.actcon)
	we4:SetTarget(c2020001.distarget)
	c:RegisterEffect(we4)
	
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_IMMUNE_EFFECT)
   -- e14:SetCondition(c2020001.realcon)
	e14:SetValue(c2020001.immefilter)
	c:RegisterEffect(e14)

	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e17:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e17:SetRange(LOCATION_MZONE)
	e17:SetValue(c2020001.indct)
	--c:RegisterEffect(e17)

	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetValue(c2020001.notfilter)
	c:RegisterEffect(e15)

	if vekey then

	local h2=Effect.CreateEffect(c)
	h2:SetDescription(aux.Stringid(2020003,9))
	h2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	h2:SetRange(LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND)
	h2:SetCategory(CATEGORY_DRAW)
	h2:SetLabelObject(c)
	h2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	h2:SetCondition(c2020001.mecon)
	h2:SetOperation(c2020001.grop2)
	c:RegisterEffect(h2)
	local xh2 = h2:Clone()
	xh2:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	xh2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xh2)

	--negate
	local ve1=Effect.CreateEffect(c)
	ve1:SetCategory(CATEGORY_DISABLE)
	ve1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	ve1:SetType(EFFECT_TYPE_QUICK_O)
	ve1:SetCode(EVENT_CHAINING)
	ve1:SetDescription(aux.Stringid(2020003,1))
	ve1:SetRange(LOCATION_HAND)
	ve1:SetCondition(c2020001.vdcon)
	ve1:SetCost(c2020001.vdcost)
	ve1:SetTarget(c2020001.vdtg)
	ve1:SetOperation(c2020001.vdop)
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
	ve2:SetCondition(c2020001.vdcon2)
	ve2:SetCost(c2020001.vdcost)
	ve2:SetTarget(c2020001.pytg)
	ve2:SetOperation(c2020001.pyop)
	c:RegisterEffect(ve2)

	end
	
end

c2020001.Password = {}

function c2020001.Active(c)
	c2020001.Password[c] = true
end

function c2020001.Die(c)
	c2020001.Password[c] = false
end


function c2020001.IsActive(c)
	if c2020001.Password[c] then
		return true
	else
		return false
	end
end

function c2020001.IsActiveByEffect(e)
	if c2020001.Password[e:GetHandler()] then
		return true
	else
		return false
	end
end


function c2020001.NotActiveByEffect(e)
	return not c2020001.IsActiveByEffect(e)
end


function c2020001.eqspsucon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if(eg:GetCount()>0 and eg:IsContains(c))then
		return true
	else
		return false
	end
end


function c2020001.ttcon(e,c,minc)
	if c==nil then return true end
	--Debug.Message(minc)
	
	local mg = Duel.GetTributeGroup(c)
	local mc = mg:GetFirst()
	local tnum = 0
	while mc do
		tnum = tnum + c2020001.gettnum(mc)
		mc = mg:GetNext()
	end
	
	
	return minc<=3 and tnum>=3--and Duel.CheckTribute(c,3)
end


function c2020001.gettnum(c)
	if c:GetMaterialCount()>1 then
		 return math.min(3,c:GetMaterialCount())
	else
		 return 1
	end
end

function c2020001.checkmg(g)
	return g:CheckWithSumEqual(c2020001.gettnum,3,1,3)
end


function c2020001.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	--local g=Duel.SelectTribute(tp,c,3,3)
	local mg = Duel.GetTributeGroup(c)
	local g = mg:SelectSubGroup(tp,c2020001.checkmg,false,1,3)
	
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end

function c2020001.eqspsuop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Duel.MoveToField(c,c:GetOwner(),c:GetOwner(),LOCATION_MZONE,POS_FACEUP,true)
	local ext_p = e:GetLabel()
	c2020001.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
end

function c2020001.sumsetcon(e,c,minc) 
	if not c then return true end
	return false
end

function c2020001.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end

function c2020001.refiledcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c2020001.IsRealSummon(c) and c:IsPreviousPosition(POS_FACEUP) 
	and (c:IsReason(REASON_RULE) or
		c:IsReason(REASON_EFFECT) or
		((c:IsReason(REASON_MATERIAL) or c:IsReason(REASON_RELEASE) or c:IsReason(REASON_COST)) and c:GetReasonPlayer(e:GetHandler():GetControler())~=tp)
		) 
end

function c2020001.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
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
	e1:SetCondition(c2020001.retcon)
	e1:SetOperation(c2020001.retop)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,2020001,0,0,1);
end

function c2020001.retcon(e,tp,eg,ep,ev,re,r,rp)
	local count,extp = e:GetLabel()
	return not e:GetLabelObject():IsLocation(LOCATION_MZONE)
	and count<Duel.GetTurnCount()
end
function c2020001.retop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	local count,extp = e:GetLabel()
	if not c2020001.IsRealSummon(c) and c:IsLocation(LOCATION_SZONE) then
		
		--c2020001.tgop(e,tp,eg,ep,ev,re,r,rp,extp)
		return nil
	end
	if Duel.MoveToField(e:GetLabelObject(), tp, tp, LOCATION_MZONE,POS_FACEUP,true) then
		e:Reset();
		Duel.ResetFlagEffect(tp,2020001);
		c2020001.SelectStatus(e:GetHandler(),tp)
	end
	
end


function c2020001.efilterr(e,te)
	local c=e:GetHandler()
	  local tc=te:GetOwner() 
	if Duel.GetTurnCount()==c:GetTurnID() then return false end
	return tc~=e:GetOwner()
			 and (( te:GetType()==EFFECT_TYPE_FIELD or te:GetType()==EFFECT_TYPE_EQUIP)
			 and Duel.GetTurnCount()-tc:GetTurnID()>=1 )
			 --or (te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --(te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --and tc:GetFlagEffect(20200010)~=0 and tc:GetFlagEffectLabel(20200010)==c:GetFieldID()) )
end

function c2020001.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	return re:GetOwner()~=e:GetOwner()
	  and (tc:GetFlagEffect(20200010)==0 or (tc:GetFlagEffect(20200010)~=0 and tc:GetFlagEffectLabel(20200010)~=c:GetFieldID()))
end
function c2020001.sdop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	  --tc:RegisterFlagEffect(2020001,RESET_EVENT+0x1fe00000,0,1)
	  if re:IsHasProperty(EFFECT_FLAG_IGNORE_IMMUNE) and tc:GetFlagEffect(8888)==0 then tc:RegisterFlagEffect(8888,0,0,0) end
	local e83=Effect.CreateEffect(c)
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetRange(LOCATION_MZONE)
	e83:SetDescription(aux.Stringid(2020001,3))
	e83:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e83:SetCountLimit(1)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	  e83:SetLabelObject(re)
	e83:SetOperation(c2020001.setop2)
	--c:RegisterEffect(e83)
end

function c2020001.setop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	  local tc=te:GetHandler()
	  if tc:GetFlagEffect(8888)~=0 then return end
	  if tc:GetFlagEffect(2020001)==0 then return end
	tc:RegisterFlagEffect(20200010,RESET_EVENT+0x1fe00000,0,1)
	  tc:SetFlagEffectLabel(20200010,c:GetFieldID())
end

function c2020001.mdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	if rp == owner then
		Debug.Message("众所周知，神是用来当祭品的")
		return true
	end
end

function c2020001.ldiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	if r&REASON_COST > 0 and rp==owner  then
		Debug.Message("众所周知，神是用来当祭品的")
		return true
	end
end

function c2020001.dieop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if c2020001.IsRealSummon(c) then
		Debug.Message("The God Had Been Defeated.")
		c2020001.Die(c)
	end


end

function c2020001.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_MZONE) or c2020001.IsRealSummon(c)
end


function c2020001.setop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	local cp = c:GetOwner()
	if c:IsLocation(LOCATION_MZONE) then
		if not c2020001.IsRealSummon(c) then
			c2020001.tgop(e,c)
		else
			if c:GetControler() ~= cp then
				if Duel.MoveToField(c,cp,cp,LOCATION_MZONE,POS_FACEUP,true) then
					c2020001.SelectStatus(c,cp)
				else
					Duel.SendtoGrave(c,REASON_RULE)
				end
			end
			local g=Duel.GetMatchingGroup(nil,tp,0xff,0xff,c)
			local tc=g:GetFirst()
			while tc do
				if tc:GetOriginalCode()~=7373632 then 
					if tc:GetOriginalCode()~=c:GetOriginalCode() then --and tc:GetFlagEffect(8888)==0 then
						c:ResetEffect(tc:GetOriginalCode(),RESET_CARD) 
					end
				end
				tc=g:GetNext() 
			end
		end
	elseif c2020001.IsRealSummon(c) then
		 if Duel.MoveToField(c, cp, cp, LOCATION_MZONE,POS_FACEUP,true) then
			c2020001.SelectStatus(c,cp)
		end
	end
end


function c2020001.SetStatus(c,model)
	if(model==1)then 
		c:RegisterFlagEffect(2020011,0,0,1)
		c:SetHint(CHINT_CARD,62180201)
	else c:ResetFlagEffect(2020011)
		c:SetHint(CHINT_CARD,10000000)
	end
end

function c2020001.ChangeStatus(c)
	if(c:GetFlagEffect(2020011)<=0)then 
		c:RegisterFlagEffect(2020011,0,0,1)
		c:SetHint(CHINT_CARD,62180201)
	else c:ResetFlagEffect(2020011)
		c:SetHint(CHINT_CARD,10000000)
	end
end

function c2020001.SelectStatus(c,p)
	local info = Duel.SelectOption(p,aux.Stringid(2020001,4),aux.Stringid(2020001,5))
	c2020001.SetStatus(c,1-info)
end

function c2020001.selectop(e,tp,eg,ep,ev,re,r,rp)
	c2020001.SelectStatus(e:GetHandler(),tp)
	 e:GetLabelObject():UseCountLimit(tp,1)
	if(e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL))then
		c2020001.Active(e:GetHandler())
	end
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end

function c2020001.changetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if(chk==0)then
		return true
	end
	Duel.SetChainLimit(aux.FALSE)
end
function c2020001.changecon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp or (Duel.GetTurnPlayer()~=tp and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end

function c2020001.attval(e,c)
if not c:IsLocation(LOCATION_MZONE)then return end
if(c:GetFlagEffect(2020011)>0) then
	return ATTRIBUTE_EARTH
else
	return ATTRIBUTE_WATER
end
end

function c2020001.changeop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	c2020001.ChangeStatus(c)
end

function c2020001.flagcon(e)
	return e:GetHandler():GetFlagEffect(2020011)>0
end


------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
function c2020001.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,nil)--e:GetHandler()
	Duel.Release(g,REASON_COST)
end

function c2020001.filter(c,atk)
	return ((
		(c:IsPosition(POS_FACEUP_ATTACK) and c:GetAttack()<atk) 
		or (c:IsPosition(POS_FACEUP_DEFENSE) and c:GetDefense()<atk) 
		or c:IsFacedown())
	)
end

function c2020001.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	  local atk=c:GetAttack()
	--if chk==0 then return Duel.IsExistingMatchingCard(c2020001.filter,tp,0,LOCATION_MZONE,1,nil,atk) end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c2020001.filter,tp,0,LOCATION_MZONE,nil,atk)
	if(g:GetCount()>0) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	end
end

function c2020001.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	  local atk=c:GetAttack()
	local g=Duel.GetMatchingGroup(c2020001.filter,tp,0,LOCATION_MZONE,nil,atk)
	local sumdamage=0
	if(g:GetCount()>0) then
		local gc = g:GetFirst()
		while gc do
			if gc:IsAttackPos() and gc:GetAttack()<c:GetAttack() then
				sumdamage = sumdamage+math.abs((atk-gc:GetAttack()))
			end
			gc = g:GetNext()
		end
		
		
		--local tc = g:GetFirst()
	   if c2020001.vekey2 then
			Duel.Destroy(g,REASON_BATTLE+REASON_RULE)
		else
			Duel.Destroy(g,REASON_BATTLE)
		end
--[[
		while tc do
			if not tc:IsOnField() then
				Debug.Message(tc:GetCode().."++++")
				Debug.Message(tc:GetReason())
				Debug.Message(tc:GetReasonEffect()==e)
				Debug.Message(tc:GetReasonEffect():GetHandler():GetCode())
			end
			tc = g:GetNext()
		end
		]]--
	end
	if(Duel.GetTurnPlayer()~=tp ) then 
		sumdamage = sumdamage+c:GetAttack() 
	end
	if c:IsOnField() then
		Duel.Damage(1-tp,sumdamage, REASON_BATTLE)
	end
	if(Duel.GetTurnPlayer()==tp and c:IsLocation(LOCATION_MZONE)) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetDescription(e:GetDescription())
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	e:GetHandler():RegisterFlagEffect(20200014, RESET_EVENT+0x1fe00000+RESET_PHASE+PHASE_END,0,1)
end

function c2020001.descon(e,tp,eg,ep,ev,re,r,rp)
			local ph=Duel.GetCurrentPhase()
	return e:GetHandler():GetFlagEffect(2020011)<=0 and
(Duel.GetTurnPlayer()==tp or
(ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
)
end

function c2020001.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(2020011)<=0
end

function c2020001.atkcon(e,tp,eg,ep,ev,re,r,rp)
			local ph=Duel.GetCurrentPhase()
	return e:GetHandler():GetFlagEffect(2020011)<=0 and
--ph==PHASE_BATTLE
(ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end

function c2020001.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end

function c2020001.onedesfilter(c)
	return c:IsFaceup() and not c:IsDisabled()
end

function c2020001.onedescost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return Duel.CheckReleaseGroup(tp,nil,1,nil)
	end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end

function c2020001.onedestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2020001.onedesfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end

function c2020001.onedesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c2020001.onedesfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetCode(EFFECT_DISABLE)
			e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e3:SetTarget(c2020001.distg)
			e3:SetLabelObject(tc)
			e3:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e3,tp)
			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e4:SetCode(EVENT_CHAIN_SOLVING)
			e4:SetCondition(c2020001.discon)
			e4:SetOperation(c2020001.disop)
			e4:SetLabelObject(tc)
			e4:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e4,tp)
			local sg=Duel.GetMatchingGroup(c2020001.desmtfilter,tp,0,LOCATION_ONFIELD,nil)
			if #sg>0 and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
				and Duel.SelectYesNo(tp,aux.Stringid(2020001,7)) then
				Duel.Destroy(sg,REASON_EFFECT)
			end
		end
	end
	e:GetHandler():RegisterFlagEffect(20200014, RESET_EVENT+0x1fe00000+RESET_PHASE+PHASE_END,0,1)
end

function c2020001.desmtfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end

function c2020001.distg(e,c)
	local tc=e:GetLabelObject()
	
	return c:IsCode(tc:GetCode(),tc:GetOriginalCodeRule()) or c:IsOriginalCodeRule(tc:GetCode(),tc:GetOriginalCodeRule())
end

function c2020001.discon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local rc = re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and (rc:IsCode(tc:GetCode(),tc:GetOriginalCodeRule()) or rc:IsOriginalCodeRule(tc:GetCode(),tc:GetOriginalCodeRule()))
end
function c2020001.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end

function c2020001.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c2020001.atkinfval)--88888888
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c2020001.definfval)--88888888
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
	  --damage maximize
	  local e6=Effect.CreateEffect(c)
	  e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	  e6:SetRange(LOCATION_MZONE)
	  e6:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	  e6:SetCondition(c2020001.rdcon)
	  e6:SetOperation(c2020001.rdop)
	e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	  --c:RegisterEffect(e6)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(c2020001.efilter2)
	e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	--c:RegisterEffect(e5)
end

function c2020001.isbattleaboutfilter(c,mc)
	return (Duel.GetAttacker()==mc and Duel.GetAttackTarget()==c) or (Duel.GetAttacker()==c and Duel.GetAttackTarget()==mc) 
end

function c2020001.atkinfval(e,c)
	local mc = e:GetHandler()
	if mc==c then
	   return 1145141919
	else
		if mc:GetAttack()>0 and c2020001.isbattleaboutfilter(c,mc) then
			if c:GetAttack()>=mc:GetAttack() then
				return mc:GetAttack()
			else
				return 810
			end
		end
		return c:GetAttack()
	end
end

function c2020001.definfval(e,c)
	local mc = e:GetHandler()
	if c~=mc and  mc:GetAttack()>0 and c2020001.isbattleaboutfilter(c,mc) then
	   if c:IsDefenseAbove(mc:GetAttack()) then
		  return mc:GetAttack()
	   else
		  return 810
	   end
	else
		return c:GetDefense()
	end
end

function c2020001.efilter2(e,te)
	return te:IsHasCategory(CATEGORY_ATKCHANGE)
end

function c2020001.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler()==Duel.GetAttackTarget() or e:GetHandler()==Duel.GetAttacker())
	  and e:GetHandler():GetAttack()>=114514810 and Duel.GetLP(1-e:GetHandler():GetControler())>Duel.GetBattleDamage(1-e:GetHandler():GetControler())
end
function c2020001.rdop(e,tp,eg,ep,ev,re,r,rp)
	  local c=e:GetHandler()
	  local X=Duel.GetLP(1-e:GetHandler():GetControler())
	  local c=e:GetHandler()
	  local ttp=c:GetControler()
	  if e:GetHandler():GetAttack()>=114514810 and Duel.GetLP(1-ttp)>Duel.GetBattleDamage(1-ttp) then
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(X)
	e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e3,ttp) end
	c:RegisterFlagEffect(20200014, RESET_EVENT+0x1fe00000+RESET_PHASE+PHASE_END,0,1)
end

function c2020001.adcon(e)
	local c = e:GetHandler()
	return c:GetFlagEffect(2020011)>0
end

function c2020001.atktg(e,c)
	return c~=e:GetHandler()
end
function c2020001.atkval(e,c)
	local num = 0.5; 
	if(e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)) then
		--num = 0.7
	end
	return math.ceil(c:GetAttack()*num)
end
function c2020001.defval(e,c)
	local num = 0.5; 
	if(e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)) then
		--num = 0.7
	end
	return math.ceil(c:GetDefense()*num)
end

function c2020001.realcon(e)
	return c2020001.IsRealSummon(e:GetHandler())
end

function c2020001.immefilter(e,te)
	local c=e:GetHandler()
	  local tc=te:GetOwner()
	return te:IsActiveType(TYPE_TRAP) --and c:GetFlagEffect(20200014)>0
	--and (not c:IsSummonType(SUMMON_TYPE_SPECIAL) or c:GetFlagEffect(20200014)>0)
	-- and c:GetFlagEffect(2020011)<=0
end
function c2020001.notfilter(e,re,rp)
	return e:GetHandler():GetFlagEffect(2020011)>0 and c2020001.IsRealSummon(e:GetHandler()) --and rp~=e:GetHandlerPlayer()
end

function c2020001.actcon(e)
	return c2020001.adcon(e) and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end

function c2020001.distarget(e,c)
	return c2020001.adcon(e) and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end

function c2020001.indct(e,re,r,rp)
	if(e:GetHandler():GetFlagEffect(2020011)>0 or e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)) then return 0 end
	if bit.band(r,REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end

function c2020001.IsRealSummon(c)
	return c2020001.IsActive(c)
end

function c2020001.tgop(e,c,p,extp)
	if not c then c = e:GetOwner() end
	if not p then
		p = c:GetOwner()
	end
	local tgzone = c:GetPreviousLocation();
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

function c2020001.gaincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,2020001)<1
end

function c2020001.gaincost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_COST)
end

function c2020001.gaintg(e,tp,eg,ep,ev,re,r,rp,chk)
	local oe = e:GetLabelObject()
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	--Debug.Message("set p,d="..tp..(oe:GetLabel()+1))
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetChainLimit(aux.FALSE)
end

function c2020001.grop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	--Debug.Message("p,d="..p..d)
	Duel.Draw(p,d,REEASON_EFFECT)
end

function c2020001.mecon(e,tp)
	local c = e:GetLabelObject()
	return tp == c:GetOwner()
end


function c2020001.grop2(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	local op = c:GetOwner()
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	Duel.Draw(op,1,REASON_RULE)
	
	if c2020001.IsRealSummon(c) then
		c2020001.Die(c)
	end
end

function c2020001.protectcon(e)
	local c = e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) --and c:IsDefensePos()
end

function c2020001.mefilter(c,p)
	return c:IsControler(p)
end

function c2020001.guardecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Debug.Message("tp"..tp..",rp"..rp)
	if false or (tp~=rp and 
		c:IsSummonType(SUMMON_TYPE_SPECIAL)) then --and c:IsDefensePos()) then
		
		local cg = Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		--Debug.Message(cg:GetFirst():GetCode())
		if cg and cg:IsExists(c2020001.mefilter,1,c,tp) then
			--Debug.Message(Duel.CheckChainTarget(ev,c))
			return true
		end
		
	end
	return false
		
end

function c2020001.guardeop(e,tp,eg,ep,ev,re,r,rp)
	if true or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		 Duel.ChangeTargetCard(ev,Group.FromCards(e:GetHandler()))
	end
end

function c2020001.guardbcon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Debug.Message("tp"..tp..",rp"..rp)
	if false or (
		c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsDefensePos()) then
		
		local atker = Duel.GetAttacker()
		local atked = Duel.GetAttackTarget()
		if atker and atked and atker:GetControler()~=tp and atked~=c and atked:GetControler()==tp then
			return true
		end
		
	end
	return false
		
end

function c2020001.guardbop(e,tp,eg,ep,ev,re,r,rp)
	if true or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		local c=e:GetHandler()
		Duel.CalculateDamage(Duel.GetAttacker(),c,true)
		
	end
end

function c2020001.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) 
		and ((c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT)) and not c:IsReason(REASON_REPLACE)))
end

function c2020001.reptg(e,tp,eg,ep,ev,re,r,rp,chk)--
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c2020001.repfilter,1,c,tp) and
		c2020001.protectcon(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
	Duel.Hint(HINT_CARD,tp,c)
	return true
	
	--return c2020001.protectcon(e) not c:IsReason(REASON_REPLACE) and e:GetHandler()~=c--Duel.SelectEffectYesNo(tp,c,96)
end

function c2020001.desval(e,c)--e,re,r,rp
	--Duel.Destroy(e:GetHandler(),REASON_REPLACE+REASON_RULE)
	
   return c2020001.repfilter(c,e:GetHandlerPlayer())
end

function c2020001.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_RULE+REASON_EFFECT+REASON_REPLACE)
end


function c2020001.atklimit(e,c)
	return c==e:GetOwner()
end




-------------------------------------------------------




function c2020001.vdcon(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
		and ep~=tp and Duel.IsChainDisablable(ev)
end

function c2020001.vdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not re:GetHandler():IsDisabled() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end

function c2020001.vdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end

function c2020001.vdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end

function c2020001.rediecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	return rp==owner and c:IsPreviousLocation(LOCATION_MZONE)
end

function c2020001.bdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	return rp==1-owner and Duel.GetAttacker()
end

function c2020001.fusundofilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end

function c2020001.vecon(e,tp)
	return e:GetHandler():GetOwner()==tp
end

function c2020001.fusundotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c2020001.fusundofilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2020001.fusundofilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c2020001.fusundofilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c2020001.mgfilter(c,e,tp,fusc,mg)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
		and c:GetReason()&(REASON_FUSION+REASON_MATERIAL)==(REASON_FUSION+REASON_MATERIAL) and c:GetReasonCard()==fusc
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and fusc:CheckFusionMaterial(mg,c,PLAYER_NONE,true)
end
function c2020001.fusundoop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=tc:GetSummonType()
	if Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)~=0 and bit.band(sumtype,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and ct>0 and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c2020001.mgfilter),nil,e,tp,tc,mg)==ct
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.SelectYesNo(tp,aux.Stringid(95286165,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end


function c2020001.vdcon2(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
end

function c2020001.fudisfilter(c)
	return not c:IsDisabled() and c:IsFaceup() and c:IsOnField()
end

function c2020001.pytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2020001.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,LOCATION_ONFIELD)
end


function c2020001.pyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg = Duel.GetMatchingGroup(c2020001.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
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





















