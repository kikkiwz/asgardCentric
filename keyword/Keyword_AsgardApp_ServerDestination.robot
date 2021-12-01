*** Keywords ***
####################################################
ServerDestinationAsgardApp
    [Arguments]    ${URL}
    Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	Log To Console    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
    ${status_open_program}=    Run Keyword And Return Status    Wait Until Screen Contain    MagellanClient_header.png     5
	#Open simulator
	Run Keyword If    '${status_open_program}'=='True'    Log To Console    Program is running
	Run Keyword If    '${status_open_program}'=='False'    Open Simulator
	#Select Dropdrown Function 
	Log To Console    Do : ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_DESTINATION}
    ${status_dropdownDest}=    Run Keyword And Return Status    Wait Until Screen Contain     ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_CHOOSE_DESTINATION}     5
	Run Keyword If    '${status_dropdownDest}'=='False'    Select Dropdrown Function    ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_DESTINATION}
	Run Keyword If    '${status_dropdownDest}'=='True'    Log To Console    Dropdrown ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_CHOOSE_DESTINATION} is open

	#Input Url
    ${status_url}=    Run Keyword And Return Status    Wait Until Screen Contain     ${ASGARD_COAPAP_IMAGE_TXT_URL}     5
    ${status_url1}=    Run Keyword And Return Status    Wait Until Screen Contain     txt_url2.png     5
	${url_img}=    Set Variable If    '${status_url1}'=='True'    txt_url3.png
	...    txt_url3.png
	Log To Console    status_url = ${status_url}
	Log To Console    status_url1 = ${status_url1}
	Run Keyword If    '${status_url}'=='True'    Input Url    ${ASGARD_COAPAP_IMAGE_TXT_URL}    ${URL}    ${ASGARD_COAPAP_IMAGE_TXT_URL_NULL}
	Run Keyword If    '${status_url}'=='False'    Input Url    ${url_img}    ${URL}    ${ASGARD_COAPAP_IMAGE_TXT_URL_NULL}

	#Payload
    Log To Console    Do : ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD}
    ${status_playload}=    Run Keyword And Return Status    Wait Until Screen Contain     ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD}     5
	Run Keyword If    '${status_playload}'=='True'    Clear Input    ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD}
	#Click Send button
	Log To Console    Do : ${ASGARD_COAPAP_IMAGE_BTN_SEND}
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click    ${ASGARD_COAPAP_IMAGE_BTN_SEND}
	#Check Success popup
	Log To Console    Do : ${ASGARD_COAPAP_IMAGE_POPUP_SUCCESS}
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Check Matched    ${ASGARD_COAPAP_IMAGE_POPUP_SUCCESS}
	Log To Console    Do : ${ASGARD_COAPAP_IMAGE_BTN_OK}	
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click    ${ASGARD_COAPAP_IMAGE_BTN_OK}
	Capture Screen		



