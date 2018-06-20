#include "iqmlcomponentcontroller.h"

/*ctor*/
IQmlComponentController::IQmlComponentController(Item object) : c_qmlObject(object){
}

/*public*/
Item IQmlComponentController::qmlObject() const{
    return c_qmlObject;
}

void IQmlComponentController::setQmlObject(Item object){
    if(c_qmlObject != object){
        c_qmlObject = object;
    }
}

QVariant IQmlComponentController::read(Item item, QString property) const{
    return QQmlProperty::read(item, property);
}

void IQmlComponentController::write(Item item, QString property, QVariant value){
    QQmlProperty::write(item, property, value);
}

/*public virtual*/
void IQmlComponentController::info() const{
    dbg << "INFO:" << c_qmlObject;
    dbg << "Parent INFO" << c_qmlObject->parent();
    dbg << "ParentItem INFO" << c_qmlObject->parentItem();
    dbg << "Childrens count: " << c_qmlObject->children().length() << "childItems count:" << c_qmlObject->childItems().size();
    dbg << "Childrens: " << c_qmlObject->children();
    dbg << "ChildItems: " << c_qmlObject->childItems();
    dbg << " --------------------- ";
}
