#!/usr/bin/python
#-*-coding: utf-8 -*-
import datetime
from ExcelManager import ExcelManager as Excel
from FileManager import FileManager as TextFile


class Logger():

    def __init__(self):
        self.reportid = None
        self.pathcurrenttemplog = None
        self.currentexcellog = None

    def get_path_templog(self):
        return self.currenttemplog

    def get_path_excellog(self):
        return self.currentexcellog

    def get_report_id(self):
        return self.reportid

    def get_date_description(self):
        current_datetime = str(datetime.datetime.now())
        arrdatetime = current_datetime.split(" ")
        datereally = arrdatetime[0].replace("-", "/")
        print datereally
        return datereally

    def get_logdatetime_now(self):
        current_datetime = str(datetime.datetime.now())
        formatrep1 = current_datetime.replace(" ", "")
        formatrep2 = formatrep1.replace("-", "")
        formatrep3 = formatrep2.replace(":", "")
        timewithoutformat = formatrep3.replace(".", "")
        return timewithoutformat

    def get_logdate_now(self, flagreplace=False):
        current_datetime = str(datetime.datetime.now())
        arrdatetime = current_datetime.split(" ")

        if flagreplace:
            datereally = arrdatetime[0].replace("-", "")
        else:
            datereally = arrdatetime[0]

        print datereally
        return datereally

    def get_logtime_now(self, flagreplace=True):
        current_datetime = str(datetime.datetime.now())
        arrdatetime = current_datetime.split(" ")

        if flagreplace:
            repformat = arrdatetime[1].replace(":", "")
            timereally = repformat.replace(".", "")
        else:
            timereally = arrdatetime[1].replace(".", "")

        print timereally
        return timereally

    def create_report_id(self):
        self.reportid = self.get_logdatetime_now()
        return self.reportid

    def create_text_logger(self, path):
        filemanager = TextFile()
        pathtxt = ""
        arrpath = path.split("\\")
        for ipath in xrange(0, len(arrpath)):
            if arrpath[ipath] != "" or arrpath[ipath] != None :
                pathtxt = pathtxt + arrpath[ipath] + "\\"

        if filemanager.get_folder_exist(pathtxt):
            resultcreate = filemanager.create_text_file(pathtxt, "TempLogEvent")
            if resultcreate != None:
                self.currenttemplog = resultcreate
                return resultcreate
            else:
                print "can not create text file logger"
        else:
            print "Path " + pathtxt + " is not exist"

    def create_excel_logger(self, path, runlocation):
        pathexcel = ""
        resultcreate = ""
        excelmanager = Excel()
        filemanager = TextFile()
        reportid = self.reportid
        arrpath = path.split("\\")
        for ipath in xrange(0, len(arrpath)):
            if arrpath[ipath] != "" or arrpath[ipath] != None :
                pathexcel = pathexcel + arrpath[ipath] + "\\"

        if filemanager.get_folder_exist(pathexcel):
            if runlocation == "LOCAL":
                pathexcel = pathexcel + "\\" + str(reportid) + "_ReportLog.xlsx"
                resultcreate = excelmanager.create_excel_file(pathexcel, "Description,Status,Log")
            elif runlocation == "SERVER":
                pathexcel = pathexcel + "\\" + str(reportid) + ".xlsx"
                resultcreate = excelmanager.create_excel_file(pathexcel, "Description,Status,Log")

            if resultcreate:
                resultheader = self.write_header_excel_log(pathexcel)
                if resultheader:
                    self.currentexcellog = pathexcel
                return pathexcel
            else:
                print "can not create excel file log local"
        else:
            print "Path " + pathexcel + " is not exist"

    def write_text_log(self, path, reportid, iteration, postion, funcname, expected, actual, result, img, file):
        if iteration != "" and postion != "" and funcname != "" and expected != "" and actual != "":
            filemanager = TextFile()
            datetimenow = self.get_logdatetime_now()
            timenow = self.get_logtime_now(False)

            if img == "None":
                img = "'-"
            if file == "None":
                file = "'-"

            logger = chr(39) + str(reportid) + "||" + chr(39) + str(iteration) + "||" + chr(39) + str(postion) + str(datetimenow) + "||" + chr(39) + str(timenow) + "||" + str(funcname) + "||" + str(expected) + "||" + str(actual) + "||" + str(result) + "||" + str(img) + "||" + str(file) + chr(10)
            print logger
            if filemanager.get_file_exist(path):
                writeresponse = filemanager.write_text_file(path, logger)
                if writeresponse:
                    return True
                else:
                    return False
            else:
                print "File current temp log event is loss"
        else:
            print "Some parameter has loss"

    def write_header_excel_log(self, path):
        excelmanager = Excel()
        filemanager = TextFile()

        if filemanager.get_file_exist(path):
            excelmanager.open_excel_file(path)
            excelmanager.write_excel_value("Description", 1, 1, "ReportID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Description", 1, 2, "ReportName", "BLACK", "")
            excelmanager.write_excel_value("Description", 1, 3, "TestScript", "BLACK", "")
            excelmanager.write_excel_value("Description", 1, 4, "UserId", "BLACK", "")
            excelmanager.write_excel_value("Description", 1, 5, "NumberOfIteration", "BLACK", "")
            excelmanager.write_excel_value("Description", 1, 6, "ProjectName", "BLACK", "")
            excelmanager.write_excel_value("Description", 1, 7, "CreateDate", "BLACK", "")
            excelmanager.write_excel_value("Status", 1, 1, "ReportID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Status", 1, 2, "IterationID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Status", 1, 3, "IterationDetail", "BLACK", "")
            excelmanager.write_excel_value("Status", 1, 4, "Status", "BLACK", "")
            excelmanager.write_excel_value("Status", 1, 5, "TestScenarioName", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 1, "ReportID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Log", 1, 2, "IterationID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Log", 1, 3, "LogID", "BLACK", "FF6666")
            excelmanager.write_excel_value("Log", 1, 4, "LogTime", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 5, "Action", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 6, "Expected", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 7, "Actual", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 8, "Result", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 9, "LogImage", "BLACK", "")
            excelmanager.write_excel_value("Log", 1, 10, "LogFile", "BLACK", "")
            return True
        else:
            print "File current excel log event is loss"
            return False

    def write_excel_report_description(self, path, reportid, repname, testscript, userid, numiter, projectname, createdate):
        excelmanager = Excel()
        filemanager = TextFile()

        if filemanager.get_file_exist(path):
            excelmanager.open_excel_file(path)

            maxrows = excelmanager.get_row_count("Description")
            writerows = int(maxrows)+1
            colrepid = excelmanager.find_column_by_value("Description", "ReportID")
            colrepname = excelmanager.find_column_by_value("Description", "ReportName")
            coltestscript = excelmanager.find_column_by_value("Description", "TestScript")
            coluserid = excelmanager.find_column_by_value("Description", "UserId")
            colnumiter = excelmanager.find_column_by_value("Description", "NumberOfIteration")
            colprojectname = excelmanager.find_column_by_value("Description", "ProjectName")
            colcreatedate = excelmanager.find_column_by_value("Description", "CreateDate")

            excelmanager.write_excel_value("Description", writerows, colrepid, chr(39) + reportid, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, colrepname, repname, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, coltestscript, testscript, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, coluserid, userid, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, colnumiter, chr(39) + numiter, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, colprojectname, projectname, "BLACK", "NOFILL")
            excelmanager.write_excel_value("Description", writerows, colcreatedate, chr(39) + createdate, "BLACK", "NOFILL")

            return True
        else:
            print "File current excel log event is loss"
            return False

    def write_excel_report_iteration(self, path, reportid, iterid, iterdetail, status, scenarioname):
        excelmanager = Excel()
        filemanager = TextFile()

        if scenarioname == "NONAME" or scenarioname == "None":
            scenarioname = "'-"

        if filemanager.get_file_exist(path):
            excelmanager.open_excel_file(path)
            maxrows = excelmanager.get_row_count("Status")
            writerows = maxrows+1
            colrepid = excelmanager.find_column_by_value("Status", "ReportID")
            coliterid = excelmanager.find_column_by_value("Status", "IterationID")
            coliterdetail = excelmanager.find_column_by_value("Status", "IterationDetail")
            colstatus = excelmanager.find_column_by_value("Status", "Status")
            colscenario = excelmanager.find_column_by_value("Status", "TestScenarioName")

            if str.upper(str(status)) == "PASS" or str.upper(str(status)) == "PASSED":
                excelmanager.write_excel_value("Status", writerows, colrepid, reportid, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, coliterid, iterid, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, coliterdetail, iterdetail, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, colstatus, status, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, colscenario, scenarioname, "GREEN", "NOFILL")
            elif str.upper(str(status)) == "FAIL" or str.upper(str(status)) == "FAILED":
                excelmanager.write_excel_value("Status", writerows, colrepid, reportid, "RED", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, coliterid, iterid, "RED", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, coliterdetail, iterdetail, "RED", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, colstatus, status, "RED", "NOFILL")
                excelmanager.write_excel_value("Status", writerows, colscenario, scenarioname, "RED", "NOFILL")
            return True
        else:
            print "File current excel log event is loss"
            return False

    def write_excel_report_log(self, path, reportid, iterid, logid, logtime, action, expect, actual , result, pathimg=None, pathfile=None):
        excelmanager = Excel()
        filemanager = TextFile()

        if filemanager.get_file_exist(path):
            excelmanager.open_excel_file(path)
            maxrows = excelmanager.get_row_count("Log")
            writerows = maxrows+1
            colrepid = excelmanager.find_column_by_value("Log", "ReportID")
            coliterid = excelmanager.find_column_by_value("Log", "IterationID")
            collogid = excelmanager.find_column_by_value("Log", "LogID")
            collogtime = excelmanager.find_column_by_value("Log", "LogTime")
            colaction = excelmanager.find_column_by_value("Log", "Action")
            colexpect = excelmanager.find_column_by_value("Log", "Expected")
            colactual = excelmanager.find_column_by_value("Log", "Actual")
            colresult = excelmanager.find_column_by_value("Log", "Result")
            colimg = excelmanager.find_column_by_value("Log", "LogImage")
            colfile = excelmanager.find_column_by_value("Log", "LogFile")

            if str.upper(result) == "PASS" or str.upper(result) == "PASSED":
                excelmanager.write_excel_value("Log", writerows, colrepid, reportid, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, coliterid, iterid, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogid, logid, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogtime, logtime, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colaction, action, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colexpect, expect, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colactual, actual, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colresult, result, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colimg, pathimg, "GREEN", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colfile, pathfile, "GREEN", "NOFILL")
            elif str.upper(result) == "FAIL" or str.upper(result) == "FAILED":
                excelmanager.write_excel_value("Log", writerows, colrepid, reportid, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, coliterid, iterid, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogid, logid, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogtime, logtime, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colaction, action, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colexpect, expect, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colactual, actual, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colresult, result, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colimg, pathimg, "RED", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colfile, pathfile, "RED", "NOFILL")
            elif str.upper(result) == "INFO" or str.upper(result) == "INFORMATION":
                excelmanager.write_excel_value("Log", writerows, colrepid, reportid, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, coliterid, iterid, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogid, logid, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogtime, logtime, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colaction, action, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colexpect, expect, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colactual, actual, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colresult, result, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colimg, pathimg, "BLUE", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colfile, pathfile, "BLUE", "NOFILL")
            else:
                excelmanager.write_excel_value("Log", writerows, colrepid, reportid, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, coliterid, iterid, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogid, logid, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, collogtime, logtime, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colaction, action, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colexpect, expect, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colactual, actual, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colresult, result, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colimg, pathimg, "BLACK", "NOFILL")
                excelmanager.write_excel_value("Log", writerows, colfile, pathfile, "BLACK", "NOFILL")

            return True
        else:
            print "File current excel log event is loss"
            return False

    def write_complete_log_from_text_to_excel(self, pathtext, pathexcel):
        filemanager = TextFile()
        if filemanager.get_file_exist(pathtext) and filemanager.get_file_exist(pathexcel):
            datatext = filemanager.read_text_file(pathtext)
            arrdatabyline = datatext.split(chr(10))
            for idata in range(0, len(arrdatabyline)):
                if arrdatabyline[idata] != "":
                    print arrdatabyline[idata]
                    arrdatalog = arrdatabyline[idata].split("||")
                    if len(arrdatalog) >= 9:
                        self.write_excel_report_log(pathexcel, arrdatalog[0], arrdatalog[1], arrdatalog[2], arrdatalog[3], arrdatalog[4], arrdatalog[5], arrdatalog[6], arrdatalog[7], arrdatalog[8], arrdatalog[9])
                    else:
                        print "check data logger on path " + pathexcel + " [" + arrdatabyline[idata] + "]"
        filemanager.del_file(pathtext)