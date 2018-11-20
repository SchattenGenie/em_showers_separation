#!/usr/bin/python
import sys
import pandas as pd
from sklearn.cluster import DBSCAN

def main():
    # print command line arguments
    input_dir, output_dir = sys.argv[1:]
    predicted_labels = []
    df = np.loadtxt(input_dir + '/opera_test.data')
    df = pd.DataFrame(df, columns=['brick_id', 'SX', 'SY', 'SZ', 'TX', 'TY'])
    for name, group in df.groupby('brick_id'):
        dbscan = DBSCAN()
        pred = dbscan.fit_predict(group[['SX', 'SY', 'SZ', 'TX', 'TY']].values / np.array([1e4, 1e4, 1e4, 1., 1.]))
        predicted_labels.append(pred)
    np.savetxt(output_dir + 'opera_test.solution', preds = np.vstack([df.brick_id.values, np.concatenate(predicted_labels)]).T.values.astype(int), fmt='%i')
    return 0

if __name__ == "__main__":
    main()