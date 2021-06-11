--魔鍵關争
--scripted by XyLeN
function c101106062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c101106062.target)
	e1:SetOperation(c101106062.activate)
	c:RegisterEffect(e1)
end
function c101106062.filter(c)
	return (c:IsType(TYPE_NORMAL) or c:IsType(TYPE_MONSTER) and c:IsSetCard(0x165) or c:IsCode(99426088)) and c:IsAbleToDeck()
end
function c101106062.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c101106062.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c101106062.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c101106062.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c101106062.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local ch=Duel.GetCurrentChain(true)-1
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 
		and ch>0 and Duel.GetChainInfo(ch,CHAININFO_TRIGGERING_PLAYER)~=tp then
		--Unaffected
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c101106062.etarget)
		e1:SetValue(c101106062.efilter)
		e1:SetLabelObject(Duel.GetChainInfo(ch,CHAININFO_TRIGGERING_EFFECT))
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,tp)
	end
end
function c101106062.efilter(e,re)
	return re==e:GetLabelObject()
end
function c101106062.etarget(e,c)
	return not c:IsType(TYPE_TOKEN) and (c:IsType(TYPE_NORMAL) or c:IsSetCard(0x165))
end
