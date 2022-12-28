import pandas as pd
iris_data = pd.read_csv('priv/helper/python/iris-data.csv')
iris_data.head()
iris_data.info()
iris_data.describe()
iris_data['class'].unique()
iris_data.loc[iris_data['class'] == 'versicolor', 'class'] = 'Iris-versicolor'
iris_data.loc[iris_data['class'] == 'Iris-setossa', 'class'] = 'Iris-setosa'
iris_data['class'].unique()

iris_data.hist(bins=50, figsize=(20,15))

iris_data.loc[(iris_data['class'] == 'Iris-versicolor') &
              (iris_data['sepal_length_cm'] < 1.0)]

iris_data.loc[(iris_data['class'] == 'Iris-versicolor') &
(iris_data['sepal_length_cm'] < 1.0),
'sepal_length_cm'] *= 100.0


iris_data.hist(bins=50, figsize=(20,15))

attributes = ["sepal_length_cm", "sepal_width_cm", "petal_length_cm",
                  "petal_width_cm"]

iris_data.loc[(iris_data['sepal_length_cm'].isnull()) |
              (iris_data['sepal_width_cm'].isnull()) |
              (iris_data['petal_length_cm'].isnull()) |
              (iris_data['petal_width_cm'].isnull())]

iris_data_features = iris_data.columns.values

import numpy as np
from sklearn.impute import SimpleImputer

imputer = SimpleImputer(missing_values = np.nan, strategy="median")

transformed_data = imputer.fit_transform(iris_data[['sepal_length_cm', 'sepal_width_cm', 'petal_length_cm',
       'petal_width_cm']])
iris_data[['sepal_length_cm', 'sepal_width_cm', 'petal_length_cm',
       'petal_width_cm']] = transformed_data

iris_data.loc[(iris_data['sepal_length_cm'].isnull()) |
              (iris_data['sepal_width_cm'].isnull()) |
              (iris_data['petal_length_cm'].isnull()) |
              (iris_data['petal_width_cm'].isnull())]

iris_data[7:12]

from sklearn.model_selection import train_test_split

all_inputs = iris_data[['sepal_length_cm', 'sepal_width_cm',
                             'petal_length_cm', 'petal_width_cm']].values
all_labels = iris_data['class'].values

X_train, X_test, y_train, y_test = train_test_split(all_inputs,
                                                    all_labels, stratify=all_labels, random_state=42)

from sklearn.ensemble import RandomForestClassifier

forest_classifer = RandomForestClassifier()
forest_classifer.fit(X_train, y_train)

forest_classifer.score(X_train, y_train)
forest_classifer.score(X_test, y_test)

from sklearn.model_selection import GridSearchCV

param_grid = [
        {'n_estimators': [3, 10, 30, 100], 'max_features': [1, 2, 4]}
]

grid_search = GridSearchCV(forest_classifer, param_grid, cv=5)
grid_search.fit(X_train, y_train)
grid_search.best_params_
grid_search.best_estimator_
forest_classifier = grid_search.best_estimator_
forest_classifier.score(X_test, y_test)

import sys
sys.path.insert(0, 'lib/iris_classifer_ml/protobuf')

import iris_pb2
from base64 import b64encode

def predict_model(args):
    iris_params = iris_pb2.IrisParams()
    iris_params.ParseFromString(args)
    model_params = np.array([[iris_params.sepal_length, iris_params.sepal_width, iris_params.petal_length, iris_params.petal_width]])
    result = forest_classifier.predict(model_params)
    return result

    