import serial

class SerialHandle():
    def __init__(self, portName, baudRate):
        self.ser = serial.Serial(portName, baudRate)
        if (self.ser.is_open):
            print("OPENED SERIAL " + portName)
        else:
            print("FAILED TO OPEN SERIAL " + portName)

    def write(self, data):
        if (self.ser.is_open):
            self.ser.write(bytes(data, encoding="ascii"))
        else:
            print("NOT OPEN")

    def __del__(self):
        if (self.ser.is_open):
            self.write('0')
            self.ser.close()
        print("CLOSED SERIAL")


