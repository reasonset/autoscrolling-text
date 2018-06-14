#!/usr/bin/python
import sys
import os
from PyQt5 import QtGui, QtQml
from OpenGL import GL  #Linux workaround.  See: http://goo.gl/s0SkFl

argv = sys.argv
argc = len(argv)

if (argc != 2):
    print("Usage:\n  webview.py addr")
    quit()

app = QtGui.QGuiApplication(["Qt Webview", "Hello"])
engine = QtQml.QQmlApplicationEngine()
engine.load("{home}/lib/unsurf/unsurf.qml".format(home=os.environ["HOME"]))
engine.rootContext().setContextProperty("myUrl", argv[1])
app.exec_()
