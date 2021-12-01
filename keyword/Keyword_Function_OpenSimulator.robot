*** Keywords ***

Open Simulator  
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Open Program 
    #Select Dropdrown ENV
	Log To Console    Do : ${ASGARD_COAPAPP_IMAGE_DDL}
    ${status_dropdown}=    Run Keyword And Return Status    Click     ddl_Choose_Centricts.png     5
	Run Keyword If    '${status_dropdown}'=='False'   Select Dropdrown ENV    ${ASGARD_COAPAPP_IMAGE_DDL}
	Run Keyword If    '${status_dropdown}'=='True'    Log To Console    Dropdrown ENV ddl_Choose_Centricts.png is open

	
Open MQTTSPY
    [Arguments]    ${Username}    ${Password}
	#Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_MQTT}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Open Program MQTT	
	#Click Menu Connection
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_MENU_CONNECTIONS}
	#Click Menu Connections -> New Connection
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_MENU_CONNECTIONS_NEWCONNECTION}
	#Click Connectivity Tab
	#Click Button    ${ASGARD_MQTT_IMAGE_TAB_CONNECTIVITY}
	#Server URI
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Value And Clear    ${ASGARD_MQTT_IMAGE_TXT_SERVERURL_DATA}    ${ASGARD_MQTT_IMAGE_TXT_SERVERURL_NULL}    ${ASGARD_MQTT_VALUE_SERVERURL}     
	#Client Id
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Value And Delete    ${ASGARD_MQTT_IMAGE_TXT_CLIENTID_DATA}    ${ASGARD_MQTT_VALUE_CLIENTID}     

	#Connection Name
	#Input Value    ${ASGARD_MQTT_IMAGE_TXT_CONNECTIONNAME_DATA}    ${ASGARD_MQTT_VALUE_CONNECTION_NAME}     	
	#Click Security Tab
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_TAB_SECURITY}
	#Click Checkbox Enable User Authentication
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_CHK_ENABLE_USER_AUTH}
	
	#Click Redio Username Predefined
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_RDI_USERNAME_PREDEFINED}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Text    ${ASGARD_MQTT_IMAGE_TXT_USERNAME_PREDEFINED}    ${Username}
	#Click Redio Password Predefined
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_RDI_PASSWORD_PREDEFINED}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Text    ${ASGARD_MQTT_IMAGE_TXT_PASSWORD_PREDEFINED}    ${Password}
	

	#Click Open Connection button
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_BTN_OPENCONNECTION}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_BTN_YES_POPUP_UNSAVECHANGESDETECTED}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Button    ${ASGARD_MQTT_IMAGE_BTN_OK_POPUP_CANNOTSAVECONFIGFILE}




