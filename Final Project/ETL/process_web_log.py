#import the libraries

from datetime import timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utild.dates import days_ago

#Defining arguments
default_args = {
    'owner' : 'Daniele Longo',
    'start_date' : days_ago(0),
    'email' : 'danielelongo14@gmail.com'
}


dag = DAG(
    'process_web_log',
    default_args = default_args,
    description= 'Process web log',
    schedule_interval = timedelta(days=1)
)

#define tasks
extract_data = BashOperator(
    task_id='extract_data',
    bash_command='grep -o ' + '\'[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\'' + ' /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted-data.txt',
    dag=dag,
)

transform_data = BashOperator(
    task_id='transform_data',
    bash_command='grep -v ' + '\'^198\.46\.149\.143\'' + ' /home/project/airflow/dags/capstone/extracted-data.txt > /home/project/airflow/dags/capstone/transformed-data.csv',
    dag=dag,
)

load_data = BashOperator(
    task_id = 'load_data',
    bash_command='tar -czvf/home/project/airflow/dags/capstone/weblog.tar.gz /home/project/airflow/dags/capstone/transformed-data.csv'
)

#pipeline

extract_data >> transform_data >> load_data