#include "messagehandler.h"

MessageHandler* MessageHandler::m_instance = nullptr;

QtMessageHandler qtMessageHandler;

void messageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    qtMessageHandler(type, context, msg);
    MessageHandler::instance()->log(type, msg);
}

MessageHandler::MessageHandler()
{
    qtMessageHandler = qInstallMessageHandler(messageOutput);
    qRegisterMetaType<QtMsgType>("QtMsgType");
}

MessageHandler *MessageHandler::instance()
{
    if (m_instance == nullptr) {
        m_instance = new MessageHandler();
    }
    return m_instance;
}
