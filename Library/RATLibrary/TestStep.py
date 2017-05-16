#!/usr/bin/python
#-*-coding: utf-8 -*-
import operator
from Configuration import Configuration as Config
from ExcelManager import ExcelManager as Excel


class TestStep:

    def __init__(self):
        self.currentpath = Config.get_current_path()
        self.configfile = Config.get_config_file()
        self.testkey = None
        self.testapp = None
        self.testmachine = None
        self.testaction = None
        self.testparam = None
        self.testjumper = None
        self.testerr = None

    def get_test_step(self,projectname,filename):
        clsexcel = Excel()
        file = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            file = file + arrpath[i] + "\\"
            testfile = file + "TestCase" + "\\" + projectname + "\\" + filename
        print testfile
        clsexcel.open_excel_file(testfile)
        colKeyNo = clsexcel.find_column_by_value("TestCase","NO.")
        colApplication = clsexcel.find_column_by_value("TestCase","APPLICATION")
        colMachine = clsexcel.find_column_by_value("TestCase","MACHINE")
        colAction = clsexcel.find_column_by_value("TestCase","ACTION")
        colParam = clsexcel.find_column_by_value("TestCase","PARAMETER")
        colJumper = clsexcel.find_column_by_value("TestCase","STEP JUMPER")
        colErrexcep = clsexcel.find_column_by_value("TestCase","ERROR EXCEPTION")
        dataKeyNo = clsexcel.get_cellvalue_by_column("TestCase",colKeyNo)
        dataApplication = clsexcel.get_cellvalue_by_column("TestCase",colApplication)
        dataMachine = clsexcel.get_cellvalue_by_column("TestCase",colMachine)
        dataAction = clsexcel.get_cellvalue_by_column("TestCase",colAction)
        dataParam = clsexcel.get_cellvalue_by_column("TestCase",colParam)
        dataJumper = clsexcel.get_cellvalue_by_column("TestCase",colJumper)
        dataErrexcep = clsexcel.get_cellvalue_by_column("TestCase",colErrexcep)
        dicKeystep = {}
        dicApplication = {}
        dicMachine = {}
        dicAction = {}
        dicParam = {}
        dicJumper = {}
        dicErrexcep = {}
        counter = 1
        flagbreak = False
        rowcount = clsexcel.get_row_count("TestCase")
        print clsexcel.get_row_count("TestCase")
        for keyno_index in range(1,rowcount):
            if flagbreak == True:
                break
            for application_index in range(1,len(dataApplication)):
                data_key = dataKeyNo.get(counter)
                data_application = dataApplication.get(counter)
                data_machine = dataMachine.get(counter)
                data_action = dataAction.get(counter)
                data_param = dataParam.get(counter)
                data_jumper = dataJumper.get(counter)
                data_err = dataErrexcep.get(counter)

                if data_key == "N":
                    flagbreak == True
                    break 

                if data_key and not (data_key is None) and not data_key.isspace():
                    if data_application and not (data_application is None) and not data_application.isspace():
                        dicKeystep[counter] = counter
                        dicApplication[counter] = data_application
                        dicMachine[counter] = data_machine
                        apptype = self.verify_type_application(data_application)
                        
                        if str.upper(str(apptype)) == "WEB":
                            dicAction[counter] = "RAT WEB " + str.upper(str(data_action))
                        elif str.upper(str(apptype)) == "MOBILE":
                            dicAction[counter] = "RAT MOBILE " + str.upper(str(data_action))
                        else:
                            dicAction[counter] = "RAT " + str.upper(str(data_action))
                        dicParam[counter] = data_param
                        dicJumper[counter] = data_jumper
                        dicErrexcep[counter] = data_err

                counter = counter + 1
        self.testkey = dicKeystep
        self.testapp = dicApplication
        self.testmachine = dicMachine
        self.testaction = dicAction
        self.testparam = dicParam
        self.testjumper = dicJumper
        self.testerr = dicErrexcep
        return dicKeystep

    def get_test_machine(self,iKey):
        return self.testmachine[iKey]

    def get_test_application(self,iKey):
        return self.testapp[iKey]

    def get_test_action(self,iKey):
        return self.testaction[iKey]

    def get_test_parameter(self,iKey):
        return self.testparam[iKey]

    def get_test_jumper(self,iKey):
        return self.testjumper[iKey]

    def get_test_errorexception(self,iKey):
        return self.testerr[iKey]

    def get_total_teststep(self):
        sMaxValue = max(self.testkey.iteritems(), key=operator.itemgetter(1))[0]
        return self.testkey[sMaxValue]

    def verify_type_application(self, appname):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        apptype = clsexcel.get_nextcellvalue_by_condition("Project", appname)
        return apptype
