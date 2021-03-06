*** Variables ***
${timeout}    0.5 second
${delay}    0.3
${BROWSER}    chrome

#STAGING
# ${URL}    https://mg-staging.siamimo.com
# ${SIGNIN_USERNAME}    QATest_003
# ${SIGNIN_PASSOWORD}    bnZkZm5nZXJnbGtkanZlaWdqbmVvZGtsZA==
#IOT
# ${URL}    https://mgcentric-iot.siamimo.com
${URL}    https://mg-iot.siamimo.com
${URL_CENTRIC}    https://mgcentric-iot.siamimo.com

${SIGNIN_USERNAME}    QA_SC
${SIGNIN_PASSOWORD}    VGVzdDEyMzQ=

${PROVISIONINGAPIS}    /provisioningapis
${CONTROLAPIS}    /controlapis
${CENTRICAPIS}    /centricapis
${ASGARDHTTP}    /asgardhttp

#IOT
#username
${SIGNIN_USERNAME}    QATest_003
#password
${SIGNIN_PASSOWORD}    bnZkZm5nZXJnbGtkanZlaWdqbmVvZGtsZA==

#header
${HEADER_CONTENT_TYPE}    application/json
${HEADER_ACCEPT}    */* 
${HEADER_X_AIS_USERNAME_AISPARTNER}    AisPartner
${HEADER_AUTHENTICATION}    Basic ZWxhc3RpYzpSM2RoQHQhQCM=

#NAME_SESSION
${NAME_SESSION_GET}    GET
${NAME_SESSION_POST}    POST
${NAME_SESSION_PUT}    PUT
${NAME_SESSION_DELETE}    DELETE

#status code
${STATUS_CODE_SUCCESS}    200
${STATUS_CODE_CREATE}    201

#field resultCode resultDescription 
${VALUE_RESULTCODE_20000}    20000
${VALUE_RESULTCODE_20100}    20100
${VALUE_RESULTCODE_50000}    50000

${FIELD_OPERATIONSTATUS}    OperationStatus
${FIELD_CODE}    Code
${FIELD_DESCRIPTION}    Description
${FIELD_OPERATIONSTATUS_LOWCASE}    operationStatus
${FIELD_CODE_LOWCASE}    code
${FIELD_DESCRIPTION_LOWCASE}    description
${FIELD_DEVELOPERMESSAGE}    DeveloperMessage
${FIELD_STATUS}    Status 
${FIELD_STATUSDESCRIPTION}    StatusDescription





