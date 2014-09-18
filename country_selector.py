# -- coding: utf-8 --
from PySide import QtGui

from ui_country_selector import Ui_CountrySelector

from countries import Countries


class CountrySelector(QtGui.QDialog):
    def __init__(self, parent=None):
        super(CountrySelector, self).__init__(parent)
        ui = Ui_CountrySelector()
        ui.setupUi(self)
        self.ui = ui

        self.countries = Countries()
        self.codes = sorted(self.countries['iso2c'])

        index = self.codes.index("NZ")

        ui.cmbCode.addItems(self.codes)
        ui.cmbCode.setCurrentIndex(index)

        self._on_selection(index)
        ui.cmbCode.currentIndexChanged.connect(self._on_selection)

        self.adjustSize()

    def _on_selection(self, index):
        idx = self.countries['iso2c'].index(self.codes[index])
        self.ui.lblCountry.setText(unicode(self.countries['name'][idx], 'utf-8').title())
        self.ui.lblCode3.setText(self.countries['iso3c'][idx])
        self.ui.lblDial.setText(self.countries['dial'][idx])
        self.ui.lblInternet.setText(self.countries['internet'][idx])
        self.ui.lblOlympic.setText(self.countries['olympic'][idx])
