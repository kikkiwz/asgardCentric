*** Keywords ***	
################################################################-- Do Not Have EndPointName --################################################################
#-------------------------------------------- CoapAPP --------------------------------------------#	
#-------------------------------------------- Server Destination : RequestObject --------------------------------------------#	
Check RequestObject App Success CoapAPP Server Destination
    [Arguments]    ${dataResponse}    ${pathUrl}
	# Log To Console    pathUrl${pathUrl}
	#"{ \"url\":\"[valuePathUrl]\", \"method\":\"GET\", \"headers\":{ \"Content-Format\":\"text/plain\", \"Content-Type\":\"text/plain\" }, \"routeParameters\":{ }, \"queryString\":{ }, \"body\":{ } }"
	${replaceUrl}=    Replace String    ${VALUE_LOG_DETAIL_REQUESTOBJECT_COAPAPP_APP_CENTRIC_SERVERDESTINATION}    [valuePathUrl]    ${pathUrl}
	${requestObject}=    Replace String To Object    ${replaceUrl}
	# Log To Console    CoapAPPServerDestinationRequestObjectApp${requestObject}
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_REQUESTOBJECT}']    ${requestObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_REQUESTOBJECT}

##############################################################################################################################################################

