#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>
#include <QSqlDatabase>
#include <QDir>
#include <QSettings>

#include "entrymodel.h"
#include "itemmodel.h"
#include "notebookmodel.h"
#include "searchengine.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Joodo");
    app.setOrganizationDomain("Joodo.com");
    app.setApplicationName("Minerdo");

    QSettings settings;
    qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME",
            settings.value("interface/theme").toString().toUtf8());

    // sql
    auto database = QSqlDatabase::addDatabase("QSQLITE");
    QString dbname = QDir::home().path() + "/default.db";
    //qDebug() << dbname;
    database.setDatabaseName(dbname);
    database.open();
    //qDebug() << database.tables();

    QQmlApplicationEngine engine;

    qmlRegisterType<EntryModel>("Minerdo", 1, 0, "EntryModel");
    qmlRegisterType<NotebookModel>("Minerdo", 1, 0, "NotebookModel");
    qmlRegisterType<ItemModel>("Minerdo", 1, 0, "ItemModel");
    qmlRegisterSingletonType(QUrl("qrc:/Settings.qml"), "Minerdo", 1, 0, "Settings");
    qmlRegisterSingletonType(QUrl("qrc:/UI.qml"), "Minerdo", 1, 0, "UI");
    qmlRegisterSingletonType(QUrl("qrc:/States.qml"), "Minerdo", 1, 0, "States");
    qmlRegisterSingletonType(QUrl("qrc:/Actions.qml"), "Minerdo", 1, 0, "Actions");

    auto context = engine.rootContext();
    context->setContextProperty("SearchEngine", SearchEngine::instance());

    const QUrl url(QStringLiteral("qrc:/MainWindow.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
