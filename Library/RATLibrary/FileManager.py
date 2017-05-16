#!/usr/bin/python
#-*-coding: utf-8 -*-
import os, shutil
import codecs
from Configuration import Configuration as Config


class FileManager():

    def __init__(self):
        initconfig = Config()
        self.currentpath = initconfig.get_current_path()
        self.currenttextfile = None

    def get_file_exist(self, path):
        return os.path.exists(path)

    def get_folder_exist(self, path):
        return os.path.isdir(path)

    def create_folder(self, path, name):
        if path != "" and name != "":
            newfolder = ""
            arrpath = path.split("\\")

            for ipath in range(0,len(arrpath)):
                if arrpath[ipath] != "":
                    newfolder = newfolder + arrpath[ipath] + "\\"

            newfolder = newfolder + name

            if not os.path.exists(newfolder):
                os.makedirs(newfolder)

            print newfolder
            return newfolder

    def create_text_file(self, path, filename):
        name = path + "\\" + filename + ".txt"
        try:
            file = codecs.open(name, "w", "utf8")
            file.close()
            self.currenttextfile = name
            return self.currenttextfile
        except IOError:
            return self.currenttextfile

    def create_file_type(self, path, filename,filetype):
        name = path + "\\" + filename + "." + filetype
        try:
            file = codecs.open(name, "w", "utf8")
            file.close()
            self.currenttextfile = name
            return self.currenttextfile
        except IOError:
            return self.currenttextfile

    def write_text_file(self, filenamewithpath, text):
        try:
            file = open(filenamewithpath, "a")
            file.write(text)
            file.close()
            return True
        except IOError:
            return False

    def read_text_file(self, filenamewithpath):
        try:
            file = open(filenamewithpath, "r")
            return file.read()
        except IOError:
            return None

    def readline_text_file(self, filenamewithpath):
        try:
            file = open(filenamewithpath, "r")
            return file.readlines()
        except IOError:
            return None

    def del_file(self, filenamewithextension):
        try:
            os.remove(filenamewithextension)
            return True
        except:
            return False

    def del_all_file_in_direcroty(self, pathfolder):
        for the_file in os.listdir(pathfolder):
            file_path = os.path.join(pathfolder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
                return True
            except Exception as e:
                print(e)
                return False

    def create_file_name_by_index(self,filepath,filetype):
        index = 0
        print filepath
        filepath = filepath.replace("/","\\")
        sFileName = str(index) + "." + filetype
        sFilePath = filepath + "\\" + sFileName
        while (self.get_file_exist(sFilePath)) :
            index = index + 1
            sFileName = str(index) + "." + filetype
            sFilePath = filepath + "\\" + sFileName  
        return str(index)
    
    def create_file_name_with_index(self,filepath,prefixname,filetype):
        index = 0
        filepath = filepath.replace("/","\\")
        filename = prefixname + "_" + str(index)
        sFileName = filename + "." + filetype
        sFilePath = filepath + "\\" + sFileName  
        while (self.get_file_exist(sFilePath)) :
            index = index + 1
            filename = prefixname + "_" + str(index)
            sFileName = filename + "." + filetype
            sFilePath = filepath + "\\" + sFileName  
        return filename