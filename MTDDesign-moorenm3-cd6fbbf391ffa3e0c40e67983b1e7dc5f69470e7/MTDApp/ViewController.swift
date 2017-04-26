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

struct SampleData {
    var battery1 = arc4random_uniform(100)
    var battery2 = arc4random_uniform(100)
    var motorTemp = arc4random_uniform(999)
    var ctrlTmp = arc4random_uniform(999)
    var hp = arc4random_uniform(999)
    var motorSpeed = arc4random_uniform(999)
    var current = arc4random_uniform(999)
    var savedAmount = arc4random_uniform(999)
}

let sample = MowerDataStruct()

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
    
    @IBOutlet weak var battery1ButtonMain = UIButton()
    @IBOutlet weak var battery2ButtonMain = UIButton()
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
    @IBOutlet weak var saved = UILabel()
    
    func setData() {
        if (sample.battery1 > 67) {
            battery1ButtonMain?.backgroundColor = UIColor.green
        } else if (sample.battery1 > 33) {
            battery1ButtonMain?.backgroundColor = UIColor.yellow
        } else {
            battery1ButtonMain?.backgroundColor = UIColor.red
        }
        if (sample.battery2 > 67) {
            battery2ButtonMain?.backgroundColor = UIColor.green
        } else if (sample.battery2 > 33) {
            battery2ButtonMain?.backgroundColor = UIColor.yellow
        } else {
            battery2ButtonMain?.backgroundColor = UIColor.red
        }
        motorTempMain?.text = String(sample.motorTemp) + " °C"
        ctrlTempMain?.text = String(sample.ctrlTmp) + " °C"
        hpMain?.text = String(sample.hp) + " HP"
        motorSpeedMain?.text = String(sample.motorSpeed) + " MPH"
        currentMain?.text = String(sample.current) + " A"
        saved?.text = "You have saved $" + String(sample.savedAmount) + " now!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        setData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is MotorSpeedViewController) {
            var msvc : MotorSpeedViewController = segue.destination as! MotorSpeedViewController
            msvc.labelText = String(sample.motorSpeed)
        } else if (segue.destination is BatteryOneController) {
            var boc : BatteryOneController = segue.destination as! BatteryOneController
            if (sample.battery1 > 67) {
                boc.color_ = UIColor.green
            } else if (sample.battery1 > 33) {
                boc.color_ = UIColor.yellow
            } else {
                boc.color_ = UIColor.red
            }
        } else if (segue.destination is BatteryTwoController) {
            var btc : BatteryTwoController = segue.destination as! BatteryTwoController
            if (sample.battery2 > 67) {
                btc.color_ = UIColor.green
            } else if (sample.battery2 > 33) {
                btc.color_ = UIColor.yellow
            } else {
                btc.color_ = UIColor.red
            }
        } else if (segue.destination is HorsepowerController) {
            var hpc : HorsepowerController = segue.destination as! HorsepowerController
            hpc.textLabel = String(sample.hp)
        } else if (segue.destination is MotorTempController) {
            var mtc : MotorTempController = segue.destination as! MotorTempController
            mtc.taxLabel = String(sample.motorTemp)
        } else if (segue.destination is CtrlTempController) {
            var ctc : CtrlTempController = segue.destination as! CtrlTempController
            ctc.textField = String(sample.ctrlTmp)
        } else if (segue.destination is CurrentController) {
            var crc : CurrentController = segue.destination as! CurrentController
            crc.textLabel = String(sample.current)
        }
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

