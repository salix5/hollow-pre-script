--魔鍵憑霊-ウェパルトゥ
--scripted by XyLeN
function c101106047.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101106047,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCost(c101106047.thcost)
	e1:SetCondition(c101106047.thcon)
	e1:SetTarget(c101106047.thtg)
	e1:SetOperation(c101106047.thop)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101106047,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCondition(c101106047.rmcon)
	e2:SetCost(c101106047.rmcost)
	e2:SetTarget(c101106047.rmtg)
	e2:SetOperation(c101106047.rmop)
	c:RegisterEffect(e2)
end
function c101106047.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) 
end
function c101106047.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c101106047.thfilter(c)
	return c:IsLevelAbove(4) and c:IsType(TYPE_NORMAL) and c:IsAbleToHand()
end
function c101106047.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101106047.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c101106047.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c101106047.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c101106047.attrchkfilter(c,attr) 
	return c:IsAttribute(attr) and (c:IsType(TYPE_NORMAL) or c:IsSetCard(0x165))
end
function c101106047.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if tc==c then tc=Duel.GetAttacker() end
	e:SetLabelObject(tc)
	return tc~=nil and c:GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_NORMAL)
		and Duel.IsExistingMatchingCard(c101106047.attrchkfilter,tp,LOCATION_GRAVE,0,1,nil,tc:GetAttribute())
end
function c101106047.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c101106047.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetLabelObject(),1,0,0)
end
function c101106047.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
