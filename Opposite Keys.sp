#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required


Handle OppoKeys;

public Plugin myinfo = {
	name = "Opposite Keys Mode",
	author = "Cruze",
	description = "Players in the server press the opposite keys",
	version = "",
	url = ""
};

public void OnPluginStart()
{
	OppoKeys =	CreateConVar("sm_oppo_keys", "1", "Opposite keys?");
}

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon) 
{
	if (GetConVarBool(OppoKeys))
	{
		vel[1] = -vel[1]; // Will always equal to the opposite value, according to rules of arithmetic.
			
		if(buttons & IN_MOVELEFT) // Fixes walking animations for CS:GO.
		{ 
			buttons &= ~IN_MOVELEFT;
			buttons |= IN_MOVERIGHT;
		} else if(buttons & IN_MOVERIGHT) 
		{
			buttons &= ~IN_MOVERIGHT;
			buttons |= IN_MOVELEFT;
		}
		vel[0] = -vel[0];

		if(buttons & IN_FORWARD) 
		{
			buttons &= ~IN_FORWARD;
			buttons |= IN_BACK;
		} 
		else if(buttons & IN_BACK) 
		{
			buttons &= ~IN_BACK;
			buttons |= IN_FORWARD;
		}
	}
	return Plugin_Changed;
}