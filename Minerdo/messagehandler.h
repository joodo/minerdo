#ifndef MESSAGEHANDLER_H
#define MESSAGEHANDLER_H

#include <QObject>

class MessageHandler : public QObject
{
    Q_OBJECT

public:
    MessageHandler();
    static MessageHandler *instance();

signals:
    void log(QtMsgType type, const QString &msg);

    void debugModelChanged(bool debugModel);

private:
    static MessageHandler* m_instance;
};

#endif // MESSAGEHANDLER_H
