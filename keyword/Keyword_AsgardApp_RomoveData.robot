*** Keywords ***
####################################################
Rollback Data Server Destination
	#ThingId,WorkerId
	[Arguments]    ${getData}

	${WorkerId}=    Set Variable    ${getData}[0]
	${ThingId}=    Set Variable    ${getData}[5]
	# Log To Console    WorkerId${WorkerId}
	# Log To Console    ThingId${ThingId}

    ${result}=    Run Keyword And Return Status    Server Destination Request RemoveData    ${ThingId}    ${WorkerId}
	# Log To Console    result${result}
	Run Keyword If    '${result}'=='false'    Log To Console    ${\n}===Delete Data Failed!====${\n}
	Run Keyword If    '${result}'=='true'    Log To Console    ${\n}===Delete Data Succeeds!===${\n}


