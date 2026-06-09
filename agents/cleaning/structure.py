import pandas as pd


def structure_dataset(df):
    required_cols = {'user_id', 'question', 'clean_answer'}

    if required_cols.issubset(df.columns):
        structured = df.pivot_table(
            index='user_id',
            columns='question',
            values='clean_answer',
            aggfunc='first'
        ).reset_index()

        return structured

    # If the input dataset is not in long survey format,
    # preserve the cleaned dataframe as-is.
    return df