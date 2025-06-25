::MSU.Table.merge(::Const.Music, {
	// Used to crossfade from silent to real music in tactical.
	// We set it to be significantly shorter than the vanilla CrossFadeTime to reduce the delay
	// in starting the music after discovering an enemy.
	RF_CrossFadeTimeToRealMusic = 1000,
	RF_DraugrTracks = [
		"music/rf_draugr_1.ogg",
		"music/rf_draugr_2.ogg"
	]
});
