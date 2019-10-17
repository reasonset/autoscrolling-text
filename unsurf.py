#!/usr/bin/python
import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWebEngineWidgets import *
import re
import os

argv = sys.argv
argc = len(argv)

if (argc != 2):
    print("Usage:\n unsurf.py addr")
    quit()

# For opening local file.
url = argv[1]
if re.match('^[a-z]+://', url):
  pass # do nothing.
elif re.match('^/', url):
  url = 'file://' + url
else:
  url = "file://" + os.getcwd() + "/" + url

app = QApplication([])
web = QWebEngineView()
web.load(QUrl(url))
web.show()

sys.exit(app.exec_())
