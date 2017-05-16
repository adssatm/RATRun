#!/usr/bin/python
#-*-coding: utf-8 -*-
import re

class StringManager():

    def __init__(self):
        self.stringdefault = None

    def update_inolder_string(self, stringold, stringnew, separator):
        if stringold == None or stringold == "":
            newstrupdate = separator + stringnew
        else:
            newstrupdate = stringold + separator + stringnew
        
        return newstrupdate

    def update_older_string_with_ascii(self, stringold, stringnew, kascii):
        textstringupdate = stringold + stringnew + chr(int(kascii))
        textstringupdate = textstringupdate.replace("None","")
        return textstringupdate 

    def plus_connect_string(self, stringone, stringtwo):
        setstrone = str(stringone)
        setstrtwo = str(stringtwo)
        if setstrone != "" and setstrone != None and setstrone != chr(32):
            print "String Text 1 := " + setstrone
        else:
            print "String Text 1 is blank"
            stringone = "-"

        if setstrtwo != "" and setstrtwo != None and setstrtwo != chr(32):
            print "String Text 2 := " + setstrtwo
        else:
            print "String Text 2 is blank"
            stringtwo = "-"

        if stringone != "" and stringtwo != "":
            if stringone != None and stringtwo != None:
                stringconvert = str(stringone) + str(stringtwo)
                return stringconvert
            elif stringone == None:
                return stringtwo
            elif stringtwo == None:
                return stringone 

    def get_string_with_regexp_condition(self, sourcestring, pattern):
        return str(re.findall(str(pattern), str(sourcestring)))

    def get_position_find_string(self, sourcestring, pattern):
        source = str(sourcestring)
        findstring = str(pattern)
        positionstring = source.find(findstring)
        print "position string := " + str(positionstring)
        return positionstring

    def verify_position_find_string(self, sourcestring, pattern):
        source = str(sourcestring)
        print "source string := " + source
        findstring = str(pattern)
        print "finding string := " + findstring
        positionstring = source.find(findstring)
        print "position string := " + str(positionstring)
        if positionstring > -1:
            return True
        else:
            return False

    def verify_match_regexp_string(self, sourcestring, pattern):
        result = re.match(str(pattern), str(sourcestring))
        if result != None:
            return True
        else:
            return False

    def verify_search_regexp_string(self, sourcestring, pattern):
        result = re.search(str(pattern), str(sourcestring))
        print result
        if result != None:
            return True
        else:
            return False

    def replace_regexp_string(self, sourcestring, replacestring, findregexp):
        result = re.compile(findregexp)
        return result.sub(replacestring, sourcestring).lstrip().rstrip()

    def replace_empty_string(self, sourcestring, findreplace):
        return str(sourcestring).replace(findreplace,"").lstrip().rstrip()

    def replace_ascii_string(self, sourcestring, kascii):
        return str(sourcestring).replace(chr(int(kascii)),"").lstrip().rstrip()

    def split_string_with_separator(self, sourcestring, separator):
        source = str(sourcestring).lstrip().rstrip()
        arrsource = source.split(separator)
        return arrsource