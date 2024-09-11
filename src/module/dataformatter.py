import os
import re
import pandas as pd
from collections import deque
from datetime import datetime
from src.module.root.datacontainer import ValueFormatter

class Modifier(ValueFormatter):
        
    transformed = list()
    
    @classmethod
    def col_name_cleaning(cls, data: pd.DataFrame):
        result = []
        for column in data.columns:
            
            column = column.replace(' ', '_')
            column = column.lower()
            column = re.sub(r'[^a-z0-9_]', '', column)
            result.append(column)
            
        data.columns = result
        return data
    
    @classmethod        
    def formatting(cls, data: pd.DataFrame, column_list: list=None, parser=None):
        
        parser_dict = {
            'date': cls._date_parse,
            'numeric': cls._numeric_parse,
            'string': cls._string_parse
        }
        if column_list:
            target = column_list
        else:
            target = [
                column for column in data.columns
                if column not in cls.transformed
            ]
        for col in target:
            data[col] = data[col].map(parser_dict[parser])
            cls.transformed.append(col)
        return data
    
    @classmethod
    def excel_date_formatting(cls, value):
        if isinstance(value, (int, float)):
            return datetime.fromordinal(datetime(1900, 1, 1).toordinal() + int(value) - 2)
        else:
            return None