import sys


from PyQt5.QtCore import QUrl, QObject
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView, QQuickItem
from Serial.Serial import SerialHandle

class AppWindow(QQuickView):



    def __init__(self, source, parent=None):
        super(QQuickView, self).__init__(parent)
        self.setSource(QUrl(source))

        self.serial = SerialHandle('COM3', 9600)
        self.ledState = True

        view = self.rootObject()

        #signal bank
        view.write.connect(lambda: self.UIClicked())

    def UIClicked(self):
        print("Writing")
        if (self.ledState):
            self.ledState = False
            self.serial.write('1')
        else:
            self.ledState = True
            self.serial.write('0')

    def __del__(self):
        self.serial.write('0')


# Main Function
if __name__ == "__main__":
    # Create main app
    app = QApplication(sys.argv)
    # Create a label and set its properties
    appLabel = AppWindow('main.qml')

    appLabel.show()

    # Execute the Application and Exit
    app.exec_()
    sys.exit()
