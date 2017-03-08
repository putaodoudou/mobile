# PC/mobile
PC/Mobile robotframework support for iOS and Android testing. Install all below for MacOsX 10.10+

  Download xcode 6.4 in below link and install:
  
    http://adcdownload.apple.com/Developer_Tools/Xcode_6.4/Xcode_6.4.dmg
    
    # copy below to install xcode
    xcode-select --install  
    sudo xcodebuild -license
  
  Download and install appium Version 1.4.8 (Draco):
  
    https://bitbucket.org/appium/appium.app/downloads/appium-1.4.8.dmg
    pip install robotframework-appiumlibrary
    
  Install Android studio and Android simulator:
  
    # copy below to terminal
    sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    sudo brew install Caskroom/cask/android-studio

  Robot Framework installation:
  
    # standard PC support
    easy_install pip
    pip install robotframework-selenium2library
    
    # optional browser support
    pip install chromedriver_installer
    pip install requests
    pip install robotframework-pabot


    # for edge and getting the latest code
    pip install --upgrade git+https://github.com/robotframework/Selenium2Library@master
  
  Mobile support:

    (see https://github.com/kenneyhe/mobile.git)
    1) pip install robotframework-appiumlibrary
    2) download appium and install

    _# iOS_
    3a) download xcode from apps library, xcode->preference->download iOS 8.4
    4a) download and install above and iOS simulator ie: 8.4 from xcode xscreen
    5a) In Appium->iOS settings->advanced setting->click:
        ~/Applications/Xcode application
    6a) chmod -R uog+w /Library/Developer/CoreSimulator
    7a) launch and run RB test files
    8a) cd /Applications/Xcode.app/Contents/Developer/Applications
    9a) if manually starting iOS simulator
        open -n iOS\ Simulator.app


    _# Android_
    3a) download android SDK
    3b) install version matching appium ie: 4.4
    3c) tools->android->AVD Manager (enable ADB), add 4.4 Nexus or other phone
    3d) play the virtual device
    3e) bring up search bar in virtual device
    3f) put in /Users/khe/Library/Android/sdk in Appium's android advance setting
    3g) run RB test files

  Installing IE with grid for development:
  
    1) Download Virtual Machine with latest IE:
    
        https://blogs.msdn.microsoft.com/ie/2013/12/18/ie11-virtual-machines-now-available-on-modern-ie/
        
        https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/
              
    2) Try below to setup Edge Selenium Grid on Windows 10:
    http://www.giuseppecilia.com/2016/04/18/selenium-grid-on-microsoft-edge-browser/

  Cmdlines for iOS:

    pybot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPhone 6" -v pVersion:8.4 -t "Search iOS Browser" bing.txt.robot  
    pabot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPhone 6" -v pVersion:8.4 -t "Search iOS Browser" bing.txt.robot  

    iPad 2:
    pybot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPad 2" -v pVersion:7.1 -t "Search iOS Browser" bing.txt.robot

Troubleshooting:

    Openssl might report:
      output: digital envelope routines:EVP_DecryptFinal_ex:bad decrypt:evp_enc.c:539:
      reason: openssl aes-256-cbc -e -in secrets -out secret-env-cipher -k "publickeystring" will fail when try to decrypt.
              no error given but during decryption it will give error.

    Older MacOS 10.6 can have below error and solution:
      1) TypeError: wait_until_page_contains_element() keywords must be strings
         use Run and igore
      2) TypeError: log_source() keywords must be strings
         remove loglevel=DEBUG
      3) open_browser() keywords must be strings
         remove arguments and install missing firefox if necessary
         
    El Capt 10.11+ can have below error:
      1) restrictive mode in /System/Library/Frameworks/Python.framework/ , user that wants to replace system python library    will need to run virtualenv
    
    Use below to help install patches from github:
      1) http://stackoverflow.com/questions/20101834/pip-install-from-github-repo-branch

Unit test:

      0) Use java7 with older MacOSX by compiling https://blogs.oracle.com/arungupta/entry/build_open_jdk_7_on
      1) launch with waxsim per instruction http://cocoamanifest.net/articles/2011/12/running-your-ios-app-in-the-simulator-from-the-command-line.html
      2) if ipa built for all architecture http://stackoverflow.com/questions/517463/how-can-i-install-a-ipa-file-to-my-iphone-simulator
      3) read https://github.com/sgleadow/xcodetest

Functional test:

      0) Run and pass external tool test for all accounts with iOS, PC and Android
         All tests are available after loading setting.jar (in private image)
             a) Tools->External Tools -> ...


Release Build test:

      0) Upon checkin, check below to make sure no issues in docker hub release tests
         https://hub.docker.com/r/kenney/mobile/builds/
