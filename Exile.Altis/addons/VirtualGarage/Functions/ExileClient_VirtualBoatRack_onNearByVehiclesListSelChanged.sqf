/*

 	Name: ExileClient_VirtualHanger_onNearByVehiclesListSelChanged.sqf
 	Author(s): Shix; modified for Virtual Hanger by Ghostrider [GRG]
    Copyright (c) 2016 Shix
 	Description: handles sel changes for dankness

*/
private ["_display","_NearByVehiclesList","_selectedSel","_selectedSel","_vehicleSelectedClass","_vehicleClassName","_selectedVehicleDispPic","_vehiclePicture","_vehiclePicture"];
disableSerialization;
params["_control","_index"];
_display = uiNameSpace getVariable ["VirtualBoatRackDialog", displayNull];
if !(localVehicles isEqualTo []) then 
{
	_NearByVehiclesList = _display displayCtrl 1501;
	_selectedSel = lbCurSel _NearByVehiclesList;
	_vehicleSelectedClass = localVehicles select _selectedSel;
	_vehicleClassName = typeOf _vehicleSelectedClass;
	_selectedVehicleDispPic = getText (configfile >> "CfgVehicles" >> _vehicleClassName >> "picture");
	_vehiclePicture = _display displayCtrl 1200;
	_vehiclePicture ctrlSetText Format["%1",_selectedVehicleDispPic];
	_vehicle = localVehicles select _index;
	_nickName = _vehicle getVariable["GRG_nickName",""];
	VG_vehicleName = _nickName;
	if (_nickName isEqualTo "") then {_nickName = "Edit a Nickname for This Vehicle"};
	ctrlSetText[1400,_nickName];
};
