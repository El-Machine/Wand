
## ![Wand 🪄](https://github.com/El-Machine/Wand/raw/main/App/Assets.xcassets/AppIcon.appiconset/magic-wand-transformed-20.png) API for Any (thing) |
**📦 An ideal API acts as the black box**  
**⚡️ It’s possible to incapsulate whole data receiving and memory managment to one symbol**  
<font size=222>?</font>   
[Medium.com](https://medium.com/@al.kozin/universal-api-7ddc67bb0aa5)
[Habr.com](https://habr.com/ru/post/674010/)
  

>In Unix-like computer operating systems, a [pipeline](https://en.wikipedia.org/wiki/Pipeline_(Unix)) is a mechanism for inter-process communication using message passing. A pipeline is a set of processes chained together by their standard streams, so that the output text of each process (stdout) is passed directly as input (stdin) to the next one. The second process is started as the first process is still executing, and they are executed concurrently.
  

### 💬 bash
```bash
command1 | command2 | command3

ls -l | grep key | less
```

### 🕊️ swift
```bash
#Create handler  
{ (bar: Bar) in

}

```

```bash
#Black box
prefix func | (handler: @escaping (Bar)->() )

#Call API
| { (bar: Bar) in

}

```

```bash
#Retreive data (profit)
handler(bar)

``` 

### ⚙️ usage

```bash

#Request current Location
|{ (location: CLLocation) in 

}

#Request .authorizedAlways permissions once
CLAuthorizationStatus.authorizedAlways | .one { status in
            
}

#Update Pedometer Data
|{ (data: CMPedometerData) in 

}

#Scan for Bluetooth Peripheral
|{ (peripheral: CBPeripheral) in 

}

#Wait for a Notification
UIWindow.keyboardWillShowNotification | { (n: Notification) in
            
}

#Enumerate Contacts
CNContact.predicateForContacts(matchingName: "John Appleseed") | .every { (contact: CNContact) in
                        
}

#Scan a tag
| .every { (tag: NFCNDEFTag) in

}

#Perform Face Observation
URL(string: "http://example.com/image.jpg") | { (faces: [VNFaceObservation]) in

}

#Perform Pose Observation
data | .while { (bodies: [VNHumanBodyPoseObservation]) in
    bodies < 2
}

#Detect shake
|{ (motion: UIEvent.EventSubtype) in
    if motion == .motionShake {
                
    }
}

```

```bash
#Customization
let wand = |{ (hands: [VNHumanHandPoseObservation]) in

}

let request: VNDetectHumanHandPoseRequest = wand.obtain()
request.maximumHandCount = 4

let preview: AVCaptureVideoPreviewLayer = wand.obtain()
view.layer.addSublayer(preview!)

```
### 💡 Idea
  Imagine that you have black box that can give you any object   
  You don't know what is already in box or what will happen inside    
  Simply ask for objects that you need

### 🪄 Сoncept

Wand started from idea about receiving anything in most efficient and fast way   
Just add one sign to completion handler and retreive the result 📦  

💳 [Feel free to contribute. You are welcome |](https://github.com/El-Machine/Wand/graphs/contributors)

## [🤝 Credits](https://github.com/El-Machine/Wand/blob/main/CONTRIB.TXT)

- 💻  El Machine
    Alex Kozin

- 🔔  The concept of pipelines was championed by Douglas McIlroy at Unix's ancestral home of
    Bell Labs
    https://wikipedia.org/wiki/Pipeline_(Unix)

- |   Wand icon
    Freepik - Flaticon
    https://flaticon.com/free-icons/wand

- 🤖  Upscaled by AI
    https://google.com/?q=ai+upscale+image

- 👨‍🎓  BSD
    https://wikipedia.org/wiki/BSD

- 🪟  Windows Production
    Stan Barnes William and Lynne Jolitz

- 💿  CD Production
    Sony Digital Audio Disk Corporation ソニー・グループ株式会社

- 📱  iPod
    Tony Fadell

- 🍏  Apple
    Steven Paul Jobs

- ⚡️  Macromedia® Flash
    600 Townsend Street, San Francisco, CA 94103 1997

- 🐢  Logo
    Bolt, Beranek and Newman 1967

- 



## Tasks

- [x] Contacts
- [x] CoreLocation
- [x] CoreMotion
- [x] NSNotification
- [ ] CoreNFC
- [ ] Vision
- [ ] Rest
- [ ] MultipeerConnectivity

[Alex Kozin](mailto:al@el-machine.com)  
[El Machine 🤖](https://el-machine.com)  
Mobile Apps since 2008