//
//  ViewController.swift
//  MTDApp
//

import UIKit
import CoreBluetooth

private let uuid: String = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
private let rx = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
private let tx = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
var date1 = NSDate()

class ViewController: UIViewController {
    @IBAction func showAlert(_ sender: AnyObject) {
        let date2 = NSDate().timeIntervalSince(date1 as Date);
        if (date2 > 10) {
            let alertController = UIAlertController(title: "ERROR  CODE 8", message: "Battery Temperature Warning", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "I Understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            date1 = NSDate();
        
        }
    }
    
    @IBOutlet weak var battery1LabelMain = UILabel()
    //@IBOutlet weak var battery1LabelPage = UILabel()
    @IBOutlet weak var battery2LabelMain = UILabel()
    //@IBOutlet weak var battery2LabelPage = UILabel()
    @IBOutlet weak var motorTempMain = UILabel()
    //@IBOutlet weak var motorTempPage = UILabel()
    @IBOutlet weak var ctrlTempMain = UILabel()
    //@IBOutlet weak var ctrlTempPage = UILabel()
    @IBOutlet weak var hpMain = UILabel()
    //@IBOutlet weak var hpPage = UILabel()
    @IBOutlet weak var motorSpeedMain = UILabel()
    //@IBOutlet weak var motorSpeedPage = UILabel()
    @IBOutlet weak var currentMain = UILabel()
    //@IBOutlet weak var currentPage = UILabel()
    
    var manager: CBCentralManager?
    var peripheral: CBPeripheral?
    var write: CBCharacteristic? // {
//        didSet {
//            // Comment this all out when connecting to lawnmower
//            // 6). Called when writing to the device
//            if let write = write {
//                if let test = "00112233445566778899".data(using: .utf8) {
//                    
//                    //"#0,00000,0000,0000,0000,0000,0,000,000,00,00,000,000,000,000,000,000,00000,00000,0000,0,0,00,0000,00000,0\n"
//                    
//                    print("Sending...")
//                    peripheral?.writeValue(test, for: write, type: CBCharacteristicWriteType.withResponse)
//                    //print("Wrote to device\n")
//                }
//            }
//        }
    //}
    
    var read: CBCharacteristic?  {
        didSet {
            // 6). Called when ready to start reading from the device
            if let read = read {
                peripheral?.readValue(for: read)
                //print("Reading...")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        battery1LabelMain?.text = "120 %" // battery1LabelPage?.text
        battery2LabelMain?.text = "32 %" //battery2LabelPage?.text
        ctrlTempMain?.text = "999" //ctrlTempPage?.text
        motorTempMain?.text = "999" //motorTempPage?.text
        currentMain?.text = "999" //currentPage?.text
    }
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("Wrote value???")
    }
    
    // 7). Called when there's new data to be read from the device
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //print("Updated value for UUID: \(characteristic.uuid)\n")
        
        // Throw error if present
        if let error = error {
            print("error: \(error)")
            return
        }
        
        if let data = characteristic.value {
            //print("Data: \(data)")
            if let str = String(data: data, encoding: .utf8) {
                print("Read In: \(str)\n")
                // Place data in struct?
            }
        }
    }
    
    // 4). Called when services are found, after connection
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        //print("Discovered services for: \(String(describing: peripheral.name)) \nServices are: \(String(describing: peripheral.services))\n")
        
        // Throw error if present
        if let error = error {
            print("Discovered Services Error: \(error)")
            return
        }
        
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    // 5). Called when characteristics of specified services are found
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        //print("Discovered characteristics for: \(String(describing: service.characteristics))\n")
        
        // Throw error if present
        if let error = error {
            print("Discovered Characteristics Error: \(error)")
            return
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                //print("\n\(String(describing: characteristic))\n")
                
                if let uuid = UUID(uuidString: tx) {
                    let cb = CBUUID(nsuuid: uuid)
                    if characteristic.uuid == cb {
                        // Write to TX
                        self.write = characteristic
                    } else {
                        // Read from RX continuously
                        peripheral.setNotifyValue(true, for: characteristic)
                        self.read = characteristic
                    }
                }
            }
        }
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    // 1). Gets called when main page loads
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("state changed")
        switch central.state {
        case .poweredOff:
            print("powered off")
        case .poweredOn:
            print("powered on")
            let cbuuid = CBUUID(string: uuid)
            central.scanForPeripherals(withServices: [cbuuid], options: nil)
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unsupported:
            print("unsupported")
        case .unknown:
            print("unknown")
        }
    }
    
    // 3). Called when successfully connected to device
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //print("Connected to \(String(describing: peripheral.name))")
        peripheral.delegate = self
        let cbuuid = CBUUID(string: uuid)
        
        peripheral.discoverServices([cbuuid])
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from: \(String(describing: peripheral.name))")
    }
    
    
    // 2). Called when device to connect to is found
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered: \(String(describing: peripheral.name))")
        self.peripheral = peripheral
        central.connect(peripheral, options: nil)
        central.stopScan()
    }
    
}

