import os
import pandas as pd

###############################################################################
###############################################################################

def load_raw_data():
    '''
    Load the data from the root directory
    '''
    raw_data = pd.read_csv(
        os.path.join(
            'data','raw_data',
            'MiningProcess_Flotation_Plant_Database.csv'
        ),
        decimal=',',index_col=0,parse_dates=True
    )
    return raw_data

###############################################################################
###############################################################################

def load_hourly_data():
    '''
    Load the hourly ddata
    '''
    train_data = pd.read_csv(
        os.path.join(
            'data',
            'hourly_train_data.csv'
        ),
        index_col=0,parse_dates=True
    )
    test_data = pd.read_csv(
        os.path.join(
            'data',
            'hourly_test_data.csv'
        ),
        index_col=0,parse_dates=True
    )

    train_x = train_data.drop('% Silica Concentrate',axis=1)
    train_y = train_data['% Silica Concentrate'].to_frame()
    test_x = test_data.drop('% Silica Concentrate',axis=1)
    test_y = test_data['% Silica Concentrate'].to_frame()

    return train_x, train_y, test_x, test_y

###############################################################################
###############################################################################



###############################################################################
###############################################################################
