/*

 	Name: ExileClient_VirtualGarge_RetrieveVehicleResponse.sqf
 	Author(s): Shix; modified for Virtual Hangers by Ghostrider [GRG]
    Copyright (c) 2016 Shix
 	Description: Handles the client Retrival a vehicle from the virtual garage.
*/
private ["_response","_this","_vehicleNetID"];
_response = _this select 0;
_vehicleNetID = _this select 1;
if(_response == "true")then
{
  VGVehicle = objectFromNetId _vehicleNetID;
  _movePlayerInCar = getNumber (missionconfigfile >> "VirtualGarageSettings" >> "VirtualGarage_MovePlayerInVehicleOnSpawn");
  if(_movePlayerInCar == 1)then
  {
      player moveInDriver VGVehicle;
  };
  _show3DMarker = getNumber (missionconfigfile >> "VirtualGarageSettings" >> "VirtualGarage_3DMarkerOnVehicleOnSpawn");
  if(_show3DMarker == 1)then
  {
    sleepTime = getNumber (missionconfigfile >> "VirtualGarageSettings" >> "VirtualGarage_3DTime");
    CurTime = diag_tickTime;
    VirtualGarageDraw3DIcon = addMissionEventHandler ["Draw3D", {
        if (diag_tickTime - CurTime > sleepTime) then {
            removeMissionEventHandler ["Draw3D", VirtualGarageDraw3DIcon];
            VirtualGarage3DIconVisible = false;
        };
        call ExileClient_VirtualGarage_VehicleDraw3DIcon;
    }];
    VirtualGarage3DIconVisible = true;
	["SuccessTitleAndText", ["Success", format["Your vehicle has been retrieved from the virtual hanger."]]] call ExileClient_gui_toaster_addTemplateToast;
  };
}
else
{
  //["Whoops",[format["The Vehicle Could Not Be Retrieved"]]] call ExileClient_gui_notification_event_addNotification;
  ["ErrorTitleAndText", ["Whoops",format["The Vehicle Could Not Be Retrieved"]]] call ExileClient_gui_toaster_addTemplateToast;
};
(findDisplay 0720) closeDisplay 0;
