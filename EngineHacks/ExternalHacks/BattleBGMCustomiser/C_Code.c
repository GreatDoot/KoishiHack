#include "C_Code.h" // headers 

// woe, externs be upon ye
extern u16 SacredWeaponMusicBGMTable[];
extern u8 IgnoreSacredWeaponMusicUnitTable[];
extern s16 gBanimFactionPal[2];
extern s16 gBanimValid[2];
extern u16 DancerBGM;
extern u16 BardBGM;
extern u16 PromotionBGM;
extern u16 ArenaBGM;
extern u16 StaffBGMTable[];
extern u8 DemonKingMusicSwitchTable_Count;
extern u8 DemonKingMusicSwitchTable_Unit[];
extern u16 DemonKingMusicSwitchTable_BGM[];
extern u16 DemonKingMusicSwitchTable_Flag[];


//smallest function i ever did see, little me
//MIGHT NOT NEED TO REPLACE THIS
/*
s16 EkrCheckWeaponSieglindeSiegmund(u16 item)
{
    return SacredWeaponMusicItemTable[GetItemIndex(item)];
}
*/

// why did i do this again?
void EkrPlayMainBGM(void)
{
    int ret, songid, songid2, pid;
    struct BattleUnit * bul, * bur, ** pbul, ** pbur;

    pbul = &gpEkrBattleUnitLeft;
    pbur = &gpEkrBattleUnitRight;

    bul = *pbul;
    bur = *pbur;

    if (gBmSt.gameStateBits & BM_FLAG_5)
    {
        gEkrMainBgmPlaying = 0;
        return;
    }

    gEkrMainBgmPlaying = 1;


    //TODO: Get this working with reverse mode somehow?
    //per chapter shenanigans
    if (gBanimFactionPal[gEkrInitialHitSide] == 0){
        //do player phase stuff
        songid = GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[3];
    }

    else if (gBanimFactionPal[gEkrInitialHitSide] == 1){
        //do enemy phase stuff
        songid = GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[4];
    }
    
    else {
        //do npc phase stuff
        songid = GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[5];
    }



    // ArenaBGM , basically not touched
    if (GetBattleAnimArenaFlag() == 1)
    {
        Sound_SetDefaultMaxNumChannels();
        EfxOverrideBgm(ArenaBGM, 0x100);
        return;
    }

    if (GetBanimLinkArenaFlag() == 1)
    {
        EfxOverrideBgm(ArenaBGM, 0x100);
        return;
    }

    // PromotionBGM , basically not touched
    if (gEkrDistanceType == EKR_DISTANCE_PROMOTION)
    {
        EfxOverrideBgm(PromotionBGM, 0x100);
        return;
    }

    // SacredWeaponBGM stuff
    //again not too bad? thanks vesly for listening to my stupidness
    ret = false;
    if (SacredWeaponMusicBGMTable[GetItemIndex(bur->weaponBefore)] > 0)
        ret = true;

    if (!EkrCheckAttackRound(1))
        ret = false;

    if (gBanimValid[POS_L] == false)
        ret = false;

    pid = UNIT_CHAR_ID(&bul->unit);
    if (IgnoreSacredWeaponMusicUnitTable[pid] == true) {
        ret = false;
    }

    //hilariously easy this time actually
    if (ret == true)
    {
        EfxOverrideBgm(SacredWeaponMusicBGMTable[GetItemIndex(bur->weaponBefore)], 0x100);
        return;
    }

    //Demon King Music Switch
    int count = DemonKingMusicSwitchTable_Count;
    for (int i = 0; i < count; i++){
        if (pid == DemonKingMusicSwitchTable_Unit[i])
        {   
            if (CheckFlag(DemonKingMusicSwitchTable_Flag[i]) == true)
            {
                EfxOverrideBgm(DemonKingMusicSwitchTable_BGM[i], 0x100);
                return;
            }
            SetFlag(DemonKingMusicSwitchTable_Flag[i]);
        }
    }

    // BossBGM , left untouched.
    songid2 = GetBanimBossBGM(&bul->unit);

    if (UNIT_FACTION(GetUnitFromCharId(UNIT_CHAR_ID(&bul->unit))) == FACTION_BLUE)
        songid2 = -1;

    if (gBanimValid[POS_L] == false)
        songid2 = -1;

    if (songid2 != -1)
    {
        EfxOverrideBgm(songid2, 0x100);
        return;
    }

    // DancerBGM
    ret = false;
    if (UNIT_CATTRIBUTES(&bur->unit) & CA_DANCE)
    {
        if (gBattleStats.config & 0x40)
            ret = true;

        if (gBattleStats.config & 0x200)
            ret = true;
        
        if (ret == true)
        {
            EfxOverrideBgm(DancerBGM, 0x100);
            return;
        }
    }
    
    // BardBGM
    ret = false;
    if (UNIT_CATTRIBUTES(&bur->unit) & CA_PLAY)
    {
        if (gBattleStats.config & 0x40)
        ret = true;

        if (gBattleStats.config & 0x200)
        ret = true;

        if (ret == true)
        {
            EfxOverrideBgm(BardBGM, 0x100);
            return;
        }
    }

    

    // StaffBGM
    if (GetItemAttributes(gBattleActor.weaponBefore) & IA_STAFF){
        songid = StaffBGMTable[GetItemIndex(gBattleActor.weaponBefore)];
    }
    


    if (songid == 0xFFFF || songid == GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[0] || songid == GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[1] || songid == GetROMChapterStruct(gPlaySt.chapterIndex)->mapBgmIds[2])
    {
        return;
    }

    
    EfxOverrideBgm(songid, 0x100);
    return;

}