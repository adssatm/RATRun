#!/usr/bin/python
#-*-coding: utf-8 -*-
import os
from Configuration import Configuration as Config


class AppiumManager:

    def __init__(self):
        self.configpath = Config.get_config_path()

    def start_appium_server_default(self):
    	print self.configpath
        command = "start /wait CMD /C wscript.exe " + self.configpath + "\\StartAppiumServerDefault.vbs"
        print "send scprit command := " + command
        os.system(command)

    def start_appium_server_multidevice(self, port1, port2, device1, device2):
        print self.configpath
        print "port1 := " + port1 + " port2 := " + port2 + " device1 := " + device1 + " device2 := " + device2
        command = "start /wait CMD /C wscript.exe " + self.configpath + "\\StartAppiumServerMultiDevice.vbs " + chr(34) + str(port1) + chr(34) + " " + chr(34) + str(port2) + chr(34) + " " + chr(34) + str(device1) + chr(34) + " " + chr(34) + str(device2) + chr(34)
        print "send scprit command := " + command
        os.system(command)

    def stop_appium_server(self):
    	print self.configpath
        command = "start /wait CMD /C wscript.exe " + self.configpath + "\\StopAppiumServer.vbs"
        print "send scprit command := " + command
        os.system(command)
