//
//  ViewController.swift
//  br301
//
//  Created by feedback on 10/3/2563 BE.
//  Copyright © 2563 ENG PSU. All rights reserved.
//

import UIKit

public var readerName: String = ""
public var gContxtHandle: SCARDCONTEXT = 0
let readerInterface = ReaderInterface()

class ViewController: UIViewController, ReaderInterfaceDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readerInterface.setDelegate(self)
        
        let ret = SCardEstablishContext(DWORD(SCARD_SCOPE_SYSTEM), nil, nil, &gContxtHandle)
        var rea: LONG = 0
        
        if ret != SCARD_S_SUCCESS {
            Tools.shareInstance.showError(errorCode: ret)
        } else {
            var readerNameLength: DWORD = 0
            rea = SCardListReaders(gContxtHandle, nil, nil, &readerNameLength)
            let mszReaders = UnsafeMutablePointer<CChar>.allocate(capacity: Int(readerNameLength))
            rea = SCardListReaders(gContxtHandle, nil, mszReaders, &readerNameLength)
            
            var tempIndex: Int = 0
            let tempReaderName = UnsafeMutablePointer<CChar>.allocate(capacity: 30)
            print(tempReaderName)
            let deviceName: String = String(cString: tempReaderName)
            print(readerNameLength)
//            for index in 0..<readerNameLength {
//
//                if mszReaders[Int(index)] != 0 {
//                    tempReaderName[tempIndex] = mszReaders[Int(index)]
//                    tempIndex += 1
//                    continue
//                }
//
//                let deviceName: String = String(cString: tempReaderName)
//                
//                print(deviceName)
//                memset(tempReaderName, 0, tempIndex)
//                tempIndex = 0
//            }
            
            mszReaders.deallocate()
            tempReaderName.deallocate()

        }
    }

}

//MARK:ReaderInterfaceDelegate
extension ViewController {
    
    func findPeripheralReader(_ readerName: String!) {
        
    }
    
    func readerInterfaceDidChange(_ attached: Bool, bluetoothID: String!) {
//        if attached == true {
//            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!reader  did didetach")
//        }
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!reader  did didetach")
    }
    
    func cardInterfaceDidDetach(_ attached: Bool) {
//        print("card did didetach")
    }

    func didGetBattery(_ battery: Int) {
        
    }
    
}

