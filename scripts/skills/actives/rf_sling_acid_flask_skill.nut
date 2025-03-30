this.rf_sling_acid_flask_skill <- ::inherit("scripts/skills/actives/throw_acid_flask", {
	function create()
	{
		this.throw_acid_flask.create();
		this.m.Icon = "skills/rf_sling_acid_flask_skill.png";
		this.m.IconDisabled = "skills/rf_sling_acid_flask_skill_sw.png";
		this.m.Overlay = "rf_sling_acid_flask_skill";
		::Reforged.Skills.adjustSlingItemSkill(this);
	}

	// We overwrite the onUse of acid_flask with the new one coming with adjustSlingItemSkill
	// We have to do the overwrite here so that we don't invalidate hookTree hooks of onUse from skill.nut
	function onUse( _user, _targetTile )
	{
		this.__onUse(_user, _targetTile);
	}
});
