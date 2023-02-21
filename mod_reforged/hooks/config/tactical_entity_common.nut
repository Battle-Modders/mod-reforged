// We overwrite the vanilla function to remove all damage multiplier and add the burning damage type
::Const.Tactical.Common.onApplyFire = function( _tile, _entity )
{
    if (_entity.getCurrentProperties().IsImmuneToFire) return;

    ::Tactical.spawnIconEffect("status_effect_116", _tile, ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
    local sounds = [
        "sounds/combat/dlc6/status_on_fire_01.wav",
        "sounds/combat/dlc6/status_on_fire_02.wav",
        "sounds/combat/dlc6/status_on_fire_03.wav"
    ];
    ::Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], ::Const.Sound.Volume.Actor, _entity.getPos());

    local damage = this.Math.rand(15, 30);
    local hitInfo = clone ::Const.Tactical.HitInfo;
    hitInfo.DamageRegular = damage;
    hitInfo.DamageArmor = damage;
    hitInfo.DamageDirect = 0.1;
    hitInfo.DamageType = ::Const.Damage.DamageType.Burning;     // Uses damagetype system from MSU
    hitInfo.BodyPart = ::Const.BodyPart.Body;
    hitInfo.BodyDamageMult = 1.0;
    hitInfo.FatalityChanceMult = 0.0;
    hitInfo.Injuries = ::Const.Injury.Burning;
    hitInfo.IsPlayingArmorSound = false;
    _entity.onDamageReceived(_entity, null, hitInfo);

    if ((!_entity.isAlive() || _entity.isDying()) && !_entity.isPlayerControlled() && (_tile.Properties.Effect == null || _tile.Properties.Effect.IsByPlayer))
    {
        this.updateAchievement("BurnThemAll", 1, 1);
    }
}
