--The God Of Sun (J)
function c2020002.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_BRAINWASHING_CHECK)
	c:SetUniqueOnField(1,1,10000010)

	local vekey = true
   -- 强制破坏开关：开启后，翼神龙支付1000LP后进行的破坏行动无视抗性
	c2020002.vekey2 = false
	-- 祭品限制开关：开启后，翼神龙解放怪兽只能解放本回合没有进行过攻击宣言的怪兽
	c2020002.vekey3 = false

	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2020002,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c2020002.ttcon1)
	e1:SetOperation(c2020002.ttop1)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2020002,1))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e2:SetTargetRange(POS_FACEUP_ATTACK,1)
	e2:SetCondition(c2020002.ttcon2)
	e2:SetOperation(c2020002.ttop2)
	e2:SetValue(SUMMON_TYPE_ADVANCE)
	--c:RegisterEffect(e2) --forbid
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_LIMIT_SET_PROC)
	e3:SetCondition(c2020002.sumsetcon)
	c:RegisterEffect(e3)

--summon cannot disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	c:RegisterEffect(e5)
	
--Can only be killed in battle,This Effect is used to Confirm its death
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_BATTLE_DESTROYED)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c2020002.bdiecon)
	e8:SetOperation(c2020002.dieop)
	c:RegisterEffect(e8)

	local e08 = Effect.CreateEffect(c)
	e08:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e08:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e08:SetCode(EVENT_RELEASE)
	e08:SetCondition(c2020002.rediecon)
	e08:SetOperation(c2020002.dieop)
	c:RegisterEffect(e08)
	
	local ke8=Effect.CreateEffect(c)
	ke8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ke8:SetCode(EVENT_BE_MATERIAL)
	ke8:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	ke8:SetCondition(c2020002.mdiecon)
	ke8:SetOperation(c2020002.dieop)
	c:RegisterEffect(ke8)

	--cost离场解除复活
	local ke1=Effect.CreateEffect(c)
	ke1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	ke1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ke1:SetCode(EVENT_LEAVE_FIELD)
	ke1:SetCondition(c2020002.ldiecon)
	ke1:SetOperation(c2020002.dieop)
	c:RegisterEffect(ke1)


	--不受陷阱效果以及魔法效果怪兽生效一回合
	local e82=Effect.CreateEffect(c)
	e82:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e82:SetCode(EVENT_CHAINING)
	e82:SetRange(LOCATION_MZONE)
	e82:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e82:SetCondition(c2020002.sdcon2)
	e82:SetLabelObject(e8)
	e82:SetOperation(c2020002.sdop2)
	c:RegisterEffect(e82)
	local e80=Effect.CreateEffect(c)
	e80:SetType(EFFECT_TYPE_SINGLE)
	e80:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e80:SetRange(LOCATION_MZONE)
	e80:SetCode(EFFECT_IMMUNE_EFFECT)
	e80:SetValue(c2020002.efilterr)
	c:RegisterEffect(e80)
	local e83=Effect.CreateEffect(c)
	e83:SetDescription(aux.Stringid(2020002,8))
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetRange(0xff)
	e83:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DELAY)
	e83:SetCountLimit(1)
	e83:SetLabelObject(c)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	e83:SetCondition(c2020002.setcon)
	e83:SetOperation(c2020002.setop)
	c:RegisterEffect(e83)
	local xe83 = e83:Clone()
	xe83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_XMATERIAL)
	xe83:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xe83)

--enter origin STATUS

	   -- summon god
	local esummon = Effect.CreateEffect(c)
	esummon:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_UNCOPYABLE)
	esummon:SetDescription(aux.Stringid(2020002,3))
	esummon:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	esummon:SetCountLimit(1)
	esummon:SetRange(LOCATION_MZONE)
	esummon:SetTarget(c2020002.forbidchaintg)
	esummon:SetOperation(c2020002.godawakeop)
	c:RegisterEffect(esummon)

	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetLabelObject(esummon)
	e6:SetCondition(c2020002.enterorgincon)
	e6:SetOperation(c2020002.enterorginop)
	c:RegisterEffect(e6)

	local e7=e6:Clone()
	e7:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e7)

--origin Effect
	local e60 = Effect.CreateEffect(c)
	e60:SetType(EFFECT_TYPE_SINGLE)
	e60:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e60:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e60:SetRange(LOCATION_MZONE)
	e60:SetCondition(c2020002.notorgincon)
	e60:SetValue(aux.imval1)
	c:RegisterEffect(e60)

	local e61 = Effect.CreateEffect(c)
	e61:SetType(EFFECT_TYPE_SINGLE)
	e61:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e61:SetRange(LOCATION_MZONE)
	e61:SetCondition(c2020002.notorgincon)
	e61:SetCode(EFFECT_CANNOT_ATTACK)
	--e61:SetValue(1)
	c:RegisterEffect(e61)

	local e62 = e60:Clone()
	e62:SetCode(EFFECT_IMMUNE_EFFECT)
	e62:SetCondition(c2020002.immcon)
	e62:SetValue(c2020002.notselffilter)
	c:RegisterEffect(e62)
	
	local eo1=e60:Clone()
	eo1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(eo1)
	local eo2=e60:Clone()
	eo2:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(eo2)
	local eo3=e60:Clone()
	eo3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(eo3)
	local eo4 = e60:Clone()
	eo4:SetCode(EFFECT_UNRELEASABLE_SUM)
	c:RegisterEffect(eo4)
	local eo5 = e60:Clone()
	eo5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(eo5)
	local eo6=e60:Clone()
	eo6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(eo6)

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
	local e00100 = e100:Clone()
	e00100:SetCode(EFFECT_CANNOT_INACTIVATE)
	c:RegisterEffect(e00100)
	local e101=e100:Clone()
	e101:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e101:SetCondition(c2020002.controlcon)
	c:RegisterEffect(e101)
	local e102=e100:Clone()
	e102:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e102)
	
	

	local e104=Effect.CreateEffect(c)
	e104:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e104:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e104:SetCode(EVENT_EQUIP)
	e104:SetRange(LOCATION_SZONE)
	e104:SetCondition(c2020002.eqspsucon)
	e104:SetOperation(c2020002.eqspsuop)
	--c:RegisterEffect(e104)
	
	local tei=Effect.CreateEffect(c)
	tei:SetType(EFFECT_TYPE_SINGLE)
	tei:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	tei:SetRange(LOCATION_MZONE)
	tei:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	tei:SetValue(1)
	c:RegisterEffect(tei)

--
--[[
--fushion monster immue
	local e110=Effect.CreateEffect(c)
	e110:SetType(EFFECT_TYPE_SINGLE)
	e110:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e110:SetRange(LOCATION_MZONE)
	e110:SetCondition(c2020002.isspfusioncon)
	e110:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e110:SetValue(1)
	c:RegisterEffect(e110)
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
	local e115=e114:Clone()
	e115:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e115)
	local e116=e115:Clone()
	e116:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e116)
	local e117=e116:Clone()
	e117:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e117)
	local e118=e117:Clone()
	e118:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e118)
	local e119=e118:Clone()
	e119:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e119)
]]--

-------------------------------------------------
----------------------unique effect-----------
----------------------------------------------

--cost:1000Lp,destory monster
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetDescription(aux.Stringid(2020002,4))
	e11:SetCategory(CATEGORY_DESTROY)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCost(c2020002.descost)
	e11:SetTarget(c2020002.destg)
	e11:SetOperation(c2020002.desop)
	c:RegisterEffect(e11)


--atk and def
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_MATERIAL_CHECK)
	e10:SetValue(c2020002.valcheck)
	c:RegisterEffect(e10)
---otk
	local e12=Effect.CreateEffect(c)
	e12:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e12:SetDescription(aux.Stringid(2020002,5))
	e12:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP)
	e12:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e12:SetType(EFFECT_TYPE_QUICK_O)
	 e12:SetCode(EVENT_FREE_CHAIN)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCountLimit(1)
	e12:SetCost(c2020002.otkcost)
	e12:SetOperation(c2020002.otkop)
	c:RegisterEffect(e12)

--解放怪兽增加攻守
	local e13=Effect.CreateEffect(c)
	e13:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e13:SetDescription(aux.Stringid(2020002,6))
	e13:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e13:SetType(EFFECT_TYPE_QUICK_O)
	e13:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP)
	  e13:SetCode(EVENT_FREE_CHAIN)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCountLimit(10)
	e13:SetCost(c2020002.otkcost2)
	e13:SetOperation(c2020002.otkop2)
	c:RegisterEffect(e13)

--unfusion
	local e14=Effect.CreateEffect(c)
	e14:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e14:SetDescription(aux.Stringid(2020002,7))
	e14:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_RECOVER)
	e14:SetType(EFFECT_TYPE_QUICK_O)
	  e14:SetCode(EVENT_FREE_CHAIN)
	e14:SetRange(LOCATION_MZONE)
	e14:SetLabelObject(e12)
	e14:SetCost(c2020002.magiccost)
	e14:SetOperation(c2020002.magicop)
	c:RegisterEffect(e14)
--atkanddef
	local e15=Effect.CreateEffect(c)
	e15:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetCode(EFFECT_SET_BASE_ATTACK)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCondition(c2020002.wakecon)
	e15:SetValue(c2020002.atkva)
	c:RegisterEffect(e15)
	local e16 = e15:Clone()
	e16:SetCode(EFFECT_SET_BASE_DEFENSE)
	e16:SetValue(c2020002.defva)
	c:RegisterEffect(e16)


	--inactivatable
	local ie4=Effect.CreateEffect(c)
	ie4:SetType(EFFECT_TYPE_FIELD)
	ie4:SetCode(EFFECT_CANNOT_INACTIVATE)
	ie4:SetRange(0xff)
	ie4:SetValue(c2020002.effectfilter)
	ie4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(ie4)
	local ie5=Effect.CreateEffect(c)
	ie5:SetType(EFFECT_TYPE_FIELD)
	ie5:SetCode(EFFECT_CANNOT_DISEFFECT)
	ie5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ie5:SetRange(0xff)
	ie5:SetValue(c2020002.effectfilter)
	c:RegisterEffect(ie5)


	 --Guard Effect
	local e1g =  Effect.CreateEffect(c)
	e1g:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1g:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1g:SetDescription(aux.Stringid(2020001,8))
	e1g:SetCode(EVENT_CHAIN_ACTIVATING)
	e1g:SetRange(LOCATION_MZONE)
	e1g:SetCondition(c2020002.guardecon)
	e1g:SetOperation(c2020002.guardeop)
	c:RegisterEffect(e1g)
	--must atk this card
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetCode(EFFECT_MUST_ATTACK)
	ge1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	ge1:SetRange(LOCATION_MZONE)
	ge1:SetTargetRange(0,LOCATION_MZONE)
	ge1:SetCondition(c2020002.protectcon)
	c:RegisterEffect(ge1)
	local ge2=ge1:Clone()
	ge2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	ge2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	ge2:SetCondition(c2020002.protectcon)
	ge2:SetValue(c2020002.atklimit)
	c:RegisterEffect(ge2)
	local e3g = Effect.CreateEffect(c)
	e3g:SetDescription(aux.Stringid(2020001,10))
	e3g:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3g:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
	e3g:SetCode(EFFECT_DESTROY_REPLACE)
	e3g:SetTargetRange(LOCATION_MZONE,0)
	--e3g:SetCondition(c2020001.repcon)
	e3g:SetTarget(c2020002.reptg)
	e3g:SetValue(c2020002.desval)
	e3g:SetOperation(c2020002.repop)
	c:RegisterEffect(e3g)

	if vekey then
	
	local h2=Effect.CreateEffect(c)
	h2:SetDescription(aux.Stringid(2020003,9))
	h2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	h2:SetRange(LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND)
	h2:SetCategory(CATEGORY_DRAW)
	h2:SetLabelObject(c)
	h2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	h2:SetCondition(c2020002.gaincon)
	h2:SetOperation(c2020002.grop2)
	c:RegisterEffect(h2)
	local xh2 = h2:Clone()
	xh2:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	xh2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(xh2)

	 --negate
	local ve1=Effect.CreateEffect(c)
	ve1:SetCategory(CATEGORY_DISABLE)
	ve1:SetDescription(aux.Stringid(2020003,1))
	ve1:SetType(EFFECT_TYPE_QUICK_O)
	ve1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	ve1:SetCode(EVENT_CHAINING)
	ve1:SetRange(LOCATION_HAND)
	ve1:SetCondition(c2020002.vdcon)
	ve1:SetCost(c2020002.vdcost)
	ve1:SetTarget(c2020002.vdtg)
	ve1:SetOperation(c2020002.vdop)
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
	ve2:SetCondition(c2020002.vdcon2)
	ve2:SetCost(c2020002.vdcost)
	ve2:SetTarget(c2020002.pytg)
	ve2:SetOperation(c2020002.pyop)
	c:RegisterEffect(ve2)

	--visiable
	local ve3=Effect.CreateEffect(c)
	ve3:SetDescription(aux.Stringid(2020001,12))
	ve3:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	ve3:SetRange(LOCATION_MZONE)
	--ve3:SetCategory(CATEGORY_DRAW)
	ve3:SetLabelObject(c)
	ve3:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_UNCOPYABLE)
	ve3:SetCondition(c2020002.mecon2)
	ve3:SetOperation(c2020002.removemeop)
	c:RegisterEffect(ve3)
	local ve03 = ve3:Clone()
	ve03:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_IGNITION+EFFECT_TYPE_CONTINUOUS)
	ve03:SetRange(LOCATION_MZONE)
	c:RegisterEffect(ve03)

	end
	--Debug.Message(c:GetOwner())
	--c2020002.SetCardOwner(c,c:GetOwner())
end
c2020002.vekey2 = false
c2020002.vekey3 = false

c2020002.CardOwner = {}
c2020002.SpSummonPass = {}
c2020002.AttackValue = {}
c2020002.DefenseValue = {}

function c2020002.GetCardOwner(c)
	if not c2020002.CardOwner[c] then return c:GetOwner() end
	return c2020002.CardOwner[c]
end

function c2020002.SetCardOwner(c,p)
	c2020002.CardOwner[c] = p
end

function c2020002.GetValue(c,kind)
	if not c or Auxiliary.GetValueType(c) ~= "Card" then 
		Debug.Message("GetValue:The Type of Parm 'c' need is Card,but this is "..Auxiliary.GetValueType(v))
		return 0
	end
	if kind and kind == 2 then
		if c2020002.DefenseValue[c] then
			return c2020002.DefenseValue[c]
		else
			return 0
		end
	else
		if c2020002.AttackValue[c] then
			return c2020002.AttackValue[c]
		else
			return 0
		end
	end
end

function c2020002.AddValue(c,v,kind)
	if not c or Auxiliary.GetValueType(c) ~= "Card" then 
		Debug.Message("AddValue:The Type of Parm 'c' need is Card,but this is "..Auxiliary.GetValueType(v))
		return nil
	end
	if not v or Auxiliary.GetValueType(v) ~= "number" then 
		Debug.Message("The Type of Parm 'v' need is Card,but this is "..Auxiliary.GetValueType(v))
		return nil 
	end
	if kind and kind == 2 then
		c2020002.SetValue(c,c2020002.GetValue(c,2)+v,2)
	else
		c2020002.SetValue(c,c2020002.GetValue(c,1)+v)
	end  
end

function c2020002.SetValue(c,v,kind)
	if not c or Auxiliary.GetValueType(c) ~= "Card" then 
		Debug.Message("SetValue:The Type of Parm 'c' need is Card,but this is "..Auxiliary.GetValueType(v))
		return nil
	end
	if not v or Auxiliary.GetValueType(v) ~= "number" then 
		Debug.Message("The Type of Parm 'v' need is Card,but this is "..Auxiliary.GetValueType(v))
		return nil 
	end
	if kind and kind == 2 then
		c2020002.DefenseValue[c] = v
	else
		c2020002.AttackValue[c] = v
	end  
end

----------------------------------------------------------------------

function c2020002.atkva(e,c)
	return c2020002.GetValue(e:GetHandler())
end

function c2020002.defva(e,c)
	return c2020002.GetValue(e:GetHandler(),2)
end

function c2020002.wakecon(e)
	return e:GetHandler():GetFlagEffect(2020012)<=0
end

-------------------------------------------------------------------------

function c2020002.eqspsucon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	if(eg:GetCount()>0 and eg:IsContains(c))then
		return true
	else
		return false
	end
end

function c2020002.isNormalSummon(c)
	if(c==nil) then return false end
	--not c:IsSummonType(SUMMON_TYPE_SPECIAL)
	return c2020002.IsRealSummon(c)
end


function c2020002.ttcon1(e,c,minc)
	if c==nil then return true end
	local mg = Duel.GetTributeGroup(c)
	
	
	return minc<=3 and c2020002.checkmg(mg)--and Duel.CheckTribute(c,3)
end


function c2020002.gettnum(c)
	if c:GetMaterialCount()>1 then
		 return math.min(3,c:GetMaterialCount())
	else
		 return 1
	end
end

function c2020002.checkmg(g)
	--return g:CheckWithSumEqual(c2020002.gettnum,3,1,3)
	local mc = g:GetFirst()
	local tnum = 0
	while mc do
		tnum = tnum + c2020002.gettnum(mc)
		mc = g:GetNext()
	end
	return tnum>=3
end


function c2020002.ttop1(e,tp,eg,ep,ev,re,r,rp,c)
	--local g=Duel.SelectTribute(tp,c,3,3)
	local mg = Duel.GetTributeGroup(c)
	local g = mg:SelectSubGroup(tp,c2020002.checkmg,false,1,3)
	
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c2020002.ttcon2(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	return minc<=3 and Duel.CheckTribute(c,3,3,mg,1-tp)
end
function c2020002.ttop2(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local g=Duel.SelectTribute(tp,c,3,3,mg,1-tp)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c2020002.sumsetcon(e,c,minc)
	if not c then return true end
	return false
end


function c2020002.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end

function c2020002.enterorgincon(e,tp,eg,ep,ev,re,r,rp)
	return not (e:GetHandler():GetFlagEffect(2020012)>0)
end

function c2020002.enterorginop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	c:RegisterFlagEffect(2020012, 0,0,1)
	c:SetHint(CHINT_CARD,10000080)
	if re and (re:GetHandler():IsAttribute(ATTRIBUTE_DIVINE)  or re:GetHandler():IsCode(10000080)) then
		c2020002.SpSummonPass[c] = true
		c2020002.SetValue(c,c:GetAttack())
		c2020002.SetValue(c,c:GetDefense(),2)
		c:ResetEffect(10000080,RESET_CARD)
	end
	if c:IsSummonType(SUMMON_TYPE_NORMAL) then
		c2020002.SpSummonPass[c] = true
	end
	if(c2020002.IsRealSummon(c)) then
		local g=c:GetMaterial()
		local tc=g:GetFirst()
		local tatk=0
		local tdef=0
		while tc do
			local atk=tc:GetAttack()
			local def=tc:GetDefense()
			if atk<0 then atk=0 end
			if def<0 then def=0 end
			tatk=tatk+atk 
			tdef=tdef+def 
			tc=g:GetNext() 
		end
		c2020002.AddValue(c,tatk)
		c2020002.AddValue(c,tdef,2)
	end
	if Duel.SelectYesNo(tp,aux.Stringid(2020002,3)) then
		local esummon = e:GetLabelObject()
		esummon:UseCountLimit(tp)
		c2020002.godawakeop(e,tp,eg,ep,ev,re,r,rp) 
	end
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
	
end

function c2020002.notorgincon(e)
	return e:GetHandler():GetFlagEffect(2020012)>0
end

function c2020002.immcon(e)
	return e:GetHandler():GetFlagEffect(2020012)>0 or
	(e:GetHandler():IsRace(RACE_PYRO) and (e:GetHandler():IsRace(0x200)))
end

function c2020002.notselffilter(e,te)
	return e:GetOwner() ~= te:GetOwner()
end


function c2020002.retcon2(e,tp,eg,ep,ev,re,r,rp)

	return e:GetHandler():GetControler()==c2020002.GetCardOwner(e:GetOwner())
end

function c2020002.controlcon(e)
	return e:GetHandler():GetControler()==c2020002.GetCardOwner(e:GetOwner())
			and e:GetHandler():GetFlagEffect(2020012)<=0
end

function c2020002.isfusioncon(e)
	return e:GetHandler():IsType(TYPE_FUSION)
end

function c2020002.isspfusioncon(e)
	local c=e:GetHandler()
	return c2020002.isfusioncon(e) or c:GetFlagEffect(2020012)>0
end

function c2020002.refiledcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--if(c:GetFlagEffect(2020012))>0 then return false end
	--if(c:GetPreviousTypeOnField()&TYPE_FUSION)>0 then return false end
	--not c:IsSummonType(SUMMON_TYPE_SPECIAL)
	if e:GetLabel() == 114514 then
		e:SetLabel(1919810)
		return false
	end
	return c2020002.IsRealSummon(c) and c:IsPreviousPosition(POS_FACEUP)
	and (   c:IsReason(REASON_RULE) or
			c:IsReason(REASON_EFFECT) or
			(   
				(c:IsReason(REASON_MATERIAL) or c:IsReason(REASON_RELEASE) or c:IsReason(REASON_COST)) 
				and c:GetReasonPlayer(e:GetHandler():GetControler())~=tp
			)
		)
end

function c2020002.IsRealSummon(c)
	--return not c:IsSummonType(SUMMON_TYPE_SPECIAL) or c2020002.SpSummonPass[c]==true
	return c2020002.SpSummonPass[c]==true
end

function c2020002.Die(c)
	c2020002.SpSummonPass[c]=false
end

function c2020002.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
	local c=e:GetHandler()
	local patk = c:GetPreviousAttackOnField()
	local pdef = c:GetPreviousDefenseOnField()
	local turncount = Duel.GetTurnCount()-1
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetDescription(aux.Stringid(2020002,2))
	e1:SetLabelObject(c)
	if Duel.GetCurrentPhase()==PHASE_END then
	   turncount =  Duel.GetTurnCount()
	end
	e1:SetLabel(turncount,patk,pdef,ext_p)
   
	e1:SetCountLimit(1)
	e1:SetCondition(c2020002.retcon)
	e1:SetOperation(c2020002.retop)
	Duel.RegisterEffect(e1,c:GetPreviousControler())
	Duel.RegisterFlagEffect(c:GetPreviousControler(),2020002,0,0,1);
	--c:RegisterFlagEffect(20200021,0,0,1,)
	--c:RegisterFlagEffect(20200022,0,0,1,)
	--Card.GetPreviousAttackOnField
--Card.GetPreviousDenfenseOnField
	
end

function c2020002.retcon(e,tp,eg,ep,ev,re,r,rp)
	local turncount,patk,pdef = e:GetLabel()
	return not e:GetLabelObject():IsLocation(LOCATION_MZONE)
	and turncount<Duel.GetTurnCount()
end
--[[
function c2020002.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	local turncount,patk,pdef,extp = e:GetLabel()
	if not c2020002.IsRealSummon(c) and c:IsLocation(LOCATION_SZONE) then
		
		c2020002.tgop(e,tp,eg,ep,ev,re,r,rp,extp)
		return nil
	end
	local oconer = c2020002.GetCardOwner(c)
	local iss =  Duel.MoveToField(e:GetLabelObject(), tp, oconer, LOCATION_MZONE,POS_FACEUP,true) 
		c:RegisterFlagEffect(2020012,0,0,1)
		Duel.GetControl(c,tp)
		c:ResetFlagEffect(2020012)
		if iss then
			e:Reset()
			Duel.ResetFlagEffect(tp,2020002);
			c:SetHint(CHINT_CARD,10000010)
		end
		
end
]]---
---------------------------------------------------------------

function c2020002.valcheck(e,c)
	local g=c:GetMaterial()
	  local tc=g:GetFirst()
	  local tatk=0
	  local tdef=0
	  while tc do
	  local atk=tc:GetAttack()
	  local def=tc:GetDefense()
	  if atk<0 then atk=0 end
	  if def<0 then def=0 end
	  tatk=tatk+atk 
	  tdef=tdef+def 
	  tc=g:GetNext() end
	Original_ATK=tatk
	Original_DEF=tdef
end

function c2020002.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterialCount()==0 then return end
	
	c2020002.SetValue(c,Original_ATK)
	c2020002.SetValue(c,Original_DEF,2)
	
end
function c2020002.godawakeop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local num = Duel.AnnounceLevel(tp,nil,nil)
	local sum = Duel.GetLP(tp)+Duel.GetLP(1-tp)
	sum = sum +Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,LOCATION_DECK,nil)
	local sec = 0;
	while sum>0 do
		sec=sec+sum%10
		sum = sum//10
	end
	sec = sec%12
	if(sec==0) then sec=12 end
	if(sec==num) then 
		Duel.GetControl(c,tp)
		c2020002.SetCardOwner(c,tp)
		c:ResetFlagEffect(2020012) 
		c:SetHint(CHINT_CARD,10000010)
		--not c:IsSummonType(SUMMON_TYPE_SPECIAL)
		
	end
end
function c2020002.forbidchaintg(e,tp,eg,ep,ev,re,r,rp,chk)
	if(chk==0)then 
		if e:GetHandler():GetFlagEffect(2020012)>0  then
			--Debug.Message(c:GetPreviousAttackOnField())
			return true
		end
	end
	--Debug.Message(c:GetPreviousAttackOnField())
	Duel.SetChainLimit(aux.FALSE)
end

function c2020002.eqspsuop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Duel.MoveToField(c,c:GetOwner(),c:GetOwner(),LOCATION_MZONE,POS_FACEUP,true)
	local ext_p = e:GetLabel()
	c2020002.refiledop(e,tp,eg,ep,ev,re,r,rp,ext_p)
end

function c2020002.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(2020012)<=0 and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end

function c2020002.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_RACE)
	e1:SetValue(0x200)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	--e:GetHandler():RegisterEffect(e1)
	local e2 = e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	e:GetHandler():RegisterEffect(e2)
	local e3 = e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	e:GetHandler():RegisterEffect(e3)
	local e4 = e1:Clone()
	e4:SetDescription(aux.Stringid(2020002,2))
	e4:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c2020002.efilter)
	e:GetHandler():RegisterEffect(e4)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c2020002.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,0,12,nil)
	if g:GetCount()>0 then 
		local res = REASON_EFFECT 
		if c2020002.vekey2 then 
			res = res + REASON_RULE 
		end
		Duel.HintSelection(g)
		Duel.Destroy(g,res)
	end
   
end
function c2020002.eefilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end

function c2020002.otkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(2020012)<=0 and Duel.GetLP(tp)>1 end
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,1)
	e:SetLabel(lp-1)
end
function c2020002.otkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		--c:RegisterFlagEffect(2020002,RESET_EVENT+0x1ff0000,nil,1)
		
		c2020002.AddValue(c,e:GetLabel())
		c2020002.AddValue(c,e:GetLabel(),2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetDescription(aux.Stringid(2020002,5))
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetRange(LOCATION_MZONE)
		--e3:SetReset(RESET_EVENT+0x1ff0000-RESET_LEAVE)
		e3:SetCode(EFFECT_ADD_TYPE)
		
		e3:SetValue(TYPE_FUSION)
		c:RegisterEffect(e3)
		  local e4=Effect.CreateEffect(c)
		  e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		  e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		  e4:SetCode(EVENT_ADJUST)
		e4:SetRange(LOCATION_MZONE)
		  e4:SetOperation(c2020002.lpop)
		  --e4:SetReset(RESET_EVENT+0x1ff0000-RESET_LEAVE)
		  c:RegisterEffect(e4) 
		local e5=e4:Clone()
		e5:SetCode(EVENT_CHAIN_SOLVED)
		c:RegisterEffect(e5) 
		local e6=e5:Clone()
		  e6:SetOperation(c2020002.lpop2)
		c:RegisterEffect(e6) 
		e:SetLabelObject(e3)
		e3:SetLabelObject(e4)
		e4:SetLabelObject(e5)
		e5:SetLabelObject(e6)
		
		c:SetHint(CHINT_CARD,77432167)
	end
end

function c2020002.lpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ttp=c:GetControler()
	local lp=Duel.GetLP(ttp)
	if c:IsType(TYPE_FUSION) and lp>1 and c:GetFlagEffect(10000082)==0 then
		Duel.SetLP(ttp,1)  
		c2020002.AddValue(c,lp-1)
		c2020002.AddValue(c,lp-1,2)
	end 
end
function c2020002.lpop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	  local ttp=c:GetControler()
	if c:GetFlagEffect(10000082)~=0 then
			c:ResetFlagEffect(10000082)
	end 
end

function c2020002.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return not c2020002.IsRealSummon(e:GetHandler()) and e:GetHandler():IsType(TYPE_FUSION)
end


function c2020002.tgop(e,c,p,extp)
	if not c then c = e:GetOwner() end
	if not p then
		p = c:GetOwner()
	end
	local tgzone = c:GetPreviousLocation()
	if extp~=nil then tgzone = extp end
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
	c2020002.SetValue(c,0,1)
	c2020002.SetValue(c,0,2)
	if c2020002.IsRealSummon(c) then
		c2020002.Die(c)
	end
end

function c2020002.otkcost2filter(c)
	if c2020002.vekey3 then
		return c:GetAttackAnnouncedCount()<1
	else
		return true
	end
end

function c2020002.otkcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(2020012)<=0 and Duel.CheckReleaseGroup(tp,c2020002.otkcost2filter,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,c2020002.otkcost2filter,1,99,e:GetHandler())
	 local tc=g:GetFirst()
		local tatk=0
		local tdef=0
		while tc do
			local atk=tc:GetAttack()
			local def = tc:GetDefense()
			if atk<0 then atk=0 end
			if def<0 then def=0 end
			tatk=tatk+atk 
			tdef = tdef+def
			tc=g:GetNext() 
		end
	e:SetLabel(tatk,tdef)
	Duel.Release(g,REASON_COST)
end

function c2020002.otkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local tatk,tdef=e:GetLabel()
		
		 c2020002.AddValue(c,tatk)
		c2020002.AddValue(c,tdef,2)
	end
end
function c2020002.costfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c2020002.magiccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  e:GetHandler():IsType(TYPE_FUSION) and Duel.IsExistingMatchingCard(c2020002.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil)  end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2020002.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	e:SetLabel(Duel.SendtoGrave(g,REASON_COST))
end

function c2020002.magicop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	   local preatk = c:GetAttack()
		local predef = c:GetDefense()
	--[[
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_REMOVE_TYPE)
		e1:SetValue(TYPE_FUSION)
		e1:SetReset(RESET_EVENT+0x1ff0000-RESET_LEAVE)
		c:RegisterEffect(e1)
	]]
		local te = e:GetLabelObject()
		local resette = e:GetLabelObject()
		
		if resette then
			local elist = {}
			local i = 1
			local teste = resette:GetLabelObject()
			while teste do
				elist[i] = teste
				i = i+1
				teste = teste:GetLabelObject()
			end
			i=i-1
			while i>=1 do
				elist[i]:Reset()
				i=i-1
			end
		end
		
		c2020002.SetValue(c,0)
		c2020002.SetValue(c,0,2)
--[[
	local e3=Effect.CreateEffect(c)
	 e3:SetType(EFFECT_TYPE_SINGLE)
	 e3:SetCode(EFFECT_UPDATE_ATTACK)
	 e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	 e3:SetRange(LOCATION_MZONE)
	 e3:SetValue(-c:GetAttack())
	 e3:SetReset(RESET_EVENT+0x1fe0000-RESET_LEAVE)
	 c:RegisterEffect(e3)
	local e4 = e3:Clone()
	e4:SetValue(-c:GetDefense())
	c:RegisterEffect(e4)
]]
	local nowatk = c:GetAttack()
	local nowdef = c:GetDefense()
	c:SetHint(CHINT_CARD,10000010)
	local rev = math.max(0,math.max(preatk-nowatk,predef-nowdef))
	Duel.Recover(tp,rev,REASON_RULE)
end

function c2020002.efilterr(e,te)
	local c=e:GetHandler()
	  local tc=te:GetOwner()
	if te:IsActiveType(TYPE_TRAP) then return true end 
	if Duel.GetTurnCount()==c:GetTurnID() then return false end
	return tc~=e:GetOwner()
			 and (
				   ( te:GetType()==EFFECT_TYPE_FIELD or te:GetType()==EFFECT_TYPE_EQUIP)
				   and 
					Duel.GetTurnCount()-tc:GetTurnID()>=1 
				 )
			 --or (te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --(te:GetCode()==EFFECT_CANNOT_ATTACK or te:GetCode()==EFFECT_CANNOT_ATTACK_ANNOUNCE)
			 --and tc:GetFlagEffect(20200020)~=0 and tc:GetFlagEffectLabel(20200020)==c:GetFieldID()) )
end

function c2020002.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if(c:GetFlagEffect(2020012)>0) then return false end
	return re:GetOwner()~=e:GetOwner()
	  and (tc:GetFlagEffect(20200020)==0 or (tc:GetFlagEffect(20200020)~=0 and tc:GetFlagEffectLabel(20200020)~=c:GetFieldID()))
end
function c2020002.sdop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	  --tc:RegisterFlagEffect(2020002,RESET_EVENT+0x1fe00000,0,1)
	  if re:IsHasProperty(EFFECT_FLAG_IGNORE_IMMUNE) and tc:GetFlagEffect(8888)==0 then tc:RegisterFlagEffect(8888,0,0,0) end
	local e83=Effect.CreateEffect(c)
	e83:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e83:SetDescription(aux.Stringid(2020002,1))
	e83:SetRange(LOCATION_MZONE)
	e83:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e83:SetCountLimit(1)
	e83:SetCode(EVENT_PHASE+PHASE_END)
	  e83:SetLabelObject(re)
	e83:SetOperation(c2020002.setop2)
	--c:RegisterEffect(e83)
end

function c2020002.mdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	if rp == owner and c:IsPreviousLocation(LOCATION_MZONE) then
		Debug.Message("众所周知，神是用来当祭品的")
		return true
	end
end

function c2020002.ldiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c:GetOwner()
	if r&REASON_COST > 0 and rp==owner  then
		Debug.Message("众所周知，神是用来当祭品的")
		return true
	end
end


function c2020002.dieop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	c2020002.SetValue(c,0)
	c2020002.SetValue(c,0,2)
	if c2020002.IsRealSummon(c) then
		Debug.Message("The God Had Been Defeated.")
		c2020002.Die(c)
	end


end

function c2020002.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	return c:IsLocation(LOCATION_MZONE) or c2020002.IsRealSummon(c)
end



function c2020002.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	local cp=c2020002.GetCardOwner(c)
	if c:IsLocation(LOCATION_MZONE) then
		if c:IsSummonType(SUMMON_TYPE_SPECIAL) then
			if (not c2020002.IsRealSummon(c)) or Duel.SelectYesNo(cp,aux.Stringid(2020002,9))then
				--e:GetLabelObject():SetLabel(114514)
				c2020002.tgop(e,c,cp)
			end
		else
			if c:GetControler() ~= cp then
				if not Duel.MoveToField(c,cp,cp,LOCATION_MZONE,POS_FACEUP,true) then

					Duel.SendtoGrave(c,REASON_RULE)
				end
			end
			local g=Duel.GetMatchingGroup(nil,tp,0xff,0xff,c)
			local tc=g:GetFirst()
			while tc do
				if tc:GetOriginalCode()~=7373632 then 
					if tc:GetOriginalCode()~=c:GetOriginalCode() then--and tc:GetFlagEffect(8888)==0 then
						c:ResetEffect(tc:GetOriginalCode(),RESET_CARD) 
					end
				end
				tc=g:GetNext() 
			end
		end
	elseif c2020002.IsRealSummon(c) then
		 if Duel.MoveToField(c, cp, cp, LOCATION_MZONE,POS_FACEUP,true) then
		end
	end


	

end

function c2020002.setop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	  local tc=te:GetHandler()
	  if tc:GetFlagEffect(8888)~=0 then return end
	  if tc:GetFlagEffect(2020002)==0 then return end
	tc:RegisterFlagEffect(20200020,RESET_EVENT+0x1fe00000,0,1)
	  tc:SetFlagEffectLabel(20200020,c:GetFieldID())
end

function c2020002.changetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if(chk==0)then
		return true
	end
	Duel.SetChainLimit(aux.FALSE)
end
function c2020002.gaincon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	--Debug.Message(c2020002.GetCardOwner(c))
	return tp == c2020002.GetCardOwner(c) --and --Duel.GetFlagEffect(tp,2020002)<1
end
function c2020002.gaincost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_COST)
end

function c2020002.gaintg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	--Debug.Message("set p,d="..tp..(oe:GetLabel()+1))
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetChainLimit(aux.FALSE)
end

function c2020002.grop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	--Debug.Message("p,d="..p..d)
	Duel.Draw(p,d,REEASON_EFFECT)
end

function c2020002.grop2(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	local op = c:GetOwner()
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	Duel.Draw(op,1,REASON_RULE)
	c2020002.SetValue(c,0,1)
	c2020002.SetValue(c,0,2)
	if c2020002.IsRealSummon(c) then
		
		c2020002.Die(c)
	end
end


function c2020002.protectcon(e)
	local c = e:GetHandler()
	return not c2020002.IsRealSummon(c) and c:GetFlagEffect(2020012)<=0
end

function c2020002.mefilter(c,p)
	return c:IsControler(p)
end

function c2020002.guardecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	--Debug.Message("tp"..tp..",rp"..rp)
	if false or (tp~=rp and c2020002.protectcon(e)) then --c:IsDefensePos()) then
		
		local cg = Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		--Debug.Message(cg:GetFirst():GetCode())
		if cg and cg:IsExists(c2020002.mefilter,1,c,tp) then
			--Debug.Message(Duel.CheckChainTarget(ev,c))
			return true
		end
		
	end
	return false
		
end

function c2020002.guardeop(e,tp,eg,ep,ev,re,r,rp)
	if false or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		 Duel.ChangeTargetCard(ev,Group.FromCards(e:GetHandler()))
	end
end

function c2020002.guardbcon(e,tp,eg,ep,ev,re,r,rp)
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

function c2020002.guardbop(e,tp,eg,ep,ev,re,r,rp)
	if false or Duel.SelectYesNo(tp,aux.Stringid(2020001,9)) then
		Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
		Duel.Hint(HINT_CARD,tp,c)
		local c=e:GetHandler()
		Duel.CalculateDamage(Duel.GetAttacker(),c,true)
		
	end
end

function c2020002.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) 
		and ((c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT)) and not c:IsReason(REASON_REPLACE)))
end


function c2020002.atklimit(e,c)
	return c==e:GetOwner()
end


function c2020002.reptg(e,tp,eg,ep,ev,re,r,rp,chk)--
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c2020002.repfilter,1,c,tp) and
		c2020002.protectcon(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	Duel.Hint(HINT_MESSAGE,tp,e:GetDescription())
	Duel.Hint(HINT_CARD,tp,c)
	return Duel.SelectYesNo(tp,e:GetDescription())
	
	--return c2020001.protectcon(e) not c:IsReason(REASON_REPLACE) and e:GetHandler()~=c--Duel.SelectEffectYesNo(tp,c,96)
end

function c2020002.desval(e,c)--e,re,r,rp
	--Duel.Destroy(e:GetHandler(),REASON_REPLACE+REASON_RULE)
	
   return c2020002.repfilter(c,e:GetHandlerPlayer())
end

function c2020002.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_RULE+REASON_EFFECT+REASON_REPLACE)
end

function c2020002.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	return p==tp and te:GetHandler():IsOriginalCodeRule(10000080)
end


-------------------------------------------------------




function c2020002.vdcon(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
		and ep~=tp and Duel.IsChainDisablable(ev)
end

function c2020002.vdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not re:GetHandler():IsDisabled() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end

function c2020002.vdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end

function c2020002.vdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end

function c2020002.rediecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c2020002.GetCardOwner(c)
	return rp==owner and c:IsPreviousLocation(LOCATION_MZONE)
end


function c2020002.bdiecon(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local owner = c2020002.GetCardOwner(c)
	return rp==1-owner and Duel.GetAttacker() and c:IsPreviousLocation(LOCATION_MZONE) and r ~= REASON_EFFECT 
end


function c2020002.fusundofilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end


function c2020002.vecon(e,tp)
	return c2020002.GetCardOwner(e:GetHandler())==tp
end

function c2020002.fusundotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c2020002.fusundofilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2020002.fusundofilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c2020002.fusundofilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c2020002.mgfilter(c,e,tp,fusc,mg)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
		and c:GetReason()&(REASON_FUSION+REASON_MATERIAL)==(REASON_FUSION+REASON_MATERIAL) and c:GetReasonCard()==fusc
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and fusc:CheckFusionMaterial(mg,c,PLAYER_NONE,true)
end
function c2020002.fusundoop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=tc:GetSummonType()
	if Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)~=0 and bit.band(sumtype,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and ct>0 and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c2020002.mgfilter),nil,e,tp,tc,mg)==ct
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.SelectYesNo(tp,aux.Stringid(95286165,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end



function c2020002.vdcon2(e,tp,eg,ep,ev,re,r,rp)
	local omnum = Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local emnum = Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)
	return (omnum<=1 or omnum<emnum)
end

function c2020002.fudisfilter(c)
	return not c:IsDisabled() and c:IsFaceup() and c:IsOnField()
end

function c2020002.pytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2020002.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,LOCATION_ONFIELD)
end


function c2020002.pyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg = Duel.GetMatchingGroup(c2020002.fudisfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
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


function c2020002.mecon2(e,tp)
	local c = e:GetLabelObject()
	return c2020002.IsRealSummon(c) and tp == c:GetOwner() and (not c:IsLocation(LOCATION_MZONE) or c:GetFlagEffect(2020012)<=0)
end

function c2020002.removemeop(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetLabelObject()
	Duel.Remove(c,POS_FACEUP,REASON_RULE)
end
















































