# PC/mobile
PC/Mobile robotframework support for iOS and Android testing. Install all below for MacOsX 10.10+
On El Capitan, Apple decided to add restrictive mode so virtual environment instruction has been
added so python can be run independently for installation and execution.

  Download xcode 6.4 in below link and install:
  
    http://adcdownload.apple.com/Developer_Tools/Xcode_6.4/Xcode_6.4.dmg
    
    # copy below to install xcode
    xcode-select --install  
    sudo xcodebuild -license
  
  Download and install appium Version 1.4.8 (Draco):
  
    https://bitbucket.org/appium/appium.app/downloads/appium-1.4.8.dmg
    
  Install brew, Android studio and Android simulator:
  
    # copy below to terminal
    sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    sudo brew install Caskroom/cask/android-studio

  Install python virtualenv:

    # install after virtualenv by follow below
    http://docs.python-guide.org/en/latest/dev/virtualenvs/

    sudo brew install virtualenv
    virtualenv -p /usr/bin/python2.7 venv
    source venv/bin/activate

  Robot Framework installation:
  
    # standard PC support
    easy_install pip
    pip install robotframework-selenium2library
    pip install robotframework-appiumlibrary
    
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

    virtualenv:
    venv/bin/pybot -v BROWSER:firefox -v login:<secret> -v DC:"browserName:firefox,version:41" -v password:<secret> -v device:"iPad 2" -v pVersion:7.1 -t "Search iOS Browser" bing.txt.robot

Troubleshooting:

    Older MacOS 10.6 can have below error and solution:
      1) TypeError: wait_until_page_contains_element() keywords must be strings
         use Run and igore
      2) TypeError: log_source() keywords must be strings
         remove loglevel=DEBUG
      3) open_browser() keywords must be strings
         remove arguments and install missing firefox if necessary
    El Capt 10.11 can have issue with installation:
      1) OSError: [Errno 13] Permission denied: '/Library/Python/2.7/site-packages/Selenium2Library/__init__.py'
         or Flag
         OSError: [Errno 1] Operation not permitted: '/tmp/pip-6a0Y7c-uninstall/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/six-1.4.1-py2.7.egg-info'
         are due to restricted mode in /System/Libary/.../python.  Best thing to do is use virtualenv
