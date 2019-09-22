#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>

#include "notebookmanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/MainWindow.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    auto context = engine.rootContext();
    context->setContextProperty("NotebookManager", NotebookManager::instance());

    qmlRegisterSingletonType(QUrl("qrc:/UI.qml"), "ReviewHelper", 1, 0, "UI");
    qmlRegisterSingletonType(QUrl("qrc:/States.qml"), "ReviewHelper", 1, 0, "States");
    qmlRegisterSingletonType(QUrl("qrc:/Actions.qml"), "ReviewHelper", 1, 0, "Actions");

    engine.load(url);

    return app.exec();
}
