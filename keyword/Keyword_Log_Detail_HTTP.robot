*** Keywords ***	
################################################################-- Do Have EndPointName --################################################################
#-------------------------------------------- HTTP --------------------------------------------#	
#-------------------------------------------- Server Destination : RequestObject --------------------------------------------#	
Check RequestObject App Success HTTP Server Destination
    [Arguments]    ${dataResponse}    ${pathUrl}    ${tid}    ${body}    ${cmdName}    ${code}    ${description}    ${identity}

	${method}=    Set Variable    ${NAME_SESSION_GET}
	# Log To Console    method${method}

	${orderdesc}=    Set Variable    ${HEADER_X_AIS_ORDERDESC_SERVERDESTINATION}
    # Log To Console    orderdesc${orderdesc}

	${requestObjectData}=    Set Variable    ${dataResponse['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_REQUESTOBJECT}']}
    # Log To Console    requestObjectData${requestObjectData}

    ${url}=    Remove String    ${pathUrl}    /api/v2
 
	${resp_json}=    Evaluate    json.loads(r'''${requestObjectData}''')    json
	# Log To Console    resp_json${resp_json['headers']['x-real-ip']}

    ${routeParameters}=    Set Variable    ${identity}

	${queryString}=    Set Variable    {}
	${host}=    Set Variable    ${resp_json['headers']['host']}
	${xRealIp}=    Set Variable    ${resp_json['headers']['x-real-ip']}
	${xForwardedFor}=    Set Variable    ${resp_json['headers']['x-forwarded-for']}
	${xForwardedProto}=    Set Variable    ${resp_json['headers']['x-forwarded-proto']}
	${contentLength}=    Set Variable    ${resp_json['headers']['content-length']}
	${userAgent}=    Set Variable    ${resp_json['headers']['user-agent']}
	${acceptEncoding}=    Set Variable    ${resp_json['headers']['accept-encoding']}
	${contentType}=    Set Variable    ${resp_json['headers']['content-type']}
	${xRequestId}=    Set Variable    ${resp_json['headers']['x-request-id']}
	${xB3Traceid}=    Set Variable    ${resp_json['headers']['x-b3-traceid']}
	${xB3Spanid}=    Set Variable    ${resp_json['headers']['x-b3-spanid']}
	${xB3Sampled}=    Set Variable    ${resp_json['headers']['x-b3-sampled']}
	${startTime}=    Set Variable    '${resp_json['headers']['startTime']}'

	${replaceUrl}=    Replace String    ${VALUE_LOG_DETAIL_REQUESTOBJECT_HTTP_APP_CENTRIC_SERVERDESTINATION}    [valuePathUrl]    ${url}
	${replaceTid}=    Replace String    ${replaceUrl}    [tid]    ${tid}
	${replaceBody}=    Replace String    ${replaceTid}    [body]    ${body}
	${replaceMethod}=    Replace String    ${replaceBody}    [method]    ${method}
	${replaceOrderdesc}=    Replace String    ${replaceMethod}    [Orderdesc]    ${orderdesc}
	${replaceHost}=    Replace String    ${replaceOrderdesc}    [host]    ${host}
	${replaceXrealIp}=    Replace String    ${replaceHost}    [x-real-ip]    ${xRealIp}
	${replaceXforwardedFor}=    Replace String    ${replaceXrealIp}    [x-forwarded-for]    ${xForwardedFor}
	${replaceXforwardedProto}=    Replace String    ${replaceXforwardedFor}    [x-forwarded-proto]    ${xForwardedProto}
	${replaceContentLength}=    Replace String    ${replaceXforwardedProto}    [content-length]    ${contentLength}
	${replaceUserAgent}=    Replace String    ${replaceContentLength}    [user-agent]    ${userAgent}
	${replaceAcceptEncoding}=    Replace String    ${replaceUserAgent}    [accept-encoding]    ${acceptEncoding}
	${replaceContentType}=    Replace String    ${replaceAcceptEncoding}    [content-type]    ${contentType}
	${replaceXrequestId}=    Replace String    ${replaceContentType}    [x-request-id]    ${xRequestId}
	${replaceXb3Traceid}=    Replace String    ${replaceXrequestId}    [x-b3-traceid]    ${xB3Traceid}
	${replaceXb3Spanid}=    Replace String    ${replaceXb3Traceid}    [x-b3-spanid]    ${xB3Spanid}
	${replaceXb3Sampled}=    Replace String    ${replaceXb3Spanid}    [x-b3-sampled]    ${xB3Sampled}
	${replaceStartTime}=    Replace String    ${replaceXb3Sampled}    [startTime]    ${startTime}
	${replaceRouteParameters}=    Replace String    ${replaceStartTime}    [routeParameters]    ${routeParameters}
	${replaceQueryString}=    Replace String    ${replaceRouteParameters}    [queryString]    ${queryString}
	${replaceText}=    Replace String    ${replaceQueryString}    '    ${EMPTY}
	${requestObject}=    Replace String To Object    ${replaceText}
	# Log To Console    HouseKeeperRequestObjectApp${requestObject}

	Check Json Data Should Be Equal    ${dataResponse}    ['${FIELD_LOG_DETAIL_CUSTOM1}']['${FIELD_LOG_DETAIL_REQUESTOBJECT}']    ${requestObject}    ${FIELD_LOG_DETAIL_CUSTOM1}.${FIELD_LOG_DETAIL_REQUESTOBJECT}

##############################################################################################################################################################
