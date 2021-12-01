*** Variables ***
#STAGING
# mongodb://{$user}:{$pass}@{$ip}:${port}/mgcore?authSource=admin	
# ${CONNECT_TO_MONGODB}    mongodb://admin:ais.co.th@104.215.197.5:27018/mgcore?authSource=admin

#IOT
# mongodb://{$user}:{$pass}@{$ip}:${port}/mgcore?authSource=admin
${CONNECT_TO_MONGODB}    mongodb://admin:ais.co.th@52.163.210.190:27018/mgcore?authSource=admin

#----------------------------------------------------------------------------------------#
${MONGODB_TYPE_ALL}    All
${MONGODB_TYPE_SEARCHBYSELECTFIEDS}    SearchBySelectFields
${MONGODB_TYPE_INSERTDATA}    InsertData
#-------------------------------------- Table --------------------------------------------------#
${MONGODB_DBNAME_MGCORE}    mgcore
${MONGODB_DBCOLLNAME_TB_HOUSEKEEPERS}    housekeepers
${MONGODB_DBCOLLNAME_TB_THINGHISTORIE}    thinghistorie

#-------------------------------------- Detail Provisioning --------------------------------------------------#
${VALUE_DB_HOUSEKEEPER}    "{'_id': ObjectId('[HouseKeeperId]'), 'ConditionProperties': [ConditionProperties], 'Type': '[Type]', 'BindingType': '[BindingType]', 'BindingKey': '[BindingKey]', 'Name': '[Name]', 'Resource': [Resource], 'Status': '[Status]', 'CreatedDateTime': datetime.datetime([CreatedDateTime]), 'LastUpdatedTimestamp': datetime.datetime([LastUpdatedTimestamp]), 'RemoveStatus': [RemoveStatus]}"
${VALUE_DB_THINGHISTORIE}    "{"RemoveStatus": false,"AccountId":ObjectId('[AccountId]'), "ThingId" : ObjectId('[ThingId]'), "OrderRef" : "10:30:10 AM", "Protocol" : "HTTP", "EventType" : "Desire", "Sensors" : { "AA" : 106607.0, "Timestmap" : "9:17:10 AM" }, "DocumentSize" : 500000000.0, "DBThingDataSize" : 380.0, "RawThingDataSize" : 164.0, "ThingDataSize" : 610.0, "CustomerId" : ObjectId('[CustomerId]'), "TenantId" : ObjectId('[TenantId]')}"

# ${VALUE_DB_THINGHISTORIE}    "{"RemoveStatus": false,"AccountId":ObjectId('[AccountId]'), "ThingId" : "${ThingId[0]}", "OrderRef" : "10:30:10 AM", "Protocol" : "HTTP", "EventType" : "Desire", "Sensors" : { "AA" : 106607.0, "Timestmap" : "9:17:10 AM" }, "DocumentSize" : 500000000.0, "DBThingDataSize" : 380.0, "RawThingDataSize" : 164.0, "ThingDataSize" : 610.0, "CustomerId" : "${postCreatePartner}[4]", "TenantId" : "${postCreatePartner}[0]"}"