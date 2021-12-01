*** Keywords ***
####################################################
MQTTConnect
    [Arguments]    ${Username}    ${Password}
    Set Username And Password    Centric.${Username}    ${Password}
	${result}=    Run Keyword And Return Status    connect   ${ASGARD_MQTT_VALUE_SERVERURL}    client_id=${ASGARD_MQTT_VALUE_CLIENTID}    clean_session=True
	[Return]    ${result}

MQTTDisconnect
    disconnect

MQTTServerDestination
    [Arguments]    ${Username}    ${Password}   ${ThingIdentifier}    ${ThingSecret}    ${IMEI} 
    MQTTConnect    ${Username}    ${Password}
	#Replace Parameters Url IMSI and IP 
	${urlPulish}=    Replace Parameters Path    ${ASGARD_MQTT_URL_PUBLISH_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	Log    urlPulish=${urlPulish}	
	#Replace Parameters Url IMSI
	${urlSubscription}=    Replace Parameters Path    ${ASGARD_MQTT_URL_SUBSCRIBE_SERVERDESTINATION}    ${ASGARD_MQTT_FIELD_THINGIDENTIFIER}    ${ThingIdentifier}    ${ASGARD_MQTT_FIELD_THINGSECRET}    ${ThingSecret}
	Log    urlSubscription=${urlSubscription}	
	#Pulish Topic
    Subscribe   topic=${urlSubscription}    qos=1   timeout=5   limit=1   
    publish  topic=${urlPulish}
    ${messages}=    Subscribe   topic=${urlSubscription}    qos=1   timeout=5   limit=1
    Log    ${messages}
    MQTTDisconnect
	Log To Console    ${\n}============ Send MQTT ServerDestination =====================
	Log To Console    ${\n}Subscribe : topic=${urlSubscription}
	Log To Console    Publish : topic=${urlPulish}
	Log To Console    Response:${messages}${\n}