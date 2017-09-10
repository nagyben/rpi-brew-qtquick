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

  qInfo() << "Setting sensor address to" << _sensorAddress;
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
          return -1;

        } // if (tPos != -1)
      } // if (line.contains("YES"))
      qWarning(qlc) << line;

    } // while(!infile.atEnd())

    // reached end of file without finding "YES" so return -1
    return -1;

  } else {
    qWarning(qlc) << "Could not open file " << filepath;
    return -1;

  } // if (file.open(QIODevice::ReadOnly || QIODevice::Text))
}
