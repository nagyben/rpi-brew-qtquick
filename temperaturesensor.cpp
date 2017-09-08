#include "temperaturesensor.h"

TemperatureSensor::TemperatureSensor(QObject *parent) : QObject(parent) {
}

QString TemperatureSensor::sensorAddress() {
  return _sensorAddress;
}

void TemperatureSensor::setSensorAddress(const QString &sensorAddress) {
  if (_sensorAddress == sensorAddress)
    return;

  _sensorAddress = sensorAddress;
  emit sensorAddressChanged();
}

float TemperatureSensor::getTemp() {
  QLoggingCategory qlc("tempsensor::getTemp()");
  const QString filepath = "/sys/bus/w1/devices/28-00000" + _sensorAddress + "/w1_slave";
  QFile file(filepath);

  if (file.open(QIODevice::ReadOnly || QIODevice::Text)) {
    QTextStream infile(&file);

    while(!infile.atEnd()) {
      QString line = in.readLine();

      if (line.contains("YES")) {
        line = in.readLine();

        int tPos = line.lastIndexOf("=");
        if (tPos != -1) {
          return line.right(line.length() - tPos).toFloat();

        } else {
          qWarning(qlc) << "Could not find equals sign in file " << filepath;
          return -1;

        } // if (tPos != -1)
      } // if (line.contains("YES"))
    } // while(!infile.atEnd())

  } else {
    qWarning(qlc) << "Could not open file " << filepath;
    return -1;

  } // if (file.open(QIODevice::ReadOnly || QIODevice::Text))
}
