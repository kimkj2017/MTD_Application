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
        if (date2 > 10){
            let alertController = UIAlertController(title: "ERROR  CODE 8", message: "Battery Temperature Warning", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "I Understand", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            date1 = NSDate();
        }
    }
    
    
    var manager: CBCentralManager?
    var peripheral: CBPeripheral?
    var write: CBCharacteristic? {
        didSet {
            if let write = write {
                if let test = "#0,00000,0000,0000,0000,0000,0,000,000,00,00,000,000,000,000,000,000,00000,00000,0000,0,0,00,0000,00000,0\n".data(using: .utf8) {
                    
                    if let read = read {
                        peripheral?.readValue(for: read)
                    }
                    
                    print("Sending: \(test.count)")
                    peripheral?.writeValue(test, for: write, type: CBCharacteristicWriteType.withResponse)
                    print("Wrote to device")
                    
                    
                }
            }
        }
    }
    var read: CBCharacteristic?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        motorTempMain?.text = String(arc4random_uniform(999))
        ctrlTempMain?.text = String(arc4random_uniform(999))
        hpMain?.text = String(arc4random_uniform(999))
        motorSpeedMain?.text = String(arc4random_uniform(999))
        currentMain?.text = String(arc4random_uniform(999))
    }
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("Wrote value")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Updated value for: \(characteristic)")
        if let data = characteristic.value {
            print("Data: \(data)")
            if let str = String(data: data, encoding: .utf8) {
                print(str)
                // Place data in struct?
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Discovered services for: \(peripheral.name) - \(peripheral.services)")
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if let uuid = UUID(uuidString: tx) {
                    let cb = CBUUID(nsuuid: uuid)
                    if characteristic.uuid == cb {
                        self.write = characteristic
                    } else {
                        self.read = characteristic
                    }
                }
            }
        }
    }
}

extension ViewController: CBCentralManagerDelegate {
    
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
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name)")
        peripheral.delegate = self
        let cbuuid = CBUUID(string: uuid)
        
        //peripheral.writeValue(<#T##data: Data##Data#>, for: <#T##CBCharacteristic#>, type: <#T##CBCharacteristicWriteType#>)
        peripheral.discoverServices([cbuuid])
        //peripheral.discoverServices(nil)
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered: \(peripheral.name)")
        self.peripheral = peripheral
        central.connect(peripheral, options: nil)
        //central.stopScan()
    }
    
}

