# genicon: A command line tool for generating icons for macOS/iPhone apps.

This tool wraps imagemagick to provide a convenient utility for generating macOS/iPhone app icons that conform to Apple's standard. You should feed it a large square image (>= 1024x1024), or (preferrably) an svg file, and get all appropriate sizes plus a proper json index in a `AppIcon.appiconset` folder, which can be directly copied into the `Assets.xcassets` folder in your Xcode project. 

# Usage

Type `genicon` or `genicon -h` in terminal:


      $ genicon

       genicon: A command line tool for generating icons for Cocoa apps.
       © Kaiyin Zhong 2016

       Usage:
       genicon [options] INPUT OUTPUT_FOLDER

       --help, -h Print this message.
       --mac Generate icons for macOS.
       --iphone Generate icons for iPhone. When neither --mac nor --iphone is given, mac icons are generated by default.

# Requirements

You need to have imagemagick installed with librsvg enabled, something like:

    brew install --with-librsvg

Only tested on macOS Sierra.

# Installation

Download and unzip the executable from the release page and put it anywhere in your PATH, `/usr/local/bin` for example.
