#ifndef CORE_H
#define CORE_H

#include <QQmlExtensionPlugin>

class Core : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // CORE_H
