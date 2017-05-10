from PyQt5 import QtCore, QtWidgets
from PyQt5.QtCore import QTime
import time
from Serial.Serial import SerialHandle


class BitBlock():
    def __init__(self, p, f, t, O = None):
        if (p == 'alt-flash'):
            self.pattern = ['010101010','101010101']
            self.patternName = 'alt-flash'
            self.bytesToWrite = 2
        elif (p == 'snake'):
            self.pattern = ['10000000','01000000','00100000','00010000','00001000', '00000100','00000010','00000001']
            self.patternName = 'snake'
            self.bytesToWrite = 8
        elif (p == 'on-off'):
            self.pattern = ['11111111', '00000000']
            self.patternName = 'on-off'
            self.bytesToWrite = 2
        else:
            print("PATTERN NOT FOUND")

        self.freq = f # in hertz Hz
        self.time = t # in milliseconds ms
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

        self.bigTime = QTime()

        #class flags
        self.runFlag = True

    #loops through bitBlock stack
    def run(self):
        self.bigTime.start()
        while self.runFlag:
            self.bigTime.restart()
            if (self.bitBlockStack.bitBlockStack != None):
                for bitBlock in self.bitBlockStack.bitBlockStack:
                    if not self.runFlag:
                        break
                    while(self.bigTime.elapsed() < bitBlock.time):
                        if not self.runFlag:
                            break
                        for index, item in enumerate(bitBlock.pattern):
                            if not self.runFlag:
                                break
                            self.serial.write(bitBlock.pattern[index])
                            #scales based upon number of bytes to write
                            self.msleep(1000/(bitBlock.freq * bitBlock.bytesToWrite))
            if not self.runFlag:
                break
        self.serial.write('00000000')

    def add(self, pattern, freq, time, order = None):
        self.bitBlockStack.add(BitBlock(pattern, freq, time, order))

    def connectSignalsToSlotsSLOT(self):
        self.mainWindow.killAllThreadsSIGNAL.connect(self.killThreadSLOT)

    def killThreadSLOT(self):
        print("STOPPING BITBLOCKSENDER")
        self.runFlag = False


