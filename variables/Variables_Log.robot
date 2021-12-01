*** Variables ***

#valueSearch: MQTT
${VALUE_SEARCH_REGISTER_MQTT}    register.get.sim.v1.
${VALUE_SEARCH_CONFIG_MQTT}    config.update.sim.v1.
${VALUE_SEARCH_REPORT_MQTT}    report.update.sim.v1.
${VALUE_SEARCH_DELTA_MQTT}    delta.get.sim.v1.

#log
${STATUS_LOG_ENDPOINTSUMMARY}    Off

# #applicationName : CoapAPI
# ${VALUE_APPLICATIONNAME_COAPAPI}    Asgard.Coap.APIs
# #applicationName : MQTT
# ${VALUE_APPLICATIONNAME_MQTT}    Asgard.Mqtt.V1.APP
#${VALUE_APPLICATIONNAME_MQTT}    MqttAPP
#applicationName : Charging
${VALUE_APPLICATIONNAME_CHARGING}    Insight.Charging.APIs
#applicationName : Centric
# ${VALUE_APPLICATIONNAME_COAP_CENTRIC}    asgardcoap
# ${VALUE_APPLICATIONNAME_MQTT_CENTRIC}    asgardmqtt

#namespace
#${VALUE_LOG_NAMESPACE}    magellan
# ${VALUE_LOG_NAMESPACE}    Magellan 
${VALUE_LOG_NAMESPACE}    mgcentric 

  
#containerId : CoapAPP
${VALUE_LOG_CONTAINERID_COAPAPP}    coapapp-v91
#containerId : CoapAPI
${VALUE_LOG_CONTAINERID_COAPAPI}    coapapis-v11
#containerId : MQTT
${VALUE_LOG_CONTAINERID_MQTT}    asgardmqtt-v62.62-6f7dd7cdd6-8tnzq
#containerId : Charging
${VALUE_LOG_CONTAINERID_CHARGING}    chargingapis-v11
#containerId : Centric
${VALUE_LOG_CONTAINERID_CENTRIC}    asgradcoap-v32.32-6df8dc74f-qdpwg
#containerId : Centric Asgard HTTP
${VALUE_LOG_CONTAINERID_CENTRIC_ASGARDHTTP}    asgradcoap-v32.32-6df8dc74f-qdpwg

#-------------------------------------------- Detail Log --------------------------------------------#
#endPointName : Asgard CoapAPP CoapAPI
${DETAIL_ENDPOINTNAME_COAPAPISERVICE}    CoapApiService

#${Api}

#endPointName : Asgard MQTT
${DETAIL_ENDPOINTNAME_RABBITMQ}    RabbitMQ

#endPointName : Charging
${DETAIL_ENDPOINTNAME_ROCSSERVICE}    RocsService

#log Detail
${VALUE_DETAIL}    Detail  
#field log Detail
${FIELD_LOG_DETAIL_SYSTEMTIMESTAP}    systemTimestamp   
${FIELD_LOG_DETAIL_LOGTYPE}    logType  
${FIELD_LOG_DETAIL_LOGLEVEL}    logLevel  
${FIELD_LOG_DETAIL_NAMESPACE}    namespace  
${FIELD_LOG_DETAIL_APPLICATIONNAME}    applicationName  
${FIELD_LOG_DETAIL_CONTAINERID}    containerId
${FIELD_LOG_DETAIL_SESSIONID}    sessionId  
${FIELD_LOG_DETAIL_TID}    tid 
${FIELD_LOG_DETAIL_CUSTOM1}    custom1   
${FIELD_LOG_DETAIL_CUSTOM2}    custom2   
${FIELD_LOG_DETAIL_ENDPOINTNAME}    endPointName
${FIELD_LOG_DETAIL_REQUESTOBJECT}    requestObject
${FIELD_LOG_DETAIL_URL}    url
${FIELD_LOG_DETAIL_HEADERS}    headers
${FIELD_LOG_DETAIL_XAISORDERREF}    x-ais-OrderRef
${FIELD_LOG_DETAIL_BODY}    body
${FIELD_LOG_DETAIL_IMSI}    Imsi
${FIELD_LOG_DETAIL_IPADDRESS}    IpAddress        
${FIELD_LOG_DETAIL_RESPONSEOBJECT}    responseObject
${FIELD_LOG_DETAIL_THINGTOKEN}    ThingToken
${FIELD_LOG_DETAIL_OPERATIONSTATUS}    OperationStatus
${FIELD_LOG_DETAIL_OPERATIONSTATUS_CODE}    Code
${FIELD_LOG_DETAIL_OPERATIONSTATUS_DESCRIPTION}    Description
${FIELD_LOG_DETAIL_ACTIVITYLOG}    activityLog
${FIELD_LOG_DETAIL_ACTIVITYLOG_STARTTIME}    startTime
${FIELD_LOG_DETAIL_ACTIVITYLOG_ENDTIME}    endTime
${FIELD_LOG_DETAIL_ACTIVITYLOG_PROCESSTIME}    processTime

${VALUE_LOG_DETAIL_LOGLEVEL}    info  
${VALUE_LOG_DETAIL_CUSTOM2}    ${NONE}
${VALUE_LOG_DETAIL_VERSION}    v1

#-------------------------------------------- Detail Server Destination --------------------------------------------#
#-------------------------------------------- requestObject CoapAPP --------------------------------------------#
#value log Detail : CoapAPP
# "requestObject":"{ \"url\":\"/api/v2/things/8966036168318670537/125590939122550/server/destination\", \"method\":\"GET\", \"headers\":{ \"Content-Format\":\"text/plain\", \"Content-Type\":\"text/plain\" }, \"routeParameters\":{ }, \"queryString\":{ }, \"body\":{ } }"
${VALUE_LOG_DETAIL_REQUESTOBJECT_COAPAPP_APP_CENTRIC_SERVERDESTINATION}    "{\"url\":\"[valuePathUrl]\",\"code\":\"0.01\",\"method\":\"GET\",\"headers\":{\"Content-Format\":\"text/plain\",\"Content-Type\":\"text/plain\"},\"routeParameters\":{},\"queryString\":{},\"body\":{}}"
#-------------------------------------------- requestObject MQTT --------------------------------------------#
#value log Detail : MQTT
# {"method":"Consume","url":"api/v2/things/8966038594706167558/567667715457019/server/destination/request","headers":{"x-ais-orderref":"1625800309477","x_ais_sessionid":"1625800309477","timestamp_in_ms":1625800309477},"body":{}}
${VALUE_LOG_DETAIL_REQUESTOBJECT_MQTT_APP_CENTRIC_SERVERDESTINATION}    "{"url":"[valuePathUrl]","headers":{"x-ais-orderref":[tid],"x_ais_sessionid":[tid],"timestamp_in_ms":[tid]},"body":{}}"
#-------------------------------------------- requestObject HTTP --------------------------------------------#
#value log Detail : HTTP
# "requestObject":"{'requestObject': '{"url":"/things/8966035525707869715/238812807779923/server/destination","method":"GET","headers":{"host":"mgcentric-iot.siamimo.com","x-real-ip":"58.8.179.168","x-forwarded-for":"58.8.179.168","x-forwarded-proto":"https","user-agent":"python-requests/2.24.0","accept-encoding":"gzip, deflate","accept":"*/*","content-type":"application/json","x-ais-orderref":"ServerDestination_27082021134306","x-ais-orderdesc":"ServerDestination","x-request-id":"7df926fc-fc95-4514-9af9-900dcf1373c7","x-b3-traceid":"4ecd00201db484786d00fb406b785f27","x-b3-spanid":"6d00fb406b785f27","x-b3-sampled":"0","content-length":"0","startTime":1630046585894},"routeParameters":{"ThingIdentifier":"8966035525707869715","ThingSecret":"238812807779923"},"queryString":{},"body":{}}"
${VALUE_LOG_DETAIL_REQUESTOBJECT_HTTP_APP_CENTRIC_SERVERDESTINATION}    "{"url":"[valuePathUrl]","method":"[method]","headers":{"host":"[host]","x-real-ip":"[x-real-ip]","x-forwarded-for":"[x-forwarded-for]","x-forwarded-proto":"[x-forwarded-proto]","user-agent":"[user-agent]","accept-encoding":"[accept-encoding]","accept":"*/*","content-type":"[content-type]","x-ais-orderref":"[tid]","x-ais-orderdesc":"[Orderdesc]","x-request-id":"[x-request-id]","x-b3-traceid":"[x-b3-traceid]","x-b3-spanid":"[x-b3-spanid]","x-b3-sampled":"[x-b3-sampled]","content-length":"[content-length]","startTime":[startTime]},"routeParameters":[routeParameters],"queryString":[queryString],"body":[body]}"
#-------------------------------------------- responseObject CoapAPP --------------------------------------------#
# "responseObject":"{ \"OperationStatus\":{ \"Code\":\"20000\", \"DeveloperMessage\":\"The requested operation was successfully\" }, \"ServerDestinationInfo\":{ \"ServerIP\":\"127.0.2.2\", \"ServerPort\":\"8080\", \"ServerDomain\":\"Worker001.com\" } }"
${VALUE_LOG_DETAIL_RESPONSEOBJECT_APP_CENTRIC_SERVERDESTINATION}    "{\"OperationStatus\":{\"Code\":\"[Code]\",\"DeveloperMessage\":\"[DeveloperMessage]\"},\"ServerDestinationInfo\":[ServerDestinationInfo]}"
#-------------------------------------------- responseObject Error --------------------------------------------#
#{ \"OperationStatus\":{ \"Code\":\"40000\", \"DeveloperMessage\":\"The client request missing or invalid format\" }, \"Detail\":[ { \"Target\":\"ThingIdentifier\", \"DeveloperMessage\":\"The length of ThingIdentifier must be 13 or 19 characters. You entered 20 characters.\" } ] }
${VALUE_LOG_DETAIL_RESPONSEOBJECT_HAVEDETAIL_ERROR}    "{\"OperationStatus\":{\"Code\":\"[Code]\",\"DeveloperMessage\":\"[DeveloperMessage]\"},\"Details\":[Detail]}"

#{"OperationStatus":{"Code":"40400","DeveloperMessage":"The requested operation could not be found."}}
${VALUE_LOG_DETAIL_RESPONSEOBJECT_NOTHAVEDETAIL_ERROR}    "{\"OperationStatus\":{\"Code\":\"[Code]\",\"DeveloperMessage\":\"[DeveloperMessage]\"}}"

#{ \"OperationStatus\":{ \"Code\":\"40000\", \"DeveloperMessage\":\"The client request missing or invalid format\" }, \"Detail\":[ { \"Target\":\"ThingIdentifier\", \"DeveloperMessage\":\"The length of ThingIdentifier must be 13 or 19 characters. You entered 20 characters.\" } ] }
# ${VALUE_LOG_DETAIL_RESPONSEOBJECT_HTTP_HAVEDETAIL_ERROR}    "{\"OperationStatus\":{\"Code\":\"[Code]\",\"DeveloperMessage\":\"[DeveloperMessage]\"},\"Details\":[Detail]}"

#-------------------------------------------- Detail DB--------------------------------------------#
# "responseObject":"{"statusCode":"20000","description":"inquiry worker is success"}"
${VALUE_LOG_DETAIL_REQUESTOBJECT_COAPAPP_DB}    {}    
${VALUE_LOG_DETAIL_RESPONSEOBJECT_COAPAPP_DB}    {"statusCode":"[statusCode]","description":"[description]"}    

#-------------------------------------------- Summary Log --------------------------------------------#
${VALUE_SUMMARY}    Summary 
#field log Summary
${FIELD_LOG_SUMMARY_SYSTEMTIMESTAP}    systemTimestamp   
${FIELD_LOG_SUMMARY_LOGTYPE}    logType  
${FIELD_LOG_SUMMARY_NAMESPACE}    namespace
${FIELD_LOG_SUMMARY_APPLICATIONNAME}    applicationName
${FIELD_LOG_SUMMARY_CONTAINERID}    containerId
${FIELD_LOG_SUMMARY_SESSIONID}    sessionId
${FIELD_LOG_SUMMARY_TID}    tid 
${FIELD_LOG_SUMMARY_IDENTITY}    identity 
${FIELD_LOG_SUMMARY_CMDNAME}    cmdName  
${FIELD_LOG_SUMMARY_RESULTCODE}    resultCode  
${FIELD_LOG_SUMMARY_RESULTDESC}    resultDesc
${FIELD_LOG_SUMMARY_CUSTOM}    custom
${FIELD_LOG_SUMMARY_CUSTOMDATA}    customData
${FIELD_LOG_SUMMARY_ENDPOINTSUMMARY}    endPointSummary
${FIELD_LOG_SUMMARY_REQTIMESTAP}    reqTimestamp 
${FIELD_LOG_SUMMARY_RESTIMESTAMP}    resTimestamp  
${FIELD_LOG_SUMMARY_USAGETIME}    usageTime 

#value log summary  cmdName: CoapAPP
${VALUE_LOG_SUMMARY_CMDNAME_SERVERDESTINATION}    ServerDestination

#value log summary cmdName: MQTT
${VALUE_LOG_SUMMARY_CMDNAME_REGISTER_MQTT}    Register

#${VALUE_LOG_SUMMARY_IDENTITY}    ${NONE}
${VALUE_LOG_SUMMARY_IDENTITY}    


${VALUE_LOG_CODE_20000}    20000
${VALUE_LOG_CODE_40000}    40000
${VALUE_LOG_CODE_40300}    40300
${VALUE_LOG_CODE_40400}    40400
${VALUE_LOG_CODE_40301}    40301
${VALUE_LOG_CODE_40305}    40305
${VALUE_LOG_CODE_40010}    40010

${VALUE_LOG_SUMMARY_RESULTDESC_OK}    OK

# ${VALUE_LOG_SUMMARY_RESULTDESC_20000_REQUESTED_OPERATION_SUCCESSFULLY}    The requested operation was successfully
${VALUE_DESCRIPTION_REQUESTED_OPERATION_SUCCESSFULLY}    The requested operation was successfully

${VALUE_LOG_SUMMARY_CUSTOM}    ${NONE}

#response description
${VALUE_DESCRIPTION_REGISTER_SUCCESS}    Register is Success
${VALUE_DESCRIPTION_REPORT_SUCCESS}     Report is Success
${VALUE_DESCRIPTION_IS_SUCCESS}     is Success

${VALUE_DESCRIPTION_FORBIDDEN_ERROR}    Forbidden
${VALUE_DESCRIPTION_INVALIDPAYLOAD_ERROR}    InvalidPayload

${VALUE_DESCRIPTION_REQUESTED_OPERATION_COULDNOTBEFOUND_ERROR}    The requested operation could not be found.
${VALUE_DESCRIPTION_REQUESTED_OPERATION_THING_COULDNOTBEFOUND_ERROR}    The requested operation Thing could not be found.

${VALUE_DESCRIPTION_THEOPERATIONHASALREADYEXPIRED_ERROR}    The operation has already expired.
${VALUE_DESCRIPTION_THETHINGIDENTIFIERREQUESTEDALREADYEXISTS_ERROR}    The ThingIdentifier requested already exists.
${VALUE_DESCRIPTION_THETHINGTOKENREQUESTEDALREADYEXISTS_ERROR}    The thingToken requested already exists.

${VALUE_DESCRIPTION_THECLIENTREQUESTMISSINGORINVALIDFORMAT_ERROR}    The client request missing or invalid format

#Details DeveloperMessage
${VALUE_DETAILS_DEVELOPERMESSAGE_RESPONSE_THINGIDENTIFIER_LENGTHMUSTMEMORETHAN_ERROR}    The length of 'ThingIdentifier' must be 19 characters. You entered 20 characters.
${VALUE_DETAILS_DEVELOPERMESSAGE_LOG_THINGIDENTIFIER_LENGTHMUSTMEMOREMORETHAN_ERROR}    The length of \'ThingIdentifier\' must be 19 characters. You entered 20 characters.

${VALUE_DETAILS_DEVELOPERMESSAGE_RESPONSE_THINGIDENTIFIER_LENGTHMUSTMELESSTHAN_ERROR}    The length of 'ThingIdentifier' must be 19 characters. You entered 18 characters.
${VALUE_DETAILS_DEVELOPERMESSAGE_LOG_THINGIDENTIFIER_LENGTHMUSTMELESSTHAN_ERROR}    The length of \'ThingIdentifier\' must be 19 characters. You entered 18 characters.

${VALUE_DETAILS_DEVELOPERMESSAGE_RESPONSE_THINGSECRET_LENGTHMUSTMEMORETHAN_ERROR}    The length of 'ThingSecret' must be 20 characters. You entered 21 characters.
${VALUE_DETAILS_DEVELOPERMESSAGE_LOG_THINGSECRET_LENGTHMUSTMEMOREMORETHAN_ERROR}    The length of \'ThingSecret\' must be 20 characters. You entered 21 characters.

${VALUE_DETAILS_DEVELOPERMESSAGE_RESPONSE_THINGIDENTIFIER_LENGTHMUSTMELESSTHAN_INVALId_ERROR}    The length of 'ThingIdentifier' must be 13 characters. You entered 3 characters.
${VALUE_DETAILS_DEVELOPERMESSAGE_LOG_THINGIDENTIFIER_LENGTHMUSTMELESSTHAN_INVALId_ERROR}    The length of \'ThingIdentifier\' must be 13 characters. You entered 3 characters.

${VALUE_DETAILS_DEVELOPERMESSAGE_THINGIDENTIFIERMUSTNOTBEEMPTY_ERROR}    ThingIdentifier must not be empty
${VALUE_DETAILS_DEVELOPERMESSAGE_THINGSECRETMUSTNOTBEEMPTY_ERROR}    ThingSecret must not be empty

#response description MQTT Error
${VALUE_DESCRIPTION_ONLINECONFIGSNOTFOUND_ERROR}    OnlineConfigs not found.


