#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QStringList>
#include <QVariantList>
#include <QMap>

class Database : public QQuickItem
{

    Q_OBJECT

    public slots:
        void update(QString sql);
        void initial(QString name);
        void close(QString name);
        void output(QString sql);
        void adjust(QString name, QString word);
        void debug(QString sql);
        void index(QString name);

    public:
        QString name;
        Q_INVOKABLE QStringList load(QString sql);
        Q_INVOKABLE QStringList cangJie(int type, QString keys, QString size);
        Q_INVOKABLE QStringList wubi(int type, QString keys, QString size);
        Q_INVOKABLE QStringList canton(QString keys, QString size);
        Q_INVOKABLE QStringList stroke(QString keys, QString size);
        Q_INVOKABLE QStringList swype(QString sql, QString count, QString size);
        Q_INVOKABLE QStringList predict(QString sql, QString size);
        //Q_INVOKABLE bool adjust(QString name, QString word);
        Database(QQuickItem *parent = 0);
        QSqlDatabase database;

};


#endif // DATABASE_H
