#!/usr/bin/env python

from PyQt5.QtWidgets import *
import sys
import pyautogui as auto
import time
import json

AUTOCOMPLETE_JSON = "/home/gaurav/scripts/config/autocomplete.json"

class Window(QWidget):
    def __init__(self):
        QWidget.__init__(self)
        layout = QVBoxLayout()
        self.setLayout(layout)

        # auto complete options
        with open(AUTOCOMPLETE_JSON,'r') as reader:
            self.texts = json.load(reader)
        completer = QCompleter(self.texts.keys())

        # create line edit and add auto complete
        self.lineedit = QLineEdit()
        self.lineedit.returnPressed.connect(self.click_ok)
        self.lineedit.setCompleter(completer)
        layout.addWidget(self.lineedit)
        
        self.ok = QPushButton("OK")
        self.ok.clicked.connect(self.click_ok)
        layout.addWidget(self.ok)
        
        self.most_used = QListWidget()
        favourites = sorted(self.texts.items(),key=lambda x:x[1],reverse=True)
        self.most_used.addItems((f[0] for f in favourites))
        self.most_used.itemClicked.connect(self.click_item)
        layout.addWidget(self.most_used)
        
        self.cancel = QPushButton("Cancel")
        self.cancel.clicked.connect(self.click_cancel)
        layout.addWidget(self.cancel)

    def click_item(self,item):
        auto.write(item.text())
        self.update_dict(item.text())
        sys.exit(0)
        
    def click_cancel(self):
        sys.exit(0)

    def click_ok(self):
        self.hide()
        print("Text:",self.lineedit.text())
        self.update_dict(self.lineedit.text())
        auto.write(self.lineedit.text())
        sys.exit(0)

    def update_dict(self,text):
        self.texts[text] = self.texts.get(text,0) + 1
        print(self.texts)
        with open(AUTOCOMPLETE_JSON,'w') as writer:
            json.dump(self.texts,writer)

app = QApplication(sys.argv)
screen = Window()
screen.show()
sys.exit(app.exec_())
