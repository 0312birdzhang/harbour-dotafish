#include <QSettings>
#include "settings.h"


SettingsObject::SettingsObject(QObject* parent) {
    settings = new QSettings("harbour-dotafish","harbour-dotafish");
}



void SettingsObject::set_accepted_status(const bool &accepted) {
    settings->setValue(QString("disclaimer/accepted"),QVariant(accepted).toString());
}

bool SettingsObject::get_accepted_status() {
    return settings->value(QString("disclaimer/accepted"),QVariant(false)).toBool();
}

void SettingsObject::set_language(const QString &language) {
    settings->setValue(QString("application/language"),language);
}

QString SettingsObject::get_language() {
    return settings->value(QString("application/language"),QString("C")).toString();
}