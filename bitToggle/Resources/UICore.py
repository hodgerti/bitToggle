import PyQt5.QtCore
class UICore():
    def __init__(self, mainWindow):
        self.root = mainWindow.rootObject()
        self.mainwindow = mainWindow

    def connectSignalsToSlotsSLOT(self):
        print("Created")
        self.root.blockDescription.connect(self.addBitBlock)

    def addBitBlock(self, pattern, freq, time):
        self.mainwindow.bitBlockSender.add(pattern, freq, time)
