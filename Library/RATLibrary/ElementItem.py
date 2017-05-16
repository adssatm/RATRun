#!/usr/bin/python
#-*-coding: utf-8 -*-
from Configuration import Configuration as Config
from ExcelManager import ExcelManager as Excel


class ElementItem:

    def __init__(self):
        self.currentpath = Config.get_current_path()

    def add_element_to_dictionary(self, projectname):
        clsexcel = Excel()
        file = ""
        path = self.currentpath
        arrpath = path.split("\\")
        for i in xrange(0,len(arrpath)-2):
            file = file + arrpath[i] + "\\"
            testfile = file + "TestCase" + "\\" + projectname + "\\" + projectname + "_ElementItem.xlsx"
        print testfile
        clsexcel.open_excel_file(testfile)
        colKey = clsexcel.find_column_by_value("ElementItem","KEYWORD")
        colType = clsexcel.find_column_by_value("ElementItem","ELEMENT TYPE")
        colProp = clsexcel.find_column_by_value("ElementItem","PROPERTY")
        dataKey = clsexcel.get_cellvalue_by_column("ElementItem",colKey)
        dataType = clsexcel.get_cellvalue_by_column("ElementItem",colType)
        dataProp = clsexcel.get_cellvalue_by_column("ElementItem",colProp)
        eledict = {}
        counter = 1
        for key_index in range(1,len(dataKey)):
            for prop_index in range(1,len(dataProp)):
                key_data = dataKey.get(counter)
                type_data = dataType.get(counter)
                prop_data = dataProp.get(counter)
                if key_data and not (key_data is None) and not key_data.isspace():
                    if prop_data and not (prop_data is None) and not prop_data.isspace():
                        if str.upper(type_data) != "MOBILE":
                            prop = ""
                            prefix = "xpath=//"+ type_data +"["
                            arrprop = prop_data.split("||")
                            for arr_index in range(0,len(arrprop)):
                                prop = prop + "@" + arrprop[arr_index]
                                if arr_index != (len(arrprop)-1):
                                    prop = prop + " "
                            postfix = "]"
                            item_data = prefix + str(prop.decode('cp874')) + postfix
                        else:
                            if prop_data.find("xpath") > -1:
                                item_data = str(prop_data.decode('cp874'))
                            else:
                                item_data = str(prop_data.replace("'","").decode('cp874'))
                        eledict[key_data] = str(item_data.encode('utf8'))
                counter = counter + 1
        return eledict