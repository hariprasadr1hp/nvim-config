// Arduino example to test editor settings

// Constants
const int ledPin = 13;    // Pin number for the built-in LED
const int buttonPin = 7;  // Pin number for a button
const int potPin = A0;    // Analog pin for a potentiometer

// Variables
int buttonState = 0;      // Variable to store the button state
int potValue = 0;         // Variable to store potentiometer value
int ledBrightness = 0;    // Variable to store LED brightness

// Setup function: runs once when the Arduino is powered on or reset
void setup() {
  // Initialize the built-in LED pin as an output
  pinMode(ledPin, OUTPUT);

  // Initialize the button pin as an input
  pinMode(buttonPin, INPUT);

  // Initialize serial communication for debugging
  Serial.begin(9600);
  Serial.println("Arduino is ready!");
}

// Main loop: runs repeatedly after setup
void loop() {
  // Read the state of the button
  buttonState = digitalRead(buttonPin);

  // If the button is pressed, toggle the LED
  if (buttonState == HIGH) {
    digitalWrite(ledPin, HIGH);  // Turn the LED on
    Serial.println("Button pressed: LED ON");
  } else {
    digitalWrite(ledPin, LOW);   // Turn the LED off
    Serial.println("Button not pressed: LED OFF");
  }

  // Read the potentiometer value (0 to 1023)
  potValue = analogRead(potPin);

  // Map the potentiometer value to a brightness level (0 to 255)
  ledBrightness = map(potValue, 0, 1023, 0, 255);

  // Set the brightness of the built-in LED (using PWM)
  analogWrite(ledPin, ledBrightness);

  // Print the potentiometer and LED brightness values to the Serial Monitor
  Serial.print("Potentiometer Value: ");
  Serial.print(potValue);
  Serial.print(" | LED Brightness: ");
  Serial.println(ledBrightness);

  // Delay for a short period
  delay(100);  // 100 milliseconds
}

// Example function to blink the LED a specific number of times
void blinkLED(int numBlinks, int delayTime) {
  for (int i = 0; i < numBlinks; i++) {
    digitalWrite(ledPin, HIGH);  // Turn the LED on
    delay(delayTime);
    digitalWrite(ledPin, LOW);   // Turn the LED off
    delay(delayTime);
  }
}

// Example of interrupt handling (using a button to trigger an interrupt)
void setupInterrupt() {
  attachInterrupt(digitalPinToInterrupt(buttonPin), toggleLED, CHANGE);
}

// Interrupt service routine (ISR) to toggle the LED
void toggleLED() {
  static bool ledState = LOW;
  ledState = !ledState;
  digitalWrite(ledPin, ledState ? HIGH : LOW);
}

// Additional example of a loop with delay
void fadingEffect() {
  for (int brightness = 0; brightness <= 255; brightness++) {
    analogWrite(ledPin, brightness);  // Increase brightness
    delay(10);
  }

  for (int brightness = 255; brightness >= 0; brightness--) {
    analogWrite(ledPin, brightness);  // Decrease brightness
    delay(10);
  }
}
