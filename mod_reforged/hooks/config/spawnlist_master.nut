::Const.World.Spawn.Troops.BanditLeader.Strength = 40;
::Const.World.Spawn.Troops.BanditLeader.Cost = 35;

function onCostCompare( _t1, _t2 )
{
    if (_t1.Cost < _t2.Cost)
    {
        return -1;
    }
    else if (_t1.Cost > _t2.Cost)
    {
        return 1;
    }

    return 0;
}

function calculateCosts( _p )
{
    foreach (p in _p)
    {
        p.Cost <- 0;

        foreach (t in p.Troops)
        {
            p.Cost += t.Type.Cost * t.Num;
        }

        if (!("MovementSpeedMult" in p))
        {
            p.MovementSpeedMult <- 1.0;
        }
    }

    _p.sort(this.onCostCompare);
}

this.calculateCosts(::Const.World.Spawn.BanditRoamers);
this.calculateCosts(::Const.World.Spawn.BanditScouts);
this.calculateCosts(::Const.World.Spawn.BanditRaiders);
this.calculateCosts(::Const.World.Spawn.BanditDefenders);
this.calculateCosts(::Const.World.Spawn.BanditBoss);
this.calculateCosts(::Const.World.Spawn.BanditsDisguisedAsDirewolves);
