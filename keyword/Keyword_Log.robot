*** Keywords ***	
Post Search Log
    [Arguments]    ${url}    ${valueSearch}    ${value_applicationName}    
	${headers}=    Create Dictionary    Content-Type=${HEADER_CONTENT_TYPE}    Authorization=${HEADER_AUTHENTICATION}    kbn-version=7.5.1  
    #${headers}=    Create Dictionary    Content-Type=${HEADER_CONTENT_TYPE}    Host=azmagellancd001-iot.southeastasia.cloudapp.azure.com:30380    kbn-version=7.5.1    Origin=http://azmagellancd001-iot.southeastasia.cloudapp.azure.com:30380    
	#Log To Console    ${headers}
	
	#return valueDateGte,valueDateLte (RANGE_SEARCH 15 minutes)
	${setRange}=    Rang Get Value Minus Time Current Date and Change Format    ${YYYYMMDDTHMSZ_FROM_NOW}    ${RANGE_SEARCH}    ${TIME_STRING_MINUTES}
	#${setRange}=    Rang Get Value Minus Time Current Date and Change Format    ${YYYYMMDDTHMSZ_FROM_NOW}    50    ${TIME_STRING_MINUTES}
	#Log To Console    setRange${setRange}
	${setRangeGTE}=    Set variable    ${setRange}[0]
	${setRangeLTE}=    Set variable    ${setRange}[1]
	#Log To Console    setRangeGTE${setRangeGTE}
	#Log To Console    setRangeLTE${setRangeLTE}

	Log    valueSearch${valueSearch}
	# Log To Console    valueSearch${valueSearch}
	
	# best_fields phrase
	${multiMatchType}=    Set Variable    phrase 
	
    ${data}=    Evaluate    {"version":"true","size":500,"sort":[{"@timestamp_es":{"order":"desc","unmapped_type":"boolean"}}],"_source":{"excludes":[]},"aggs":{"2":{"date_histogram":{"field":"@timestamp_es","fixed_interval":"30s","time_zone":"Asia/Bangkok","min_doc_count":1}}},"stored_fields":["*"],"script_fields":{},"docvalue_fields":[{"field":"@timestamp_es","format":"date_time"},{"field":"cauldron.custom1.activityLog.endTime","format":"date_time"},{"field":"cauldron.custom1.activityLog.startTime","format":"date_time"},{"field":"time","format":"date_time"}],"query":{"bool":{"must":[],"filter":[{"multi_match":{"type":"${multiMatchType}","query":"${valueSearch}","lenient":"true"}},{"range":{"@timestamp_es":{"format":"strict_date_optional_time","gte":"${setRangeGTE}","lte":"${setRangeLTE}"}}}],"should":[],"must_not":[]}},"highlight":{"pre_tags":["@kibana-highlighted-field@"],"post_tags":["@/kibana-highlighted-field@"],"fields":{"*":{}},"fragment_size":2147483647}}
    # Log To Console    ${data}
	#Log To Console    ${url}
	${res}=    Post Api Request    ${url}    ${EMPTY}    ${headers}    ${data}
	Log    ${res}
	# Log To Console    ${res}
	${total}=    Set variable    ${res['hits']['total']}
	Log    ${total}
	${total_str}    Convert To String    ${total}
	Should Not Be Equal     ${total_str}    0
	Log To Console    Total Of Search Log : ${total_str}  
	#Sleep    10s
	[return]    ${res}

Get tid for Search Log
    [Arguments]    ${value_applicationName}    ${imsi_thingToken}    ${endPointName}
	#Log To Console    value_applicationName${value_applicationName}	
	#Log To Console    imsi_thingToken${imsi_thingToken}	
	${resLog}=    Wait Until Keyword Succeeds    5x    15s    Post Search Log    ${URL_GET_LOG}    ${imsi_thingToken}    ${value_applicationName}

	# ${resLog}=    Post Search Log    ${URL_GET_LOG}    ${imsi_thingToken}    ${value_applicationName}
	# Sleep    10s
	Log    resLog${resLog}	
	${total}=    Set variable    ${resLog['hits']['total']}
	# Log To Console    resLog${resLog}  
	# Log To Console    total${total}  
	@{valArrData}=    Create List
	FOR    ${i}    IN RANGE    ${total}
        # Log To Console    ${i}  
	    ${valLog}=    Set variable    ${resLo g['hits']['hits'][${i}]['_source']['cauldron']}
        # Log To Console    applicationName${valLog['applicationName']}
        # Log To Console    valLog${valLog}
		
	    ${applicationName}=    Set variable    ${valLog['applicationName']}
        # Log To Console    applicationName${applicationName}
  
		Run Keyword If    '${applicationName}'=='${value_applicationName}'     Append To List    ${valArrData}    ${valLog}        #Add data to array set at valArrData
		# Run Keyword If    '${imsi_thingToken}'=='${ASGARD_COAPAPI_VALUE_TST_F4_0_2_003_DATASEARCH}'    Append To List    ${valArrData}    ${valLog}        #Add data to array set at valArrData
		
        # Exit For Loop
	END
	#Log To Console    tivalArrDatad${valArrData}
    ${tid}=    Set variable    ${valArrData[0]['tid']}
	# Log To Console    tid${tid}
	${sessionId}=    Set variable    ${valArrData[0]['sessionId']}
	# Log To Console    sessionId${sessionId}
    [return]    ${tid}    ${sessionId}
	
Data Log Response
    [Arguments]    ${value_applicationName}    ${imsi_thingToken}    ${endPointName}
	
	Sleep    5s
	${resTid}=    Get tid for Search Log    ${value_applicationName}    ${imsi_thingToken}    ${endPointName}
	
	${getTidSessionId}=    Set Variable If	'${value_applicationName}'=='${VALUE_APPLICATIONNAME_CHARGING}'    ${resTid}[1]    
	...    '${value_applicationName}'!='${VALUE_APPLICATIONNAME_CHARGING}'    ${resTid}[0]
	# ${resTid}=    Get tid for Search Log    ${value_applicationName}    ${imsi_thingToken}    ${endPointName}
	# Log To Console    resTid${resTid}	
	#Log To Console    getTidSessionId${getTidSessionId}	
   
	${resLog}=    Post Search Log    ${URL_GET_LOG}    ${getTidSessionId}    ${value_applicationName}
    Log    resLog${resLog}	
	Sleep    10s
		
	${total}=    Set variable    ${resLog['hits']['total']}
	# Log To Console    total${total}
	
    @{valArrData}=    Create List
	@{valArrDetail}=    Create List
	@{valArrSummary}=    Create List
	FOR    ${i}    IN RANGE    ${total}
        # Log To Console    ${i}  
	    ${valLog}=    Set variable    ${resLog['hits']['hits'][${i}]['_source']['log']}
        # Log To Console    valLog${valLog}

        # r use for parameter / have in data 
	    ${dataResponse}=    Evaluate    json.loads(r'''${valLog}''')    json
        # Log To Console    dataRespon/se${dataResponse}
	    Log    ${dataResponse}
	    ${applicationName}=    Set variable    ${dataResponse['applicationName']}
		Log    ${applicationName}
        # Log To Console    applicationName${applicationName}
		${logType}=    Set variable    ${dataResponse['logType']}
		Log    ${logType}
        # Log To Console    logType${logType}

	    Run Keyword If    '${applicationName}'=='${value_applicationName}'    Append To List    ${valArrData}    ${dataResponse}    #Add data to array set at valArrData
		Run Keyword If    '${applicationName}'=='${value_applicationName}' and '${logType}'=='${VALUE_DETAIL}'   Append To List    ${valArrDetail}    ${dataResponse}    #Add data to array set at valArrDetail
		Run Keyword If    '${applicationName}'=='${value_applicationName}' and '${logType}'=='${VALUE_SUMMARY}'   Append To List    ${valArrSummary}    ${dataResponse}    #Add data to array set at valArrSummary
		
    END
	# Log To Console    valArrData${valArrData}  
	# Log To Console    valArrDetail${valArrDetail}  
	# Log To Console    valArrSummary${valArrSummary}  
    [return]    ${valArrData}    ${valArrDetail}    ${valArrSummary}    ${resTid}[0]    ${resTid}[1]

Check Log Detail 
    [Arguments]    ${code}    ${description}     ${data}    ${tid}    ${applicationName}     ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${identity}    ${custom}    ${customDetailDB}    ${responseObjectDetail}   

    Log    data${data} 
	
	${dataLogDetail}=    Log Detail Check EndPointName    ${data}
    Log    ${dataLogDetail}    
	#value ArrDetail Have EndPointName
	${valArrDetailHaveEndPointName}=    Set Variable    ${dataLogDetail}[0]
	#value ArrDetail Not Have EndPointName
	${valArrDetailNotHaveEndPointName}=    Set Variable    ${dataLogDetail}[1]

	# Log To Console    valArrDetailHaveEndPointName${valArrDetailHaveEndPointName}  
	# Log To Console    valArrDetailNotHaveEndPointName${valArrDetailNotHaveEndPointName}  

	${langValArrDetailHaveEndPointName}=    Get Length    ${valArrDetailHaveEndPointName}
    # Log To Console    langValArrDetailHaveEndPointName${langValArrDetailHaveEndPointName}  

	${langValArrDetailNotHaveEndPointName}=    Get Length    ${valArrDetailNotHaveEndPointName}
    # Log To Console    langValArrDetailNotHaveEndPointName${langValArrDetailNotHaveEndPointName}  
	
	Run Keyword If    '${langValArrDetailHaveEndPointName}'!='0'    Check Log Detail Have EndPointName    ${code}    ${description}     ${valArrDetailHaveEndPointName}    ${tid}    ${applicationName}     ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${custom}    ${customDetailDB}
    Run Keyword If    '${langValArrDetailNotHaveEndPointName}'!='0'    Check Log Detail App Do Not Have EndPointName    ${code}    ${description}     ${valArrDetailNotHaveEndPointName}    ${tid}    ${applicationName}     ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${identity}    ${custom}    ${responseObjectDetail} 

Log Detail Check EndPointName
    [Arguments]    ${data}
	${data_count}=    Get Length    ${data}
	#Log To Console    data_count${data_count}
    @{valArrDetailHaveEndPointName}=    Create List
	@{valArrDetailNotHaveEndPointName}=    Create List
    FOR    ${i}    IN RANGE    ${data_count}
	    ${keyCustom1}=    Set Variable   @{data[${i}]['custom1']}
		# Log To Console    ${keyCustom1}    
		${checkKeyEndPointName}=    Get Matches    ${keyCustom1}    endPointName
		${countKeyEndPointName}=    Get Length    ${checkKeyEndPointName}
		#Log To Console    checkKeyEndPointName${checkKeyEndPointName} 
		#Log To Console    countKeyEndPointName${countKeyEndPointName} 
		Run Keyword If    ${countKeyEndPointName}==1    Append To List    ${valArrDetailHaveEndPointName}    ${data}[${i}]    #Add data to array set at valArrData
		Run Keyword If    ${countKeyEndPointName}==0    Append To List    ${valArrDetailNotHaveEndPointName}    ${data}[${i}]    #Add data to array set at valArrData
		
		#${data[${i}]['custom1']['endPointName']}
	END	
	# Log To Console    valArrDetailHaveEndPointName${valArrDetailHaveEndPointName}  
	# Log To Console    valArrDetailNotHaveEndPointName${valArrDetailNotHaveEndPointName}  
	[return]    ${valArrDetailHaveEndPointName}    ${valArrDetailNotHaveEndPointName}

#-------------------------------------------- Check Log Detail Have EndPointName --------------------------------------------#	
Check Log Detail Have EndPointName  
    [Arguments]    ${code}    ${description}     ${data}    ${tid}    ${applicationName}     ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${custom}    ${customDetailDB}
    ${data_count}=    Get Length    ${data}
	# Log To Console    data_count${data_count}  
	# Log To Console    data${data} 
	# ${thingToken}=    Set Variable
	FOR    ${i}    IN RANGE    ${data_count}
		
		#Log To Console    ${data[${i}]['custom1']['requestObject']}
		#Log To Console    ${data[${i}]['custom1']['endPointName']}
		#Log To Console    ${code}
		
	    ${dataResponse}=    Set Variable    ${data[${i}]}
		# Log To Console    dataResponse${dataResponse}  
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_SYSTEMTIMESTAP}']    ${data[${i}]['systemTimestamp']}    ${FIELD_LOG_DETAIL_SYSTEMTIMESTAP}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_LOGTYPE}']    ${VALUE_DETAIL}    ${FIELD_LOG_DETAIL_LOGTYPE} 
        Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_LOGLEVEL}']    ${logLevel}    ${FIELD_LOG_DETAIL_LOGLEVEL} 
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_NAMESPACE}']    ${namespace}    ${FIELD_LOG_DETAIL_NAMESPACE}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_APPLICATIONNAME}']    ${applicationName}    ${FIELD_LOG_DETAIL_APPLICATIONNAME}
		#Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CONTAINERID}']    ${containerId}    ${FIELD_LOG_DETAIL_CONTAINERID}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_SESSIONID}']    ${tid}    ${FIELD_LOG_DETAIL_SESSIONID}
		#Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_TID}']    ${tid}    ${FIELD_LOG_DETAIL_TID}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_STARTTIME}']    ${data[${i}]['custom1']['activityLog']['startTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_STARTTIME} 
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_ENDTIME}']    ${data[${i}]['custom1']['activityLog']['endTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_ENDTIME}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_PROCESSTIME}']    ${data[${i}]['custom1']['activityLog']['processTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_PROCESSTIME}
        Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM2}']    ${VALUE_LOG_DETAIL_CUSTOM2}    ${FIELD_LOG_DETAIL_CUSTOM2}
    
		#Custom
		#Check endPointName

		#Check requestObject responseObject 
        ${json_customDetailDB}=    Convert String to JSON    ${customDetailDB}
		# Log To Console    json_custom${json_custom}
		${json_endPointName}=    Convert String to JSON    ${endPointName}
		#  Log To Console    json_endPointName${json_endPointName}  
		  
		${dataCustomDetailDB}=    Set Variable    ${json_customDetailDB['endPointSummary'][${i}]}
		# Log To Console    dataCustomDetailDB${dataCustomDetailDB}  
		${dataEndPointName}=    Set Variable    ${json_endPointName[${i}]}
		# Log To Console    dataEndPointName${dataEndPointName}  
		Check Log Detail Custom RequestObject and ResponseObject DB    ${code}    ${description}    ${dataResponse}    ${dataSearch}    ${body}    ${tid}    ${urlCmdName}    ${cmdName}    ${dataEndPointName}    ${response}    ${applicationName}    ${custom}    ${dataCustomDetailDB} 
    
	END

#-------------------------------------------- Check Log Detail : RequestObject and ResponseObject Have EndPointName --------------------------------------------#		
Check Log Detail Custom RequestObject and ResponseObject DB
	[Arguments]    ${code}    ${description}    ${dataResponse}    ${dataSearch}    ${body}    ${tid}    ${urlCmdName}    ${cmdName}    ${endPointName}    ${response}    ${applicationName}   ${custom}    ${dataCustomDetailDB} 
	#-------------------------------------------- Coapp App --------------------------------------------#
	#endPointName : Coapp App [Server Destination]
	Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}'    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ENDPOINTNAME}']    ${endPointName}    ['endPointName']
    #RequestObject : Coapp App [Server Destination]
    Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}'    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['requestObject']    ${VALUE_LOG_DETAIL_REQUESTOBJECT_COAPAPP_DB}    requestObject    
    #ResponseObject : Coapp App [Server Destination]
    Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}'    Check ResponseObject Success DB    ${VALUE_LOG_CODE_20000}    ${dataCustomDetailDB['responseStatus']}    ${dataResponse}

#-------------------------------------------- Check Log Detail Do Not Have EndPointName --------------------------------------------#		
Check Log Detail App Do Not Have EndPointName
    [Arguments]    ${code}    ${description}     ${data}    ${tid}    ${applicationName}     ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${identity}    ${custom}    ${responseObjectDetail} 
    ${data_count}=    Get Length    ${data}
	#Log To Console    data_count${data_count}  
	FOR    ${i}    IN RANGE    ${data_count}
	 
	    ${dataResponse}=    Set Variable    ${data[${i}]}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_SYSTEMTIMESTAP}']    ${data[${i}]['systemTimestamp']}    ${FIELD_LOG_DETAIL_SYSTEMTIMESTAP}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_LOGTYPE}']    ${VALUE_DETAIL}    ${FIELD_LOG_DETAIL_LOGTYPE}
        Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_LOGLEVEL}']    ${logLevel}    ${FIELD_LOG_DETAIL_LOGLEVEL}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_NAMESPACE}']    ${namespace}    ${FIELD_LOG_DETAIL_NAMESPACE}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_APPLICATIONNAME}']    ${applicationName}    ${FIELD_LOG_DETAIL_APPLICATIONNAME}
		#Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CONTAINERID}']    ${containerId}    ${FIELD_LOG_DETAIL_CONTAINERID}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_SESSIONID}']    ${tid}    ${FIELD_LOG_DETAIL_SESSIONID}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_TID}']    ${tid}    ${FIELD_LOG_DETAIL_TID}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_STARTTIME}']    ${data[${i}]['custom1']['activityLog']['startTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_STARTTIME} 
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_ENDTIME}']    ${data[${i}]['custom1']['activityLog']['endTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_ENDTIME}
	    Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_ACTIVITYLOG}']['${FIELD_LOG_DETAIL_ACTIVITYLOG_PROCESSTIME}']    ${data[${i}]['custom1']['activityLog']['processTime']}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_ACTIVITYLOG}.${FIELD_LOG_DETAIL_ACTIVITYLOG_PROCESSTIME}
        Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM2}']    ${VALUE_LOG_DETAIL_CUSTOM2}    ${FIELD_LOG_DETAIL_CUSTOM2}

		Check Log Detail Custom RequestObject and ResponseObject App    ${code}    ${description}    ${applicationName}    ${dataResponse}    ${dataSearch}    ${tid}    ${urlCmdName}    ${cmdName}    ${endPointName}    ${body}    ${response}    ${pathUrl}    ${identity}    ${custom}    ${applicationName}    ${responseObjectDetail}
				
	END
#-------------------------------------------- Check Log Detail : RequestObject and ResponseObject --------------------------------------------#		
Check Log Detail Custom RequestObject and ResponseObject App
	[Arguments]    ${code}    ${description}    ${applicationName}    ${dataResponse}    ${imsi}    ${tid}    ${urlCmdName}    ${cmdName}    ${endPointName}    ${body}    ${response}    ${pathUrl}    ${identity}    ${custom}    ${applicationName}    ${responseObjectDetail}
	
	#-------------------------------------------- RequestObject --------------------------------------------#	
	#-------------------------------------------- Coapp App --------------------------------------------#	
	#RequestObject : Coapp App [Server Destination]
	Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}' and '${applicationName}'=='${VALUE_APPLICATIONNAME_COAPAPP}'    Check RequestObject App Success CoapAPP Server Destination    ${dataResponse}    ${pathUrl}
	
	#-------------------------------------------- MQTT --------------------------------------------#
	#RequestObject : MQTT App [Server Destination]
	Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}' and '${applicationName}'=='${VALUE_APPLICATIONNAME_MQTT}'    Check RequestObject App Success MQTT Server Destination    ${dataResponse}    ${pathUrl}    ${tid}

    #-------------------------------------------- HTTP --------------------------------------------#	
	#RequestObject : HTTP [Server Destination]
	Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}' and '${applicationName}'=='${VALUE_APPLICATIONNAME_ASGARDHTTP}'    Check RequestObject App Success HTTP Server Destination    ${dataResponse}    ${pathUrl}    ${tid}    ${body}    ${cmdName}    ${code}    ${description}    ${identity}

    #-------------------------------------------- ResponseObject --------------------------------------------#	
	#ResponseObject : Coapp App and HTTP [Server Destination]
	Run Keyword If    '${cmdName}'=='${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}' and '${code}'=='${VALUE_LOG_CODE_20000}'    Check ResponseObject App Success Server Destination    ${code}    ${description}    ${dataResponse}    ${response}
	
	#ResponseObject : Coapp App [Error !20000]
	${removeTextResponseObjectDetail}=    Remove String    ${responseObjectDetail}    '    ${EMPTY}
	Run Keyword If    '${code}'!='${VALUE_LOG_CODE_20000}' and '${removeTextResponseObjectDetail}'=='null'    Check ResponseObject Error    ${VALUE_LOG_DETAIL_RESPONSEOBJECT_NOTHAVEDETAIL_ERROR}    ${code}    ${description}    ${dataResponse}
    Run Keyword If    '${code}'!='${VALUE_LOG_CODE_20000}' and '${removeTextResponseObjectDetail}'!='null'    Check ResponseObject Error Detail    ${VALUE_LOG_DETAIL_RESPONSEOBJECT_HAVEDETAIL_ERROR}    ${code}    ${description}    ${dataResponse}    ${responseObjectDetail}

#--------------------------------------------  ResponseObject Error Not Have EndPointName --------------------------------------------#
Check ResponseObject Error  
    [Arguments]    ${value}    ${code}    ${description}    ${dataResponse}
	
	# ${code}=    Set Variable    ${code}
	# ${code} =	Set Variable If    '${code}'=='${VALUE_LOG_CODE_40300}'    ${VALUE_LOG_CODE_40400}
	# ...    '${code}'!='${VALUE_LOG_CODE_40300}'    ${code}
	# Log To Console    code${code}
	# Log To Console    description${description}
	# Log To Console    dataResponse${dataResponse}

	${replaceCodeCmdName}=    Replace String    ${value}    [Code]    ${code}
	${replaceDescriptionCmdName}=    Replace String    ${replaceCodeCmdName}    [DeveloperMessage]    ${description}

	${responseObject}=    Replace String To Object    ${replaceDescriptionCmdName}
	# Log To Console    responseObjectError${responseObject}
			
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_RESPONSEOBJECT}']    ${responseObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_RESPONSEOBJECT}

Check ResponseObject Error Detail  
    [Arguments]    ${value}    ${code}    ${description}    ${dataResponse}    ${responseObjectDetail}
	
	# ${code}=    Set Variable    ${code}
	# ${code} =	Set Variable If    '${code}'=='${VALUE_LOG_CODE_40300}'    ${VALUE_LOG_CODE_40400}
	# ...    '${code}'!='${VALUE_LOG_CODE_40300}'    ${code}
	# Log To Console    code${code}
	# Log To Console    description${description}
	# Log To Console    dataResponse${dataResponse}

	${replaceCodeCmdName}=    Replace String    ${value}    [Code]    ${code}
	${replaceDescriptionCmdName}=    Replace String    ${replaceCodeCmdName}    [DeveloperMessage]    ${description}
	${replaceDetail}=    Replace String    ${replaceDescriptionCmdName}    [Detail]    ${responseObjectDetail}

	${responseObject}=    Replace String To Object    ${replaceDetail}
	# Log To Console    responseObjectError${responseObject}
			
	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_RESPONSEOBJECT}']    ${responseObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_RESPONSEOBJECT}
									 
Check Log Response 
    #resultCode_summary[20000],resultDesc_summary[20000],Code_detail[20000],Description_detail[Register is Success],applicationName,pathUrl,urlCmdName,dataSearch,body[request],response[response],namespace,containerId,identity,cmdName,endPointName,logLevel,custom,customDetailDB,responseObjectDetail
    [Arguments]    ${resultCode_summary}    ${resultDesc_summary}    ${code_detail}    ${description_detail}    ${applicationName}    ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${namespace}    ${containerId}    ${identity}    ${cmdName}    ${endPointName}    ${logLevel}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    #Log To Console    imsi_thingTokenimsi_thingToken${imsi_thingToken}
	#return valArrData,valArrDetail,valArrSummary,tid
	${dataLogResponse}=    Data Log Response    ${applicationName}    ${dataSearch}    ${endPointName}
	Log    Log is ${dataLogResponse}
	
	Check Log Detail    ${code_detail}    ${description_detail}    ${dataLogResponse}[1]    ${dataLogResponse}[3]    ${applicationName}    ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${identity}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    Check Log Summary    ${resultCode_summary}    ${resultDesc_summary}    ${dataLogResponse}[2]    ${dataLogResponse}[3]    ${applicationName}    ${namespace}    ${containerId}    ${identity}    ${cmdName}    ${custom}

MQTT Check Log Response  
    #resultCode_summary[20000],resultDesc_summary[20000],Code_detail[20000],Description_detail[Register is Success],applicationName,pathUrl,urlCmdName,imsi_thingToken,ipAddress,body,namespace,containerId,identity,cmdName,endPointNameSimRegister,endPointNameCoapAPP,logLevel,valueSearchText,custom,SensorKey
    [Arguments]    ${resultCode_summary}    ${resultDesc_summary}    ${code_detail}    ${description_detail}    ${applicationName}    ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${namespace}    ${containerId}    ${identity}    ${cmdName}    ${endPointName}    ${logLevel}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
        
	# [Arguments]    ${resultCode_summary}    ${resultDesc_summary}    ${code_detail}    ${description_detail}    ${applicationName}    ${pathUrl}    ${urlCmdName}    ${imsi_thingToken}    ${body}    ${response}    ${namespace}    ${containerId}    ${identity}    ${cmdName}    ${endPointName}    ${logLevel}    ${valueSearchText}    ${custom}    ${SensorKey}    ${EMPTY}      
    #Log To Console    imsi_thingToken${imsi_thingToken}
	#return valArrData,valArrDetail,valArrSummary,tid
	${dataLogResponse}=    Data Log Response    ${applicationName}    ${dataSearch}    ${endPointName}
	
	Check Log Detail    ${code_detail}    ${description_detail}    ${dataLogResponse}[1]    ${dataLogResponse}[3]    ${applicationName}    ${pathUrl}    ${urlCmdName}    ${dataSearch}    ${body}    ${response}    ${endPointName}    ${logLevel}    ${namespace}    ${containerId}    ${cmdName}    ${identity}    ${custom}    ${customDetailDB}    ${responseObjectDetail} 
    Check Log Summary    ${resultCode_summary}    ${resultDesc_summary}    ${dataLogResponse}[2]    ${dataLogResponse}[3]    ${applicationName}    ${namespace}    ${containerId}    ${identity}    ${cmdName}    ${custom}

Replace String To Object
    [Arguments]    ${string}
    
	${replStringToJsonStart}=    Replace String    ${string}    "{    {
	${replStringToJsonEnd}=    Replace String    ${replStringToJsonStart}    }"    }
	[RETURN]    ${replStringToJsonEnd}
	