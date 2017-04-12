/*  INFO FOR REFERENCE: https://www.cloudcity.io/blog/2015/06/11/zero-to-ble-on-ios-part-one/
 
    Peripheral: Device that has the data (Lawn Mower Microcontroller)
    Central: Device that wants the data contained in the Peripheral (iOS App)
 
    Getting Data:
        Characteristics: Properties of the device that will be read from and written to
        Services: Collection of characteristics
 
    Discovering Connection:
        Central listens for signals the Bluetooth device sends out
        Central can specify which Services it is interested in
 
    Swift's CoreBluetooth
        CBCentralManager: Managers and interacts with Peripherals
        CBPeripheral: An abstraction of the Peripheral that wraps the functionality surrounding the retrieval and updating of data in the remote device
        CBService: Services
        CBCharacteristics: Characteristics
            Must use 16-bit or 128-bit UUID
 
    UUID: Univesally Unique Identifier; A number needed if developing our own Services and Characteristics
        UUIDGEN is a tool that allows us to create a random 128-bit UUID
 
    CODING INFO FOR REFERENCE: https://www.cloudcity.io/blog/2016/09/09/zero-to-ble-on-ios--part-two---swift-edition/
    
        In ViewDidLoad (ViewController):
            centralManager = CBCentralManager(delegate: self, queue: nil)
 
        For Bluetooth:
            
            // Scanning for Peripherals
            func centralManagerDidUpdateState(central: CBCentralManager) {
                switch central.state {
                    case .PoweredOn:
                        keepScanning = true
                        _ = NSTimer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
                        centralManager.scanForPeripheralsWithServices(nil, options: nil)
                    case .PoweredOff:
                        state = "Bluetooth on this device is currently powered off."
                    case .Unsupported:
                        state = "This device does not support Bluetooth Low Energy."
                    case .Unauthorized:
                        state = "This app is not authorized to use Bluetooth Low Energy."
                    case .Resetting:
                        state = "The BLE Manager is resetting; a state update is pending."
                    case .Unknown:
                        state = "The state of the BLE Manager is unknown."
                }
            }
 
            // Connecting to the Peripheral
            func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
                peripheral.discoverServices(nil)
            }
 
            By passing "nil", we are telling it to discover ALL of the Services that the device supports
            Otherwise, we can pass in an array of Service UUID's that the device exposes
 
            ~~~~~~~~~
 
            // Peripheral Services
 
            func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
                // Core Bluetooth creates an array of CBService objects —- one for each Service that is discovered on the peripheral.
                if let services = peripheral.services {
                    for service in services {
                        // Look for specific Service types in this if statement
                        if (service.UUID == CBUUID(string: Device.TemperatureServiceUUID)) || (service.UUID == CBUUID(string: Device.HumidityServiceUUID)) {
                            peripheral.discoverCharacteristics(nil, forService: service)
                        }
                    }
                }
            }
 

 
    UART SERVICE BASE UUID: 6E400001-B5A3-F393-­E0A9-­E50E24DCCA9E
    TX (App -> Bluetooth): 6E400002-B5A3-F393-­E0A9-­E50E24DCCA9E
    RX (Bluetooth -> App): 6E400003-B5A3-F393-­E0A9-­E50E24DCCA9E
 
 */

