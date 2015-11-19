# parse_adeck.py
"""
Utilizes the Python Pandas library to parse and query messy A-DECK files.
"""
#---------------
# Import modules
#---------------
import sys
import pandas as pd
import numpy as np

#---------------------
# Specify column names
#---------------------
# Pandas only likes it if the first row contains the max number of file columns.
# The A-DECK files are messy and unpredictable in terms of max column #.
# Unfortunately, the 'ExtraX' columns were appended through trial and error.
# I'll search for a better way to deal with ragged csv files in the future.
columns = ['Basin',
           'Cy',
           'YYYYMMDDHH',
           'Technum/Min',
           'Tech',
           'Tau',
           'LatN/S',
           'LonE/W',
           'VMax',
           'MSLP',
           'TY',
           'Rad',
           'Wind_code',
           'Rad1',
           'Rad2',
           'Rad3',
           'Rad4',
           'RadP',
           'RRP',
           'MRD',
           'Gusts',
           'Eye',
           'Subregion',
           'Max_seas',
           'Initials',
           'Dir',
           'Speed',
           'Storm_name',
           'Depth',
           'Seas',
           'Seas_code',
           'AAA',
           'QQQ',
           'Seas1',
           'Seas2',
           'Seas3',
           'Seas4',
           'User_defined',
           'Extra1',
           'Extra2',
           'Extra3',
           'Extra4',
           'Extra5',
           'Extra6']

#-----------------
# Load A-DECK file
#-----------------
f       = './aal112015.dat'
adeck   = pd.read_csv(f, sep=',', names=columns, header=None)

#----------------------------------------------
# Locate GFS forecasts initialized on 00Z, 10/2
#----------------------------------------------
model_code  = 'AVNO'
init_time   = 2015100200

storm_locator = adeck \
                    .loc[
                        (adeck['Tech'].str.contains(model_code)) & \
                        (adeck['YYYYMMDDHH'] == init_time)
                    ]

#-----------
# Write data
#-----------
f = './storm_data.csv'
storm_locator.to_csv(f)
