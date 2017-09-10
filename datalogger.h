#ifndef DATALOGGER_H
#define DATALOGGER_H

#include <QObject>
#include <QFile>

class DataLogger : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool logEnabled READ logEnabled WRITE setLogEnabled NOTIFY logEnabledChanged)
  public:
    explicit DataLogger(QObject *parent = nullptr);
    ~DataLogger();

    bool logEnabled();
    void setLogEnabled(const bool enabled);

    Q_INVOKABLE void log(const QList<QString> logData);

  signals:
    void logEnabledChanged();

  private:
    bool _logEnabled;
    QFile _logFile;

};

#endif // DATALOGGER_H
