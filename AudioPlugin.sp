#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma newdecls required
#pragma semicolon 1

#define DEBUG

public Plugin myinfo = 
{
	name = "Better Mutes for Prisoners",
	author = "proobs",
	description = "",
	version = "1.0",
	url = "https://github.com/proobs"
};

ConVar g_cvEnablePlugin;
ConVar g_cvMuteTime;


public void OnPluginStart()
{
	g_cvEnablePlugin = CreateConVar("sm_enableaudioplugin", "1", "enable or disable the plugin");
	g_cvMuteTime = CreateConVar("sm_audioplugintime", "45.0", "time set for mute prisoners(Has to be a float value)");
	
	HookEvent("round_start", Event_RoundStart);
	//HookEvent("player_death", )
}
public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	int team = GetClientTeam(client); 
	
	if(GetConVarBool(g_cvEnablePlugin) == true)
	{
		if (IsClientInGame(client) || IsPlayerAlive(client))
		{
			if(team == CS_TEAM_T)
			{
				SetClientListeningFlags(client, VOICE_MUTED);
				float muteTime = GetConVarFloat(g_cvMuteTime);
				CreateTimer(muteTime, UnMuteTs);
				PrintToChatAll("[SM] All T's are now muted for 45 seconds!"); 
			}
		}
	}
}

public Action UnMuteTs(Handle timer)
{
	
	SetClientListeningFlags(, VOICE_NORMAL);
}

