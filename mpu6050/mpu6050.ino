#include <Wire.h>
#include <MPU6050.h>
#include <Fuzzy.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <WiFiClientSecure.h>

MPU6050 mpu;


float motorStatus = 0;  // Status motor
unsigned long previousTime = 0;   // Waktu sebelumnya
float deltaDistance = 0;          // Total jarak yang ditempuh
float previousDistance = 0;       // Jarak sebelumnya
float Distance = 0;       // Jarak sebelumnya
float previousAccel = 0;       // Jarak sebelumnya
float velocity = 0;               // Kecepatan saat ini
float deltaTime = 0;              // Interval waktu
float accelTotal = 0;             // Percepatan total
String statusMotor;
float deltaAccel = 0;
int modeAman = 0;
const int alarmPin = 12;  // Pin 12 untuk alarm
unsigned long alarmStartTime = 0;  // Waktu mulai alarm
bool alarmActive = false;          // Status alarm aktif atau tidak


// WiFi and MQTT Broker settings
const char* ssid = "vivo 1920";                
const char* password = "hernican";             
const char* mqttServer = "nae2e62a.ala.asia-southeast1.emqxsl.com";  
const int mqttPort = 8883;                     
const char* mqttUser = "smode";                
const char* mqttPassword = "12345678";         
const char* mqttTopic = "esp32/tes";           

WiFiClientSecure wifiClient;  
PubSubClient mqttClient(wifiClient);

void callback(char* topic, byte* message, unsigned int length) {
  Serial.print("Pesan diterima di topik: ");
  Serial.println(topic);

  String messageTemp;

  for (int i = 0; i < length; i++) {
    messageTemp += (char)message[i];
  }

  messageTemp.trim();

  Serial.print("Pesan: ");
  Serial.println(messageTemp);

  // Mengubah nilai modeAman berdasarkan pesan
  if (String(topic) == "vehicle/aman/1") {
    if (messageTemp == "1") {
      modeAman = 1;
    } else if (messageTemp == "0") {
      modeAman = 0;
    }

    Serial.print("Mode Aman diubah menjadi: ");
    Serial.println(modeAman);
  }
}


// Fungsi fuzzy untuk mendefinisikan variabel
Fuzzy *fuzzy = new Fuzzy();

// FuzzyInput Getaran
FuzzySet *GetarRendah = new FuzzySet(0, 0, 2, 4);
FuzzySet *GetarSedang = new FuzzySet(2, 4, 4, 7);
FuzzySet *GetarTinggi = new FuzzySet(4, 5, 7, 7);

// Gerakan
FuzzySet *GerakRendah = new FuzzySet(0, 0, 2, 4);
FuzzySet *GerakSedang = new FuzzySet(2, 4, 4, 7);
FuzzySet *GerakTinggi = new FuzzySet(4, 5, 7, 7);

// FuzzyOutput Status Motor
FuzzySet *aman = new FuzzySet(0, 0, 1, 2);
FuzzySet *siaga = new FuzzySet(1, 2, 2, 4);
FuzzySet *bahaya = new FuzzySet(2, 3, 4, 4);


float getMembershipAman(float x) {
    if (x >= 0 && x <= 1) return 1; // x <= 0, full membership
    else if (x >= 2) return 0; // x >= 2, no membership
    else return (2 - x); // linear decrease
}

float getMembershipSiaga(float x) {
    if (x <= 1 || x >= 4) return 0; // outside the range, no membership
    else if (x > 1 && x < 2) return (x - 1); // linear increase
    else if (x == 2) return 1; // full membership
    else return (4 - x) / (4 - 2); // linear decrease
}

float getMembershipBahaya(float x) {
    if (x <= 2) return 0; // x <= 2, no membership
    else if (x >= 4) return 1; // x >= 5, full membership
    else return (x - 2) / (4 - 2); // linear increase
}

void setup() {
  Serial.begin(115200); 
  Wire.begin();
  mpu.initialize();

  pinMode(alarmPin, OUTPUT);
  digitalWrite(alarmPin, LOW);  // Awalnya alarm mati


  statusMotor = "A";

  // randomSeed(analogRead(0));

  if (!mpu.testConnection()) {
    Serial.println("MPU6050 tidak terhubung");
    while (1);
  }

  Serial.println("MPU6050 terhubung!");

  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Menghubungkan ke WiFi...");
  }
  Serial.println("Terhubung ke WiFi!");

  
  wifiClient.setInsecure(); 

  // Konek ke MQTT broker
  mqttClient.setServer(mqttServer, mqttPort);
  while (!mqttClient.connected()) {
    Serial.print("Menghubungkan ke MQTT... rc=");
    Serial.print(mqttClient.state());
    if (mqttClient.connect("ESP32Client", mqttUser, mqttPassword)) {
      Serial.println("Terhubung ke MQTT broker!");
    } else {
      Serial.print("Gagal, rc=");
      Serial.print(mqttClient.state());
      delay(2000);
    }
  }

  mqttClient.setCallback(callback);

  // Langganan ke topik di mana kita ingin menerima pesan
  mqttClient.subscribe("vehicle/aman/1");

  // FuzzyInput
  FuzzyInput *getaran = new FuzzyInput(1);
  getaran->addFuzzySet(GetarRendah);
  getaran->addFuzzySet(GetarSedang);
  getaran->addFuzzySet(GetarTinggi);
  fuzzy->addFuzzyInput(getaran);

  FuzzyInput *gerakan = new FuzzyInput(2);
  gerakan->addFuzzySet(GerakRendah);
  gerakan->addFuzzySet(GerakSedang);
  gerakan->addFuzzySet(GerakTinggi);
  fuzzy->addFuzzyInput(gerakan);

  // FuzzyOutput
  FuzzyOutput *status = new FuzzyOutput(1);

  status->addFuzzySet(aman);
  status->addFuzzySet(siaga);
  status->addFuzzySet(bahaya);
  fuzzy->addFuzzyOutput(status);

  // Rule
  FuzzyRuleAntecedent *input1 = new FuzzyRuleAntecedent();
  input1->joinWithAND(GetarRendah, GerakRendah);
  FuzzyRuleConsequent *output1 = new FuzzyRuleConsequent();
  output1->addOutput(aman);
  FuzzyRule *fuzzyRule1 = new FuzzyRule(1, input1, output1);
  fuzzy->addFuzzyRule(fuzzyRule1);

  FuzzyRuleAntecedent *input2 = new FuzzyRuleAntecedent();
  input2->joinWithAND(GetarRendah, GerakSedang);
  FuzzyRuleConsequent *output2 = new FuzzyRuleConsequent();
  output2->addOutput(siaga);
  FuzzyRule *fuzzyRule2 = new FuzzyRule(2, input2, output2);
  fuzzy->addFuzzyRule(fuzzyRule2);

  FuzzyRuleAntecedent *input3 = new FuzzyRuleAntecedent();
  input3->joinWithAND(GetarRendah, GerakTinggi);
  FuzzyRuleConsequent *output3 = new FuzzyRuleConsequent();
  output3->addOutput(siaga);
  FuzzyRule *fuzzyRule3 = new FuzzyRule(3, input3, output3);
  fuzzy->addFuzzyRule(fuzzyRule3);

  FuzzyRuleAntecedent *input4 = new FuzzyRuleAntecedent();
  input4->joinWithAND(GetarSedang, GerakRendah);
  FuzzyRuleConsequent *output4 = new FuzzyRuleConsequent();
  output4->addOutput(siaga);
  FuzzyRule *fuzzyRule4 = new FuzzyRule(4, input4, output4);
  fuzzy->addFuzzyRule(fuzzyRule4);

  FuzzyRuleAntecedent *input5 = new FuzzyRuleAntecedent();
  input5->joinWithAND(GetarSedang, GerakSedang);
  FuzzyRuleConsequent *output5 = new FuzzyRuleConsequent();
  output5->addOutput(siaga);
  FuzzyRule *fuzzyRule5 = new FuzzyRule(5, input5, output5);
  fuzzy->addFuzzyRule(fuzzyRule5);

  FuzzyRuleAntecedent *input6 = new FuzzyRuleAntecedent();
  input6->joinWithAND(GetarSedang, GerakTinggi);
  FuzzyRuleConsequent *output6 = new FuzzyRuleConsequent();
  output6->addOutput(bahaya);
  FuzzyRule *fuzzyRule6 = new FuzzyRule(6, input6, output6);
  fuzzy->addFuzzyRule(fuzzyRule6);

  FuzzyRuleAntecedent *input7 = new FuzzyRuleAntecedent();
  input7->joinWithAND(GetarTinggi, GerakRendah);
  FuzzyRuleConsequent *output7 = new FuzzyRuleConsequent();
  output7->addOutput(bahaya);
  FuzzyRule *fuzzyRule7 = new FuzzyRule(7, input7, output7);
  fuzzy->addFuzzyRule(fuzzyRule7);

  FuzzyRuleAntecedent *input8 = new FuzzyRuleAntecedent();
  input8->joinWithAND(GetarTinggi, GerakSedang);
  FuzzyRuleConsequent *output8 = new FuzzyRuleConsequent();
  output8->addOutput(bahaya);
  FuzzyRule *fuzzyRule8 = new FuzzyRule(8, input8, output8);
  fuzzy->addFuzzyRule(fuzzyRule8);

  FuzzyRuleAntecedent *input9 = new FuzzyRuleAntecedent();
  input9->joinWithAND(GetarTinggi, GerakTinggi);
  FuzzyRuleConsequent *output9 = new FuzzyRuleConsequent();
  output9->addOutput(bahaya);
  FuzzyRule *fuzzyRule9 = new FuzzyRule(9, input9, output9);
  fuzzy->addFuzzyRule(fuzzyRule9);

}

void loop() {
   mqttClient.loop();  // Keep MQTT connection alive

  int16_t ax, ay, az;
  unsigned long currentTime = millis();
  float deltaTime = (currentTime - previousTime) / 1000.0;
  previousTime = currentTime;

  // Membaca data percepatan dari MPU6050
  mpu.getAcceleration(&ax, &ay, &az);

  // Mengonversi percepatan dari satuan g ke m/s² (1g = 9.8 m/s²)
  float accelX = (ax / 16384.0) * 9.8;
  float accelY = (ay / 16384.0) * 9.8;
  float accelZ = ((az / 16384.0) * 9.8) - 9.8;

  // Menghitung percepatan total
  accelTotal = sqrt((accelX * accelX) + (accelY * accelY) + (accelZ * accelZ));

// Menghitung perubahan percepatan
  deltaAccel = abs(accelTotal - previousAccel);
  previousAccel = accelTotal;



   // Menghitung kecepatan baru: v = v0 + a * t
  velocity = 0 + (accelTotal * deltaTime);

  // Menghitung perubahan jarak baru: s = 1/2 * a * t^2
  float Distance = (accelTotal * deltaTime * deltaTime)/2;

  deltaDistance = abs(Distance - previousDistance);
  previousDistance = Distance;
  


  // Hitung nilai fuzzy untuk getaran dan gerakan
  fuzzy->setInput(1, deltaAccel);
  fuzzy->setInput(2, deltaDistance);
  
  // Jalankan logika fuzzy
  fuzzy->fuzzify();

  // Dapatkan output dari fuzzy
  motorStatus = fuzzy->defuzzify(1);

  float derajatAman = getMembershipAman(motorStatus);
  float derajatSiaga = getMembershipSiaga(motorStatus);
  float derajatBahaya = getMembershipBahaya(motorStatus);


   // Menentukan kategori berdasarkan derajat keanggotaan
    if (derajatAman > derajatSiaga && derajatAman > derajatBahaya) {
        statusMotor = "Aman";

    } else if (derajatSiaga > derajatAman && derajatSiaga > derajatBahaya) {
        statusMotor = "Siaga";

    } else {
      statusMotor = "Bahaya";

    }

    String payload = String(
                        "PerTotal: " + String(accelTotal) + "\n" +
                        "Jarak: " + String(Distance) + "\n" +
                        "Per.Percepatan: " + String(deltaAccel) + "\n" +
                        "Pe.Jarak: " + String(deltaDistance) + "\n" +
                        "Nil.Mamdani: " + String(motorStatus) + "\n" +
                        "Der.Aman: " + String(derajatAman) + "\n" +
                        "Der.Siaga: " + String(derajatSiaga) + "\n" +
                        "Der.Bahaya: " + String(derajatBahaya) + "\n" +
                        "Status: " + String(statusMotor)) ;

    String tes = String(
                        "ax " + String(ax) + "\n" +
                        "ay " + String(ay) + "\n" +
                        "az " + String(az) + "\n" +
                        "accelX " + String(accelX) + "\n" +
                        "accelY " + String(accelY) + "\n" +
                        "accelZ " + String(accelZ) );

    String com = tes + "\n" +payload ;
    
    if (!mqttClient.publish(mqttTopic, com.c_str())) {
          Serial.println("Gagal mempublikasikan pesan");
      } else {
          Serial.println("Pesan berhasil dipublikasikan");
    }

    if (modeAman == 1){
        if (statusMotor == "Siaga" || statusMotor == "Bahaya"){
          mqttClient.publish("vehicle/deteksi/1", statusMotor.c_str());
        }
    }

    
    Serial.print("Mode Aman: ");  Serial.print(modeAman);

    // Jika status motor Bahaya, aktifkan alarm dan catat waktu
  if (statusMotor == "Bahaya" && !alarmActive && modeAman == 1) {
    digitalWrite(alarmPin, HIGH);  // Hidupkan alarm
    alarmStartTime = millis();     // Catat waktu alarm dinyalakan
    alarmActive = true;            // Set alarm aktif
    Serial.println("Alarm dihidupkan!");
  }

  // Jika alarm sudah aktif lebih dari 1 menit, matikan alarm
  if (alarmActive && millis() - alarmStartTime >= 60000 && modeAman == 1) {
    digitalWrite(alarmPin, LOW);   // Matikan alarm
    alarmActive = false;           // Reset status alarm
  }

  

  delay(1000);  // Delay untuk pengambilan data berikutnya
}
