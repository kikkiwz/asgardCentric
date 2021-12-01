*** Variables ***
#-------------------------------------------- signin --------------------------------------------#	
#path url signin
${URL_SIGNIN}    /api/v1/auth/signin

#header Signin
${HEADER_X_AIS_ORDERREF_SIGNIN}    Signin_
${HEADER_X_AIS_ORDERDESC_SIGNIN}    User Authentication

#response description
${VALUE_DESCRIPTION_SINGNIN_SUCCESS}    SignInProcess is Success

#request name
${SINGNIN}    Signin

#-------------------------------------------- ValidateToken --------------------------------------------#	
#path url ValidateToken
${URL_VALIDATETOKEN}    /api/v1/auth/ValidateToken

#header ValidateToken
${HEADER_X_AIS_ORDERREF_VALIDATETOKEN}    ValidateToken_
${HEADER_X_AIS_ORDERDESC_VALIDATETOKEN}    ValidateToken

#response description
${VALUE_DESCRIPTION_VALIDATETOKEN_SUCCESS}    ValidateTokenProcess is Success

#request name
${VALIDATETOKEN}    ValidateToken
#-------------------------------------------- Partner --------------------------------------------#	
#path url CreatePartner
${URL_CREATEPARTNER}    /api/v1/Partner/CreatePartner

#header CreatePartner
${HEADER_X_AIS_ORDERREF_CREATEPARTNER}    CreatePartner_
${HEADER_X_AIS_ORDERDESC_CREATEPARTNER}    CreatePartner

#value Create Partner
${VALUE_PARTNERNAME}    SC_
${VALUE_MERCHANTCONTACT}    Jida_TestMerchantContact@ais.co.th
${VALUE_CPID}    Jida_TesCPID@ais.co.th
${VALUE_ACCOUNTNAME}    Jida_TestAccountname
${VALUE_CONFIGGROUPNAME}    Sensor_TestThingGroupName

#response description
${VALUE_DESCRIPTION_CREATEPARTNER_SUCCESS}    CreatePartner is Success

#request name
${CREATEPARTNER}    CreatePartner
#-------------------------------------------- Account --------------------------------------------#	
#path url CreateAccount
${URL_CREATEACCOUNT}    /api/v1/Account/CreateAccount

#header CreateAccount
${HEADER_X_AIS_ORDERREF_CREATEACCOUNT}    CreateAccount_
${HEADER_X_AIS_ORDERDESC_CREATEACCOUNT}    CreateAccount

#response description
${VALUE_DESCRIPTION_CREATEACCOUNT_SUCCESS}    CreateAccount is Success

#request name
${CREATEACCOUNT}    CreateAccount
#-------------------------------------------- CreateThing --------------------------------------------#	
#path url CreateThing
${URL_CREATETHING}    /api/v1/Thing/CreateThing

#header CreateThing
${HEADER_X_AIS_ORDERREF_CREATETHING}    CreateThing_
${HEADER_X_AIS_ORDERDESC_CREATETHING}    CreateThing

#value Create CreateThing
${VALUE_THINGNAME}    Sensor_TestThingName

#response description
${VALUE_DESCRIPTION_CREATETHING_SUCCESS}    CreateThing is Success

#request name
${CREATETHING}    CreateThing

#-------------------------------------------- CreateThingStateInfo --------------------------------------------#	
#path url CreateThingStateInfo
${URL_CREATETHINGSTATEINFO}    /api/v1/Thing/CreateThingStateInfo

#header CreateThingStateInfo
${HEADER_X_AIS_ORDERREF_CREATETHINGSTATEINFO}    CreateThingStateInfo_
${HEADER_X_AIS_ORDERDESC_CREATETHINGSTATEINFO}    CreateThingStateInfo

#value Create ThingStateInfo
${VALUE_SENSORKEY}    Temp
${VALUE_SENSORKEY_CHARGING}    AA
${VALUE_TYPE}    Report

#response description
${VALUE_DESCRIPTION_CREATETHINGSTATEINFO_SUCCESS}    CreateThingStateInfo is Success

#request name
${CREATETHINGSTATEINFO}    CreateThingStateInfo
#-------------------------------------------- ConfigGroup --------------------------------------------#	
#path url CreateConfigGroup
${URL_CREATECONFIGGROUP}    /api/v1/ConfigGroup/CreateConfigGroup

#header CreateConfigGroup
${HEADER_X_AIS_ORDERREF_CREATECONFIGGROUP}    CreateConfigGroup_
${HEADER_X_AIS_ORDERDESC_CREATECONFIGGROUP}    CreateConfigGroup

#value Create ConfigGroup
#"ConfigInfo": {"RefreshTime": "On","Max": "99"}
${VALUE_CONFIGINFO_KEY_REFRESHTIME}    RefreshTime
${VALUE_CONFIGINFO_KEY_REFRESHTIME_VALUE}    On
${VALUE_CONFIGINFO_KEY_MAX}    Max
${VALUE_CONFIGINFO_KEY_MAX_VALUE}    99
#response description
${VALUE_DESCRIPTION_CREATECONFIGGROUP_SUCCESS}    CreateConfigGroup is Success

#request name
${CREATECONFIGGROUP}    CreateConfigGroup
#-------------------------------------------- Control --------------------------------------------#	
#path url Control
${URL_CREATECONTROLTHING}    /api/v1/Control/Thing

#header CreateControlthing
${HEADER_X_AIS_ORDERREF_CREATECONTROLTHING}    CreateControlthing_
${HEADER_X_AIS_ORDERDESC_CREATECONTROLTHING}    CreateControlthing
#response description
${VALUE_DESCRIPTION_CREATECONTROLTHING_SUCCESS}    ControlOneThing is Success

#request name
${CREATECONTROLTHING}    CreateControlthing

#-------------------------------------------- CreateAThing --------------------------------------------#	
#path url CreateAThing
${URL_CREATEATHING}    /api/v1/Things

#header CreateAThing
${HEADER_X_AIS_ORDERREF_CREATEATHING}    CreateAThing_
${HEADER_X_AIS_ORDERDESC_CREATEATHING}    CreateAThing

#value Create CreateAThing
# ${VALUE_THINGNAME}    Sensor_TestThingName

#response description
${VALUE_DESCRIPTION_CREATEATHING_SUCCESS}    Successfully created.

#request name
${CREATEATHING}    CreateAThing

#request name
${VALUE_ATHINGNAME}    ThingName
${VALUE_SUPPLIERID}    SupplierId
${VALUE_SUPPLIERNAME}    SupplierName

${VALUE_THINGSTATE_IDLE}    Idle
${VALUE_THINGSTATE_PENDING}    Pending
${VALUE_THINGSTATE_MENUFACTURING}    Menufacturing
${VALUE_THINGSTATE_ACTIVATED}    Activated
${VALUE_CONNECTIVITYTYPE_NBIOT}    NBIOT
${VALUE_CONNECTIVITYTYPE_WIFI}    WIFI

#-------------------------------------------- CreateAWorker --------------------------------------------#	
#path url CreateAWorker
${URL_CREATEAWORKER}    /api/v1/Workers

#header CreateAWorker
${HEADER_X_AIS_ORDERREF_CREATEAWORKER}    CreateAWorker_
${HEADER_X_AIS_ORDERDESC_CREATEAWORKER}    CreateAWorker

#response description
${VALUE_DESCRIPTION_CREATEAWORKER_SUCCESS}    Successfully created.

#request name
${CREATEAWORKER}    CreateAWorker

#request name
${VALUE_WORKNAME}    Worker
${VALUE_SERVERIP}    127.0.2.2
${VALUE_SERVERPORT}    8080
${VALUE_SERVERDOMAIN}    Worker001.com

${VALUE_WORKERSTATE_ACTIVATED}    Activated
${VALUE_WORKERSTATE_TERMINATED}    Terminated
${VALUE_WORKERSTATE_IDLE}    Idle
${VALUE_WORKERSTATE_TEST}    Test

#-------------------------------------------- ActivateThings --------------------------------------------#	
#path url ActivateThings
${URL_ACTIVATETHINGS}    /api/v1/Capability/Worker/{WorkerId}/Thing/Activates

#header ActivateThings
${HEADER_X_AIS_ORDERREF_ACTIVATETHINGS}    ActivateThings_
${HEADER_X_AIS_ORDERDESC_ACTIVATETHINGS}    ActivateThings

#response description
${VALUE_DESCRIPTION_ACTIVATETHINGS_SUCCESS}    The requested operation was successfully.

#request name
${ACTIVATETHINGS}    ActivateThings

#-------------------------------------------- Other --------------------------------------------#	
#Other field
${FIELD_ACCESSTOKEN}    AccessToken    
${FIELD_PARTNERINFO}    PartnerInfo  
${FIELD_PARTNERID}    PartnerId  
${FIELD_ACCOUNTINFO}    AccountInfo  
${FIELD_ACCOUNTNAME}    AccountName  
${FIELD_ACCOUNTID}    AccountId  
${FIELD_THINGINFO}    ThingInfo  
${FIELD_THINGID}    ThingId 
${FIELD_THINGIDENTIFIER}    ThingIdentifier  
${FIELD_THINGSECRET}    ThingSecret  
${FIELD_IMSI}    IMSI  
${FIELD_IMEI}    IMEI
${FIELD_THINGTOKEN}    ThingToken   
${FIELD_CONFIGGROUPINFO}    ConfigGroupInfo   
${FIELD_CONFIGGROUPID}    ConfigGroupId   
${FIELD_WORKERSINFO}    WorkersInfo 
${FIELD_WORKERID}    WorkerId
${FIELD_ICCIDPRE}    896603
${FIELD_SERVERDESTINATIONINFO}    ServerDestinationInfo  
${FIELD_SERVERID}    ServerIP
${FIELD_SERVERPORT}    ServerPort
${FIELD_SERVERDOMAIN}    ServerDomain
${FIELD_DETAILS}    Details
${FIELD_TARGET}    Target
${FIELD_DEVELOPERMESSAGE}    DeveloperMessage





