//
//  QrScannerDelegate.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//


protocol QrScannerDelegate : AnyObject {
    func getQrScannedDataDelegate(scannedData: String)
}
