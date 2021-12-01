*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot
#Suite Setup    Open Directory

*** Test Cases ***
################### Post ###################
CoapAppServerDestination_TST_F1_0_4_005_Error_ThingIdentifierThingSecretInvalid
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
    ${ThingSecret}=    Set Variable    ${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_INVALID}
    ${ThingIdentifierCreate}=    Set Variable    ${valData[2]}
	${ThingIdentifier}=    Set Variable    ${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_INVALID}
	
	#Prepare data
	# [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId]
	${createResponse}=    Create Data get WorkerId ThingId and ActivateThings    ${ThingIdentifierCreate}    ${ThingSecretCreate}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	
	
    #Replace Parameters Url ThingIdentifier and ThingSecret 
	${url}=    Replace Parameters Url Path     ${ASGARD_COAPAPP_URL}    ${ASGARD_COAPAPP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	Log To Console    Server Destination Url is : ${url}

	#====== End Prepare data ==========	
	
	#Server Destination and check log
    ServerDestinationAsgardApp    ${url}
	
	#Check log detail and summary
	${endPointName}=    Set Variable    null
	${custom}=    Set Variable    null
	${customDetailDB}=    Set Variable    ThingIdentifier
    ${responseObjectDetail}=    Set Variable    [{"Target":"ThingIdentifier","DeveloperMessage":"${VALUE_DETAILS_DEVELOPERMESSAGE_THINGIDENTIFIERMUSTNOTBEEMPTY_ERROR}"}]

	Log ServerDestination Error    ${VALUE_LOG_CODE_40000}    ${VALUE_DESCRIPTION_THECLIENTREQUESTMISSINGORINVALIDFORMAT_ERROR}    ${VALUE_LOG_CODE_40000}    ${VALUE_DESCRIPTION_THECLIENTREQUESTMISSINGORINVALIDFORMAT_ERROR}    ${createResponse}    ${ThingIdentifier}    ${EMPTY}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    Capture Screen
	[Teardown]    Generic Test Case Teardown    ${SERVERDESTINATION}    ${createResponse}
		



	