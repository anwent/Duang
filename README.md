<center><h1>Duang</h1></center>

###Customizable Pagemenu In Swift. 


## Sample   
- **create**  

```swift
    let menu: Duang = {
        let menu = Duang(
            frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 100),
            subControllers: [AVC.self, BVC.self, CVC.self],
            dataSource: self,
            delegate: self,
            controlBarHeight: 54,
            loadAllCtl: false,
            style: .full)
        menu.controlSpacing = 10.0
        menu.segmentHeight = 5.0
        return menu
    }()
```  
- **dataSource:**  `DuangDataSource`  

```swift  
// Return to the view on the control bar
func duangControlBar(itemForIndex index: Int) -> UIView 
```
- **delegate:**  `DuangDelegate`  

```swift   
// Invoke this method when initializing a controller
func duang(initialized ctl: UIViewController)

func duang(current ctl: UIViewController, page: Int)

func duang(current item: UIView)

func duang(didSelectControlBarAt index: Int) 
 
```  

## Installation  

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):  

``` ruby
pod 'Duang'
```

## License

**Duang** is under MIT license. See the [LICENSE](LICENSE) file for more info.
