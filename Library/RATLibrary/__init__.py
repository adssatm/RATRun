#!/usr/bin/python
#-*-coding: utf-8 -*-
import os
import sys  
from version import VERSION
from Configuration import *
from ExcelManager import *
from ElementItem import *
from FileManager import *
from StringManager import *
from TestStep import *
from Parameter import *
from Iteration import *
from Logger import *
from AppiumManager import *
from MobileManager import *
from IntegerManager import *
#from OracleManager import *
from Utility import *


class RATLibrary(
    Configuration,
    ExcelManager,
    ElementItem,
    TestStep,
    Parameter,
    Iteration,
    FileManager,
    StringManager,
    Logger,
    AppiumManager,
    MobileManager,
    IntegerManager,
#    OracleManager,
    Utility
):

    reload(sys)  
    sys.setdefaultencoding('cp874')
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
