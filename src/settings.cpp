#include <QSettings>
#include "settings.h"


SettingsObject::SettingsObject(QObject* parent) {
    settings = new QSettings("harbour-cantonferry","harbour-cantonferry");
}



void SettingsObject::set_accepted_status(const bool &accepted) {
    settings->setValue(QString("disclaimer/accepted"),QVariant(accepted).toString());
}

bool SettingsObject::get_accepted_status() {
    return settings->value(QString("disclaimer/accepted"),QVariant(false)).toBool();
}