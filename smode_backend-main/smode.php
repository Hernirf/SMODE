<?php

require('vendor/autoload.php');

use \PhpMqtt\Client\MqttClient;
use \PhpMqtt\Client\ConnectionSettings;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

$host = "localhost";
$username = "root";
$password = "";
$database = "smode";

$conn = mysqli_connect($host, $username, $password, $database);

$server   = 'nae2e62a.ala.asia-southeast1.emqxsl.com';
$port     = 8883;
$clientId = 'SMODE PHP';
$username = 'smode';
$password = '12345678';
$clean_session = false;

$connectionSettings  = (new ConnectionSettings)
  ->setUsername($username)
  ->setPassword($password)
  ->setKeepAliveInterval(60)
  ->setConnectTimeout(3)
  ->setUseTls(true)
  ->setTlsSelfSignedAllowed(true);


function getAccessToken() {
    $serviceAccountPath = 'smode-e4417-32f9e415b3ab.json';

    // Sesuaikan dengan file JSON service account Anda
    $credentials = json_decode(file_get_contents($serviceAccountPath), true);

    $jwtHeader = base64_encode(json_encode(['alg' => 'RS256', 'typ' => 'JWT']));
    $now = time();
    $jwtClaim = base64_encode(json_encode([
        'iss' => $credentials['client_email'],
        'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
        'aud' => $credentials['token_uri'],
        'iat' => $now,
        'exp' => $now + 3600
    ]));

    $jwt = $jwtHeader . '.' . $jwtClaim;
    $signature = '';
    openssl_sign($jwt, $signature, $credentials['private_key'], 'SHA256');
    $jwt .= '.' . base64_encode($signature);

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $credentials['token_uri']);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/x-www-form-urlencoded']);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
        'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion' => $jwt
    ]));

    $response = curl_exec($ch);
    curl_close($ch);

    $responseData = json_decode($response, true);
    return $responseData['access_token'];
}

function sendNotification($deviceToken, $pesan) {
    $apiKey = 'AAAAF904xjk:APA91bFDCMiubnU4sKhrwz6ajJMZ-rqb5K86WwhD_fw3W77bivayMzK_d6bzZQ5r967qj2HA0PBwioZdww3ArW0f44l_myTQBZn_LdPqwlVAO-OIiZ5K48UMjkmqQR5-AxuNfcviatRG';

    $title = 'Motor anda terindikasi dalam keadaan '.$pesan;
    $body = 'Segera lakukan tindakan yang diperlukan untuk pengamanan!';

    $payload = array(
        'message'=> array(
        "token"=>$deviceToken,
        "notification"=> array(
            'title' => $title,
            'body' => $body
        ),
        )
    );

    $accessToken = getAccessToken();

    $headers = array(
        // 'Authorization: Bearer ya29.a0AcM612wOaL4U2ed1FQvr4gBmdHstpy6843nZblsGdb_8IwInCsfYg2UxfprICgGyEhyezoHZh2qOgJ1IiuuGe9W-tDGG7c-api549YhrWeDkgTbvSYrPeWU2pTlyS-4RO7iiAijMDvbX64xMGoAHagp0T0oMLEp1qSGFk3LsaCgYKARYSARISFQHGX2Mi-y36NB--qQJnJQjvukyEbg0175',
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    );

    $ch = curl_init('https://fcm.googleapis.com/v1/projects/smode-e4417/messages:send');

    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $response = curl_exec($ch);
    curl_close($ch);

    return $response; // Optional: Untuk melihat respon dari server
}

$mqtt = new MqttClient($server, $port, $clientId, MqttClient::MQTT_3_1_1);

$mqtt->connect($connectionSettings, $clean_session);

$id = 1;

$topic_lokasi = 'vehicle/lokasi/' . $id;

$mqtt->subscribe($topic_lokasi, function ($topic, $message) {
    list($lat, $lon) = explode(",", $message);

    global $id;
    global $conn;

    $sql = "UPDATE `vehicles` SET `lat` = '$lat', `lon` = '$lon' WHERE `id` = $id";

    if (mysqli_query($conn, $sql)) {
        print("[Success] Data Vehicle ID $id berhasil diupdate\n");
    } else {
        print("[Error] Data Vehicle ID $id gagal diupdate\n");
    }

}, 0);

$topic_deteksi = 'vehicle/deteksi/' . $id;

$mqtt->subscribe($topic_deteksi, function ($topic, $message) {
    printf("Received message on topic [%s]: %s\n", $topic, $message);
    global $id;
    global $conn;

    $sql = "SELECT `token` FROM `users` WHERE id = $id";

    $result = $conn->query($sql);

    // print($result->num_rows);


    if ($result->num_rows > 0) {

        $row = $result->fetch_assoc();
        $token = $row["token"];


        sendNotification($token, $message);

    }
    else{
        println("tidak tahu");
    }

    date_default_timezone_set('Asia/Singapore');
    $now = now();

    $sql = "INSERT INTO `detections` (`vehicle_id`, `message`, `created_at`, `updated_at`) VALUES ('$id', '$message' ,'$now', '$now')";

    if (mysqli_query($conn, $sql)) {
        print("[Success] Data Detection Vehicle ID $id berhasil dibuat\n");
    } else {
        print("[Error] Data Detection Vehicle ID $id gagal dibuat\n");
    }

}, 0);


// $modeaman = 1;

$topic = 'vehicle/mesin/' . $id;

$mqtt->subscribe($topic, function ($topic, $message) {
    printf('Received message on topic [%s]: %s',$topic, $message);
}, 0);

// $mqtt->subscribe('php/mqtt', function ($topic, $message) {
//     printf("Received message on topic [%s]: %s\n", $topic, $message);
// }, 0);

// $payload = array(
//   'from' => 'php-mqtt client',
//   'date' => date('Y-m-d H:i:s')
// );
// $mqtt->publish($topic, json_encode($payload), 0);

$topic_aman = 'vehicle/aman/' . $id;
$mqtt->subscribe($topic_aman, function ($topic, $message) {
    printf('Received message on topic [%s]: %s',$topic, $message);

    global $id;
    global $conn;

    $sql = "UPDATE `vehicles` SET `mode_aman` = '$message' WHERE `id` = $id";

    if (mysqli_query($conn, $sql)) {
        print("\n[Success] Data Vehicle ID $id berhasil diupdate\n");
    } else {
        print("[Error] Data Vehicle ID $id gagal diupdate\n");
    }

}, 0);

$mqtt->loop(true);
