#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "Quick/QuickFramelessWindow.h"
#include "aiclient.h"
static QObject *AiClientProvider(QQmlEngine *engine, QJSEngine *jsEngine) {
  Q_UNUSED(engine);
  Q_UNUSED(jsEngine);

  auto client = new AiClient;
  return client;
}

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

  qmlRegisterType<QuickFramelessWindow>("com.FramelessWindow", 1, 0, "FramelessWindow");
  qmlRegisterSingletonType(QUrl("qrc:/Singleton/GlobalProperties.qml"), "com.Global", 1, 0, "Properties");
  qmlRegisterSingletonType<AiClient>("com.AiClient", 1, 0, "AiClient", AiClientProvider);
  QQmlApplicationEngine engine;
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &a, [&]() { a.quit(); });
  engine.loadFromModule("AiClient", "Main");

  return a.exec();
}
