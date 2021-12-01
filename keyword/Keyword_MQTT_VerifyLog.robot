*** Keywords ***
####################################################
Log MQTT ServerDestination Success
	[Arguments]    ${getData}    ${ThingIdentifier}    ${ThingSecret}
	#api/v2/things/ThingIdentifier/ThingSecret/server/destination/request
	${pathUrl}=    Replace Parameters Path    ${ASGARD_MQTT_URL_PUBLISH_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	# Log To Console    pathUrl${pathUrl}
	#api/v2/things/ThingIdentifier/ThingSecret/server/destination/response
	${urlResponse}=    Replace Parameters Path    ${ASGARD_MQTT_URL_SUBSCRIBE_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	# Log To Console    urlResponse${urlResponse}
	
	${identity}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}
    ${endPointName}=    Set Variable    ["db.WorkersCollection","db.ThingsCollection"]
	${custom}=    Set Variable If    '${STATUS_LOG_ENDPOINTSUMMARY}'=='On'    { "endPointSummary":[ { "no": 1, "endPointName": "db.ThingsCollection", "responseStatus": "20000:inquiry thing is success", "processTime": null, "endPointURL": null }, { "no": 2, "endPointName": "db.workerCollection", "responseStatus": "20000:inquiry worker is success", "processTime": null, "endPointURL": null } ]}    	 
	...    null
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no": 2, "endPointName": "db.workerCollection", "responseStatus": "20000:inquiry worker is success", "processTime": null, "endPointURL": null }, { "no": 1, "endPointName": "db.ThingsCollection", "responseStatus": "20000:inquiry thing is success", "processTime": null, "endPointURL": null } ]}
	${responseBody}=    Set Variable    {"ServerIP":"${getData}[2]","ServerPort":"${getData}[3]","ServerDomain":"${getData}[4]"}
    ${responseObjectDetail}=    Set Variable    null

	#resultCode_summary[20000],resultDesc_summary[The requested operation was successfully.],Code_detail[20000],Description_detail[Register is Success],applicationName[asgardmqtt],pathUrl[api/v2/things/ThingIdentifier/ThingSecret/server/destination/request],urlResponse[api/v2/things/ThingIdentifier/ThingSecret/server/destination/response],dataSearch,ipAddress,body[request],namespace[mgcentric],containerId[coapapp-vXX],identity,cmdName[ServerDestination],endPointName,logLevel[info],custom,customDetailDB,responseObjectDetail
    MQTT Check Log Response    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_SUCCESSFULLY}    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_SUCCESSFULLY}    ${VALUE_APPLICATIONNAME_MQTT}    ${pathUrl}    null    ${pathUrl}    null    ${responseBody}    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_MQTT}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 

Log MQTT ServerDestination Error
	[Arguments]    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${getData}    ${ThingIdentifier}    ${ThingSecret}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail}  
	#api/v2/things/ThingIdentifier/ThingSecret/server/destination/request
	${pathUrl}=    Replace Parameters Path    ${ASGARD_MQTT_URL_PUBLISH_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	# Log To Console    pathUrl${pathUrl}
	#api/v2/things/ThingIdentifier/ThingSecret/server/destination/response
	${urlResponse}=    Replace Parameters Path    ${ASGARD_MQTT_URL_SUBSCRIBE_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	# ${urlResponse}=    Replace String    ${urlResponseReplace}    /    .
	# Log To Console    urlResponse${urlResponse}

    ${identityThingIdentifierThingSecret}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}
    ${identityThingIdentifier}=    Set Variable    {\"ThingIdentifier\":\" \",\"ThingSecret\":\"${ThingSecret}\"}
	${identityThingSecret}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\" \"}
    ${identity} =	Set Variable If    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='null'    ${identityThingIdentifierThingSecret}
    ...    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='ThingIdentifier'     ${identityThingIdentifier}
	...    '${Code}'=='${VALUE_LOG_CODE_40000}' and '${customDetailDB}'=='ThingSecret'     ${identityThingSecret}
	...    '${Code}'!='${VALUE_LOG_CODE_40000}'    ${identityThingIdentifierThingSecret}

    # Log To Console    pathUrl${identity}

	#resultCode_summary[40300],resultDesc_summary[Forbidden],Code_detail[40300],Description_detail[The requested operation could not be found.],applicationName[asgardmqtt],pathUrl[api/v2/things/ThingIdentifier/ThingSecret/server/destination/request],urlResponse[api/v2/things/ThingIdentifier/ThingSecret/server/destination/response],dataSearch,ipAddress,body[null],namespace[mgcentric],containerId[coapapp-vXX],identity,cmdName[ServerDestination],endPointName[],logLevel[info],custom,customDetailDB,responseObjectDetail
    Check Log Response    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${VALUE_APPLICATIONNAME_MQTT}    ${pathUrl}    null    ${pathUrl}    null    null    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_MQTT}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
