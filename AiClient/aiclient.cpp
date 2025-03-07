#include "aiclient.h"

AiClient::AiClient(QObject *parent) : QObject(parent) { manager = new QNetworkAccessManager(this); }

void AiClient::sendRequest(const QString &prompt) {
  QUrl apiUrl("https://api.deepseek.com/v1/chat/completions");  // 替换为实际API地址
  QNetworkRequest request(apiUrl);

  // 设置请求头
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setRawHeader("Authorization", "Bearer sk-ea65ae999f13482089ce89d8bc3ca558");  // 替换为实际API密钥

  // 构造请求体
  QJsonObject body;
  body["model"] = this->m_model;  // 根据实际情况修改
  body["stream"] = true;

  QJsonArray messages;
  QJsonObject message;
  message["role"] = "user";
  message["content"] = prompt;
  messages.append(message);
  body["messages"] = messages;

  QJsonDocument doc(body);
  QByteArray data = doc.toJson();

  // 发送POST请求
  reply = manager->post(request, data);

  // 连接信号
  connect(reply, &QNetworkReply::readyRead, this, &AiClient::handleReadyRead);
  connect(reply, &QNetworkReply::finished, this, &AiClient::handleFinished);
  connect(reply, &QIODevice::readyRead, this, &AiClient::handleReadyRead);
}

void AiClient::setModel(const QString &model) { this->m_model = model; }

void AiClient::handleReadyRead() {
  while (reply->bytesAvailable()) {
    buffer += reply->readAll();

    // SSE格式解析（数据以"data: "开头，结尾为\n\n）
    while (true) {
      int endIndex = buffer.indexOf("\n\n");
      if (endIndex == -1) break;

      QString event = buffer.left(endIndex);
      buffer = buffer.mid(endIndex + 2);

      if (event.startsWith("data: ")) {
        QString jsonStr = event.mid(6).trimmed();
        if (jsonStr == "[DONE]") break;

        QJsonParseError parseError;
        QJsonDocument doc = QJsonDocument::fromJson(jsonStr.toUtf8(), &parseError);

        if (parseError.error != QJsonParseError::NoError) {
          emit errorOccurred("JSON解析错误: " + parseError.errorString());
          continue;
        }

        QJsonObject json = doc.object();
        if (json.contains("choices")) {
          QJsonObject choice = json["choices"].toArray().first().toObject();
          if (choice.contains("delta")) {
            QJsonObject delta = choice["delta"].toObject();
            if (delta.contains("content")) {
              QString content = delta["content"].toString();
              emit receivedDelta(content);
            }
          }
        }
      }
    }
  }
}

void AiClient::handleFinished() {
  if (reply->error() != QNetworkReply::NoError) {
    emit errorOccurred(reply->errorString());

  } else {
    emit finished();
  }
  reply->deleteLater();
}
