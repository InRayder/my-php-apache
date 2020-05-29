<?php  
$serverUrl = "210.17.120.49, 11433";
$connInfo = array( "Database"=>"RISDB", "UID"=>"risuser", "PWD"=>"rispassword", "CharacterSet" => "UTF-8");
//$connInfo = array( "Database"=>"WebCrawlerData", "UID"=>"php", "PWD"=>"phptest", "CharacterSet" => "UTF-8");
echo $serverUrl."\n";
$conn = sqlsrv_connect( $serverUrl, $connInfo);
if( $conn ) {
 echo "Connection succeeded.";
}else{
 echo "Connection failed.";
 die( print_r( sqlsrv_errors(), true));
}

sqlsrv_close($conn);  
?>
