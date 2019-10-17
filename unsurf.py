#!/usr/bin/python
import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWebEngineWidgets import *

argv = sys.argv
argc = len(argv)

if (argc != 2):
    print("Usage:\n unsurf.py addr")
    quit()

app = QApplication([])
web = QWebEngineView()
web.load(QUrl(argv[1]))
web.show()

sys.exit(app.exec_())
