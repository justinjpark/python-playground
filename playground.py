import pytz
from datetime import datetime


def playground():
    format = '%Y-%m-%d %H:%M:%S %Z%z'

    utc_timestamp = datetime.now(pytz.utc)
    print(f'Timestamp (now) in UTC: {utc_timestamp.strftime(format)}')

    et_timestamp = utc_timestamp.astimezone(pytz.timezone('US/Eastern'))
    print(f'Timestamp converted to Eastern Time: {et_timestamp.strftime(format)}')

    pt_timestamp = utc_timestamp.astimezone(pytz.timezone('US/Pacific'))
    print(f'Timestamp converted to Pacific Time: {pt_timestamp.strftime(format)}')


if __name__ == '__main__':
    playground()
