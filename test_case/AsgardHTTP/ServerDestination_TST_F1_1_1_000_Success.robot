*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot
#Suite Setup    Open Directory

*** Test Cases ***
################### Post ###################
ServerDestination_TST_F1_1_1_000_Success
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
	${createResponse}=    Request CreateData for get WorkerId ThingId and ActivateThings    ${ThingIdentifier}    ${ThingSecret}    ${IMEI}
	Log To Console    createResponse is : ${createResponse}	

	${ServerIP}=    Set Variable    ${createResponse}[2]
    Log To Console    ServerIP is : ${ServerIP}

	${ServerPort}=    Set Variable    ${createResponse}[3]
    Log To Console    ServerPort is : ${ServerPort}

	${ServerDomain}=    Set Variable    ${createResponse}[4]
    Log To Console    ServerDomain is : ${ServerDomain}

	#====== End Prepare data ==========

	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    #Headers
	${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_SERVERDESTINATION}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_SERVERDESTINATION}    Accept=${HEADER_ACCEPT}  
	Log To Console    Headers is : ${headers}
		
	# Replace Parameters Url ThingIdentifier and ThingSecret 
	${urlServerDestination}=    Replace String    ${ASGARD_HTTP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}
    ${urlServerDestination}=    Replace String    ${urlServerDestination}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	Log To Console    urlServerDestination is : ${urlServerDestination}

    #Response
    ${res}=    Run keyword And Continue On Failure    Get Api Request    ${URL_CENTRIC}${ASGARDHTTP}    ${urlServerDestination}    ${headers}
	Log To Console    Response is : ${res}

    ${checkReponse}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${SERVERDESTINATION}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DEVELOPERMESSAGE}
    Log To Console    checkReponse is : ${checkReponse}

    ${ServerDestinationInfo}=    Get From Dictionary    ${res}     ${FIELD_SERVERDESTINATIONINFO}   
    #Log To Console    ${ServerDestinationInfo}	
	${GetResponse_ServerIP}=    Get From Dictionary    ${ServerDestinationInfo}     ${FIELD_SERVERID}    
	${GetResponse_ServerPort}=    Get From Dictionary    ${ServerDestinationInfo}     ${FIELD_SERVERPORT}   
	${GetResponse_ServerDomain}=    Get From Dictionary    ${ServerDestinationInfo}     ${FIELD_SERVERDOMAIN}   
	Run keyword And Continue On Failure    Should Be Equal As Strings    ${GetResponse_ServerIP}    ${ServerIP}
	Run keyword And Continue On Failure    Should Be Equal As Strings    ${GetResponse_ServerPort}    ${ServerPort}
	Run keyword And Continue On Failure    Should Be Equal As Strings    ${GetResponse_ServerDomain}    ${ServerDomain}

    ${pathUrl}=    Set Variable    ${urlServerDestination}
	${dataSearch}=    Set Variable    ${HEADER_X_AIS_ORDERREF_SERVERDESTINATION}${current_timestamp}

	#====== Check log ==========

	#Check log detail and summary
	Log ServerDestination HTTP Success    ${createResponse}    ${pathUrl}    ${dataSearch}

    [Teardown]    Generic Test Case Teardown HTTP    ${SERVERDESTINATION_HTTP}    ${createResponse}