from PyQt5 import QtCore, QtWidgets
from PyQt5.QtCore import QTime
import time
from Serial.Serial import SerialHandle


class BitBlock():
    def __init__(self, p, f, t, O = None):
        if (p == 'alt-flash'):
            self.pattern = ['010101010','101010101']
            self.patternName = 'alt-flash'
        elif (p == 'snake'):
            self.pattern = ['10000000','01000000','00100000','00010000','00001000', '00000100','00000010','00000001']
            self.patternName = 'snake'
        else:
            print("PATTERN NOT FOUND")

        self.freq = f
        self.time = t
        self.order = O

    #set block's number in order
    def setOrder(self, O):
        self.order = O

#sorts bit blocks and puts them in a stack.
#a new one should be generated at each submit
class BitBlockStack():
    def __init__(self):
        self.bitBlockStack = []

    #inserts bitBlock sequentially
    def add(self, bitBlock):
        if (bitBlock.order != None):
            self.bitBlockStack.insert(bitBlock.order, bitBlock)
        else:
            self.bitBlockStack.append(bitBlock)


#Thread that sends bits to serial connection
class BitBlockSender(QtCore.QThread):

    def __init__(self, mainWindow):
        super(BitBlockSender, self).__init__()

        self.mainWindow = mainWindow

        self.serial = SerialHandle("COM3", 9600)

        self.bitBlockStack = BitBlockStack()

        self.timer = QTime()

        #class flags
        self.runFlag = True

    #loops through bitBlock stack
    def run(self):
        self.timer.start()
        while self.runFlag:
            self.timer.restart()
            if (self.bitBlockStack.bitBlockStack != None):
                for bitBlock in self.bitBlockStack.bitBlockStack:
                    while(self.timer.elapsed() < bitBlock.time):
                        for index, item in enumerate(bitBlock.pattern):
                            self.serial.write(bitBlock.pattern[index])
                            self.msleep(bitBlock.freq)
                            print("WRITING 1 BYTE " + bitBlock.patternName)
                    print("SWAPPING BLOCKS")

    def connectSignalsToSlotsSLOT(self):
        self.mainWindow.killAllThreadsSIGNAL.connect(self.killThreadSLOT)

    def killThreadSLOT(self):
        print("STOPPING BITBLOCKSENDER")
        self.runFlag = False


