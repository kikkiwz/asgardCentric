*** Keywords ***
####################################################
Create Data get WorkerId ThingId and ActivateThings
    [Arguments]    ${thingIdentifier}    ${thingSecret}    ${imei}
    #set variable ${IMAGE_DIR} for set folder img
	${path}=    Normalize path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	Set Global Variable    ${IMAGE_DIR}    ${path}
	Log To Console    ${\n}Path IMG is : ${IMAGE_DIR}	
    #getDataRequest position data=[#WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId,ThingIdentifier,ThingSecret,ThingSecret,ThingId(Activate Things)]
    ${getDataRequest}=    Request CreateData for get WorkerId ThingId and ActivateThings    ${thingIdentifier}    ${thingSecret}    ${imei}
	# Log To Console    ${getDataRequest}
	#set data use cross testcase
	Set Global Variable    ${getData}    ${getDataRequest}
	Log Many    ${getData}
	[return]    ${getData}

Create Data get WorkerId ThingId
    [Arguments]    ${thingIdentifier}    ${thingSecret}    ${imei}
    #set variable ${IMAGE_DIR} for set folder img
	${path}=    Normalize path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	Set Global Variable    ${IMAGE_DIR}    ${path}
	Log To Console    ${\n}Path IMG is : ${IMAGE_DIR}	
    #getDataRequest position data=[#WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId,ThingIdentifier,ThingSecret,ThingSecret,ThingId(Activate Things)]
    ${getDataRequest}=    Request CreateData for get WorkerId ThingId    ${thingIdentifier}    ${thingSecret}    ${imei}
	# Log To Console    ${getDataRequest}
	#set data use cross testcase
	Set Global Variable    ${getData}    ${getDataRequest}
	Log Many    ${getData}
	[return]    ${getData}
