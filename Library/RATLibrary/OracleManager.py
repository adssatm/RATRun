#!/usr/bin/python
#-*-coding: utf-8 -*-
import cx_Oracle


class OracleManager:

    def __init__(self):
        self.conndatabase = None
        self.currentquery = None

    def connect_oracle_database(self, hostip, port, database, user, password):
        dsntns = cx_Oracle.makedsn(hostip, port, database)
        print "connection := " + str(dsntns)
        try:
            conn = cx_Oracle.connect(user, password, dsntns)
            self.conndatabase = conn
            return True
        except Exception as e:
            print e
            return False

    def sql_execution(self, sql):
        try:
          self.conndatabase.execute (sql)
        except cx_Oracle.DatabaseError, exception:
          printException(exception)
        result = self.conndatabase.fetchall()
        self.currentquery = result
        return result