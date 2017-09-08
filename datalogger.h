#ifndef DATALOGGER_H
#define DATALOGGER_H

#include <QObject>

class DataLogger : public QObject
{
    Q_OBJECT
  public:
    explicit DataLogger(QObject *parent = nullptr);

  signals:

  public slots:
    void log();
};

#endif // DATALOGGER_H
