#ifndef AICLIENT_H
#define AICLIENT_H

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
class AiClient : public QObject {
  Q_OBJECT
 public:
  explicit AiClient(QObject *parent = nullptr);

  Q_INVOKABLE void sendRequest(const QString &prompt);

 signals:
  void receivedDelta(const QString &text);
  void finished();
  void errorOccurred(const QString &error);

 private slots:
  void handleReadyRead();

  void handleFinished();

 private:
  QNetworkAccessManager *manager;
  QNetworkReply *reply = nullptr;
  QByteArray buffer;
};

#endif  // AICLIENT_H
