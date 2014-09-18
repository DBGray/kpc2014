# -- coding: utf-8 --
import csv


class Countries(object):
    def __init__(self, csv_file='countries.csv'):
        self.countries = {}
        with open(csv_file, 'r') as f:
            reader = csv.reader(f, delimiter=';', escapechar='\\', doublequote=True)
            CCODE = []
            for row in reader:
                if not row[0].startswith('#'):
                    CCODE.append(row)
            self.countries = {'name': [c[0].strip() for c in CCODE],
                              'iso2c': [c[1].strip() for c in CCODE],
                              'iso3c': [c[2].strip() for c in CCODE],
                              'internet': [c[3].strip() for c in CCODE],
                              'un_car': [c[4].strip() for c in CCODE],
                              'olympic': [c[5].strip() for c in CCODE],
                              'unmn49': [c[6].strip() for c in CCODE],
                              'dial': [c[7].strip() for c in CCODE]
            }

    def __getitem__(self, item):
        try:
            return self.countries[item]
        except KeyError:
            return None
