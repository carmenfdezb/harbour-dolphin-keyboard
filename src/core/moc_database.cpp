/****************************************************************************
** Meta object code from reading C++ file 'database.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "database.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'database.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Database_t {
    QByteArrayData data[22];
    char stringdata[133];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_Database_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_Database_t qt_meta_stringdata_Database = {
    {
QT_MOC_LITERAL(0, 0, 8),
QT_MOC_LITERAL(1, 9, 6),
QT_MOC_LITERAL(2, 16, 0),
QT_MOC_LITERAL(3, 17, 3),
QT_MOC_LITERAL(4, 21, 7),
QT_MOC_LITERAL(5, 29, 4),
QT_MOC_LITERAL(6, 34, 5),
QT_MOC_LITERAL(7, 40, 6),
QT_MOC_LITERAL(8, 47, 6),
QT_MOC_LITERAL(9, 54, 4),
QT_MOC_LITERAL(10, 59, 5),
QT_MOC_LITERAL(11, 65, 4),
QT_MOC_LITERAL(12, 70, 7),
QT_MOC_LITERAL(13, 78, 4),
QT_MOC_LITERAL(14, 83, 4),
QT_MOC_LITERAL(15, 88, 4),
QT_MOC_LITERAL(16, 93, 4),
QT_MOC_LITERAL(17, 98, 6),
QT_MOC_LITERAL(18, 105, 6),
QT_MOC_LITERAL(19, 112, 5),
QT_MOC_LITERAL(20, 118, 5),
QT_MOC_LITERAL(21, 124, 7)
    },
    "Database\0update\0\0sql\0initial\0name\0"
    "close\0output\0adjust\0word\0debug\0load\0"
    "cangJie\0type\0keys\0size\0wubi\0canton\0"
    "stroke\0swype\0count\0predict\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Database[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    1,   79,    2, 0x0a,
       4,    1,   82,    2, 0x0a,
       6,    0,   85,    2, 0x0a,
       7,    1,   86,    2, 0x0a,
       8,    2,   89,    2, 0x0a,
      10,    1,   94,    2, 0x0a,

 // methods: name, argc, parameters, tag, flags
      11,    1,   97,    2, 0x02,
      12,    3,  100,    2, 0x02,
      16,    3,  107,    2, 0x02,
      17,    2,  114,    2, 0x02,
      18,    2,  119,    2, 0x02,
      19,    3,  124,    2, 0x02,
      21,    2,  131,    2, 0x02,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    5,    9,
    QMetaType::Void, QMetaType::QString,    3,

 // methods: parameters
    QMetaType::QStringList, QMetaType::QString,    3,
    QMetaType::QStringList, QMetaType::Int, QMetaType::QString, QMetaType::QString,   13,   14,   15,
    QMetaType::QStringList, QMetaType::Int, QMetaType::QString, QMetaType::QString,   13,   14,   15,
    QMetaType::QStringList, QMetaType::QString, QMetaType::QString,   14,   15,
    QMetaType::QStringList, QMetaType::QString, QMetaType::QString,   14,   15,
    QMetaType::QStringList, QMetaType::QString, QMetaType::QString, QMetaType::QString,    3,   20,   15,
    QMetaType::QStringList, QMetaType::QString, QMetaType::QString,    3,   15,

       0        // eod
};

void Database::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Database *_t = static_cast<Database *>(_o);
        switch (_id) {
        case 0: _t->update((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->initial((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->close(); break;
        case 3: _t->output((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->adjust((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 5: _t->debug((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: { QStringList _r = _t->load((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 7: { QStringList _r = _t->cangJie((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 8: { QStringList _r = _t->wubi((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 9: { QStringList _r = _t->canton((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 10: { QStringList _r = _t->stroke((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 11: { QStringList _r = _t->swype((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 12: { QStringList _r = _t->predict((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject Database::staticMetaObject = {
    { &QQuickItem::staticMetaObject, qt_meta_stringdata_Database.data,
      qt_meta_data_Database,  qt_static_metacall, 0, 0}
};


const QMetaObject *Database::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Database::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Database.stringdata))
        return static_cast<void*>(const_cast< Database*>(this));
    return QQuickItem::qt_metacast(_clname);
}

int Database::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 13;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
