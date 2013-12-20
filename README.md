#Localizzle


###Localization directly in Interface Builder

Playing around with method swizzling in Objective-C I created something useful, something I've always needed. Specifying localization keys directly in my XIB.

My first solution was creating new subclasses of UILabel, UITextView etc. But this would force me to update all XIBs and change classes for all views.

Using method swizzling I simply do the localization in -awakeFromNib.

###Usage

Simply add Localizzle.h/m to your project. That's it!

You specify your localization key by adding a "User Defined Runtime Attribute" named localizingKey. See GIF


![alt text](https://raw.github.com/jenshandersson/Localizzle/master/screencast.gif "Screen cast")
