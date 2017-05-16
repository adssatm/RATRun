#!/usr/bin/python
#-*-coding: utf-8 -*-
from datetime import datetime, timedelta

class Utility:

    def __init__(self):
        self.configpath = None

    def get_cal_date(self, day, fromdate, oper, language):
        calcu_date = None

        if day != None and fromdate != None and oper != None: 
            if oper == '+':
                calcu_date = datetime.strptime(fromdate, '%Y-%m-%d') + timedelta(days=int(day))             
            if oper == '-': 
                calcu_date = datetime.strptime(fromdate, '%Y-%m-%d') - timedelta(days=int(day))
                print "Date is := " + calcu_date.strftime("%d/%m/%Y")
        
        sDate = str(calcu_date)
        sYear = sDate[:4]  

        now = datetime.now()

        nowYear = now.year

        print nowYear

        if str.upper(language) == "TH":
            sDate = str(calcu_date)
            sYear = sDate[:4]
            sMonthDay = sDate[5:]

            if sYear == nowYear:
                iYear = int(sYear) + 543
            else:
                iYear = int(sYear)

            calcu_date = str(iYear) + sMonthDay

        return str(calcu_date)           

    def get_calculate_number(self, num1, num2, oper):
        result = "FAIL"
        if not (num1 is None) and not (num2 is None) and not (oper is None):
            num1_int = float(num1)
            num2_int = float(num2)
            
            if oper == '+':
                result = num1_int + num2_int
            if oper == '-':
                result = num1_int - num2_int
            if oper == '*':
                result = num1_int * num2_int
            if oper == '/':
                result = num1_int / num2_int
            print "Result is : " + str(result)
        return result

    def is_null(self, param):
        print "Param := "+ param
        if param and param.isspace():
            return True
        else:
            return False

    def is_contain_string(self, param1, param2):
        print "Param1 := "+ param1
        print "Param2 := "+ param2

        if param2 in param1:
            return True
        else:
            return False