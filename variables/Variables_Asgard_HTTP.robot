*** Variables ***
#-------------------------------------------- Start ENV Master --------------------------------------------#
#STAGING	
# ${URL_GET_LOG}    https://mg-staging.siamimo.com:30380/elasticsearch/application*/_search?rest_total_hits_as_int=true&ignore_unavailable=true&ignore_throttled=true&preference=1620900474581&timeout=30000ms
# applicationName : asgardhttp
# ${VALUE_APPLICATIONNAME_ASGARDHTTP}    asgardhttp

#IOT asgardhttp
${URL_GET_LOG}    https://mg-iot.siamimo.com:30380/elasticsearch/application*/_search?rest_total_hits_as_int=true&ignore_unavailable=true&ignore_throttled=true&preference=1620900474581&timeout=30000ms
# applicationName : asgardhttp
${VALUE_APPLICATIONNAME_ASGARDHTTP}    asgardhttp

#-------------------------------------------- Data AsgardHTTP --------------------------------------------#	
#-------------------------------------------- ServerDestination --------------------------------------------#	
#path url ServerDestination
${ASGARD_HTTP_URL_SERVERDESTINATION}    /api/v2/things/ThingIdentifier/ThingSecret/server/destination

#header ServerDestination
${HEADER_X_AIS_ORDERREF_SERVERDESTINATION}    ServerDestination_
${HEADER_X_AIS_ORDERREF_SERVERDESTINATION_FAIL}    ServerDestinationfail_
${HEADER_X_AIS_ORDERDESC_SERVERDESTINATION}    ServerDestination

#response description
${VALUE_DESCRIPTION_SERVERDESTINATION_SUCCESS}    The requested operation was successfully.

#request name
${SERVERDESTINATION}    ServerDestination
${SERVERDESTINATION_HTTP}    ServerDestination
#----------------------------------------------------------------------------------------#	
${ASGARD_HTTP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_NOTFOUND}    1111135026573339052
${ASGARD_HTTP_SERVERDESTINATION_VALUE_THINGSECRET_NOTFOUND}    111524055695113

${ASGARD_HTTP_SERVERDESTINATION_VALUE_THINGIDENTIFIER_INVALID}    %20
${ASGARD_HTTP_SERVERDESTINATION_VALUE_THINGSECRET_INVALID}    %20

