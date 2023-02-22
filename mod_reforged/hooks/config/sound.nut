function lowerAnnoyingKid( _soundArray )
{
    foreach (soundTable in ::Const.SoundAmbience.GeneralSettlement)
    {
        if (soundTable.File != "ambience/settlement/settlement_people_08.wav") continue;
        soundTable.Volume *= 0.80;
        break;
    }
}

lowerAnnoyingKid(::Const.SoundAmbience.GeneralSettlement);
lowerAnnoyingKid(::Const.SoundAmbience.LargeSettlement);
lowerAnnoyingKid(::Const.SoundAmbience.VeryLargeSettlement);
