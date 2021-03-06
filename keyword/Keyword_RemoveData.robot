*** Keywords ***
Remove Partner
    [Arguments]    ${url}    ${accessToken}    ${PartnerId}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVEPARTNER}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVEPARTNER}    x-ais-AccessToken=Bearer ${accessToken}    Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}
				
    ${data}=    Evaluate    {"PartnerId": "${PartnerId}"}   
    #Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVEPARTNER}    ${headers}    ${data}
	# Log To Console    RemovePartner Response : ${res}
	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVEPARTNER}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemovePartner Result : ${result}
	[return]    ${result}

Remove Account
    [Arguments]    ${url}    ${accessToken}    ${PartnerId}    ${AccountId}
	Log    ${url}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVEACCOUNT}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVEACCOUNT}    x-ais-AccessToken=Bearer ${accessToken}    Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}
				
    ${data}=    Evaluate    {"PartnerID": "${PartnerId}","AccountId": "${AccountId}"}   
    # Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVEACCOUNT}    ${headers}    ${data}
	# Log To Console    RemoveAccount Response : ${res}

	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVEACCOUNT}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemoveAccount Result : ${result}
	[return]    ${result}

Remove Thing
    [Arguments]    ${url}    ${accessToken}    ${ThingID}    ${AccountId}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVETHING}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVETHING}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}        Accept=${HEADER_ACCEPT}  
	# Log To Console    ${headers}
		
    ${data}=    Evaluate    {"ThingId": "${ThingID}"}   
    # Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVETHING}    ${headers}    ${data}
	# Log To Console    RemoveThing Response : ${res}

	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVETHING}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemoveThing Result : ${result}
	[return]    ${result}

Remove ThingStateInfo
    [Arguments]    ${url}    ${accessToken}    ${ThingId}    ${AccountId}    ${Type}    ${SensorKey}

	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVETHINGSTATEINFO}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVETHINGSTATEINFO}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}        Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}

    ${data}=    Evaluate    {"ThingId": "${ThingId}","stateType": "${Type}", "stateKey": "${SensorKey}"}   
    # Log To Console    ${data}
    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVETHINGSTATEINFO}    ${headers}    ${data}
	# Log To Console    RemoveThingStateInfo Response : ${res}

    ${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVETHINGSTATEINFO}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemoveThingStateInfo Result : ${result}

	[return]    ${result}

Remove ThingFromAccount
    [Arguments]    ${url}    ${accessToken}    ${AccountId}    ${ThingId}    
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVETHINGFROMACCOUNT}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVETHINGFROMACCOUNT}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}        Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}

    ${data}=    Evaluate    {"ThingId": ["${ThingID}"]}   
    #Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVETHINGFROMACCOUNT}    ${headers}    ${data}
	# Log To Console    RemoveThingFromAccount Response : ${res}
	
	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVETHINGFROMACCOUNT}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemoveThingFromAccount Result : ${result}
	
	[return]    ${result}

Remove ConfigGroup
    [Arguments]    ${url}    ${accessToken}    ${AccountId}    ${ConfigGroupId}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-UserName=${HEADER_X_AIS_USERNAME_AISPARTNER}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVECONFIGGROUP}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVECONFIGGROUP}    x-ais-AccessToken=Bearer ${accessToken}    x-ais-AccountKey=${AccountId}        Accept=${HEADER_ACCEPT}  
	#Log To Console    ${headers}

    ${data}=    Evaluate    {"ConfigGroupId": "${ConfigGroupId}"}   
    #Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${PROVISIONINGAPIS}    ${URL_REMOVECONFIGGROUP}    ${headers}    ${data}
	# Log To Console    RemoveConfigGroup Response : ${res}

	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVECONFIGGROUP}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
    # Log To Console    RemoveConfigGroup Result : ${result}
	
	[return]    ${result}

Remove A Thing
    [Arguments]    ${url}    ${ThingId}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVEATHING}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVEATHING}
	#Log To Console    ${headers}
		
    # ${data}=    Evaluate    {"ThingId": "${ThingId}"}  
	${data}=    Set Variable    ${EMPTY} 
    # Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${CENTRICAPIS}    ${URL_REMOVEATHING}${ThingId}    ${headers}    ${data}
	Log To Console    Remove A Thing Response : ${res}
	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVEATHING}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	# Log To Console    Remove A Thing Result : ${result}
	[return]    ${result}
	
Remove A Worker
    [Arguments]    ${url}    ${WorkerId}
	${current_timestamp}=    Change format date now    ${DDMMYYYYHMS_NOW}
    ${headers}=    Create Dictionary        Content-Type=${HEADER_CONTENT_TYPE}    x-ais-OrderRef=${HEADER_X_AIS_ORDERREF_REMOVEAWORKER}${current_timestamp}    x-ais-OrderDesc=${HEADER_X_AIS_ORDERDESC_REMOVEAWORKER}  
	#Log To Console    ${headers}
		
    # ${data}=    Evaluate    {"WorkerId": "${WorkerId}"}   
	${data}=    Set Variable    ${EMPTY}
    # Log To Console    ${data}

    ${res}=    Delete Api Request    ${url}${CENTRICAPIS}    ${URL_REMOVEAWORKER}${WorkerId}    ${headers}    ${data}
	Log To Console    Remove A Worker Response : ${res}
	${result}=    Run keyword And Continue On Failure    Response ResultCode Should Have    ${res}    ${REMOVEAWORKER}    ${FIELD_OPERATIONSTATUS}    ${FIELD_CODE}    ${FIELD_DESCRIPTION}
	# Log To Console    Remove A Worker Result : ${result}
	[return]    ${result}

Server Destination Request RemoveData
    #ThingId,WorkerId
    [Arguments]    ${ThingId}    ${WorkerId}
	${deleteRemoveAThing}=    Remove A Thing    ${URL_CENTRIC}    ${ThingId}
	${deleteRemoveAWorker}=    Remove A Worker    ${URL_CENTRIC}    ${WorkerId} 
	# Log To Console    deleteRemoveAThing${deleteRemoveAThing}
	# Log To Console    deleteRemoveAWorker${deleteRemoveAWorker}
    
	${result}=    Set Variable If    '${deleteRemoveAThing}'=='true' and '${deleteRemoveAWorker}'=='true'    true
    ...    '${deleteRemoveAThing}'!='true' and '${deleteRemoveAWorker}'!='true'    false
    # Log To Console    Group Request RemoveData : ${result}
	[return]    ${result}

