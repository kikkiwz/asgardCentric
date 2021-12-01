*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot

*** Test Cases ***
################### Post ###################
AsgardMQTTServerDestination_TST_F1_0_4_004_Error_ThingSecretInvalid
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
    ${ThingSecretCreate}=    Set Variable    ${valData[1]}
	${ThingSecret}=    Set Variable    ${ASGARD_MQTT_SERVERDESTINATION_VALUE_THINGSECRET_INVALID}
    ${ThingIdentifier}=    Set Variable    ${valData[2]}
	
    #Prepare data
	# [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId]
	${createResponse}=    Create Data get WorkerId ThingId and ActivateThings    ${ThingIdentifier}    ${ThingSecretCreate}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	

	#=============Start Prepare data==============     
	${username}=    Set Variable    ${ThingIdentifier}
	${password}=    Set Variable    ${ThingSecretCreate}
	#=============End Prepare data==============

	#Server Destination Success
    MQTTServerDestination    ${username}    ${password}    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}

	#Check log detail and summary
	${endPointName}=    Set Variable    ["db.ThingsCollection"]
	${custom}=    Set Variable If    '${STATUS_LOG_ENDPOINTSUMMARY}'=='On'    { "endPointSummary":[ { "no":1, "endPointName":"db.ThingsCollection", "responseStatus":"20000:inquiry thing is success", "processTime":null, "endPointURL":null }]}    	 
	...    null
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no":1, "endPointName":"db.ThingsCollection", "responseStatus":"20000:inquiry thing is success", "processTime":null, "endPointURL":null }]}    	 
    ${responseObjectDetail}=    Set Variable    null

	Log MQTT ServerDestination Error    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_THING_COULDNOTBEFOUND_ERROR}    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_THING_COULDNOTBEFOUND_ERROR}    ${createResponse}    ${ThingIdentifier}    ${ThingSecret}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    Capture Screen
    [Teardown]    Generic Test Case Teardown    ${SERVERDESTINATION_MQTT}    ${createResponse}   