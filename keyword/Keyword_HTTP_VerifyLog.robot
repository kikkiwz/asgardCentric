*** Keywords ***
####################################################
Log ServerDestination HTTP Success
	[Arguments]    ${getData}    ${pathUrl}    ${dataSearch}
    
    #/api/v2/things/ThingIdentifier/ThingSecret/server/destination
	${identity}=    Set Variable    {\"ThingIdentifier\":\"${ThingIdentifier}\",\"ThingSecret\":\"${ThingSecret}\"}
	${endPointName}=    Set Variable    ["db.WorkersCollection","db.ThingsCollection"]
    ${custom}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Thing is Success", "processTime":null }, { "no":"2", "endPointName":"db.WorkersCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Worker is Success", "processTime":null}]}    	 
	${customDetailDB}=    Set Variable    { "endPointSummary":[ { "no":"1", "endPointName":"db.WorkersCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Worker is Success", "processTime":null}, { "no":"2", "endPointName":"db.ThingsCollection", "endPointURL":null, "responseStatus":"20000:Inquiry Thing is Success", "processTime":null }]}    	 
    ${responseObjectDetail}=    Set Variable    null

	${body}=    Set Variable    {}
	${response}=    Set Variable    {"ServerIP":"${getData}[2]","ServerPort":"${getData}[3]","ServerDomain":"${getData}[4]"}

	#resultCode_summary[20000],resultDesc_summary[The requested operation was successfully],Code_detail[20000],Description_detail[The requested operation was successfully],applicationName[asgradcoap],pathUrl[/api/v2/things/ThingIdentifier/ThingSecret/server/destination],urlCmdName[],dataSearch,body[request],response[response],namespace[mgcentric],containerId[coapapp-vXX],identity,cmdName[ServerDestination],endPointName[],logLevel[info],custom,customDetailDB,responseObjectDetail
	Check Log Response    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_SERVERDESTINATION_SUCCESS}    ${VALUE_LOG_CODE_20000}    ${VALUE_DESCRIPTION_SERVERDESTINATION_SUCCESS}    ${VALUE_APPLICATIONNAME_ASGARDHTTP}    ${pathUrl}    null    ${dataSearch}    ${body}    ${response}    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_CENTRIC_ASGARDHTTP}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail}  

Log ServerDestination HTTP Error
	[Arguments]    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${getData}    ${pathUrl}    ${dataSearch}    ${endPointName}    ${custom}    ${customDetailDB}    ${responseObjectDetail}    ${identity}    ${ThingIdentifier}    ${ThingSecret}

    #/api/v2/things/ThingIdentifier/ThingSecret/server/destination
    ${response}=    Set Variable    ${getData}
	${body}=    Set Variable    {}
	
	#resultCode_summary[40300],resultDesc_summary[Forbidden],Code_detail[40300],Description_detail[The requested operation could not be found.],applicationName[ProvisioningAPIs],pathUrl[mg-iot.siamimo.com/api/v1/auth/signin],dataSearch,accessToken,accountId,body[request],response[response],namespace[magellan],containerId[provisioningapis-vXX],identity,cmdName[SignInProcess],endPointName[],logLevel[INFO],custom,customDetailDB,responseObjectDetail
    Check Log Response    ${ResultCode}    ${ResultDesc}    ${Code}    ${Desc}    ${VALUE_APPLICATIONNAME_ASGARDHTTP}    ${pathUrl}    null    ${dataSearch}    ${body}    ${response}    ${VALUE_LOG_NAMESPACE}    ${VALUE_LOG_CONTAINERID_CENTRIC_ASGARDHTTP}    ${identity}    ${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ${endPointName}    ${VALUE_LOG_DETAIL_LOGLEVEL}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
