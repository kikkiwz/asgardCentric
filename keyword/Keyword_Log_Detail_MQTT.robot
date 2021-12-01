*** Keywords ***	
################################################################-- Do Not Have EndPointName --################################################################
#-------------------------------------------- MQTT --------------------------------------------#	
#-------------------------------------------- Server Destination : RequestObject --------------------------------------------#	
Check RequestObject App Success MQTT Server Destination
    [Arguments]    ${dataResponse}    ${pathUrl}    ${tid}

	#"{"method":"Consume","url":"[valuePathUrl]","headers":{"x-ais-orderref":"[tid]","x_ais_sessionid":"[tid]","timestamp_in_ms":[tid]},"body":{}}"
	${replaceUrl}=    Replace String    ${VALUE_LOG_DETAIL_REQUESTOBJECT_MQTT_APP_CENTRIC_SERVERDESTINATION}    [valuePathUrl]    ${pathUrl}
	${replaceHeaders}=    Replace String    ${replaceUrl}    [tid]    ${tid}
	${requestObject}=    Replace String To Object    ${replaceHeaders}
	# Log To Console    MQTTServerDestinationRequestObjectApp${requestObject}
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_REQUESTOBJECT}']    ${requestObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_REQUESTOBJECT}

##############################################################################################################################################################

