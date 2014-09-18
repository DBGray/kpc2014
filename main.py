'''
Created on 9/09/2014

@author: glenn
'''

import sys
#from PyQt5 import Qt # use a hiddenimport instead
from PySide import QtGui
from country_selector import CountrySelector


def main():
    app = QtGui.QApplication(sys.argv)

    dlg = CountrySelector()
    dlg.show()

    app.exec_()

if __name__ == '__main__':
    main()
