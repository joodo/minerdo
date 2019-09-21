#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>

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

    qmlRegisterSingletonType(QUrl("qrc:/UI.qml"), "ReviewHelper", 1, 0, "UI");
    qmlRegisterSingletonType(QUrl("qrc:/States.qml"), "ReviewHelper", 1, 0, "States");

    engine.load(url);

    return app.exec();
}
