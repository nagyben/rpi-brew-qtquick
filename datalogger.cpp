#include "datalogger.h"
#include <QDate>
#include <QLoggingCategory>
#include <QFile>

DataLogger::DataLogger(QObject *parent) : QObject(parent) {
  _logEnabled = false;
  const QString FILENAME = "brew-" + QDate::currentDate().toString("yyyy-MM-dd") + ".log";
  _logFile.setFileName(FILENAME);
  _logFile.open(QIODevice::WriteOnly | QIODevice::Text);

  qInfo() << "Log file" << FILENAME << "opened";

}

DataLogger::~DataLogger() {
  if (_logFile.isOpen()) {
    _logFile.close();
  }
}

bool DataLogger::logEnabled() {
  return _logEnabled;
}

void DataLogger::setLogEnabled(const bool enabled) {
  qInfo() << "Logging" << (enabled? "enabled" : "disabled");
  _logEnabled = enabled;
}

void DataLogger::log(const QList<QString> logData) {
  //    QLoggingCategory qlc("DataLogger::log()");

  if (_logEnabled && logData.length() > 0) {
    QStringList qsl(logData);
    QTextStream out(&_logFile);
    qInfo() << QDateTime::currentDateTime().toString() << "," << qsl.join(",");
    out << QDateTime::currentDateTime().toString() << "," << qsl.join(",");
  }
}
