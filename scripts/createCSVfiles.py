#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 24 20:15:46 2025

@author: Devi
"""

import os, sqlite3
import pandas as pd
import numpy as np

def addSessionIndexFindTargets(df_):
    session = 1
    df_["session_number"] = 0
    for _, d in df_.groupby("start_time"):
        df_.loc[d.index,"session_number"] = session
        session +=1

def addSessionIndexGoNoGo(df_):
    df_["session_number"] = 1
    df_.loc[df_.shape[0]//2: df_.shape[0], "session_number"] = 2

def calculateShotsPerTarget(df_):
    df_1 = df_.copy()
    df_1["shotPerTarget"] = -1
    shots_per_target = 1
    for ind, row in df_1.iterrows():
        if row["target_id"] == "reference":
            continue
        if (row["event"] == "destroy") & (row["target_id"].startswith("find")):
            df_1.loc[ind, "shotPerTarget"] = shots_per_target
            shots_per_target = 1
        else:
            shots_per_target +=1
    df_1 = df_1.loc[df_1["shotPerTarget"] != -1, :]
    df_1["hit_rate"] = 1 / df_1.loc[:, "shotPerTarget"]
    return df_1

def calculateTotalDistTraveled(df_):
    df_return = []
    cols = ["position_x", "position_y"]
    for _, d in df_.groupby("session_number"):
        df_return.append(
            {
                "start_time": d["start_time"].unique()[0],
                "end_time": d["end_time"].unique()[0],
                "session_number": _,
                "total_distance_traveled": np.sqrt((d[cols].diff().dropna()[cols]**2).sum(axis=1)).sum()
                }
            )
    return pd.DataFrame(df_return)

def runMain():
    DATA_FOLDER_PATH = os.path.join(os.path.dirname(os.getcwd()), "FPSci", "results")
    SCRIPTS_FOLDER_PATH = os.getcwd()
    dataFileNames = []
    for root, dirs, files in os.walk(DATA_FOLDER_PATH):
        for file in files:
            if file.startswith('._'):
                continue
            if file.endswith('.db'):
                dataFileNames.append(os.path.join(root, file))
    scriptsFileNames = []
    for root, dirs, files in os.walk(SCRIPTS_FOLDER_PATH):
        for file in files:
            if file.startswith('._'):
                continue
            if file.endswith('.sql'):
                scriptsFileNames.append(os.path.join(root, file))
    #dataFileNames = [f for f in os.listdir(DATA_FOLDER_PATH) if os.path.isfile(os.path.join(DATA_FOLDER_PATH, f))]
    #dataFileNames = [f for f in dataFileNames if (f.endswith('.db'))]
    
    #scriptsFileNames = [f for f in os.listdir(SCRIPTS_FOLDER_PATH) if os.path.isfile(os.path.join(SCRIPTS_FOLDER_PATH, f))]
    #scriptsFileNames = [f for f in scriptsFileNames if f.endswith('.sql')]
    #print(dataFileNames)
    #print(scriptsFileNames)
    for dataFile in dataFileNames:
        print("Processing data filename: ", dataFile)
        con = sqlite3.connect(dataFile)
        name = dataFile.split(".db")[0].split("Experiment_1_")[1]
        SAVE_FOLDER_PATH = os.path.join(DATA_FOLDER_PATH, "csvFiles", name)
        if not os.path.exists(SAVE_FOLDER_PATH):
                os.makedirs(SAVE_FOLDER_PATH)
        else:
            continue
        for scriptFile in scriptsFileNames:
            csvFileName = os.path.join(SAVE_FOLDER_PATH, f'{scriptFile.split(".")[0].split("\\")[-1]}.csv')
            #print(csvFileName)
            with open(scriptFile, 'r') as sql_file:
                query = sql_file.read()
                df = pd.read_sql_query(query, con)
                if "HitRate" in scriptFile:
                    df['hit_rate'] = df["count_hits"] / df["number_shots_taken"]
                if "findTarget" in scriptFile:
                    addSessionIndexFindTargets(df_=df)
                    if "RawHitsMisses" in scriptFile:
                        print("Happened")
                        df1 = calculateShotsPerTarget(df_=df)
                        df1.to_csv(os.path.join(SAVE_FOLDER_PATH, "findTargets_ShotsPerTarget.csv"))
                    elif "RawPlayerPosition" in scriptFile:
                        df1 = calculateTotalDistTraveled(df_=df)
                        df1.to_csv(os.path.join(SAVE_FOLDER_PATH, "findTargets_totalDistanceTraveled.csv"))
                    else:
                        pass
                elif 'daySessionTiming' in scriptFile:
                    pass
                else:
                    addSessionIndexGoNoGo(df_=df)
                df.to_csv(csvFileName)       
        con.close()

if __name__ == '__main__':
    runMain()