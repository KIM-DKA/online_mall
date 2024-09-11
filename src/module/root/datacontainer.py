import os
import re
from dateutil import parser
from typing import Union

class DirectoryHandler:
    """
    파일 디렉토리의 경로, 내용물 관리 클래스
    """    
    @staticmethod
    def find_directory(
        start_path: str,
        target_directory_name: str,
        visited=None
    ):
        """
        시작 경로부터 지정한 이름의 디렉토리를 탐색한 후 그 절대경로를 반환하는 함수
        
        :param start_path: 탐색을 시작할 경로 지정
        :param target_directory_name: 탐색 목표인 지정 디렉토리 이름
        """
        
        if os.path.isdir(start_path):
            curr_dir = start_path
        else:
            curr_dir = os.path.dirname(start_path)
        
        if visited == None:
            visited = list()
            visited.append(1)
        
        founded = False
        while founded == False:
            
            tried_num = visited[0]
            
            if tried_num > 4:
                print("Can not find target directory in short time")
                break
            
            for root, dirs, files in os.walk(curr_dir):
                
                if root in visited:
                    continue
                else:
                    visited.append(root)
                    if os.path.basename(root) == target_directory_name:
                        founded = True
                        return root
            
            visited[0] += 1
            upper_dir = os.path.dirname(curr_dir)
            
            return DirectoryHandler.find_directory(
                start_path=upper_dir,
                target_directory_name=target_directory_name, 
                visited=visited
            )
    
    @classmethod
    def get_file_list(cls, target_directory: str, file_format: tuple):
        """
        목표 디렉토리로부터 xlsx, xlsm 형식의 파일 이름을 가져와 리스트 생성하는 함수
        
        :param target_dircetory: 가져올 파일이 담긴 디렉토리
        :param file_format: 가져올 파일의 형식(튜플 형태로 나열)
        """
        all_file_list = os.listdir(target_directory)
        return sorted([file for file in all_file_list if file.endswith(file_format)])        

    
class ValueFormatter:
    
    date_format = '%Y-%m-%d'
    numeric_format= r'[^0-9.]'

    @classmethod
    def _date_parse(cls, value: str):
        
        if isinstance(value, int | float):
            value = str(value)
        try:
            return parser.parse(value).strftime(cls.date_format)
        except:
            return None
        
    @classmethod
    def _numeric_parse(cls, value: str):
        
        if isinstance(value, int | float):
            value = str(value)
        try:
            return float(re.sub(cls.numeric_format, '', value))
        except:
            return None
        
    @classmethod
    def _string_parse(cls, value: str):
        return str(value) if value else None
    
    @classmethod
    def update_format(cls, date_format: str=None, numeric_format: str=None):
        if date_format:
            cls.date_format = date_format
        if numeric_format:
            cls.numeric_format = numeric_format