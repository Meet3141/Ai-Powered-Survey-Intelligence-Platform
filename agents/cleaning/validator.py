
def validate_dataset(df):

    print("\n===== VALIDATION =====\n")

    print("Missing Values:")
    print(df.isnull().sum())

    print("\nDuplicates:")
    print(df.duplicated().sum())

    print("\nFinal Shape:")
    print(df.shape)