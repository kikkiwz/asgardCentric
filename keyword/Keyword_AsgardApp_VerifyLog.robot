*** Keywords ***
####################################################
Log ServerDestination Success
    #${getData} = [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId,ThingIdentifier,ThingSecret,ThingSecret,ThingId(Activate Things)]
	[Arguments]    ${getData}    ${ThingIdentifier}    ${ThingSecret}

	#/api/v2/things/ThingIdentifier/ThingSecret/server/destination
	${pathUrl}=    Replace Parameters Path    ${ASGARD_COAPAPP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	${payload}=    Set Variable    null

	${identity}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}
	# ${endPointName}=    Set Variable    ["db.workersCollection","db.thingsCollection"]
	${endPointName}=    Set Variable    ["db.WorkersCollection","db.ThingsCollection"]
	${custom}=    Set Variable If    '${STATUS_LOG_ENDPOINTSUMMARY}'=='On'    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:inquiry thing is success", "processTime":null }, { "no":"2", "endPointName":"db.WorkersCollection", "endPointURL":null, "responseStatus":"20000:inquiry worker is success", "processTime":null}]}    	 
	...    null
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.WorkersCollection", "endPointURL":null, "responseStatus":"20000:inquiry worker is success", "processTime":null}, { "no":"2", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:inquiry thing is success", "processTime":null }]}    	 
	${responseBody}=    Set Variable    {"ServerIP":"${getData}[2]","ServerPort":"${getData}[3]","ServerDomain":"${getData}[4]"}
    ${responseObjectDetail}=    Set Variable    null
	#resultCode_summary[20000],resultDesc_summary[The requested operation was successfully],Code_detail[20000],Description_detail[The requested operation was successfully],applicationName[asgradcoap],pathUrl[/api/v2/things/ThingIdentifier/ThingSecret/server/destination],urlCmdName[],dataSearch,ipAddress,body[request],namespace[mgcentric],containerId[coapapp-vXX],identity,cmdName[ServerDestination],endPointName[],logLevel[info],custom,customDetailDB,responseObjectDetail
    Check Log Response    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_SUCCESSFULLY}    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_SUCCESSFULLY}    ${VALUE_APPLICATIONNAME_COAPAPP}    ${pathUrl}    null    ${pathUrl}    null    ${responseBody}    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_COAPAPP}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail}  
	
Log ServerDestination Error
	[Arguments]    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${getData}    ${ThingIdentifier}    ${ThingSecret}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail}  
	
	#/register/sim/v1/IMSI/IPAddress
	${pathUrl}=    Replace Parameters Path    ${ASGARD_COAPAPP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	${payload}=    Set Variable    null

	# ${identity}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}

	${identityThingIdentifierThingSecret}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}
    ${identityThingIdentifier}=    Set Variable    {\"ThingIdentifier\":\" \",\"ThingSecret\":\"${ThingSecret}\"}
	${identityThingSecret}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\" \"}
    ${identity} =	Set Variable If    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='null'    ${identityThingIdentifierThingSecret}
    ...    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='ThingIdentifier'     ${identityThingIdentifier}
	...    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='ThingSecret'     ${identityThingSecret}
	...    '${Code}'!='${VALUE_LOG_CODE_40000}'    ${identityThingIdentifierThingSecret}

	
	#resultCode_summary[40300],resultDesc_summary[Forbidden],Code_detail[40300],Description_detail[The requested operation could not be found.],applicationName[CoapAPP],pathUrl[/api/v2/things/ThingIdentifier/ThingSecret/server/destination],urlCmdName[],dataSearch,ipAddress,payload[null],namespace[mgcentric],containerId[coapapp-vXX],identity,cmdName[ServerDestination],endPointName[],logLevel[info],custom,customDetailDB,responseObjectDetail
    Check Log Response    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${VALUE_APPLICATIONNAME_COAPAPP}    ${pathUrl}    null    ${pathUrl}    null    ${payload}    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_COAPAPP}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 


