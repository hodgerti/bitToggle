import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5 import QtWidgets, QtCore, QtGui
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView, QQuickItem, QQuickWindow
from Serial.Serial import SerialHandle
from BitBlock.BitBlock import BitBlockSender, BitBlockStack, BitBlock
from Resources.UICore import UICore

UI_PATH = "Resources/qml/main.qml"

class AppWindow(QQuickView):
    startAllThreadsSIGNAL = QtCore.pyqtSignal()
    connectSignalsToSlotsSIGNAL = QtCore.pyqtSignal()
    killAllThreadsSIGNAL = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        #starting up QQuickView
        super(AppWindow, self).__init__(parent)
        self.setSource(QUrl(UI_PATH))
        self.show()
        self.root = self.rootObject()
        self.closing.connect(self.closeEvent)

        #threading defines
        self.numThreadsRunning = 0
        self.threads = []

        #objects
        self.bitBlockSender = BitBlockSender(self)
        self.core = UICore(self)

        # bitBlockSender demo


        #adding threads to list
        self.threads.append(self.bitBlockSender)

        #connecting all thread slots
        for thread in self.threads:
            self.connectSignalsToSlotsSIGNAL.connect(thread.connectSignalsToSlotsSLOT)
            self.startAllThreadsSIGNAL.connect(thread.start)

        self.connectSignalsToSlotsSIGNAL.connect(self.core.connectSignalsToSlotsSLOT)

        #starting all threads
        self.startAllThreadsSIGNAL.emit()

        self.connectSignalsToSlotsSIGNAL.emit()

        #ensure all threads closed
        for threads in self.threads:
            if not thread.isRunning():
                self.close()

        print("ALL THREADS STARTED SUCCESFULLY")

    # NOT a true close event, but this way works fine with QQuickView
    def closeEvent(self):
        print("APPLICATION CLOSING...")
        self.killAllThreadsSIGNAL.emit()

        for thread in self.threads:
            thread.wait()

        print("...APPLICATION CLOSED")



# Main Function
if __name__ == "__main__":
    # Create main app
    app = QGuiApplication(sys.argv)
    # Create thing
    engine = AppWindow()

    # Execute the Application and Exit
    app.exec_()
    sys.exit()
