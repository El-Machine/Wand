//
//  ContentView.swift
//  Shared
//
//  Created by Alex Kozin on 29.08.2022.
//

import CoreBluetooth
import CoreLocation

import SwiftUI
import Wand

struct ContentView: View {

    var body: some View {

        Text("Hello, Wand |").onAppear {

//            |.one { (l: CLLocation) in
//
//                print(l)
//            } | { (e: Error) in
//                print(e)
//
//            }

//            CLAuthorizationStatus.authorizedWhenInUse | .one { (s: CLAuthorizationStatus) in
//
//                print(s)
//            } | { (e: Error) in
//                print(e)
//
//            }



//            |
//                .retrieve { (peripherals: [CBPeripheral]) in
//                    print()
//                }

//            let uids: [CBUUID] = [.flipperZerof6,
//                                  .flipperZeroWhite,
//                                  .flipperZeroBlack]
//
//            let pipe = Wand()
//            pipe.store(uids)
//
//            pipe | { (peripheral: CBPeripheral) in
//                print(peripheral.name)
//            }


        }

    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

}
