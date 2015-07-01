# Self Study abroad

获得用户手机：

if DeviceType.IS_IPHONE_6 {

} else if DeviceType.IS_IPHONE_5 {

} else if DeviceType.IS_IPHONE_6P {

} else if DeviceType.IS_IPHONE_4_OR_LESS {

} else if DeviceType.IS_IPAD {

}


调用服务器API：

ServerMethods.getAllUsers(<#T##token: String##String#>)

ServerMethods.getCollege(<#T##from: String##String#>, to: <#T##String#>, token: <#T##String#>)

ServerMethods.obtainNewToken(<#T##refresh_token: String##String#>)

ServerMethods.obtainToken(<#T##username: String##String#>, password: <#T##String#>)

ServerMethods.signup(<#T##username: String##String#>, password: <#T##String#>)