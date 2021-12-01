*** Settings ***
Library    SikuliLibrary
Library    Collections
Library    String
Library    DateTime
Library    OperatingSystem
Library    Process
Library    BuiltIn
Library    JSONLibrary
Library    MongoDBLibrary
Library    MQTTLibrary

Resource    ../keyword/Keyword_Request.robot
Resource    ../keyword/Keyword_Datetime.robot
Resource    ../keyword/Keyword_CreateData.robot
Resource    ../keyword/Keyword_RemoveData.robot
Resource    ../keyword/Keyword_UpdateData.robot
Resource    ../keyword/Keyword_InquiryData.robot

Resource    ../keyword/Keyword_Log.robot
Resource    ../keyword/Keyword_Log_Summary.robot
Resource    ../keyword/Keyword_Log_Detail.robot
Resource    ../keyword/Keyword_Log_Detail_CoapApp.robot
Resource    ../keyword/Keyword_Log_Detail_MQTT.robot
Resource    ../keyword/Keyword_Log_Detail_HTTP.robot

Resource    ../keyword/Keyword_Function_CreateData.robot
Resource    ../keyword/Keyword_Function_OpenSimulator.robot

Resource    ../keyword/Keyword_AsgardApp_RomoveData.robot
Resource    ../keyword/Keyword_AsgardApp_VerifyLog.robot
Resource    ../keyword/Keyword_AsgardApp_ServerDestination.robot

Resource    ../keyword/Keyword_MQTT_VerifyLog.robot
Resource    ../keyword/Keyword_MQTT_ServerDestination.robot

Resource    ../keyword/Keyword_HTTP_VerifyLog.robot

Resource    ../keyword/Keyword_MongoDB.robot

#Library Document
#https://robotframework.org/robotframework/latest/libraries/BuiltIn.html
#https://robotframework.org/robotframework/latest/libraries/String.html
#https://robotframework.org/robotframework/latest/libraries/Collections.html
#https://robotframework-thailand.github.io/robotframework-jsonlibrary/JSONLibrary.html

*** Keywords ***
####################################################
Add Needed Image Path
    Add Image Path    ${IMAGE_DIR}
	
Replace Text
    [Arguments]    ${string}    ${search_for}    ${replace_with}
	
	${replaceUrl}=    Replace String    ${string}    ${search_for}    ${replace_with}
	Log To Console    ${text}
	[RETURN]    ${text}
	
Replace Parameters Url Path
	[Arguments]    ${url}    ${urlPath}    ${ParametersField}    ${value_ParametersField}    ${ParametersField_ipAddress}    ${value_ipAddress}
	${replaceParametersUrl}=    Replace String    ${urlPath}    ${ParametersField}    ${value_ParametersField}
	#Log To Console    replaceUrl${replaceParametersUrl}
    ${replaceIPAddressUrl}=    Replace String    ${replaceParametersUrl}    ${ParametersField_ipAddress}    ${value_ipAddress}
	#Log To Console    replaceUrl${replaceIPAddressUrl}
	${url}=    Set Variable    ${url}${replaceIPAddressUrl}
	Log To Console    Url Path${url}
	[return]    ${url}
	
Replace Parameters Path
	[Arguments]    ${urlPath}    ${ParametersField}    ${value_ParametersField}    ${ParametersField_ipAddress}    ${value_ipAddress}
	${replaceParametersUrl}=    Replace String    ${urlPath}    ${ParametersField}    ${value_ParametersField}
	#Log To Console    replaceUrl${replaceParametersUrl}
    ${replaceIPAddressUrl}=    Replace String    ${replaceParametersUrl}    ${ParametersField_ipAddress}    ${value_ipAddress}
	#Log To Console    replaceUrl${replaceIPAddressUrl}
	${path}=    Set Variable    ${replaceIPAddressUrl}
	#Log To Console    ${path}
	[return]    ${path}	

Replace Parameters
	[Arguments]    ${urlPath}    ${ParametersField}    ${value_ParametersField}
	${replaceParametersUrl}=    Replace String    ${urlPath}    ${ParametersField}    ${value_ParametersField}
	#Log To Console    replaceUrl${replaceParametersUrl}
	${path}=    Set Variable    ${replaceParametersUrl}
	#Log To Console    ${path}
	[return]    ${path}	
	
Check Matched
    [Arguments]    ${image}
	Set Min Similarity    0.99
	${index}=    Set Variable    
    FOR    ${index}    IN RANGE    1    5
	    ${valueCheck}=    Exists    ${image}    2
	    Run Keyword If    ${valueCheck} == True    Exit For Loop
	    Run Keyword If    ${valueCheck} == False    Log To Console    ${\n}Failed!! Retry Check Again!!#${index}	     
	    ${index}=    Evaluate    ${index} + 1
    END
	[return]    ${valueCheck}	

Check Matched Result
    [Arguments]    ${image}
	Set Min Similarity    0.99
	Exists    ${image}    2
	#Run Keyword If    ${valueCheck} == True   Log    Pass    #Log    'PASS'
    #...    ELSE   FAIL    msg=Not Matched

Open Program  
    Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	Log To Console    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	#Open Directory
	#Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	#Log    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
	# ${result_folder_header}=    Run Keyword And Return Status    Wait Until Screen Contain    ${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}    5  
	# Run Keyword If	'${result_folder_header}' == 'True'    Click    ${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}
	# Run Keyword If	'${result_folder_header}' == 'False'    Click    Thing-Simulator-Portable1_V3.1.0.png
	${result}=    Run Keyword And Return Status    Wait Until Screen Contain    ${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}    5   
	Run Keyword If	'${result}' == 'True'    Double Click    ${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}
	Run Keyword If	'${result}' == 'False'    Double Click    Thing_Simulator_2.png
	#Run Keyword If	'${result}' == 'False'    Log To Console    ${\n} Retry Open Application "${ASGARD_COAPAP_IMAGE_THING_SIMULATOR}" Failed!!
	Log To Console    Do : ${ASGARD_COAPAP_IMAGE_MAGELLANCLIENT_HEADER}
	Wait Until Screen Contain    ${ASGARD_COAPAP_IMAGE_MAGELLANCLIENT_HEADER}    5

Open Program MQTT  
    Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_MQTT}
    Double Click    ${ASGARD_MQTT_IMAGE_MQTTSPY}
	Wait Until Screen Contain    ${ASGARD_MQTT_IMAGE_MQTTSPY_HEADER}    5

Select Dropdrown ENV
    [Arguments]    ${value_selectd}
    Exists     ${ASGARD_COAPAPP_IMAGE_DDL_ENV_IOT_DOCKERAZURE}     5
	Click    ${ASGARD_COAPAPP_IMAGE_DDL_ENV_IOT_DOCKERAZURE}
    Exists     ${value_selectd}     5
	Click    ${value_selectd}
	
Select Dropdrown Function
    [Arguments]    ${value_selectd}
    Exists     ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_REPORT}     5
	Click    ${ASGARD_COAPAPP_IMAGE_DDL_FUNCTION_REPORT}
    Exists     ${value_selectd}     5
	Click    ${value_selectd}	

Clear Input  
    [Arguments]    ${img_input}
    Double Click    ${img_input}
	Type With Modifiers    x    KEY_CTRL	

Clear Input Again 
    [Arguments]    ${img_url}
    Double Click    ${img_url}
	Type With Modifiers    x    KEY_CTRL	
    
Input Url 
    [Arguments]    ${img_url}    ${url}    ${img_url_null}
    Log To Console    Do : ${img_url}
	Exists     ${img_url}     5
	Clear Input    ${img_url}

    #check again
	${status}=    Run Keyword And Return Status    Wait Until Screen Contain     clear_input.png     5
    Run Keyword If    '${status}'=='True'    Clear Input Again    clear_input.png

    #check again
	${status1}=    Run Keyword And Return Status    Wait Until Screen Contain     clear_input1.png     5
    Run Keyword If    '${status1}'=='True'    Clear Input Again    clear_input1.png

    Run Keyword If    '${status}'=='False' and '${status1}'=='False'    Log To Console    Clear Success

    Log To Console    Do : ${img_url_null}
	Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Text    ${img_url_null}    ${url} 
	
Input Payload 
    [Arguments]    ${value}
	Clear Input    ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD}
	Input Text    ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD_NULL}    ${value}

Input Payload Textarea Null 
    [Arguments]    ${value}
	Input Text    ${ASGARD_COAPAP_IMAGE_TXTAREA_PAYLOAD_NULL}    ${value}
	
Close Program
    Click    ${ASGARD_IMAGE_BTN_CLOSE}
	
Input Value
    [Arguments]    ${img_txt_data}    ${txt}
	Exists     ${img_txt_data}     5
	Double Click    ${img_txt_data}
	Input Text    ${img_txt_data}    ${txt}

Input Value And Clear
    [Arguments]    ${img_txt_data}    ${img_txt_data_all}    ${txt}
	Exists     ${img_txt_data}     5
	#Double Click    ${img_txt_data}
	Clear Input    ${img_txt_data}
	Input Text    ${img_txt_data_all}    ${txt}

Input Value And Delete
    [Arguments]    ${img_txt_data}    ${txt}
	Exists     ${img_txt_data}     5
	Double Click    ${img_txt_data}
	Clear Input    ${img_txt_data}
	Input Text    ${img_txt_data}    ${txt}


#for use check log and verify DB check data 
Check Json Data Should Be Equal
	[Arguments]    ${JsonData}    ${field}    ${expected}    ${fieldName}
	
	#json.dumps use for parameter convert ' to "
	${listAsString}=    Evaluate    json.dumps(${JsonData})    json
	#r use for parameter / have in data
	${resp_json}=    Evaluate    json.loads(r'''${listAsString}''')    json
	#Log To Console    resp_json${resp_json}	
    #Should Be Equal    ${resp_json['${field}']}    ${expected}
	#Log To Console    resp_json${resp_json${field}}
	Log Many    ${listAsString}	
	Log To Console    ${fieldName} : ${expected} = ${resp_json${field}}
    Run Keyword And Continue On Failure    Should Be Equal    ${expected}    ${resp_json${field}}    error=${field}	

Teardown Message
    [Arguments]    ${message}
    Log    Failed!!!	
  

Generic Test Case Teardown
    [Arguments]    ${Flow}    ${getData}
    # Catch of Try Catch Finally
    Run Keyword If Test Failed    Test Case Catch 
    # Finally of Try Catch Finally
    #  RKITS is only executed when test passed.
    Run Keyword If Test Passed    Test Case Finally
	Run Keyword If	"${Flow}" == "${SERVERDESTINATION}"    Rollback Data Server Destination    ${getData}
	#Run Keyword If	"${Flow}" == "${SERVERDESTINATION}"    Close Program

Generic Test Case Teardown HTTP
    [Arguments]    ${Flow}    ${getData}
    # Catch of Try Catch Finally
    Run Keyword If Test Failed    Test Case Catch 
    # Finally of Try Catch Finally
    #  RKITS is only executed when test passed.
    Run Keyword If Test Passed    Test Case Finally
	Run Keyword If	"${Flow}" == "${SERVERDESTINATION_HTTP}"    Rollback Data Server Destination    ${getData}

Test Case Catch
    Log To Console    Test Case Catch : Rollback!!
 
	 
Test Case Finally
    Log To Console    Test Case Finally

Open Directory
    #Add Needed Image Path
    #set variable ${IMAGE_DIR} for set folder img
	Add Image Path    ${CURDIR}${IMAGE_PATH_ASGARD_COAPAPP}
    sleep    1s
	Exists     search.png     5
    Click    search.png
    Double Click    input_search.png
	SikuliLibrary.Input Text    input_search.png    file explorer
	Click    File_Explorer.png
	Add Image Path    ${CURDIR}${path_Thing-Simulator-Portable_V3.1.0}
	${path_simulator}=    Normalize path    ${CURDIR}${path_Thing-Simulator-Portable_V3.1.0}
	Log    ${path_simulator}
	SikuliLibrary.Input Text    Quick_access.png    ${path_simulator}
    Click    enter.png


Click Button
    [Arguments]    ${IMG}
	Exists     ${IMG}     5
	Click    ${IMG}


Prepare data for IMEI ThingSecret ThingIdentifier
	#set IMEI
	${randomIM1}=    Evaluate    random.randint(10000000, 99999999)    random
	${randomIM2}=    Evaluate    random.randint(1000000, 9999999)    random
	${random_IMEI}=    Set Variable    ${randomIM1}${randomIM2}
	# Log To Console    ${random_IMEI} 
	Set Global Variable    ${IMEI}    ${random_IMEI}
    Log To Console    IMEI is : ${IMEI}

	#set ThingSecret
	${randomIM3}=    Evaluate    random.randint(10000000, 99999999)    random
	${randomIM4}=    Evaluate    random.randint(1000000, 9999999)    random
	${random_ThingSecret}=    Set Variable    ${randomIM3}${randomIM4}
	# Log To Console    ${random_ThingSecret} 
	Set Global Variable    ${ThingSecret}    ${random_ThingSecret}
    Log To Console    ThingSecret is : ${ThingSecret}
	
	#set ThingIdentifier
	${randomICCID1}=    Evaluate    random.randint(1000000, 9999999)    random
	${randomICCID2}=    Evaluate    random.randint(100000, 999999)    random
	${random_ThingIdentifier}=    Set Variable    ${FIELD_ICCIDPRE}${randomICCID1}${randomICCID2}
	# Log To Console    ${random_ThingIdentifier} 
	Set Global Variable    ${ThingIdentifier}    ${random_ThingIdentifier}
    Log To Console    ThingIdentifier is : ${ThingIdentifier}	

	[return]    ${IMEI}    ${ThingSecret}    ${ThingIdentifier}