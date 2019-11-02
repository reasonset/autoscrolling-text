#!/usr/bin/python
import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWebEngineWidgets import *
from PyQt5.QtGui import QIcon
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

app = QApplication(["unsurf"])

# Choice application icon. I don't know smart way for choice generic web browser icon.
for iconpath in ["Papirus/64x64/apps/redhat-web-browser.svg", "Vibrancy-Colors/apps/96/browser.png", "Papirus/64x64/apps/internet-web-browser.svg", "breeze/apps/48/plasma-browser-integration.svg", "breeze/apps/48/internet-web-browser.svg", "Adwaita/scalable/apps/web-browser-symbolic.svg", "gnome/256x256/apps/web-browser.png", "ePapirus/22x22/actions/web-browser.svg", "AwOken/clear/128x128/apps/browser.png", "andromeda/apps/48/internet-web-browser.svg"]:
    if os.path.exists("/usr/share/icons/" + iconpath):
        app.setWindowIcon(QIcon.fromTheme("web-browser", QIcon("/usr/share/icons/" + iconpath)))
        break
web = QWebEngineView()

# Set profile name if you need.
pf = QWebEngineProfile()
page = QWebEnginePage(pf, web)
web.setPage(page)

web.setWindowTitle("Unsruf Quick WebBrowser")
web.load(QUrl(url))
web.show()

sys.exit(app.exec_())

