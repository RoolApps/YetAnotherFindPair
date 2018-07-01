#include "gridcontroller.h"

/*ctor*/
GridController::GridController(Item object) : IQmlComponentController(object){

}

/*dtor*/
GridController::~GridController(){
    clear();
}

/*private*/
bool GridController::checkIfSolved(){
    for(int row = 0; row < c_gridArray2d.size(); row++){
        for(int col = 0; col < c_gridArray2d.at(row).size(); col++){
            if (c_gridArray2d.at(row).at(col)->canRotate()) {
                return false;
            }
        }
    }
    return true;
}

void GridController::clear(){
    for(int row = 0; row < c_gridArray2d.size(); row++){
        for(int col = 0; col < c_gridArray2d.at(row).size(); col++){
            CellController * cell = c_gridArray2d.at(row).at(col);
            if(cell->type() != Game::CellType::Transparent) {
                disconnect(cell, SIGNAL(cellClicked(CellController*)), this, SLOT(cellClicked(CellController*)));
                disconnect(cell, SIGNAL(cellRotationStopped(CellController*)), this, SLOT(cellRotationStopped(CellController*)));
            }
        }
    }

    c_hints.clear();

    for(GridArray2d::iterator array = c_gridArray2d.begin(); array != c_gridArray2d.end(); ++array){
        for(GridArray::iterator it = array->begin(); it != array->end(); ++it){
            delete *it; *it = nullptr;
        }
        array->clear();
    }
    c_gridArray2d.clear();

    while(!c_qmlObject->childItems().empty()){
        Item item = c_qmlObject->childItems().takeFirst();
        delete item; item = nullptr;
    }
}

CellController * GridController::createCellController(int size) const{
    Item cell = Game::createQmlObject("CppCell");
    cell->setParent(c_qmlObject);
    cell->setParentItem(c_qmlObject);
    cell->setWidth(size);
    cell->setHeight(size);
    return new CellController(cell);
}

CellController * GridController::atIndex(Index index){
    return c_gridArray2d.at(index.r).at(index.c);
}

int GridController::calculateCellSize() const {
    int rows = read(qmlObject(), "rows").toInt();
    int columns = read(qmlObject(), "columns").toInt();
    int spacing = read(qmlObject(), "spacing").toInt();
    int width = read(qobject_cast<Item>(qmlObject()->parent()), "width").toInt() - (spacing * columns);
    int height = read(qobject_cast<Item>(qmlObject()->parent()), "height").toInt() - (spacing * rows);
    int size = qMin(width / columns, height / rows);
    return size - (size * .2);
}

/*public*/
void GridController::loadLevel(Level &level, bool shuffle){
    clear();

    c_hints = level.hints();
    write(c_qmlObject, "rows", level.rows());
    write(c_qmlObject, "columns", level.columns());
    this->rows = level.rows();
    this->columns = level.columns();
    this->difficulty = level.difficulty();

    if(shuffle) level.shuffle();

    int cellSize = calculateCellSize();

    for(int row = 0; row < level.rows(); row++){
        GridArray gridArray;
        for(int col = 0; col < level.columns(); col++){
            int type = level.hints().at(row * level.columns() + col).toInt();
            CellController *cellController = createCellController(cellSize);
            cellController->setType(static_cast<Game::CellType>(type));
            if (type == Game::CellType::Transparent) {
                cellController->setCanRotate(false);
            }
            else {
                connect(cellController, SIGNAL(cellClicked(CellController*)), this, SLOT(cellClicked(CellController*)));
                connect(cellController, SIGNAL(cellRotationStopped(CellController*)), this, SLOT(cellRotationStopped(CellController*)));
            }
            gridArray.append(cellController);
        }
        c_gridArray2d.append(gridArray);
    }

    levelReady();
}

Index GridController::getIndex(CellController * controller) {
    for(int row = 0; row < c_gridArray2d.size(); row++){
        for(int col = 0; col < c_gridArray2d.at(row).size(); col++){
            CellController * cell = c_gridArray2d.at(row).at(col);
            if(cell == controller) {
                return Index(row, col);
            }
        }
    }
    return Index();
}

/*private slot*/
void GridController::cellClicked(CellController * controller) {

    if (firstCell != NULL && secondCell != NULL) {
        return;
    }

    if (firstCell == controller || secondCell == controller) {
        return;
    }

    if (!controller->canRotate()) {
        return;
    }

    emit makeMoveSound();

    if (firstCell == NULL) {
        firstCell = controller;
    }
    else {
        secondCell = controller;
    }
    controller->rotate();
}

void GridController::cellRotationStopped(CellController * controller) {

    if (firstCell == NULL || secondCell == NULL) {
        return;
    }
    if (secondCell != controller) {
        return;
    }
    if(firstCell->type() == secondCell->type()) {
        firstCell->setCanRotate(false);
        secondCell->setCanRotate(false);
    }
    else {
        firstCell->rotate();
        secondCell->rotate();
    }
    if(checkIfSolved()) {
        firstCell = NULL;
        secondCell = NULL;
        emit solved();
        return;
    }
    moveCells();
}

void GridController::shiftCells(GridArray * cells, int chunkSize) {

    Index * indices = new Index[cells->size()];
    GridArray * newCells = new GridArray();

    int itemsProcessed = 0;
    int chunksProcessed = 0;

    int offset = randomBool() ? 1 : -1;

    for(int cellIndex=0;cellIndex<cells->size();cellIndex++) {
        int sourceCellIndex = cellIndex + offset;
        if (sourceCellIndex == chunksProcessed * chunkSize - 1) {
            sourceCellIndex = (chunksProcessed + 1) * chunkSize - 1;
        }
        if (sourceCellIndex == (chunksProcessed + 1) * chunkSize) {
            sourceCellIndex = chunksProcessed * chunkSize;
        }
        indices[cellIndex] = getIndex(cells->at(sourceCellIndex));
        newCells->append(cells->at(sourceCellIndex));
        itemsProcessed++;
        if(itemsProcessed==chunkSize) {
            chunksProcessed++;
            itemsProcessed=0;
            offset = randomBool() ? 1 : -1;
        }
    }

    GridArray * movedCells = new GridArray();

    for(int cellIndex=0;cellIndex<cells->size();cellIndex++) {
        QMetaObject::Connection * connection = new QMetaObject::Connection();
        *connection = QObject::connect(cells->at(cellIndex), &CellController::cellMovementStopped, [movedCells, cells, newCells, indices, connection, this](CellController * controller) {
            QObject::disconnect(*connection);
            delete connection;
            movedCells->append(controller);
            if(std::equal(cells->begin(), cells->end(), movedCells->begin())) {
                delete indices;
                delete newCells;
                delete cells;
                delete movedCells;
                this->firstCell = NULL;
                this->secondCell = NULL;
            }
        });
        Index index = indices[cellIndex];
        c_gridArray2d[index.r][index.c] = cells->at(cellIndex);
        cells->at(cellIndex)->setPosition(newCells->at(cellIndex)->getPosition());
    }

}

void GridController::moveCells() {

    bool moveRow = randomBool();
    int length = moveRow ? this->columns : this->rows;
    QVector<int> vector = QVector<int>();
    int vectorLength = moveRow ? this->rows : this->columns;
    for(int i=0;i<vectorLength;i++) {
        vector.append(i);
    }
    std::random_shuffle(vector.begin(), vector.end());
    GridArray * cells = new GridArray();

    for(int move=0;move<this->difficulty;move++) {
        for(int cell=0;cell<length;cell++) {
            if(moveRow) {
                cells->append(c_gridArray2d.at(vector.at(move)).at(cell));
            }
            else {
                cells->append(c_gridArray2d.at(cell).at(vector.at(move)));
            }
        }
    }
    shiftCells(cells, length);
}

/*public virtual*/
void GridController::info() const{
    return IQmlComponentController::info();
}
