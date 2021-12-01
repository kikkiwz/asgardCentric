*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot

*** Test Cases ***
################### Post ###################
AsgardMQTTServerDestination_TST_F1_0_4_000_Error_ThingIdentifierOverMax19
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
    ${ThingIdentifierCreate}=    Set Variable    ${valData[2]}

	${randomICCID1}=    Evaluate    random.randint(1000000, 9999999)    random
	${randomICCID2}=    Evaluate    random.randint(1000000, 9999999)    random
	${ThingIdentifier}=    Set Variable    ${FIELD_ICCIDPRE}${randomICCID1}${randomICCID2}
	
    #Prepare data
	# [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId]
	${createResponse}=    Create Data get WorkerId ThingId and ActivateThings    ${ThingIdentifierCreate}    ${ThingSecret}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	

	#=============Start Prepare data==============     
	${username}=    Set Variable    ${ThingIdentifierCreate}
	${password}=    Set Variable    ${ThingSecret}
	#=============End Prepare data==============

	#Server Destination Success
    MQTTServerDestination    ${username}    ${password}    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}
	
	#Check log detail and summary
	${endPointName}=    Set Variable    null
	${custom}=    Set Variable    null
	${customDetailDB}=    Set Variable    null
    ${responseObjectDetail}=    Set Variable    [{"Target":"ThingIdentifier","DeveloperMessage":"${VALUE_DETAILS_DEVELOPERMESSAGE_RESPONSE_THINGIDENTIFIER_LENGTHMUSTMEMORETHAN_ERROR}"}]

	Log MQTT ServerDestination Error    ${VALUE_LOG_CODE_40000}    ${VALUE_DESCRIPTION_THECLIENTREQUESTMISSINGORINVALIDFORMAT_ERROR}    ${VALUE_LOG_CODE_40000}    ${VALUE_DESCRIPTION_THECLIENTREQUESTMISSINGORINVALIDFORMAT_ERROR}    ${createResponse}    ${ThingIdentifier}    ${ThingSecret}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
	Capture Screen
    [Teardown]    Generic Test Case Teardown    ${SERVERDESTINATION_MQTT}    ${createResponse}