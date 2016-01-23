# PC/mobile
PC/Mobile robotframework support for iOS and Android testing. Install all below for MacOsX 10.10.4

  Download xcode 6.4 in below link:
    http://adcdownload.apple.com/Developer_Tools/Xcode_6.4/Xcode_6.4.dmg

  Download appium Version 1.4.8 (Draco)
    https://bitbucket.org/appium/appium.app/downloads/appium-1.4.8.dmg

  Robot Framework installation:
    # standard PC support

    easy_install pip
    pip install robotframework-selenium2library
    
    # optional browser support
    pip install chromedriver_installer
    pip install requests
    pip install pabot
    
    # mobile support (see https://github.com/kenneyhe/mobile.git)
    1) pip install robotframework-appiumlibrary
    2) download appium and install
    
    # iOS
    3a) download xcode from apps library, xcode->preference->download iOS 8.4
    4a) download and install above and iOS simulator ie: 8.4 from xcode xscreen
    5a) In Appium->iOS settings->advanced setting->click:
        ~/Applications/Xcode application
    6a) chmod -R uog+w /Library/Developer/CoreSimulator
    7a) launch and run RB test files
    
    # or Android
    3a) download android SDK
    3b) install version matching appium ie: 4.4
    3c) tools->android->AVD Manager (enable ADB), add 4.4 Nexus or other phone
    3d) play the virtual device
    3e) bring up search bar in virtual device
    3f) put in /Users/khe/Library/Android/sdk in Appium's android advance setting
    3g) run RB test files

  Cmdline:
    iPhone:

    pybot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPhone 6" -v pVersion:8.4 -t "Search iOS Browser" bing.txt.robot  
    pabot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPhone 6" -v pVersion:8.4 -t "Search iOS Browser" bing.txt.robot  

    iPad 2:
    pybot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPad 2" -v pVersion:7.1 -t "Search iOS Browser" bing.txt.robot
