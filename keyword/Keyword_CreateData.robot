*** Keywords ***
ValidateToken
    [Arguments]    ${url}    ${accessToken}
    ${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_VALIDATETOKEN}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_VALIDATETOKEN}    Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}
	
    ${data}=    Evaluate    {"AccessToken": "${accessToken}"}   
	${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_VALIDATETOKEN}    ${headers}    ${data}
	#Log To Console    Response ValidateToken : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${VALIDATETOKEN}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
Create Partner
    [Arguments]    ${url}    ${accessToken}
    #Generate Random number
    ${random_number}=    generate random string    6    [NUMBERS]
	#PartnerName
	${PartnerName}=    Set Variable    ${VALUE_PARTNERNAME}${random_number}
	#MerchantContact
	${MerchantContact}=    Set Variable    ${VALUE_MERCHANTCONTACT}
	#CPID
	${CPID}=    Set Variable    ${VALUE_CPID}
	
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATEPARTNER}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATEPARTNER}    x-ais-AccessToken=Bearer ${accessToken}    Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}
				
    ${data}=    Evaluate    {"PartnerName": "${PartnerName}","PartnerType": ["Supplier","Customer"],"PartnerDetail": {"MerchantContact": "${MerchantContact}","CPID": "${CPID}"},"Property": {"RouteEngine": "false"}}   
    #Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_CREATEPARTNER}    ${headers}    ${data}
    Log To Console    Response Create Partner : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATEPARTNER}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
	#GetResponse_PartnerId
    ${PartnerInfo}=    Get From Dictionary    ${res}     ${FIELD_PARTNERINFO}   
    # Log To Console    ${PartnerInfo}	
	${GetResponse_PartnerId}=    Get From Dictionary    ${PartnerInfo}     ${FIELD_PARTNERID}    
	# Log To Console    ${GetResponse_PartnerId}	
	${GetResponse_CustomerId}=    Get From Dictionary    ${PartnerInfo}     ${FIELD_CUSTOMERID}
    ${PartnerType}=    Set Variable     ${PartnerInfo['PartnerType']}
	${setPartnerTypeArr}=    Set Variable    '${PartnerType}[0]', '${PartnerType}[1]' 
    ${Property}=    Set Variable     ${PartnerInfo['Property']}
	${RouteEngine}=    Set Variable    ${Property['RouteEngine']}
    #AccountName
    ${AccountName}=    Set Variable    ${VALUE_ACCOUNTNAME}${random_number}
    #Log To Console    ${AccountName}
    #ConfigGroupName
    ${ConfigGroupName}=    Set Variable    ${VALUE_CONFIGGROUPNAME}${random_number}
    #Log To Console    ${ConfigGroupName}
    [Return]    ${GetResponse_PartnerId}    ${AccountName}    ${ConfigGroupName}    ${PartnerName}    ${GetResponse_CustomerId}    ${setPartnerTypeArr}    ${RouteEngine}    ${MerchantContact}    ${CPID}   

Create Account
    [Arguments]    ${url}    ${accessToken}    ${PartnerId}    ${AccountName}
    ${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary    Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATEACCOUNT}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATEACCOUNT}    x-ais-AccessToken=Bearer ${accessToken}    Accept=${HEADER_ACCEPT}
    #Log To Console    ${headers}
    ${randomSensorApp}=    Evaluate    random.randint(100, 999)    random
    ${data}=    Evaluate    {"PartnerID": "${PartnerId}","AccountName": "${AccountName}${randomSensorApp}"}

    #Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_CREATEACCOUNT}    ${headers}    ${data}
	Log To Console    Response Create Account : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATEACCOUNT}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
	#GetResponse_AccountName
    ${PartnerInfo}=    Get From Dictionary    ${res}     ${FIELD_PARTNERINFO}   
    #Log To Console    ${PartnerInfo}	
	${AccountInfo}=    Get From Dictionary    ${PartnerInfo}     ${FIELD_ACCOUNTINFO}  
	#Log To Console    ${AccountInfo}	
	${GetResponse_AccountName}=    Get From Dictionary    ${AccountInfo}[0]     ${FIELD_ACCOUNTNAME}    
	#Log To Console    ${GetResponse_AccountName}
	#GetResponse_AccountId
	${GetResponse_AccountId}=        Get From Dictionary    ${AccountInfo}[0]     ${FIELD_ACCOUNTID}    
    #Log To Console    ${GetResponse_AccountId} 
	
	[return]    ${GetResponse_AccountId}     ${GetResponse_AccountName}    

Create Thing
    [Arguments]    ${url}    ${accessToken}    ${AccountId}    ${AccountName}
    ${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary    Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATETHING}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATETHING}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}    Accept=${HEADER_ACCEPT}
    #Log To Console    ${headers}
    #random_IM
    ${randomIM1}=    Evaluate    random.randint(10000000, 99999999)    random
    ${randomIM2}=    Evaluate    random.randint(1000000, 9999999)    random
    ${random_IM}=    Set Variable    ${randomIM1} ${randomIM2}
    #Log To Console    ${random_IM}
    #random_ICCID
    ${randomICCID1}=    Evaluate    random.randint(1000000, 9999999)    random
    ${randomICCID2}=    Evaluate    random.randint(100000, 999999)    random
    ${random_ICCID}=    Set Variable    ${randomICCID1} ${randomICCID2}
    #Log To Console    ${random_ICCID}
    #ThingName
    ${random_number}=    generate random string    6    [NUMBERS]
	${ThingName}=    Set Variable    ${VALUE_THINGNAME}${random_number}
    #Log To Console    ${ThingName} 

    ${data}=    Evaluate    {"ThingName": "${ThingName}","IMEI": "${random_IM}","IMSI": "${random_IM}","ICCID": "${random_ICCID}","RouteUrl": ${VALUE_ROUTEURL},"RouteInfo": {"MIMO_ID": ${VALUE_ROUTEINFO_MIMO_ID},"MIMO_SerialNo": ${VALUE_ROUTEINFO_MIMO_SERIALNO}},"RouteFlag": {"ThingName": ${VALUE_ROUTEFLAG_THINGNAME},"ThingToken": ${VALUE_ROUTEFLAG_THINGTOKEN},"IMEI": ${VALUE_ROUTEFLAG_IMEI},"ICCID": ${VALUE_ROUTEFLAG_ICCID},"RouteInfo": ${VALUE_ROUTEFLAG_ROUTEINFO}}}   
    #Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_CREATETHING}    ${headers}    ${data}
	#Log To Console    Response Create Thing : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATETHING}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
	#GetResponse_ThingID
    ${ThingInfo}=    Get From Dictionary    ${res}     ${FIELD_THINGINFO}   
    #Log To Console    ${ThingInfo}	
	${GetResponse_ThingID}=    Get From Dictionary    ${ThingInfo}     ${FIELD_THINGID}    
	#Log To Console    ${GetResponse_ThingID}
	${GetResponse_IMSI}=    Get From Dictionary    ${ThingInfo}     ${FIELD_IMSI}    
	#Log To Console    ${GetResponse_IMSI}
	${GetResponse_ThingToken}=    Get From Dictionary    ${ThingInfo}     ${FIELD_THINGTOKEN}  
	#Log To Console    ${GetResponse_ThingToken}
	
	[return]    ${GetResponse_ThingID}    ${GetResponse_IMSI}    ${GetResponse_ThingToken}
	
Create ThingStateInfo
    [Arguments]    ${url}    ${accessToken}    ${AccountId}    ${ThingId}    ${type}    ${SensorKey}
    ${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary    Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATETHINGSTATEINFO}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATETHINGSTATEINFO}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}    Accept=${HEADER_ACCEPT}
    #Log To Console    ${headers}
    #random_Sensor
    ${random_Sensor}=    Evaluate    random.randint(100, 999)    random
    #${random_Sensor}=    Set Variable    ${randomSensor1}
    #Log To Console    ${random_Sensor}
    # ${setThingId}=    Set Variable    ["${ThingId}"]

    ${data}=    Evaluate    {"ThingId": ${ThingId},"Type": "${type}", "Sensor": {"${SensorKey}": "${random_Sensor}"}}
    Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_CREATETHINGSTATEINFO}    ${headers}    ${data}
	#Log To Console    Response Create ThingStateInfo : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATETHINGSTATEINFO}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
	[return]    ${type}    ${SensorKey}    ${random_Sensor}  

Create ControlThing
    [Arguments]    ${url}    ${accessToken}    ${ThingId}    ${AccountId}    ${SensorKey}    ${random_Sensor}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATECONTROLTHING}${current_timestamp}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}
	#Log To Console    ${headers}
	#{"${VALUE_SENSORKEY}": "${random_Sensor_App}"}  
	#random_Sensor_Report
	${random_Sensor_App}=    Evaluate    random.randint(100, 999)    random
	#Set Global Variable    ${randomSensorApp}    ${random_Sensor_App}
			 
    ${data}=    Evaluate    {"ThingId": "${ThingId}", "Sensors": {"${SensorKey}": "${random_Sensor_App}"}}   
    #Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${CONTROLAPIS}    ${URL_CREATECONTROLTHING}    ${headers}    ${data}
	#Log To Console    Response Create ControlThing : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATECONTROLTHING}    ${FIELD_OPERATIONSTATUS_LOWCASE}    ${FIELD_CODE_LOWCASE}    ${FIELD_DESCRIPTION_LOWCASE}
		
	[return]    ${random_Sensor_App}  
	
Create ConfigGroup
    [Arguments]    ${url}    ${accessToken}    ${ThingId}    ${AccountId}    ${ConfigGroupName}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATECONFIGGROUP}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATECONFIGGROUP}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}        Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}
	#"ConfigInfo": {"RefreshTime": "On","Max": "99"}	 
    ${data}=    Evaluate    {"ConfigName": "${ConfigGroupName}","ThingId": ["${ThingId}"], "ConfigInfo": {"${VALUE_CONFIGINFO_KEY_REFRESHTIME}": "${VALUE_CONFIGINFO_KEY_REFRESHTIME_VALUE}","${VALUE_CONFIGINFO_KEY_MAX}": "${VALUE_CONFIGINFO_KEY_MAX_VALUE}"}}   
    #Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${PROVISIONINGAPIS}    ${URL_CREATECONFIGGROUP}    ${headers}    ${data}
	#Log To Console    Response Create ConfigGroup : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATECONFIGGROUP}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	
	#GetResponse_ConfigGroupInfo
    ${ConfigGroupInfo}=    Get From Dictionary    ${res}     ${FIELD_CONFIGGROUPINFO}   
    #Log To Console    ${ConfigGroupInfo}	
	${GetResponse_ConfigGroupId}=    Get From Dictionary    ${ConfigGroupInfo}     ${FIELD_CONFIGGROUPID}    
    #Log To Console    GetResponse_ConfigGroupId${GetResponse_ConfigGroupId}	
	[return]    ${GetResponse_ConfigGroupId}
	
Create A Worker
    [Arguments]    ${url}    ${ServerIP}    ${ServerPort}    ${ServerDomain}    ${WorkerState}    
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATEAWORKER}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATEAWORKER}
	#Log To Console    ${headers}
	
	#ThingName
	${random1}=    Evaluate    random.randint(100, 999)    random
	${random2}=    Evaluate    random.randint(100, 999)    random
    ${string_random}=    Generate Random String    5    [LETTERS]
	${random_number}=    Set Variable    ${string_random}${random1}${random2}
	${WorkerName}=    Set Variable    ${VALUE_WORKNAME}${random_number}
    #Log To Console    ${ThingName} 
	
    ${data}=    Evaluate    { "WorkerName": "${WorkerName}", "ServerProperties": { "ServerIP": "${ServerIP}", "ServerPort": "${ServerPort}", "ServerDomain": "${ServerDomain}" }, "WorkerState": "${WorkerState}" }  
    # Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${CENTRICAPIS}    ${URL_CREATEAWORKER}    ${headers}    ${data}
	Log To Console    Response Create A Worker : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATEAWORKER}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DEVELOPERMESSAGE}
	
	#GetResponse_ThingID
    ${WorkersInfo}=    Get From Dictionary    ${res}     ${FIELD_WORKERSINFO}   
    #Log To Console    ${WorkersInfo}	
	${GetResponse_WorkerID}=    Get From Dictionary    ${WorkersInfo}     ${FIELD_WORKERID}    
	#Log To Console    ${GetResponse_WorkerID}
	
	[return]    ${GetResponse_WorkerID}    ${WorkerName}    ${ServerIP}    ${ServerPort}    ${ServerDomain}    ${WorkerState}

Create A Thing Not Have WorkerId
    [Arguments]    ${url}    ${ConnectivityType}    ${ThingState}    ${ThingIdentifier}    ${ThingSecret}    ${imei}    
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_CREATEATHING}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_CREATEATHING}
	#Log To Console    ${headers}
	
	#ThingName
	${random1}=    Evaluate    random.randint(100, 999)    random
	${random2}=    Evaluate    random.randint(100, 999)    random
    ${string_random}=    Generate Random String    5    [LETTERS]
	${random_number}=    Set Variable    ${string_random}${random1}${random2}
	${ThingName}=    Set Variable    ${VALUE_ATHINGNAME}${random_number}
    #Log To Console    ${ThingName}

	#SupplierId
	${SupplierId}=    Set Variable    ${VALUE_SUPPLIERID}${random_number}
	#SupplierName
	${SupplierName}=    Set Variable    ${VALUE_SUPPLIERNAME}${random_number} 

    ${data}=    Evaluate    {"ConnectivityType":"${ConnectivityType}","ThingName":"${ThingName}","ThingIdentifier":"${ThingIdentifier}","ThingSecret":"${ThingSecret}","IMEI":"${imei}","ThingState":"${ThingState}","CustomDetails":{},"SupplierDetail":{"SupplierId": "${SupplierId}", "SupplierName": "${SupplierName}" } }   
    # Log To Console    ${data}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${CENTRICAPIS}    ${URL_CREATEATHING}    ${headers}    ${data}
	Log To Console    Response Create A Thing Not Have WorkerId : ${res}
	Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${CREATEATHING}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DEVELOPERMESSAGE}
	
	#GetResponse_ThingID
    ${ThingInfo}=    Get From Dictionary    ${res}     ${FIELD_THINGINFO}   
    #Log To Console    ${ThingInfo}	
	${GetResponse_ThingID}=    Get From Dictionary    ${ThingInfo}     ${FIELD_THINGID}    
	# Log To Console    ${GetResponse_ThingID}
	# ${GetResponse_IMEI}=    Get From Dictionary    ${ThingInfo}     ${FIELD_IMEI}    
	# #Log To Console    ${GetResponse_IMEI}
	# ${GetResponse_ThingIdentifier}=    Get From Dictionary    ${ThingInfo}     ${FIELD_THINGIDENTIFIER}  
	# #Log To Console    ${GetResponse_ThingIdentifier}
	# ${GetResponse_ThingSecret}=    Get From Dictionary    ${ThingInfo}     ${FIELD_THINGSECRET}  
	# #Log To Console    ${GetResponse_ThingSecret}
	
	[return]    ${GetResponse_ThingID}

Activate Things
    [Arguments]    ${url}    ${WorkerId}    ${ThingIdentifier}    ${ThingSecret}    ${imei}    
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_ACTIVATETHINGS}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_ACTIVATETHINGS}  
	#Log To Console    ${headers}

    ${data}=    Evaluate    [ { "ThingIdentifier": "${ThingIdentifier}", "ThingSecret": "${ThingSecret}", "IMEI": "${imei}" } ]
    #Log To Console    ${data}

	${replaceUrl}=    Replace String    ${URL_ACTIVATETHINGS}    {WorkerId}    ${WorkerId}
	# Log To Console    ${replaceUrl}

    ${res}=    Run keyword And Continue On Failure    Post Api Request    ${url}${CENTRICAPIS}    ${replaceUrl}    ${headers}    ${data}
	Log To Console    Response Activate Things : ${res}

	# Response ResultCode Should Have    ${res}    ${ACTIVATETHINGS}    ${FIELD_OPERATIONSTATUS}    ${FIELD_STATUS}    ${FIELD_STATUSDESCRIPTION}
	${data_count}=    Get Length    ${res}
    # Log To Console    ${data_count}
	FOR    ${i}    IN RANGE    ${data_count}
		#GetResponse_ThingID
    	${status}=    Get From Dictionary    ${res}[${i}]     ${FIELD_STATUS}
		# Log To Console    ${status}
		${StatusDespcription}=    Set Variable   ${res}[${i}][${FIELD_STATUSDESCRIPTION}]
		# Log To Console    ${StatusDespcription}
	    Run keyword And Continue On Failure    Response ResultCode Should Have Success    ${status}    ${StatusDespcription}    ${ACTIVATETHINGS}
	#Exit For Loop
	END
	# [return]

Request CreateData for get WorkerId ThingId and ActivateThings	
    [Arguments]    ${ThingIdentifier}    ${ThingSecret}    ${imei}
	${postCreateAWorker}=    Create A Worker    ${URL_CENTRIC}    ${VALUE_SERVERIP}    ${VALUE_SERVERPORT}    ${VALUE_SERVERDOMAIN}    ${VALUE_WORKERSTATE_TERMINATED}    
	# Log To Console    ${postCreateAWorker}
	${postCreateAThingNotHaveWorkerId}=    Create A Thing Not Have WorkerId    ${URL_CENTRIC}    ${VALUE_CONNECTIVITYTYPE_NBIOT}    ${VALUE_THINGSTATE_PENDING}    ${ThingIdentifier}    ${ThingSecret}    ${imei}
	# Log To Console    ${postCreateAThingNotHaveWorkerId}
	${postActivateThings}=    Activate Things    ${URL_CENTRIC}    ${postCreateAWorker}[0]    ${ThingIdentifier}    ${ThingSecret}    ${imei} 
	# Log To Console    postActivateThings${postActivateThings}
	#WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId,ThingIdentifier,ThingSecret,ThingSecret
    [return]    ${postCreateAWorker}[0]    ${postCreateAWorker}[1]    ${postCreateAWorker}[2]    ${postCreateAWorker}[3]    ${postCreateAWorker}[4]    ${postCreateAThingNotHaveWorkerId}

Request CreateData for get WorkerId ThingId	
    [Arguments]    ${ThingIdentifier}    ${ThingSecret}    ${imei}    
	${postCreateAWorker}=    Create A Worker    ${URL_CENTRIC}    ${VALUE_SERVERIP}    ${VALUE_SERVERPORT}    ${VALUE_SERVERDOMAIN}    ${VALUE_WORKERSTATE_TERMINATED}    
	# Log To Console    ${postCreateAWorker}
	${postCreateAThingNotHaveWorkerId}=    Create A Thing Not Have WorkerId    ${URL_CENTRIC}    ${VALUE_CONNECTIVITYTYPE_NBIOT}    ${VALUE_THINGSTATE_PENDING}    ${ThingIdentifier}    ${ThingSecret}    ${imei}
	# Log To Console    ${postCreateAThingNotHaveWorkerId}
	#WorkerId,WorkerName,ServerIP,ServerPort,ServerDomain,ThingId,ThingIdentifier,ThingSecret,ThingSecret
    [return]    ${postCreateAWorker}[0]    ${postCreateAWorker}[1]    ${postCreateAWorker}[2]    ${postCreateAWorker}[3]    ${postCreateAWorker}[4]    ${postCreateAThingNotHaveWorkerId}

