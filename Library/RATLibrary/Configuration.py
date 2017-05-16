#!/usr/bin/python
#-*-coding: utf-8 -*-
import os
from ExcelManager import ExcelManager as Excel
from version import VERSION
_version_ = VERSION


class Configuration:

    def __init__(self):
        self.currentpath = os.getcwd()
        self.configpath = None
        self.configresult = None
        self.configfile = None
        self.runproject = None

    def get_current_path(self):
        return self.currentpath

    def get_config_path(self):
        pconfig = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            pconfig = pconfig + arrpath[i] + "\\"
        self.configpath = pconfig + "Config"
        print "Config path := " + self.configpath
        return self.configpath

    def get_result_path(self):
        pconfig = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            pconfig = pconfig + arrpath[i] + "\\"
        self.configresult = pconfig + "Result"
        print "Result path := " + self.configresult
        return self.configresult

    def get_testcase_path(self):
        pconfig = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            pconfig = pconfig + arrpath[i] + "\\"
        self.configpath = pconfig + "TestCase"
        print "TestCase path := " + self.configpath
        return self.configpath

    def get_config_file(self):
        file = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            file = file + arrpath[i] + "\\"
        self.configfile = file + "Config" + "\\Configuration.xlsx"
        print "Config file with path := " + self.configfile
        return self.configfile

    def get_run_project(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        projValue = clsexcel.get_nextcellvalue_by_condition("RATFramework", "RATRUN")
        self.runproject = projValue
        print "Project testing := " + self.runproject
        return self.runproject

    def get_run_testcase(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        testValue = clsexcel.get_nextcellvalue_by_condition("RATFramework", "RATTEST")
        print testValue
        arrValue = testValue.split("|")
        return arrValue

    def get_run_location(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        localValue = clsexcel.get_nextcellvalue_by_condition("RATFramework", "RATLOCATION")
        print "Location testing := " + localValue
        return localValue

    def get_run_result(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runLogger = clsexcel.get_nextcellvalue_by_condition("RATFramework","RATLOG")
        print "Logger := " + runLogger
        return runLogger

    def get_run_tester(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runTester = clsexcel.get_nextcellvalue_by_condition("RATFramework", "TESTER")
        print "Tester := " + runTester
        return runTester

    def get_run_flag_email(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runFlagmail = clsexcel.get_nextcellvalue_by_condition("RATFramework", "FLAG-EMAIL")
        print "Flag-Email := " + runFlagmail
        return runFlagmail

    def get_run_email_from(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runMailfrom = clsexcel.get_nextcellvalue_by_condition("RATFramework", "EMAIL-FROM")
        print "Email-From := " + runMailfrom
        return runMailfrom

    def get_run_email_to(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runMailto = clsexcel.get_nextcellvalue_by_condition("RATFramework", "EMAIL-TO")
        print "Email-To := " + runMailto
        return runMailto

    def get_run_email_cc(self):
        clsexcel = Excel()
        exfile = self.configfile
        clsexcel.open_excel_file(exfile)
        runMailcc = clsexcel.get_nextcellvalue_by_condition("RATFramework","EMAIL-CC")
        print "Email-CC := " + runMailcc
        return runMailcc

    def get_run_global_variable(self, configpath, projectname):
        clsexcel = Excel()
        sheetname = "GOL_" + str.upper(str(projectname))
        print sheetname
        globalfile = str(configpath) + "\\GlobalParameter.xlsx"
        print globalfile
        clsexcel.open_excel_file(globalfile)
        colParamName = clsexcel.find_column_by_value(sheetname, "PARAMETER")
        colParamValue = clsexcel.find_column_by_value(sheetname, "VALUE")
        dataParamName = clsexcel.get_cellvalue_by_column(sheetname, colParamName)
        dataParamValue = clsexcel.get_cellvalue_by_column(sheetname, colParamValue)
        dicgolparam = {}
        print "dicgolparam := " + str(dicgolparam)
        counter = 1
        for name_index in range(1,len(dataParamName)):
            for value_index in range(1,len(dataParamValue)):
                data_name = dataParamName.get(counter)
                data_value = dataParamValue.get(counter)
                if data_name and not (data_name is None) and data_name != chr(32) and not data_name.isspace():
                    if data_name and not (data_name is None)and data_name != chr(32) and not data_value.isspace():
                        dicgolparam[str.upper(data_name)] = data_value
                counter = counter + 1
        return dicgolparam