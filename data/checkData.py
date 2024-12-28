import pandas as pd

def check_duplicates(csv_file):
    try:
        df = pd.read_csv(csv_file)
        duplicates = df.duplicated().sum()

        if duplicates > 0:
            print(f"В файле {csv_file} найдены повторяющиеся значения: {duplicates}")
        else:
            print(f"В файле {csv_file} нет повторяющихся значений")

    except FileNotFoundError:
        print(f"Файл {csv_file} не найден")
    except pd.errors.EmptyDataError:
        print(f"Файл {csv_file} пуст")
    except pd.errors.ParserError:
        print(f"Ошибка парсинга файла {csv_file}")


check_duplicates('../table/colors.csv')
check_duplicates('../table/applicationmethods.csv')
check_duplicates('../table/souvenircategories.csv')
