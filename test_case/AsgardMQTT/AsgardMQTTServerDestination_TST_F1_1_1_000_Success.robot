*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot

*** Test Cases ***
################### Post ###################
AsgardMQTTServerDestination_TST_F1_1_1_000_Success
    [Documentation]    Step is :    
	...    1. Create a Worker
	...    2. Create a Thing Not Have Worker
	...    3. Activate Things
	...    4. Server destination
	...    5. Verify Log
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
	${createResponse}=    Create Data get WorkerId ThingId and ActivateThings    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	

	#=============Start Prepare data==============     
	${username}=    Set Variable    ${ThingIdentifier}
	${password}=    Set Variable    ${ThingSecret}
	#=============End Prepare data==============

	#Server Destination Success
	MQTTServerDestination    ${username}    ${password}    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}

	#Check log detail and summary
	Log MQTT ServerDestination Success    ${createResponse}    ${ThingIdentifier}    ${ThingSecret}
	#Capture Screen
    [Teardown]    Generic Test Case Teardown    ${SERVERDESTINATION_MQTT}    ${createResponse}    