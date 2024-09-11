import os
import pandas as pd
import unicodedata
from datetime import datetime
from src.module.root.postgre import PostgreSQL
from src.module.root.datacontainer import DirectoryHandler
from src.module.dataextractor import Extractor
from src.module.dataformatter import Modifier

""" 초기 셋팅 """
# 원천데이터 경로 파악
data_dir = DirectoryHandler.find_directory(
    start_path=os.getcwd(),
    target_directory_name='main'
)

# 폴더 이름 영문으로 변경
# dir_eng = {
#     '이벤트': 'event',
#     '검색어': 'search',
#     '주문결제': 'order',
#     '회원정보': 'member'
# }

# directory = [dir for dir in os.listdir(data_dir) if '.DS_Store' not in dir ]
# for idx, dir in enumerate(directory):
#         original_dir = f'{data_dir}/{dir}'
#         if os.path.isdir(original_dir):
#             new_dir = f'{data_dir}/{dir_eng[dir]}'
#             os.rename(original_dir, new_dir)
            
# 디렉토리별 데이터 경로 딕셔너리에 저장
file_dict = dict()
for root, dirs, files in os.walk(data_dir):
    key = os.path.basename(root)
    file_path = [f'{root}/{file}' for file in files]
    file_dict[key] = file_path

# Postgre 설정
work_dir = DirectoryHandler.find_directory(
    start_path=os.getcwd(),
    target_directory_name='online_mall'
)
config_path = f'{work_dir}/private_configs.yaml'
postgre = PostgreSQL(config_file_path=config_path, request_url='local_postgre')
    
    
""" '주문정보' 데이터 추출 및 처리 """
order = file_dict['order']

# 데이터 추출
order_log = pd.DataFrame()
payment_log = pd.DataFrame()

for file_name in order:
    
    if not file_name.endswith(('.xlsx')):    
        continue
    
    data = Extractor.data_load(path=file_name, header='조합원코드')
    sheets = list(data.keys())
    
    for sheet in sheets:
        if '주문' in unicodedata.normalize('NFC', file_name):
            order_log = pd.concat([order_log, data[sheet]], axis=0)
        elif '결제' in unicodedata.normalize('NFC', file_name):
            payment_log = pd.concat([payment_log, data[sheet]], axis=0)

# 컬럼명 변경
order_log_mapping = {
    '조합원코드': 'member_code',
    '구매날짜': 'purchase_date',
    '결제번호': 'payment_number',
    '상품코드': 'product_code',
    '상품명': 'product_name',
    '카테고리(대)': 'category_large',
    '카테고리(중)': 'category_medium',
    '단가': 'unit_price',
    '수량': 'quantity',
    '금액': 'amount'
}
order_log.rename(columns=order_log_mapping, inplace=True)

payment_log_mapping = {
    '조합원코드': 'member_code',
    '구매날짜': 'purchase_date',
    '결제번호': 'payment_number',
    '배송지 (시군구)': 'delivery_district',
    '금액': 'amount',
    '수매선수금 사용 금액': 'prepayment_used_amount',
    '마일리지 사용금액': 'mileage_used_amount',
    '쿠폰사용여부': 'coupon_used',
    '구매당시 회원 등급': 'member_grade_at_purchase',
    '접속유형': 'access_type'
}
payment_log.rename(columns=payment_log_mapping, inplace=True)

# 날짜 환산
order_log['purchase_date'] = order_log['purchase_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)
payment_log['purchase_date'] = payment_log['purchase_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)

# postgre 업로드
postgre.connect()
postgre.exec_sql("create schema if not exists online_mall;")
postgre.write_data(data=order_log, table_name='order_log', schema='online_mall')
postgre.write_data(data=payment_log, table_name='payment_log', schema='online_mall')
postgre.close()


""" 검색어 키워드 정보에 대한 데이터 추출 및 처리"""
search = file_dict['search']

# 데이터 추출
order_keyword = pd.DataFrame()
search_keyword = pd.DataFrame()

for file_name in search:
    
    if not file_name.endswith(('.xlsx')):    
        continue
    
    data = Extractor.data_load(path=file_name, header=None)
    sheets = list(data.keys())

    for sheet in sheets:
        if '주문' in unicodedata.normalize('NFC', sheet):
            order_keyword = pd.concat([order_keyword, data[sheet]], axis=0)
        elif '검색어' in unicodedata.normalize('NFC', sheet):
            search_keyword = pd.concat([search_keyword, data[sheet]], axis=0)
        
# 컬럼명 변경
order_keyword_mapping = ['member_code', 'order_date', 'ordered_keyword']
order_keyword.columns = order_keyword_mapping

search_keyword_mapping = ['member_code', 'search_date', 'searched_keyword']
search_keyword.columns = search_keyword_mapping

# postgre 업로드
postgre.connect()
postgre.exec_sql("create schema if not exists online_mall;")
postgre.write_data(data=order_keyword, table_name='order_keyword', schema='online_mall')
postgre.write_data(data=search_keyword, table_name='search_keyword', schema='online_mall')
postgre.close()    


""" 이벤트 정보에 대한 데이터 추출 및 처리 """
event = file_dict['event']

# 데이터 추출
event_info = pd.DataFrame()

for file_name in event:
    
    if not file_name.endswith(('.xlsx', 'xlsb')):    
        continue
    
    data = Extractor.data_load(path=file_name, header='참여자코드')
    sheets = list(data.keys())

    for sheet in sheets:
        event_info = pd.concat([event_info, data[sheet]], axis=0)
  
# 컬럼명 변경
event_info_mapping = {
    '챌린지명 (샘플로 1개 챌린지 데이터 추출)': 'challenge_name',
    '참여자코드': 'participants'
}
event_info.rename(columns=event_info_mapping, inplace=True)

# postgre 업로드
postgre.connect()
postgre.exec_sql("create schema if not exists online_mall;")
postgre.write_data(data=event_info, table_name='event_info', schema='online_mall')
postgre.close()    

""" 회원 정보에 대한 데이터 추출 및 처리 """
member = file_dict['member']

# 데이터 추출
for file_name in member:
    
    if not file_name.endswith(('.xlsx', 'xlsb')):    
        continue
    
    data = Extractor.data_load(path=file_name, header='회원상태', sheet_list=['회원정보'])
    sheets = list(data.keys())
    
    for sheet in sheets:
        
        member_info = data[sheet].copy()
        member_info = member_info.iloc[1:, :]
        member_info.reset_index(inplace=True, drop=True)

# None인 컬럼 삭제        
member_info = member_info.drop([col for col in member_info.columns if col is None], axis=1)

# 컬럼명 변경
member_info_mapping = {
    '조합원코드': 'member_code',
    '회원상태': 'member_status',
    '연령': 'birth_date',
    '성별': 'gender',
    '주거지': 'residence',
    '가입일자(실버)': 'silver_join_date',
    '가입일자(골드)': 'gold_join_date',
    '가입일자(프리미엄)': 'premium_join_date',
    '가입동기': 'join_motivation',
    '가구인원수': 'household_size',
    '가구유형': 'household_type',
    '기대하는 상품': 'expected_product',
    '회원유형': 'member_type',
    '마케팅수신여부(자연드림몰)': 'marketing_consent_online_mall',
    '마케팅수신여부(조합)': 'marketing_consent_coop',
    '마케팅수신여부(의료사협': 'marketing_consent_medical',
    '출자금': 'investment',
    '수매선수금': 'prepayment',
    '중복가입여부(의료사협과생협)': 'duplicate_membership_medical_and_coop'
}
member_info.rename(columns=member_info_mapping, inplace=True)

# 날짜 환산
member_info['birth_date'] = member_info['birth_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)
member_info['silver_join_date'] = member_info['silver_join_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)
member_info['gold_join_date'] = member_info['gold_join_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)
member_info['premium_join_date'] = member_info['premium_join_date'].map(
    lambda value: Modifier.excel_date_formatting(value)
)
# postgre 업로드
postgre.connect()
postgre.exec_sql("create schema if not exists online_mall;")
postgre.write_data(data=member_info, table_name='member_info', schema='online_mall')
postgre.close()    