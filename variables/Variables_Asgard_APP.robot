*** Variables ***
#-------------------------------------------- Start ENV Master --------------------------------------------#
#STAGING	
# ${ASGARD_COAPAPP_URL}    coap://52.139.231.235:5683
# ${ASGARD_COAPAPP_IMAGE_DDL}    ddl_Staging_CauldronAzue.png
# ${URL_GET_LOG}    https://mg-staging.siamimo.com:30380/elasticsearch/application*/_search?rest_total_hits_as_int=true&ignore_unavailable=true&ignore_throttled=true&preference=1620900474581&timeout=30000ms
# ${VALUE_APPLICATIONNAME_COAPAPP}    Asgard.Coap.APP
#IOT
#${ASGARD_COAPAPP_URL}    coap://52.139.225.243:5683
#${ASGARD_COAPAPP_IMAGE_DDL}    ddl_IoT_Cauldorn_Azure.png
#${URL_GET_LOG}    https://mg-iot.siamimo.com:30380/elasticsearch/application*/_search?rest_total_hits_as_int=true&ignore_unavailable=true&ignore_throttled=true&preference=1620900474581&timeout=30000ms
#applicationName : CoapAPP
#${VALUE_APPLICATIONNAME_COAPAPP}    CoapAPP

#IOT Centric
${ASGARD_COAPAPP_URL}    coap://52.163.246.237:5685
${ASGARD_COAPAPP_IMAGE_DDL}    ddl_Centricts.png
${URL_GET_LOG}    https://mg-iot.siamimo.com:30380/elasticsearch/application*/_search?rest_total_hits_as_int=true&ignore_unavailable=true&ignore_throttled=true&preference=1620900474581&timeout=30000ms
# applicationName : CoapAPP
${VALUE_APPLICATIONNAME_COAPAPP}    asgardcoap


#-------------------------------------------- End ENV Master -----------------------------------#	
${ASGARD_COAPAPP_IP_ADDRESS}    1.2.3.4
#-------------------------------------------- Image --------------------------------------------#
#image Asgrad Coap APP and API
${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}    Thing_Simulator.png
${ASGARD_COAPAP_IMAGE_MAGELLANCLIENT_HEADER}    MagellanClient_header.png
${ASGARD_COAPAPP_IMAGE_DDL_ENV_IOT_DOCKERAZURE}    ddl_IoT_Docker_Azure.png
${ASGARD_COAPAPP_IMAGE_DDL_ENV_CENTRICTS}    ddl_Centricts.png
${ASGARD_COAPAP_IMAGE_TXT_URL}    txt_url.png 
${ASGARD_COAPAP_IMAGE_TXT_URL_AFTERCLICK}    txt_url_click.png 
${ASGARD_COAPAP_IMAGE_TXT_URL_REGISTER}    txt_url_register.png 
${ASGARD_COAPAP_IMAGE_TXT_URL_NULL}    txt_url_null.png 
${ASGARD_COAPAP_IMAGE_TXT_URL_NULL0}    txt_url_null0.png 
${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD}    txtarea_payload.png 
${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD_NULL}    txtarea_payload_null.png 
${ASGARD_COAPAP_IMAGE_BTN_SEND}    btn_Send.png
${ASGARD_COAPAP_IMAGE_BTN_OK}    btn_ok.png
${ASGARD_COAPAP_IMAGE_POPUP_SUCCESS}    popup_Success.png
${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_REPORT}    ddl_function_report.png
${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_CONFIG}    ddl_function_config.png
${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_DELTA}    ddl_function_delta.png
${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_DESTINATION}    ddl_function_Destination.png
${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_CHOOSE_DESTINATION}    ddl_function_choose_Destination.png
${ASGARD_COAPAP_IMAGE_TXT_URL_DELTA}    txt_url_delta.png
${ASGARD_COAPAP_IMAGE_TXT_URL_CONFIG}    txt_url_config.png
${ASGARD_COAPAP_IMAGE_TXT_URL_IMSI}    imsi.png
${ASGARD_COAPAP_IMAGE_RESPONSE_SUCCESS_20000}    Response_20000.png
${ASGARD_COAPAP_IMAGE_RESPONSE_ERROR_40300}    Response_40300.png
${ASGARD_COAPAP_IMAGE_RESPONSE_ERROR_40010}    Response_40010.png
${ASGARD_COAPAP_IMAGE_RESPONSE_SUCCESS_CONFIG}    Response_20000_config.png
${ASGARD_COAPAP_IMAGE_RESPONSE_SUCCESS_CONFIG_002}    Response_20000_config_002.png

#-------------------------------------------- Data CoapApp   --------------------------------------------#
#url Path : CoapApp
${ASGARD_COAPAPP_URL_SERVERDESTINATION}    /api/v2/things/ThingIdentifier/ThingSecret/server/destination

${ASGARD_COAPAPP_FIELD_TOKEN}    ThingToken
${ASGARD_COAPAPP_FIELD_IPADDRESS}    IPAddress
${ASGARD_COAPAPP_FIELD_IMSI}    IMSI

${ASGARD_COAPAPP_FIELD_THINGIDENTIFIER}    ThingIdentifier  
${ASGARD_COAPAPP_FIELD_THINGSECRET}    ThingSecret  

${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_NOTFOUND}    1111135026573339052
${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGSECRET_NOTFOUND}    111524055695113

${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_INVALID}    %20
${ASGARD_COAPAPP_SERVERDESTINATION_VALUE_THINGSECRET_INVALID}    %20

