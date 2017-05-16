#!/usr/bin/python
#-*-coding: utf-8 -*-
import re

class IntegerManager():
    """"class management int value"""

    def __init__(self):
        self.intdefault = None

    def addictional_integer_value(self, intval):
        ivalue = int(intval)+1
        return ivalue