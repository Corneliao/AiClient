#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "aiclient.h"
class StreamRequester : public QObject {};

// 使用示例
int main(int argc, char *argv[]) {
  QGuiApplication a(argc, argv);

  // StreamRequester requester;
  // QObject::connect(&requester, &StreamRequester::receivedDelta, [](const QString &text) {
  //   qDebug() << "Received:" << text;
  //   // 这里可以更新UI显示流式输出
  // });
  // QObject::connect(&requester, &StreamRequester::finished, &a, &QCoreApplication::quit);
  // QObject::connect(&requester, &StreamRequester::errorOccurred, [](const QString &error) {
  //   qDebug() << "Error:" << error;
  //   QCoreApplication::exit(1);
  // });

  // requester.sendRequest("你好，请介绍一下量子计算");

  qmlRegisterType<AiClient>("com.AiClient", 1, 0, "AiClient");
  QQmlApplicationEngine engine;
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &a, [&]() { a.quit(); });
  engine.loadFromModule("AiClient", "Main");

  return a.exec();
}
