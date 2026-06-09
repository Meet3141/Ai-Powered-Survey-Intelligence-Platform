import pandas as pd


def profile_dataset(df):
    profile = {}

    profile["shape"] = df.shape
    profile["columns"] = list(df.columns)

    missing = df.isnull().sum().to_dict()
    duplicates = int(df.duplicated().sum())

    dtypes = df.dtypes.astype(str).to_dict()

    sample_data = df.head(5).to_dict(orient="records")

    profile["missing_values"] = missing
    profile["duplicates"] = duplicates
    profile["data_types"] = dtypes
    profile["sample_data"] = sample_data

    return profile