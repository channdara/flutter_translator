## 0.0.12
* update some dependencies use to support the package
## 0.0.11
* add the possibility to do localization with **Map<String, dynamic>** instead of **json file**. Check the **README** or **example** for more information with the **initWithMap()** function
## 0.0.10
* solve the problem where **currentLocale** is null when try to call at the **main.dart** (after **initState()**)
## 0.0.9
* nothing new, just refactor some code and performance
## 0.0.8
* rollback change on *0.0.7* which cause problem to the localization process
## 0.0.7
* add possibility to add more custom delegate at the **init()** function
## 0.0.6
* added get language name feature
* in **init()** function, rename **languageCodes** to **supportedLanguageCodes**
* added **save** parameter in **translate()** function, so you can decide to save the cache or not
## 0.0.5
* fix bug where the initLanguageCode in **init()** function is not working
## 0.0.4
* add language cache (the selected language will save and load when the app is open)
## 0.0.3
* drop down the sdk and flutter version support
## 0.0.2
* provide more documents and code comments
## 0.0.1
* first version of the package