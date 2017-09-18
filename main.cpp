#include <QApplication>
#include <QQmlApplicationEngine>
#include <QSettings>

#include "temperaturesensor.h"
#include "datalogger.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    qmlRegisterType<TemperatureSensor>("tempsensor", 1, 0, "TempSensor");
    qmlRegisterType<DataLogger>("datalogger", 1, 0, "DataLogger");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

//    QPushButton *button = engine->findChild<QPushButton *>("button1");

    return app.exec();
}
