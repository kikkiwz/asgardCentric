*** Settings ***
Resource    ../../variables/Variables.robot    
Resource    ../../keyword/Keyword.robot
#Suite Setup    Open Directory

*** Test Cases ***
################### Post ###################
ServerDestination_TST_F1_0_2_002_Error_ThingSecretNotFound
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
    ${ThingSecretCreate}=    Set Variable    ${valData[1]}
    ${ThingIdentifier}=    Set Variable    ${valData[2]}
	${ThingSecret}=    Set Variable    ${ASGARD_HTTP_SERVERDESTINATION_VALUE_THINGSECRET_NOTFOUND}

    #Prepare data
	# [WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId]
	${createResponse}=    Request CreateData for get WorkerId ThingId and ActivateThings    ${ThingIdentifier}    ${ThingSecretCreate}    ${IMEI}
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
	${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_SERVERDESTINATION_FAIL}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_SERVERDESTINATION}    Accept=${HEADER_ACCEPT}  
	Log To Console    Headers is : ${headers}
		
	# Replace Parameters Url ThingIdentifier and ThingSecret 
	${urlServerDestination}=    Replace String    ${ASGARD_HTTP_URL_SERVERDESTINATION}    ${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}
    ${urlServerDestination}=    Replace String    ${urlServerDestination}    ${ASGARD_COAPAPP_FIELD_THINGSECRET}    ${ThingSecret}
	Log To Console    urlServerDestination is : ${urlServerDestination}

    #Response
    ${res}=    Run keyword And Continue On Failure    Get Api Request    ${URL_CENTRIC}${ASGARDHTTP}    ${urlServerDestination}    ${headers}
	Log To Console    Response is : ${res}

    ${checkReponse}=    Run keyword And Continue On Failure    Response ResultCode Should Have Error    ${res}    ${SERVERDESTINATION}   ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DEVELOPERMESSAGE}    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}
    Log To Console    checkReponse is : ${checkReponse}

    ${pathUrl}=    Set Variable    ${urlServerDestination}
	${dataSearch}=    Set Variable    ${HEADER_X_AIS_ORDERREF_SERVERDESTINATION_FAIL}${current_timestamp}

	${endPointName}=    Set Variable    ["db.ThingsCollection"]
	${custom}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Thing is Success", "processTime":null }]}    	 
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Thing is Success", "processTime":null }]}    	 
    ${responseObjectDetail}=    Set Variable    null

    ${identity}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}	

	#====== Check log ==========

	#Check log detail and summary
	Log ServerDestination HTTP Error    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}    ${VALUE_LOG_CODE_40400}    ${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}    ${createResponse}    ${pathUrl}    ${dataSearch}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail}    ${identity}    ${ThingIdentifier}    ${ThingSecret} 
    
    [Teardown]    Generic Test Case Teardown HTTP    ${SERVERDESTINATION_HTTP}    ${createResponse}