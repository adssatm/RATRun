#!/usr/bin/python
#-*-coding: utf-8 -*-
import operator
from exceptions import AssertionError
from Configuration import Configuration as Config
from ExcelManager import ExcelManager as Excel


class Iteration:

    def __init__(self):
        self.currentpath = Config.get_current_path()
        self.diccurrentiteration = None
        self.numofiteration = None

    def get_iteration(self,projectname,filename):
        clsexcel = Excel()
        file = ""
        path = self.currentpath
        arrpath = path.split("\\")

        for i in xrange(0,len(arrpath)-2):
            file = file + arrpath[i] + "\\"
            testfile = file + "TestCase" + "\\" + projectname + "\\" + filename
        print "Iteration file path : " + testfile

        clsexcel.open_excel_file(testfile)
        xlsrowcount = clsexcel.get_row_count("Iteration")
        xlscolcount = clsexcel.get_column_count("Iteration")
        print "Iteration rows : " + str(xlsrowcount)
        print "Iteration columns : " + str(xlscolcount)

        self.numofiteration = xlsrowcount-1

        sumvalue = ""
        rowcounter = 2

        while rowcounter <= xlsrowcount:
            colcounter = 1
            while colcounter <= xlscolcount:
                iterheader = clsexcel.get_cellvalue_by_position("Iteration","1",colcounter)
                itervalue = clsexcel.get_cellvalue_by_position("Iteration",rowcounter,colcounter)
                sumvalue = sumvalue + str(iterheader) + "=" + str(itervalue).replace("=","[e]") + "|"
                colcounter += 1
            sumvalue = sumvalue + "[+]"
            rowcounter += 1

        arritervalue = sumvalue.split("[+]")
        max_arr = len(arritervalue)
        del arritervalue[max_arr-1]
        self.diccurrentiteration = arritervalue
        return self.diccurrentiteration

    def get_number_of_iteration(self):
        return str(self.numofiteration)

    def get_sequence_iteration(self, fulliteration):
        valiteration = fulliteration.split("|")
        issequence = "IT" + valiteration[0].replace("NO=","")
        return issequence

    def get_test_scenario_name(self, fulliteration):
        flagcheck = False
        scenarioname = "NONAME"
        arritervalue = fulliteration.split("|")
        print arritervalue
        for ival in xrange(0,len(arritervalue)-1):
            arrvalteration = arritervalue[ival].split("=")
            itername = str(arrvalteration[0]).lstrip().rstrip()
            iterval = str(arrvalteration[1]).lstrip().rstrip()
            if itername.upper() == "TESTSCENARIONAME":
                flagcheck = True
                scenarioname = iterval
            if flagcheck == True:
                break
        print "test scenario name >>> " + str(scenarioname)
        return scenarioname

