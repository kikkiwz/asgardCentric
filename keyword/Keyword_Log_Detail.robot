*** Keywords ***	
################################################################-- Have EndPointName --################################################################
#-------------------------------------------- DB --------------------------------------------#	
Check ResponseObject Success DB
    [Arguments]    ${code}    ${description}    ${dataResponse}
	# "{"statusCode":"20000","description":"inquiry worker is success"}"
    # "{"statusCode":"[statusCode]","description":"[description]"}""    

	${replaceDescription}    Replace String    ${description}    20000:    ${EMPTY}    
	${replaceCode}=    Replace String    ${VALUE_LOG_DETAIL_RESPONSEOBJECT_COAPAPP_DB}    [statusCode]    ${code}
	${replaceDescription}=    Replace String    ${replaceCode}    [description]    ${replaceDescription}
	${responseObject}=    Replace String To Object    ${replaceDescription}
	# Log To Console    responseObjectDelta${responseObject}
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_RESPONSEOBJECT}']    ${responseObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_RESPONSEOBJECT}

##############################################################################################################################################################
		
################################################################-- Do Not Have EndPointName --################################################################
#-------------------------------------------- Server Destination --------------------------------------------#	
#-------------------------------------------- Server Destination : ResponseObject --------------------------------------------#	
Check ResponseObject App Success Server Destination
    [Arguments]    ${code}    ${description}    ${dataResponse}    ${ServerDestinationInfo}

	${replaceCode}=    Replace String    ${VALUE_LOG_DETAIL_RESPONSEOBJECT_APP_CENTRIC_SERVERDESTINATION}    [Code]    ${code}
	${replaceDescription}=    Replace String    ${replaceCode}    [DeveloperMessage]    ${description}
	${replaceDatas}=    Replace String    ${replaceDescription}    [ServerDestinationInfo]    ${ServerDestinationInfo}

	${responseObject}=    Replace String To Object    ${replaceDatas}
	# Log To Console    responseObjectServerDestination${responseObject}
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_RESPONSEOBJECT}']    ${responseObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_RESPONSEOBJECT}

##############################################################################################################################################################
Converting a JSON File
	[Arguments]    ${payload}
    ${MY_DATA_TABLE_VALUES}    evaluate  json.loads('''${payload}''')    json
    [Return]  ${MY_DATA_TABLE_VALUES}

Delta Case1
    [Arguments]    ${payload}
    ${requestObject}=    Convert JSON To String    ${payload}
	[Return]  ${requestObject}