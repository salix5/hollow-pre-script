--光波干渉
function c100278039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100278039,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,100278039)
	e2:SetCondition(c100278039.atkcon)
	e2:SetTarget(c100278039.atktg)
	e2:SetOperation(c100278039.atkop)
	c:RegisterEffect(e2)
end
function c100278039.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c100278039.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then 
		tc=Duel.GetAttackTarget()
	end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0xe5) and tc:IsRelateToBattle() and Duel.IsExistingMatchingCard(c100278039.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,tc,tc:GetCode())
end
function c100278039.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:IsOnField() end
	e:SetLabelObject(nil)
	Duel.SetTargetCard(tc)
end
function c100278039.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToBattle() and tc:IsControler(tp) and tc:IsFaceup() and tc:IsSetCard(0xe5) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
end