#!/usr/bin/python
#-*-coding: utf-8 -*-
import re
import datetime


class PCMSpecific:

    def __init__(self):
        self.configpath = None

    def get_otp_eservice(self, sms):
        # Create by Chayut 31/1/2017
        otpcode = None
        if sms != None:
            arrsms = sms.split("|")
            smsdetail = arrsms[1]
            arrdetail = smsdetail.split(":")
            otpcode = arrdetail[1].replace(" ", "").replace(chr(32), "")
            print "OTP is := " + otpcode
        return otpcode

    def replace_date(self, message):
    #Create By Sudaws49 31/01/2017
        arrmessage = None
        if message != None:
            arrmessage = str(message).replace("[","").replace("'","").replace("]","")
        return arrmessage

    def split_date(self, message):
    #Create By Sudaws49 31/01/2017
        arrmessage = None
        if message != None:
            arrmessage = str(re.findall(r'(\d+/\d+/\d+)', message))
        return arrmessage

    def get_registerdate_package(self, propack):
        # Create by Chayut 1/2/2017
        txtpackage = str(propack).replace(chr(32), "").replace(" ", "")
        arrpackage = txtpackage.split(chr(10))
        splitkey = "เวลา"
        splitkey = splitkey.decode('utf8')
        arrdatetime = arrpackage[0].split(splitkey)
        regisdate = str(re.findall(r'(\d+/\d+/\d+)', arrdatetime[0]))
        replacekey = "น."
        replacekey = replacekey.decode('utf8')
        registime = arrdatetime[1].replace(replacekey, "")
        regisdatetime = str(regisdate).replace("[u'", "").replace("']", "") + "!" + str(registime)
        print regisdatetime
        return regisdatetime

    def get_expiredate_package(self, propack):
        # Create by Chayut 1/2/2017
        txtpackage = str(propack).replace(chr(32),"").replace(" ","")
        splitkey1 = "ใช้งานได้ถึง"
        splitkey1 = splitkey1.decode('utf8')
        arrpackage = txtpackage.split(splitkey1)
        splitkey2 = "เวลา"
        splitkey2 = splitkey2.decode('utf8')
        arrdatetime = arrpackage[1].split(splitkey2)
        expiredate = str(re.findall(r'(\d+/\d+/\d+)', arrdatetime[0]))
        replacekey = "น."
        replacekey = replacekey.decode('utf8')
        expiretime = arrdatetime[1].replace(replacekey,"")
        expiredatetime = str(expiredate).replace("[u'", "").replace("']", "") + "!" + str(expiretime)
        print expiredatetime
        return expiredatetime

    def split_USSD_Code(self, txt):
        #Create by Panumas (Nueng) 30/1/2017
        ussd = None

        idx_begin = txt.find("*")
        idx_end = txt.find("#")+1
        print "Index of * := " + str(idx_begin)
        print "idx_end of # :=" + str(idx_end)

        if idx_begin >= 0 and idx_end >= 0:
            ussd  = txt[idx_begin:idx_end]

        if ussd != None:
            print "USSD Number := " +  ussd
        else:
            print "No USSD Number in Text"

        return ussd

    def create_dictionary_datasorted(self):
        global datasorted
        datasorted = {}

    def add_dictionary_datasorted(self, keydic, datavalue):
        if not (keydic is None) and not (datavalue is None):
            keywords = str(keydic).replace(chr(32),"").replace(" ","")
            arrdatetime = datavalue.split(" ")
            try:
                dateconvert = self.date_key(arrdatetime[0])
                datetimeconvert = str(dateconvert) + " " + str(arrdatetime[1])
                print keywords + ":=" + datetimeconvert
                datasorted.update({keywords:datetimeconvert})
                print datasorted[keywords]
            except Exception as e:
                print e

    def sorted_datadictonary_by_value(self):
        for key, value in sorted(datasorted.iteritems(), key=lambda (k,v): (v,k)):
            print "%s: %s" % (key, value)
            lastkey = key
            lastvalue = value

        print "len sort data dictionary := " + str(len(datasorted)) + "[" + str(lastkey) + ":" + str(lastvalue) + "]"
        print "result max value in dictionary :=" + "[" + str(lastkey) + ":" + str(lastvalue) + "]"
        return lastkey

    def date_key(self, sdate):
        dateconvert = datetime.datetime.strptime(sdate, '%d/%m/%Y').date()
        return dateconvert

    def verify_benefit_package(self,CURR_PACK,BENEFIT_PACK,BENEFIT_EXPIRE_DT,language):
        #Variable
        COUNT  = int(1)
        SEPERATOR1 = '@@'
        SEPERATOR2 = '!!'
        RESULT = False

        current_datetime = datetime.datetime.now()

        sNow = str(current_datetime.strftime("%d/%m/%Y"))

        if str.upper(language) == "TH":
            
            sYear = sNow[6:]

            sMonthDay = sNow[:6]

            iYear = int(sYear) + 543

            sNow = sMonthDay + str(iYear)

        BENEFIT_START_DT = sNow

        # Program
        print "  ---Input Variable ------------------"
        print "  INPUT CURR_PACK         = " + CURR_PACK
        print "  INPUT BENEFIT_PACK      = " + BENEFIT_PACK
        print "  INPUT BENEFIT_START_DT  = " + BENEFIT_START_DT
        print "  INPUT BENEFIT_EXPIRE_DT = " + BENEFIT_EXPIRE_DT
        print "  ---Internal Variable ---------------"
        print "  SEPERATOR1              = " + SEPERATOR1
        print "  SEPERATOR2              = " + SEPERATOR2
        print "  ------------------------------------"
        CURR_PACK = str.replace(str(CURR_PACK),' ','')
        BENEFIT_PACK = str.replace(str(BENEFIT_PACK),' ','')
        BENEFIT_START_DT = str.replace(str(BENEFIT_START_DT),' ','')
        BENEFIT_EXPIRE_DT = str.replace(str(BENEFIT_EXPIRE_DT),' ','')
        LIST1 = CURR_PACK.split(SEPERATOR1)
        print "  LIST1                = " + str(LIST1)
        #print "  LIST1[0]             = " + str(LIST1[0])
        LENGTH_LIST = len(LIST1)
        print "  NUMBER OF LIST       = " + str(LENGTH_LIST-1)
        print "  ------------------------------------"
        # Loop Compare Benefit Package
        print "  Loop Compare Benefit Package"
        print "  INITIAL COUNT        = " + str(COUNT)
        print "  INITIAL RESULT       = " + str(RESULT)
        while (COUNT < LENGTH_LIST) and (RESULT is False):
            print "     ROUND = " + str(COUNT)
            LIST2   = LIST1[COUNT].split(SEPERATOR2)
            LIST2_1 = LIST2[0]
            LIST2_2 = LIST2[1]
            LIST2_3 = LIST2[2]
            FIND_POSITION = LIST2_2.find('!')
            # transform value ---------------------
            if FIND_POSITION != -1:
                LIST2_2 = LIST2_2[0:FIND_POSITION]
            FIND_POSITION = LIST2_3.find('!')
            if FIND_POSITION != -1:
                LIST2_3 = LIST2_3[0:FIND_POSITION]
            #--------------------------------------
            print "       LIST2                = " + str(LIST2)
            print "         LIST2_1            = " + LIST2_1
            print "         LIST2_2            = " + LIST2_2
            print "         LIST2_3            = " + LIST2_3
            print "         BENEFIT_PACK       = " + BENEFIT_PACK
            print "         BENEFIT_START_DT   = " + BENEFIT_START_DT
            print "         BENEFIT_EXPIRE_DT  = " + BENEFIT_EXPIRE_DT
            if (LIST2_1 == BENEFIT_PACK and LIST2_2 == BENEFIT_START_DT and LIST2_3 == BENEFIT_EXPIRE_DT):
                print "       RESULT IS EQUAL"
                RESULT = True;
            else:
                print "       RESULT IS NOT EQUAL"
            COUNT = COUNT + 1;
        print "  ------------------------------------"
        print "  RETURN RESULT : " + str(RESULT)
        return RESULT

    def verify_start_ma_with_effective_time(self, effectivetime, starttime, expectedtime):
        efftime = str(effectivetime).split(" ")
        starttime = str(starttime).split(" ")
        datecompare = False
        timecompare = False
        if str(efftime[0]).lstrip().rstrip() == str(starttime[0]).lstrip().rstrip():
            datecompare = True
            print "compare date start := " + str(starttime[0]) + " effective := " + str(efftime[0])
            arrefftime = efftime[1].split(":")
            arrstarttime = starttime[1].split(":")
            print "compare min start := " + str(starttime[1]) + " effective := " + str(efftime[1])
            if str(arrefftime[1]).lstrip().rstrip() == str(arrstarttime[1]).lstrip().rstrip():
                timecompare = True
            else:
                resulttime = int(arrefftime[1])-int(arrstarttime[1])
                print "verify min time := " + str(resulttime) + " expected min := " + str(expectedtime)
                if resulttime >= 0 and resulttime <= int(expectedtime):
                    timecompare = True

        if datecompare and timecompare:
            return True
        else:
            return False

    def get_time_start_ma(self, requesttime):
        startdatetime = str(re.findall("<eventTime>.*</eventTime>", requesttime))
        startdatetime = startdatetime.replace("'", "").replace("u", "").replace("[", "").replace("]", "")
        startdatetime = startdatetime.replace("<eventTime>", "").replace("</eventTime>", "")
        startdatetime = startdatetime.lstrip().rstrip()
        print "regx from request := " + startdatetime
        arrdatetime = startdatetime.split("T")
        arrdate = arrdatetime[0].split("-")
        dateconvert = arrdate[2] + "/" + arrdate[1] + "/" + arrdate[0]
        timeconvert = str(arrdatetime[1])
        madatetime = dateconvert + " " + timeconvert
        print "MA start time := " + madatetime
        return madatetime