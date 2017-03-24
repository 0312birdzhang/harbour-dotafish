# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-dotafish

CONFIG += sailfishapp

SOURCES += src/harbour-dotafish.cpp \
    src/settings.cpp

OTHER_FILES += qml/harbour-dotafish.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-dotafish.changes.in \
    rpm/harbour-dotafish.spec \
    rpm/harbour-dotafish.yaml \
    translations/*.ts \
    harbour-dotafish.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-dotafish-de.ts \
                translations/harbour-dotafish-zh_CN.ts

DISTFILES += \
    qml/pages/API.js \
    qml/pages/quiz.js \
    qml/pages/HeroDetail.qml \
    qml/pages/Signalcenter.qml \
    qml/components/Panel.qml \
    qml/components/PanelView.qml \
    qml/pages/NavigationPanel.qml \
    qml/components/HorizontalIconTextButton.qml \
    qml/pages/SettingPage.qml \
    qml/components/LabelText.qml \
    qml/components/ImagePage.qml \
    qml/pages/HeroesPage.qml \
    qml/components/HeroAttribs.qml \
    qml/components/HeroAbilities.qml \
    qml/pages/ItemsPage.qml \
    qml/pages/DisclaimerDialog.qml \
    qml/pages/ItemDetail.qml \
    qml/pages/QuizPage.qml

HEADERS += \
    src/settings.h

zh.path = /usr/share/$${TARGET}/translations
zh.files += $$PWD/translations/harbour-dotafish-zh_CN.qm
INSTALLS += zh
