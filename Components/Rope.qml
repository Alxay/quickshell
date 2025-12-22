// Stolen form https://codeberg.org/zacoons/rivendell-hyprdots/src/branch/master/.config/quickshell/components/Rope.qml
import QtQuick
import QtQuick.Shapes

// Komponent symulujący linę/sznurek między dwoma punktami
// Używa fizyki Verleta do realistycznej animacji
Item {
    id: root

    // Punkty początkowy i końcowy liny (wymagane)
    required property vector2d start
    required property vector2d end

    // Liczba segmentów z których składa się lina
    property double segmentCount: 8
    // Długość pojedynczego segmentu w pikselach
    property double segmentLen: 50

    // Alias umożliwiający zmianę koloru liny z zewnątrz
    property alias color: path.strokeColor

    // Komponent dla pojedynczego punktu liny (PathLine)
    readonly property Component p: PathLine {
        property vector2d pos        // Aktualna pozycja punktu
        property vector2d prevPos: pos  // Poprzednia pozycja (dla Verleta)
        property vector2d acc        // Przyspieszenie (grawitacja)

        x: pos.x
        y: pos.y
    }
    // Siła grawitacji działająca na linę
    readonly property double gravity: 5000
    // Ile razy na klatkę wykonujemy korekcję długości segmentów
    // (więcej = bardziej sztywna lina)
    readonly property int constraintRunCount: 40

    // Shape renderujący linę jako krzywą
    Shape {
        id: shape
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: path
            capStyle: ShapePath.RoundCap
            strokeColor: "#DAC99B"  // Beżowy kolor liny
            strokeWidth: 10          // Grubość liny
            fillColor: "transparent"
        }
    }

    Component.onCompleted: () => {
        // INICJALIZACJA: Tworzymy punkty liny rozłożone równomiernie między start a end
        const xInc = (end.x - start.x) / segmentCount;
        const yInc = (end.y - start.y) / segmentCount;
        let i = 0;
        while (i < segmentCount) {
            // Każdy punkt dostaje pozycję początkową i przyspieszenie (grawitację)
            path.pathElements.push(p.createObject(root, {
                pos: start.plus(Qt.vector2d(xInc * i, yInc * i)),
                acc: Qt.vector2d(0, root.gravity)  // Grawitacja w dół
            }));
            i++;
        }

        // Pierwszy i ostatni punkt są "przypięte" - nie mają grawitacji
        // (dzięki temu lina pozostaje przymocowana do start i end)
        path.pathElements[0].acc.y = 0;
        path.pathElements[segmentCount - 1].acc.y = 0;

        // Ustawiamy punkt startowy ścieżki
        path.startX = path.pathElements[0].x;
        path.startY = path.pathElements[0].y;
    }

    FrameAnimation {
        running: true
        onTriggered: () => {
            const dt = frameTime;

            // KROK 1: FIZYKA VERLETA - aktualizujemy pozycje punktów środkowych
            // Pomijamy pierwszy i ostatni punkt (są przypięte)
            for (const p of path.pathElements.slice(1, root.segmentCount - 2)) {
                // Integracja Verleta: nowa_poz = 2*aktualna - poprzednia + przyspieszenie*dt²
                // https://en.wikipedia.org/wiki/Verlet_integration
                const newPos = p.pos.times(2.0).minus(p.prevPos).plus(p.acc.times(dt * dt));
                p.prevPos = p.pos;
                p.pos = newPos;
            }

            // KROK 2: CONSTRAINTS - korygujemy długości segmentów
            // Upewniamy się, że odległość między sąsiednimi punktami = segmentLen
            for (let i = 0; i < root.segmentCount - 1; i++) {
                const cur = path.pathElements[i];
                const next = path.pathElements[i + 1];

                // Wielokrotnie korygujemy odległość dla większej sztywności
                for (let j = 0; j < root.constraintRunCount; j++) {
                    const toNext = next.pos.minus(cur.pos);  // Wektor do następnego punktu
                    const distToNext = toNext.length();      // Obecna odległość
                    const error = root.segmentLen - distToNext;  // O ile za krótki/długi
                    // Siła korekcyjna - ciągnie punkty by przywrócić właściwą długość
                    const pull = toNext.times(1.0 / distToNext).times(error).times(0.1);
                    if (i != 0) {
                        // Punkty środkowe: oба punkty się przesuwają (po 50%)
                        cur.pos = cur.pos.minus(pull.times(0.5));
                        next.pos = next.pos.plus(pull.times(0.5));
                    } else {
                        // Pierwszy punkt jest przypięty, więc tylko drugi się przesuwa
                        next.pos = next.pos.plus(pull);
                    }
                }
            }

            // KROK 3: Przypiąć z powrotem końce liny do zadanych punktów
            // (mogły się nieznacznie przesunąć podczas constraints)
            path.pathElements[0].pos = root.start;
            path.pathElements[root.segmentCount - 1].pos = root.end;

            // Aktualizuj punkt startowy ścieżki dla renderera
            path.startX = path.pathElements[0].x;
            path.startY = path.pathElements[0].y;
        }
    }
}
