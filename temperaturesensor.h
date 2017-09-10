#ifndef TEMPSENSOR_H
#define TEMPSENSOR_H

#include <QObject>

class TemperatureSensor : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString sensorAddress READ sensorAddress WRITE setSensorAddress NOTIFY sensorAddressChanged)
    Q_PROPERTY(float temp READ temp NOTIFY tempChanged)

  public:
    explicit TemperatureSensor(QObject *parent = nullptr);

    QString sensorAddress();
    float temp();
    void setSensorAddress(const QString &sensorAddress);
    Q_INVOKABLE float getTemp();
    Q_INVOKABLE void update();

  signals:
    void sensorAddressChanged();
    void tempChanged();

  private:
    QString _sensorAddress;
    float _temp = 0;

  public slots:

};

#endif // TEMPSENSOR_H
