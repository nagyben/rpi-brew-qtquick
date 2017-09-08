#ifndef TEMPSENSOR_H
#define TEMPSENSOR_H

#include <QObject>

class TemperatureSensor : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString sensorAddress READ sensorAddress WRITE setSensorAddress NOTIFY sensorAddressChanged)

  public:
    explicit TemperatureSensor(QObject *parent = nullptr);

    QString sensorAddress();
    void setSensorAddress(const QString &sensorAddress);
    float getTemp();

  signals:
    void sensorAddressChanged();

  private:
    QString _sensorAddress;

  public slots:

};

#endif // TEMPSENSOR_H
