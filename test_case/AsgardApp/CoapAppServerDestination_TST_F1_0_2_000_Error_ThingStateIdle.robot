*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot
#Suite Setup    Open Directory

*** Test Cases ***
################### Post ###################
CoapAppServerDestination_TST_F1_0_2_000_Error_ThingStateIdle
    [Documentation]    Step is :    
	...    1. Create a Worker
	...    2. Create a Thing Not Have Worker
	...    3. Server destination
	...    4. Verify Log
	...    6. Delete a Thing
	...    7. Delete a Worker

	#====== Start Prepare data ==========
	
	# Prepare data for create thing
	${valData}=    Prepare data for IMEI ThingSecret ThingIdentifier
	Log To Console    valData is : ${valData}

    ${IMEI}=    Set Variable    ${valData[0]}
    ${ThingSecret}=    Set Variable    ${valData[1]}
    ${ThingIdentifier}=    Set Variable    ${valData[2]}
	
	#Prepare data
	# [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId]
	${createResponse}=    Create Data get WorkerId ThingId    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	
	
    #Replace Parameters Url ThingIdentifier and ThingSecret 
	${url}=    Replace Parameters Url Path     ${ASGARD_COAPAPP_URL}    ${ASGARD_COAPAPP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	Log To Console    Server Destination Url is : ${url}

	#====== End Prepare data ==========	
	
	#Server Destination and check log
    ServerDestinationAsgardApp    ${url}
	
	#Check log detail and summary
	${endPointName}=    Set Variable    ["db.ThingsCollection"]
	${custom}=    Set Variable If    '${STATUS_LOG_ENDPOINTSUMMARY}'=='On'    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:inquiry thing is success", "processTime":null }]}    	 
	...    null
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:inquiry thing is success", "processTime":null }]}    	 
    ${responseObjectDetail}=    Set Variable    null

	Log ServerDestination Error    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}    ${createResponse}    ${ThingIdentifier}    ${ThingSecret}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    
	Capture Screen
	[Teardown]    Generic Test Case Teardown    ${SERVERDESTINATION}    ${createResponse}
		



	