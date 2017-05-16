#!/usr/bin/python
# -*-coding: utf-8 -*-
import os, sys
from StringManager import *


class MobileManager:
    def __init__(self):
        self.testerr = None

    def get_money_balance(self, stringussd):
        strMagnager = StringManager()
        print stringussd
        findbalance = None
        moneybalance = None
        findbalance = strMagnager.get_string_with_regexp_condition(stringussd, "is.*B")
        moneybalance = str(findbalance).replace("is", "").replace("B", "")
        print "case is*Bath: " + findbalance + " | " + moneybalance

        if findbalance == None and findbalance == None:
            findbalance = strMagnager.get_string_with_regexp_condition(sUSSD, "is.*฿")
            moneybalance = str(findbalance).replace("is", "").replace("฿", "")
            print "case is*Bath: " + findbalance + " | " + moneybalance

        moneybalance = moneybalance.replace("'", "").replace("u", "").replace("[", "").replace("]", "")
        print moneybalance
        return moneybalance

    def get_date_validity(self, stringussd):
        strMagnager = StringManager()
        print stringussd
        findvalidity = strMagnager.get_string_with_regexp_condition(stringussd, r'(\d+/\d+/\d+)')
        validitydate = findvalidity.replace("'", "").replace("u", "").replace("[", "").replace("]", "")
        print "validity date is := " + validitydate
        return validitydate

    def get_mobile_number(self, stringussd):
        originalussd = stringussd.replace(" ", "")
        return originalussd.replace("MSISDN:", "")

    def get_ussd_package(self, profile, stringussd, package):
        arrpackage = str(stringussd).split(chr(10))
        print "amount array package : " + str(len(arrpackage))
        menupackage = ""
        menunext = ""
        menuback = ""

        for x in xrange(0, len(arrpackage)):
            print "list package : " + str(x) + " : " + str(arrpackage[x]) + "|" + str(package)
            ussdpack = str.upper(str(arrpackage[x])).replace(" ","").replace(chr(32),"")
            selectpack = str.upper(str(package)).replace(" ","").replace(chr(32),"")

            if str.upper(str(profile)) == "EN":
                if ussdpack.find("PRESS") > -1:
                    ussdpack.replace("PRESS", "")
                else:
                    prefixnum = ussdpack[:2]
                    ussdpack.replace(prefixnum, "")

                print "ussd clear ragular expression : " + ussdpack
                
                fullmenu = str.upper(str(arrpackage[x])).replace("PRESS", "").replace(chr(32),"").replace(" ", "")

                if ussdpack.find(selectpack) > -1:
                    print "ussd seq := " + fullmenu
                    menupackage = fullmenu[:1]
                    break
                elif ussdpack.find("NEXT") > -1:
                    print "ussd seq := " + fullmenu
                    menunext = fullmenu[:1]
                elif ussdpack.find("BACK") > -1:
                    print "ussd seq := " + fullmenu
                    menuback = fullmenu[:1]
            elif str.upper(str(profile)) == "TH":
                fullmenu = str.upper(str(arrpackage[x])).replace(chr(32),"").replace(" ", "")
                if ussdpack.find(selectpack) > -1:
                    try:
                        seqnum = int(fullmenu[:1])
                        menupackage = str(seqnum)
                    except Exception as e:
                        presskey = fullmenu[:2]
                        clearmenu = fullmenu.replace(presskey,"")
                        menupackage = clearmenu[:1]
                    print "ussd seq := " + fullmenu
                    break
                elif ussdpack.find("9.") > -1:
                    if str(fullmenu[:2]) == "9.":
                        menunext = "9"
                elif ussdpack.find("0.") > -1:
                     if str(fullmenu[:2]) == "0.":
                        menuback = "0"

        if menupackage != "":
            return menupackage
        elif menunext != "":
            return menunext
        elif menuback != "":
            return menuback
        else:
            return False

    def verify_message_detail_by_keywords(self, sms, keywords):
        textsms = str(sms)
        findkey = str(keywords)
        arrsms = textsms.split("|")
        arrkeyword = findkey.split(",")
        smshaskey = None
        flagbreak = False
        for isms in xrange(1,len(arrsms)):
            if flagbreak:
                break
            smsvalue = arrsms[isms].replace(" ","").replace(chr(32),"")
            print smsvalue
            for ikey in xrange(0,len(arrkeyword)):
                keyvalue = arrkeyword[ikey].replace(" ","").replace(chr(32),"")
                print keyvalue
                if smsvalue.find(keyvalue) > -1:
                    print "message := " + smsvalue + "keyword := " + keyvalue
                    smshaskey = arrsms[isms]
                    flagbreak = True
                    break
        return smshaskey