#include "core.h"
#include "database.h"
#include "settings.h"
#include <qqml.h>

void Core::registerTypes(const char *uri)
{
    // @uri harbour.dolphin.core
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");
    qmlRegisterType<Database>(uri, 1, 0, "Database");
}