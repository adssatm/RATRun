#!/usr/bin/python
#-*-coding: utf-8 -*-
import operator
from exceptions import AssertionError
from Configuration import Configuration as Config
from ExcelManager import ExcelManager as Excel
from TestStep import *


class Parameter:

    def __init__(self, arg):
        self.configpath = Config.get_config_path()
        self.runproject = Config.get_run_project()
        self.globalparam = None

    def get_run_global_parameter(self):
        conf = Config()
        self.globalparam = conf.get_run_global_variable(self.configpath,self.runproject)

    def get_parameter_value(self,param,paramname):
        arrAllParam = param.split("|")
        dicParam = {}
        for iparam in xrange(0,len(arrAllParam)):
            arrSubParam = arrAllParam[iparam].split("=")
            sParamName = arrSubParam[0]
            sParamName = sParamName.lstrip()
            sParamName = sParamName.rstrip()
            sParamValue = arrSubParam[1].replace("'", "")
            sParamValue = sParamValue.lstrip()
            sParamValue = sParamValue.rstrip()
            dicParam[sParamName.upper()] = sParamValue
        return dicParam[paramname.upper()]

    def verify_parameter_value(self,paramname,iteration):
        paramval = ""
        paramname = str(paramname)
        if (paramname.find("{") != -1 or paramname.find("[") != -1) and (paramname.find("}") != -1 or paramname.find("]") != -1) and paramname.find("+") != -1:
            arrparam = paramname.split("+")
            for iparam in xrange(0,len(arrparam)):
                paramval = str(paramval) + str(self.verify_parameter_condition(arrparam[iparam].lstrip().rstrip(),iteration))
        else:
            paramval = str(self.verify_parameter_condition(paramname,iteration))
        paramval = paramval.replace(chr(10), " ")
        paramval = paramval.lstrip().rstrip()
        return paramval

    def verify_parameter_condition(self,paramname,iteration):   
        print "Paremeter : " + str(paramname)
        resultGlobal = self.verify_parameter_global(paramname)
        print "Verify global parameter : " + str(resultGlobal)
        if resultGlobal != "NoParam":
            try:
                glodicparameter = self.globalparam[str.upper(resultGlobal)]
                return glodicparameter
            except Exception as e:
                print e
                return "NoParam"

        if resultGlobal == "NoParam":
            resultIteration = self.verify_parameter_iteration(paramname)
            print "Verify iteration parameter : " + str(resultIteration)
            if resultIteration != "NoParam":
                arrIter = iteration.split("|")
                for iVal in xrange(0,len(arrIter)-1):
                    arrSubIter = arrIter[iVal].split("=")
                    if arrSubIter[0].upper() == resultIteration.upper():
                        return arrSubIter[1].replace("[e]","=")
                        break
                try:
                    glodicassignment = assigndic[str.upper(resultIteration)]
                    return glodicassignment
                except Exception as e:
                    print e
                    return "NoParam"

        if resultGlobal == "NoParam" and resultIteration == "NoParam":
            resultAssign = self.verify_parameter_assign(paramname)
            print "Verify assign parameter : " + str(resultAssign)
            if resultAssign != "NoParam":
                return resultAssign
            else:
                return paramname

    def verify_parameter_global(self,param):
        variableParam = param
        countParam = len(variableParam)
        if variableParam[0:2] == "@[":
            if variableParam[(countParam-2):countParam] == "]@":
                variableParam = variableParam.replace("]@","")
                variableParam = variableParam.replace("@[","")
                variableParam = variableParam.lstrip()
                variableParam = variableParam.rstrip()
                globalValue = variableParam
                return globalValue
        else:
            return "NoParam"

    def verify_parameter_assign(self,param):
        variableParam = param
        countParam = len(variableParam)
        if variableParam[0:2] == "${":
            if variableParam[(countParam-2):countParam] == "}$":
                assignVariable = variableParam.split("}$")
                assignName = assignVariable[0].replace("${","")
                return assignName
        else:
            return "NoParam"

    def verify_parameter_iteration(self,param):
        variableParam = param
        countParam = len(variableParam)
        if variableParam[0:2] == "@{":
            if variableParam[(countParam-2):countParam] == "}@":
                iterationVariable = variableParam.split("}@")
                iterationName = iterationVariable[0].replace("@{","")
                return iterationName
        else:
            return "NoParam"

    def create_dictionary_assignment(self):
        global assigndic
        assigndic = {}
        
    def add_dictionary_assignment(self, keydic, datavalue):
        keywords = str(keydic).replace("$","").replace("{","").replace("}","").replace(" ","")
        keywords = str.upper(keywords)
        datavalue = str(datavalue)
        print keywords + ":=" + datavalue
        try:
            assigndic.update({keywords:datavalue})
            print "assign value to dictionary >>> " + str(assigndic[keywords])
            return True
        except Exception as e:
            print "error add data to dictionary >>> " + str(e)
            return False

    def verify_none_parameter_value(self, param):
        if not (param is None) and param != "" and not param.isspace() and param != "None" and param != chr(32):
            return True
        else:
            return False

    def additional_parameter_value(self, allparam, paramname, defalutval):
        convertallparam = str(allparam)
        convertparamname = str(paramname)
        if str.upper(convertallparam).find(str.upper(convertparamname)) == -1:
            if not (allparam is None) and allparam != "" and not allparam.isspace() and allparam.find("=") != -1:
                allparam =  allparam + "|" + paramname + "=" + "'" + defalutval + "'"
            else:
                allparam =  paramname + "=" + "'" + defalutval + "'"
        return allparam
            