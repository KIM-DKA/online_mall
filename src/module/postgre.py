import psycopg2
import yaml
import pandas as pd
from sqlalchemy import create_engine

class PostgreSQL:
    
    def __init__(self, config_file_path=None, request_url=None, host=None, database=None, user=None, password=None, port=None):

        self.config = None
        self.file_path = config_file_path

        if self.file_path:
            self.load_credentials()

            self.host = self.config[request_url]['host']
            self.user = self.config[request_url]['user']
            self.database = self.config[request_url]['database']
            self.password = self.config[request_url]['password']
            self.port = self.config[request_url]['port']
            self.connection = None
            self.cursor = None
         
        else:
            self.host = host
            self.database = database
            self.user = user
            self.password = password
            self.port = port
            self.connection = None
            self.cursor = None

        print('Initialize Class')

    def load_credentials(self):

        with open(self.file_path, 'r') as file:
            self.config = yaml.safe_load(file)
    
    def connect(self):
        try:
            self.connection = psycopg2.connect(
                host=self.host,
                database=self.database,
                user=self.user,
                password=self.password,
                port=self.port
            )
            self.cursor = self.connection.cursor()
            print("Connected to PostgreSQL")
        except (Exception, psycopg2.Error) as error :
            print ("Error while connecting to PostgreSQL", error)

    def close(self):
        if(self.connection):
            self.cursor.close()
            self.connection.close()
            print("PostgreSQL connection is closed")

    def read_data(self, query):
        self.cursor.execute(query)
        rows = self.cursor.fetchall()
        column_names = [desc[0] for desc in self.cursor.description]
        df = pd.DataFrame(rows, columns=column_names)
        return df
        
    def write_data(self, data: pd.DataFrame, table_name: str, schema: str):

        engine = create_engine(f'postgresql+psycopg2://{self.user}:{self.password}@{self.host}:{self.port}/{self.database}')
        data.to_sql(name=table_name, con=engine, schema=schema, if_exists='append', index=False)


if __name__ == "__main__":

    
    private_configs_file_path = './private_configs.yaml'
    postgres = PostgreSQL(config_file_path=private_configs_file_path, request_url='postgre')

    postgres = PostgreSQL(
        host='localhost', 
        database='dap', 
        user='postgres',
        password='',  
        port='5432'
    )

    query = """
    select * from information_schema.columns limit 10
    """

    postgres.connect()
    data = postgres.read_data(query)
    postgres.close()
    