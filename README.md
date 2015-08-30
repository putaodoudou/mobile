# PC/mobile
PC/Mobile robotframework support for iOS and Android testing

Robot Framework installation:
   # standard PC support
   easy_install pip
   pip install robotframework-selenium2library
   
   # optional browser support
   pip install chromedriver_installer
   pip install requests
   
   # mobile support (see https://github.com/kenneyhe/mobile.git)
   1) pip install robotframework-appiumlibrary
   2) download appium and install
   3) download xcode from apps library
   4) download and install above and iOS simulator ie: 8.4 from xcode xscreen
   5) In Appium->iOS settings->advanced setting->click:
        ~/Applications/Xcode application
   6) chmod -R uog+w /Library/Developer/CoreSimulator
   7) launch and run RB test files
   
   