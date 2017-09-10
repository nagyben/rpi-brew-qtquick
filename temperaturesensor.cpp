#include "temperaturesensor.h"
#include <QtCore>

TemperatureSensor::TemperatureSensor(QObject *parent) : QObject(parent) {
}

QString TemperatureSensor::sensorAddress() {
  return _sensorAddress;
}

float TemperatureSensor::temp() {
  return _temp;
}

void TemperatureSensor::setSensorAddress(const QString &sensorAddress) {
  if (_sensorAddress == sensorAddress)
    return;

  qInfo() << "Setting sensor address to" << sensorAddress;
  _sensorAddress = sensorAddress;
  emit sensorAddressChanged();
}

void TemperatureSensor::update() {
  float newTemp = getTemp();
  if (_temp != newTemp) {
    _temp = newTemp;
    emit tempChanged();
  }
}

float TemperatureSensor::getTemp() {
  QLoggingCategory qlc("tempsensor::getTemp()");
  const QString filepath = "/sys/bus/w1/devices/28-00000" + _sensorAddress + "/w1_slave";
  QFile file(filepath);

  if (file.exists()) {
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
      QTextStream infile(&file);

      while(!infile.atEnd()) {
        QString line = infile.readLine();

        if (line.contains("YES")) {
          line = infile.readLine();

          int tPos = line.lastIndexOf("=");
          if (tPos != -1) {
            return line.right(line.length() - tPos).toFloat();

          } else {
            qWarning(qlc) << "Could not find equals sign in file " << filepath;

          } // if (tPos != -1)
        } // if (line.contains("YES"))
        qWarning(qlc) << line;

      } // while(!infile.atEnd())

    } else {
      qWarning(qlc) << "Could not open file " << filepath;
    } // if (file.open(QIODevice::ReadOnly || QIODevice::Text))

  } else {
    qInfo(qlc) << "File" << filepath << "does not exist";
  } // if (file.exists())

  // if we have reached here, then all the checks have failed and we return -1
  return -1;
}
